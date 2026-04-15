import AppKit
import Foundation

struct CatSticker {
    let id: String
    let title: String
    let expression: Expression
}

enum Expression {
    case cryingYell
    case sideEye
    case shocked
    case smug
    case sleepy
    case angry
    case pleading
    case dizzy
}

let stickers: [CatSticker] = [
    CatSticker(id: "cat_crying_yell", title: "爆哭猫", expression: .cryingYell),
    CatSticker(id: "cat_side_eye", title: "斜眼猫", expression: .sideEye),
    CatSticker(id: "cat_shocked", title: "震惊猫", expression: .shocked),
    CatSticker(id: "cat_smug", title: "得意猫", expression: .smug),
    CatSticker(id: "cat_sleepy", title: "困困猫", expression: .sleepy),
    CatSticker(id: "cat_angry", title: "凶凶猫", expression: .angry),
    CatSticker(id: "cat_pleading", title: "求求猫", expression: .pleading),
    CatSticker(id: "cat_dizzy", title: "宕机猫", expression: .dizzy),
]

let rootURL = URL(fileURLWithPath: CommandLine.arguments.dropFirst().first ?? "packs/cat-meme-v2/stickers")
try FileManager.default.createDirectory(at: rootURL, withIntermediateDirectories: true)

for sticker in stickers {
    let image = drawSticker(sticker)
    guard let tiffData = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiffData),
          let pngData = bitmap.representation(using: .png, properties: [:]) else {
        throw CocoaError(.fileWriteUnknown)
    }
    try pngData.write(to: rootURL.appendingPathComponent("\(sticker.id).png"))
}

private func drawSticker(_ sticker: CatSticker) -> NSImage {
    let size = NSSize(width: 512, height: 512)
    guard let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(size.width),
        pixelsHigh: Int(size.height),
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    ), let context = NSGraphicsContext(bitmapImageRep: bitmap) else {
        return NSImage(size: size)
    }

    bitmap.size = size
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context
    defer { NSGraphicsContext.restoreGraphicsState() }

    NSColor.clear.setFill()
    NSRect(origin: .zero, size: size).fill()

    let head = catHeadPath()
    drawDropShadow(path: head)

    NSColor.white.setStroke()
    head.lineWidth = 24
    head.stroke()

    NSColor(calibratedRed: 0.78, green: 0.75, blue: 0.68, alpha: 1).setFill()
    head.fill()

    NSColor(calibratedRed: 0.46, green: 0.44, blue: 0.39, alpha: 0.22).setStroke()
    head.lineWidth = 6
    head.stroke()

    drawFurTexture()
    drawMuzzle()
    drawWhiskers()
    drawExpression(sticker.expression)

    let image = NSImage(size: size)
    image.addRepresentation(bitmap)
    return image
}

private func catHeadPath() -> NSBezierPath {
    let path = NSBezierPath()
    path.move(to: NSPoint(x: 72, y: 336))
    path.curve(to: NSPoint(x: 146, y: 430), controlPoint1: NSPoint(x: 72, y: 380), controlPoint2: NSPoint(x: 100, y: 414))
    path.curve(to: NSPoint(x: 196, y: 407), controlPoint1: NSPoint(x: 156, y: 468), controlPoint2: NSPoint(x: 182, y: 466))
    path.curve(to: NSPoint(x: 256, y: 415), controlPoint1: NSPoint(x: 216, y: 414), controlPoint2: NSPoint(x: 236, y: 417))
    path.curve(to: NSPoint(x: 316, y: 407), controlPoint1: NSPoint(x: 276, y: 417), controlPoint2: NSPoint(x: 296, y: 414))
    path.curve(to: NSPoint(x: 366, y: 430), controlPoint1: NSPoint(x: 330, y: 466), controlPoint2: NSPoint(x: 356, y: 468))
    path.curve(to: NSPoint(x: 440, y: 336), controlPoint1: NSPoint(x: 412, y: 414), controlPoint2: NSPoint(x: 440, y: 380))
    path.curve(to: NSPoint(x: 418, y: 182), controlPoint1: NSPoint(x: 456, y: 264), controlPoint2: NSPoint(x: 446, y: 208))
    path.curve(to: NSPoint(x: 256, y: 98), controlPoint1: NSPoint(x: 374, y: 118), controlPoint2: NSPoint(x: 322, y: 98))
    path.curve(to: NSPoint(x: 94, y: 182), controlPoint1: NSPoint(x: 190, y: 98), controlPoint2: NSPoint(x: 138, y: 118))
    path.curve(to: NSPoint(x: 72, y: 336), controlPoint1: NSPoint(x: 66, y: 208), controlPoint2: NSPoint(x: 56, y: 264))
    path.close()
    return path
}

private func drawDropShadow(path: NSBezierPath) {
    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.22)
    shadow.shadowBlurRadius = 16
    shadow.shadowOffset = NSSize(width: 0, height: -8)
    shadow.set()
    NSColor.black.withAlphaComponent(0.08).setFill()
    path.fill()
    NSShadow().set()
}

private func drawFurTexture() {
    NSColor(calibratedRed: 0.34, green: 0.33, blue: 0.3, alpha: 0.18).setStroke()
    for x in stride(from: 162, through: 350, by: 24) {
        let path = NSBezierPath()
        path.lineWidth = 5
        path.lineCapStyle = .round
        path.move(to: NSPoint(x: x, y: 396))
        path.curve(to: NSPoint(x: x - 12, y: 332), controlPoint1: NSPoint(x: x - 18, y: 378), controlPoint2: NSPoint(x: x + 16, y: 354))
        path.stroke()
    }

    NSColor.white.withAlphaComponent(0.2).setStroke()
    for y in [168, 198, 372] {
        drawLine(from: NSPoint(x: 118, y: y), to: NSPoint(x: 394, y: y + 8), width: 5)
    }
}

private func drawMuzzle() {
    NSColor(calibratedRed: 0.86, green: 0.83, blue: 0.76, alpha: 0.92).setFill()
    NSBezierPath(ovalIn: NSRect(x: 160, y: 164, width: 192, height: 118)).fill()

    NSColor(calibratedRed: 0.42, green: 0.29, blue: 0.25, alpha: 1).setFill()
    let nose = NSBezierPath()
    nose.move(to: NSPoint(x: 224, y: 254))
    nose.curve(to: NSPoint(x: 288, y: 254), controlPoint1: NSPoint(x: 238, y: 270), controlPoint2: NSPoint(x: 274, y: 270))
    nose.curve(to: NSPoint(x: 256, y: 226), controlPoint1: NSPoint(x: 282, y: 236), controlPoint2: NSPoint(x: 270, y: 226))
    nose.curve(to: NSPoint(x: 224, y: 254), controlPoint1: NSPoint(x: 242, y: 226), controlPoint2: NSPoint(x: 230, y: 236))
    nose.fill()
}

private func drawExpression(_ expression: Expression) {
    switch expression {
    case .cryingYell:
        drawBrows(style: .angry)
        drawHalfEyes()
        drawTears()
        drawOpenMouth(height: 92)
    case .sideEye:
        drawBrows(style: .flat)
        drawSideEyes()
        drawFlatMouth()
    case .shocked:
        drawRoundEyes()
        drawOpenMouth(height: 70)
    case .smug:
        drawBrows(style: .smug)
        drawHappyClosedEyes()
        drawSmirk()
    case .sleepy:
        drawBrows(style: .soft)
        drawSleepyEyes()
        drawSmallMouth()
    case .angry:
        drawBrows(style: .angry)
        drawSharpEyes()
        drawFrown()
    case .pleading:
        drawPleadingEyes()
        drawTinyMouth()
        drawCheeks()
    case .dizzy:
        drawSpiralEyes()
        drawWobblyMouth()
    }
}

private enum BrowStyle {
    case angry, flat, smug, soft
}

private func drawBrows(style: BrowStyle) {
    NSColor.black.setStroke()
    switch style {
    case .angry:
        drawLine(from: NSPoint(x: 148, y: 336), to: NSPoint(x: 218, y: 310), width: 14)
        drawLine(from: NSPoint(x: 294, y: 310), to: NSPoint(x: 364, y: 336), width: 14)
    case .flat:
        drawLine(from: NSPoint(x: 148, y: 322), to: NSPoint(x: 218, y: 324), width: 12)
        drawLine(from: NSPoint(x: 294, y: 324), to: NSPoint(x: 364, y: 322), width: 12)
    case .smug:
        drawLine(from: NSPoint(x: 148, y: 338), to: NSPoint(x: 218, y: 320), width: 12)
        drawLine(from: NSPoint(x: 294, y: 316), to: NSPoint(x: 364, y: 334), width: 12)
    case .soft:
        drawArc(center: NSPoint(x: 184, y: 304), radius: 38, start: 20, end: 160, width: 9)
        drawArc(center: NSPoint(x: 328, y: 304), radius: 38, start: 20, end: 160, width: 9)
    }
}

private func drawHalfEyes() {
    drawLine(from: NSPoint(x: 152, y: 292), to: NSPoint(x: 220, y: 292), width: 14)
    drawLine(from: NSPoint(x: 292, y: 292), to: NSPoint(x: 360, y: 292), width: 14)
}

private func drawSideEyes() {
    drawEyeBall(center: NSPoint(x: 184, y: 290), pupilOffset: NSPoint(x: -13, y: -3), size: 58)
    drawEyeBall(center: NSPoint(x: 328, y: 290), pupilOffset: NSPoint(x: -13, y: -3), size: 58)
}

private func drawRoundEyes() {
    drawEyeBall(center: NSPoint(x: 184, y: 302), pupilOffset: .zero, size: 68)
    drawEyeBall(center: NSPoint(x: 328, y: 302), pupilOffset: .zero, size: 68)
}

private func drawPleadingEyes() {
    drawEyeBall(center: NSPoint(x: 184, y: 304), pupilOffset: NSPoint(x: 0, y: 8), size: 74)
    drawEyeBall(center: NSPoint(x: 328, y: 304), pupilOffset: NSPoint(x: 0, y: 8), size: 74)
    NSColor.white.setFill()
    NSBezierPath(ovalIn: NSRect(x: 168, y: 320, width: 16, height: 16)).fill()
    NSBezierPath(ovalIn: NSRect(x: 312, y: 320, width: 16, height: 16)).fill()
}

private func drawHappyClosedEyes() {
    drawArc(center: NSPoint(x: 184, y: 288), radius: 34, start: 15, end: 165, width: 12)
    drawArc(center: NSPoint(x: 328, y: 288), radius: 34, start: 15, end: 165, width: 12)
}

private func drawSleepyEyes() {
    drawLine(from: NSPoint(x: 148, y: 292), to: NSPoint(x: 220, y: 282), width: 11)
    drawLine(from: NSPoint(x: 292, y: 282), to: NSPoint(x: 364, y: 292), width: 11)
}

private func drawSharpEyes() {
    NSColor.black.setFill()
    triangle(NSPoint(x: 146, y: 308), NSPoint(x: 220, y: 292), NSPoint(x: 154, y: 270)).fill()
    triangle(NSPoint(x: 366, y: 308), NSPoint(x: 292, y: 292), NSPoint(x: 358, y: 270)).fill()
}

private func drawSpiralEyes() {
    drawSpiral(center: NSPoint(x: 184, y: 294))
    drawSpiral(center: NSPoint(x: 328, y: 294))
}

private func drawEyeBall(center: NSPoint, pupilOffset: NSPoint, size: CGFloat) {
    NSColor.white.setFill()
    NSBezierPath(ovalIn: NSRect(x: center.x - size / 2, y: center.y - size / 2, width: size, height: size)).fill()
    NSColor.black.setFill()
    NSBezierPath(ovalIn: NSRect(x: center.x + pupilOffset.x - 14, y: center.y + pupilOffset.y - 14, width: 28, height: 28)).fill()
}

private func drawTears() {
    let blue = NSColor(calibratedRed: 0.05, green: 0.45, blue: 1.0, alpha: 0.9)
    blue.setStroke()
    drawLine(from: NSPoint(x: 156, y: 280), to: NSPoint(x: 132, y: 178), width: 18)
    drawLine(from: NSPoint(x: 356, y: 280), to: NSPoint(x: 380, y: 178), width: 18)
    blue.withAlphaComponent(0.95).setFill()
    NSBezierPath(ovalIn: NSRect(x: 112, y: 152, width: 34, height: 46)).fill()
    NSBezierPath(ovalIn: NSRect(x: 366, y: 152, width: 34, height: 46)).fill()
}

private func drawOpenMouth(height: CGFloat) {
    NSColor.black.setFill()
    NSBezierPath(ovalIn: NSRect(x: 216, y: 130, width: 80, height: height)).fill()
    NSColor(calibratedRed: 0.66, green: 0.18, blue: 0.24, alpha: 1).setFill()
    NSBezierPath(ovalIn: NSRect(x: 228, y: 136, width: 56, height: height * 0.32)).fill()
}

private func drawFlatMouth() {
    drawLine(from: NSPoint(x: 220, y: 178), to: NSPoint(x: 292, y: 178), width: 9)
}

private func drawSmirk() {
    drawArc(center: NSPoint(x: 256, y: 176), radius: 42, start: 205, end: 330, width: 10)
}

private func drawSmallMouth() {
    drawArc(center: NSPoint(x: 256, y: 174), radius: 24, start: 205, end: 335, width: 8)
}

private func drawTinyMouth() {
    NSColor.black.setStroke()
    NSBezierPath(ovalIn: NSRect(x: 246, y: 164, width: 20, height: 16)).stroke()
}

private func drawFrown() {
    drawArc(center: NSPoint(x: 256, y: 138), radius: 42, start: 30, end: 150, width: 10)
}

private func drawWobblyMouth() {
    let path = NSBezierPath()
    path.lineWidth = 9
    path.lineCapStyle = .round
    path.move(to: NSPoint(x: 214, y: 168))
    path.curve(to: NSPoint(x: 298, y: 168), controlPoint1: NSPoint(x: 238, y: 194), controlPoint2: NSPoint(x: 274, y: 142))
    path.stroke()
}

private func drawCheeks() {
    NSColor(calibratedRed: 1.0, green: 0.36, blue: 0.55, alpha: 0.28).setFill()
    NSBezierPath(ovalIn: NSRect(x: 128, y: 214, width: 56, height: 34)).fill()
    NSBezierPath(ovalIn: NSRect(x: 328, y: 214, width: 56, height: 34)).fill()
}

private func drawWhiskers() {
    NSColor.black.withAlphaComponent(0.5).setStroke()
    for offset in [-24.0, 0.0, 24.0] {
        drawLine(from: NSPoint(x: 178, y: 218 + offset), to: NSPoint(x: 78, y: 228 + offset), width: 5)
        drawLine(from: NSPoint(x: 334, y: 218 + offset), to: NSPoint(x: 434, y: 228 + offset), width: 5)
    }
}

private func drawSpiral(center: NSPoint) {
    let path = NSBezierPath()
    path.lineWidth = 8
    path.lineCapStyle = .round
    NSColor.black.setStroke()
    var radius: CGFloat = 5
    var angle: CGFloat = 0
    var point = center
    path.move(to: point)
    while radius < 34 {
        angle += 0.38
        radius += 0.9
        point = NSPoint(x: center.x + cos(angle) * radius, y: center.y + sin(angle) * radius)
        path.line(to: point)
    }
    path.stroke()
}

private func drawLine(from: NSPoint, to: NSPoint, width: CGFloat) {
    let path = NSBezierPath()
    path.lineWidth = width
    path.lineCapStyle = .round
    path.move(to: from)
    path.line(to: to)
    path.stroke()
}

private func drawArc(center: NSPoint, radius: CGFloat, start: CGFloat, end: CGFloat, width: CGFloat) {
    let path = NSBezierPath()
    path.lineWidth = width
    path.lineCapStyle = .round
    NSColor.black.setStroke()
    path.appendArc(withCenter: center, radius: radius, startAngle: start, endAngle: end)
    path.stroke()
}

private func triangle(_ a: NSPoint, _ b: NSPoint, _ c: NSPoint) -> NSBezierPath {
    let path = NSBezierPath()
    path.move(to: a)
    path.line(to: b)
    path.line(to: c)
    path.close()
    return path
}

