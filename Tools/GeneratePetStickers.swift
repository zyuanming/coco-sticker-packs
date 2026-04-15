import AppKit
import Foundation

struct StickerSpec {
    let id: String
    let animal: Animal
    let text: String
    let accent: NSColor
    let mood: Mood
}

enum Animal {
    case cat, dog, duck, hamster, rabbit, pig, frog, seal
}

enum Mood {
    case blank, proud, panic, suspicious, tired, happy, smug, shocked
}

let specs: [StickerSpec] = [
    StickerSpec(id: "pet_cat_blank", animal: .cat, text: "开摆", accent: .systemOrange, mood: .blank),
    StickerSpec(id: "pet_dog_silly", animal: .dog, text: "装傻", accent: .systemBlue, mood: .happy),
    StickerSpec(id: "pet_duck_huh", animal: .duck, text: "嘎？", accent: .systemYellow, mood: .shocked),
    StickerSpec(id: "pet_hamster_run", animal: .hamster, text: "先跑", accent: .systemPink, mood: .panic),
    StickerSpec(id: "pet_rabbit_nope", animal: .rabbit, text: "别吵", accent: .systemMint, mood: .tired),
    StickerSpec(id: "pet_pig_food", animal: .pig, text: "饭呢", accent: .systemRed, mood: .suspicious),
    StickerSpec(id: "pet_frog_chill", animal: .frog, text: "淡定", accent: .systemGreen, mood: .smug),
    StickerSpec(id: "pet_seal_proud", animal: .seal, text: "就这", accent: .systemTeal, mood: .proud),
]

let rootURL = URL(fileURLWithPath: CommandLine.arguments.dropFirst().first ?? "packs/pets-goofy-v1/stickers")
try FileManager.default.createDirectory(at: rootURL, withIntermediateDirectories: true)

for spec in specs {
    let image = drawSticker(spec)
    guard let tiffData = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiffData),
          let pngData = bitmap.representation(using: .png, properties: [:]) else {
        throw CocoaError(.fileWriteUnknown)
    }
    try pngData.write(to: rootURL.appendingPathComponent("\(spec.id).png"))
}

private func drawSticker(_ spec: StickerSpec) -> NSImage {
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

    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.18)
    shadow.shadowBlurRadius = 18
    shadow.shadowOffset = NSSize(width: 0, height: -8)

    let bodyRect = NSRect(x: 74, y: 138, width: 364, height: 300)
    shadow.set()
    spec.accent.withAlphaComponent(0.2).setFill()
    rounded(bodyRect.insetBy(dx: -12, dy: -12), radius: 82).fill()
    NSShadow().set()

    drawAnimal(spec.animal, in: bodyRect, accent: spec.accent, mood: spec.mood)
    drawCaption(spec.text, accent: spec.accent)

    let image = NSImage(size: size)
    image.addRepresentation(bitmap)
    return image
}

private func drawAnimal(_ animal: Animal, in rect: NSRect, accent: NSColor, mood: Mood) {
    switch animal {
    case .cat:
        drawEars(rect: rect, fill: NSColor(calibratedRed: 0.98, green: 0.68, blue: 0.34, alpha: 1))
        drawFace(rect: rect, fill: NSColor(calibratedRed: 1.0, green: 0.76, blue: 0.42, alpha: 1), mood: mood)
        drawWhiskers(rect: rect)
    case .dog:
        drawDogEars(rect: rect)
        drawFace(rect: rect, fill: NSColor(calibratedRed: 0.82, green: 0.58, blue: 0.34, alpha: 1), mood: mood)
        drawSnout(rect: rect)
    case .duck:
        drawFace(rect: rect, fill: NSColor(calibratedRed: 1.0, green: 0.86, blue: 0.22, alpha: 1), mood: mood)
        drawBill(rect: rect)
    case .hamster:
        drawRoundEars(rect: rect, fill: NSColor(calibratedRed: 0.72, green: 0.48, blue: 0.28, alpha: 1))
        drawFace(rect: rect, fill: NSColor(calibratedRed: 0.86, green: 0.62, blue: 0.38, alpha: 1), mood: mood)
        drawCheeks(rect: rect, accent: accent)
    case .rabbit:
        drawRabbitEars(rect: rect)
        drawFace(rect: rect, fill: NSColor(calibratedWhite: 0.96, alpha: 1), mood: mood)
        drawCheeks(rect: rect, accent: accent)
    case .pig:
        drawRoundEars(rect: rect, fill: NSColor(calibratedRed: 1.0, green: 0.56, blue: 0.62, alpha: 1))
        drawFace(rect: rect, fill: NSColor(calibratedRed: 1.0, green: 0.68, blue: 0.74, alpha: 1), mood: mood)
        drawPigNose(rect: rect)
    case .frog:
        drawFrogEyes(rect: rect)
        drawFace(rect: rect, fill: NSColor(calibratedRed: 0.38, green: 0.76, blue: 0.35, alpha: 1), mood: mood)
    case .seal:
        drawFace(rect: rect, fill: NSColor(calibratedRed: 0.72, green: 0.86, blue: 0.88, alpha: 1), mood: mood)
        drawWhiskers(rect: rect)
    }
}

private func drawFace(rect: NSRect, fill: NSColor, mood: Mood) {
    fill.setFill()
    NSColor.black.withAlphaComponent(0.2).setStroke()
    let face = NSBezierPath(ovalIn: rect)
    face.lineWidth = 8
    face.fill()
    face.stroke()

    drawEyes(rect: rect, mood: mood)
    drawMouth(rect: rect, mood: mood)
}

private func drawEyes(rect: NSRect, mood: Mood) {
    let left = NSPoint(x: rect.midX - 68, y: rect.midY + 42)
    let right = NSPoint(x: rect.midX + 68, y: rect.midY + 42)
    NSColor.black.setStroke()
    NSColor.black.setFill()

    switch mood {
    case .blank:
        drawLine(from: NSPoint(x: left.x - 24, y: left.y), to: NSPoint(x: left.x + 24, y: left.y), width: 10)
        drawLine(from: NSPoint(x: right.x - 24, y: right.y), to: NSPoint(x: right.x + 24, y: right.y), width: 10)
    case .panic, .shocked:
        NSBezierPath(ovalIn: NSRect(x: left.x - 22, y: left.y - 22, width: 44, height: 44)).fill()
        NSBezierPath(ovalIn: NSRect(x: right.x - 22, y: right.y - 22, width: 44, height: 44)).fill()
        NSColor.white.setFill()
        NSBezierPath(ovalIn: NSRect(x: left.x - 8, y: left.y + 4, width: 12, height: 12)).fill()
        NSBezierPath(ovalIn: NSRect(x: right.x - 8, y: right.y + 4, width: 12, height: 12)).fill()
    case .suspicious, .smug:
        drawLine(from: NSPoint(x: left.x - 28, y: left.y + 12), to: NSPoint(x: left.x + 24, y: left.y - 4), width: 10)
        drawLine(from: NSPoint(x: right.x - 24, y: right.y - 4), to: NSPoint(x: right.x + 28, y: right.y + 12), width: 10)
    case .tired:
        drawLine(from: NSPoint(x: left.x - 26, y: left.y + 2), to: NSPoint(x: left.x + 26, y: left.y - 8), width: 9)
        drawLine(from: NSPoint(x: right.x - 26, y: right.y - 8), to: NSPoint(x: right.x + 26, y: right.y + 2), width: 9)
    case .happy, .proud:
        drawArc(center: left, radius: 24, start: 10, end: 170, width: 9)
        drawArc(center: right, radius: 24, start: 10, end: 170, width: 9)
    }
}

private func drawMouth(rect: NSRect, mood: Mood) {
    NSColor.black.setStroke()
    switch mood {
    case .panic, .shocked:
        NSColor.black.setFill()
        NSBezierPath(ovalIn: NSRect(x: rect.midX - 24, y: rect.midY - 72, width: 48, height: 62)).fill()
    case .proud, .smug:
        drawArc(center: NSPoint(x: rect.midX, y: rect.midY - 46), radius: 38, start: 200, end: 340, width: 9)
    case .happy:
        drawArc(center: NSPoint(x: rect.midX, y: rect.midY - 42), radius: 50, start: 200, end: 340, width: 10)
    case .tired, .blank, .suspicious:
        drawLine(from: NSPoint(x: rect.midX - 36, y: rect.midY - 54), to: NSPoint(x: rect.midX + 36, y: rect.midY - 54), width: 9)
    }
}

private func drawCaption(_ text: String, accent: NSColor) {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    let attrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 72, weight: .black),
        .foregroundColor: NSColor.white,
        .strokeColor: NSColor.black,
        .strokeWidth: -5,
        .paragraphStyle: paragraph,
    ]
    let rect = NSRect(x: 22, y: 32, width: 468, height: 92)
    accent.withAlphaComponent(0.9).setFill()
    rounded(rect.insetBy(dx: 24, dy: 10), radius: 24).fill()
    text.draw(in: rect, withAttributes: attrs)
}

private func drawEars(rect: NSRect, fill: NSColor) {
    fill.setFill()
    triangle(NSPoint(x: rect.minX + 58, y: rect.maxY - 42), NSPoint(x: rect.minX + 126, y: rect.maxY + 84), NSPoint(x: rect.minX + 178, y: rect.maxY - 26)).fill()
    triangle(NSPoint(x: rect.maxX - 58, y: rect.maxY - 42), NSPoint(x: rect.maxX - 126, y: rect.maxY + 84), NSPoint(x: rect.maxX - 178, y: rect.maxY - 26)).fill()
}

private func drawDogEars(rect: NSRect) {
    NSColor(calibratedRed: 0.42, green: 0.24, blue: 0.16, alpha: 1).setFill()
    rounded(NSRect(x: rect.minX - 24, y: rect.midY + 36, width: 92, height: 152), radius: 40).fill()
    rounded(NSRect(x: rect.maxX - 68, y: rect.midY + 36, width: 92, height: 152), radius: 40).fill()
}

private func drawRoundEars(rect: NSRect, fill: NSColor) {
    fill.setFill()
    NSBezierPath(ovalIn: NSRect(x: rect.minX + 28, y: rect.maxY - 24, width: 92, height: 92)).fill()
    NSBezierPath(ovalIn: NSRect(x: rect.maxX - 120, y: rect.maxY - 24, width: 92, height: 92)).fill()
}

private func drawRabbitEars(rect: NSRect) {
    NSColor(calibratedWhite: 0.96, alpha: 1).setFill()
    rounded(NSRect(x: rect.minX + 86, y: rect.maxY - 12, width: 70, height: 160), radius: 34).fill()
    rounded(NSRect(x: rect.maxX - 156, y: rect.maxY - 12, width: 70, height: 160), radius: 34).fill()
}

private func drawFrogEyes(rect: NSRect) {
    NSColor(calibratedRed: 0.38, green: 0.76, blue: 0.35, alpha: 1).setFill()
    NSBezierPath(ovalIn: NSRect(x: rect.minX + 64, y: rect.maxY - 12, width: 94, height: 94)).fill()
    NSBezierPath(ovalIn: NSRect(x: rect.maxX - 158, y: rect.maxY - 12, width: 94, height: 94)).fill()
}

private func drawSnout(rect: NSRect) {
    NSColor(calibratedRed: 0.96, green: 0.78, blue: 0.55, alpha: 1).setFill()
    NSBezierPath(ovalIn: NSRect(x: rect.midX - 62, y: rect.midY - 78, width: 124, height: 84)).fill()
}

private func drawBill(rect: NSRect) {
    NSColor(calibratedRed: 1.0, green: 0.52, blue: 0.18, alpha: 1).setFill()
    rounded(NSRect(x: rect.midX - 86, y: rect.midY - 82, width: 172, height: 74), radius: 36).fill()
}

private func drawPigNose(rect: NSRect) {
    NSColor(calibratedRed: 0.94, green: 0.42, blue: 0.52, alpha: 1).setFill()
    rounded(NSRect(x: rect.midX - 58, y: rect.midY - 76, width: 116, height: 72), radius: 34).fill()
    NSColor.black.withAlphaComponent(0.6).setFill()
    NSBezierPath(ovalIn: NSRect(x: rect.midX - 30, y: rect.midY - 50, width: 16, height: 22)).fill()
    NSBezierPath(ovalIn: NSRect(x: rect.midX + 14, y: rect.midY - 50, width: 16, height: 22)).fill()
}

private func drawCheeks(rect: NSRect, accent: NSColor) {
    accent.withAlphaComponent(0.28).setFill()
    NSBezierPath(ovalIn: NSRect(x: rect.midX - 130, y: rect.midY - 44, width: 54, height: 34)).fill()
    NSBezierPath(ovalIn: NSRect(x: rect.midX + 76, y: rect.midY - 44, width: 54, height: 34)).fill()
}

private func drawWhiskers(rect: NSRect) {
    NSColor.black.withAlphaComponent(0.55).setStroke()
    for offset in [-18.0, 0.0, 18.0] {
        drawLine(from: NSPoint(x: rect.midX - 118, y: rect.midY - 28 + offset), to: NSPoint(x: rect.midX - 186, y: rect.midY - 42 + offset), width: 5)
        drawLine(from: NSPoint(x: rect.midX + 118, y: rect.midY - 28 + offset), to: NSPoint(x: rect.midX + 186, y: rect.midY - 42 + offset), width: 5)
    }
}

private func rounded(_ rect: NSRect, radius: CGFloat) -> NSBezierPath {
    NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
}

private func triangle(_ a: NSPoint, _ b: NSPoint, _ c: NSPoint) -> NSBezierPath {
    let path = NSBezierPath()
    path.move(to: a)
    path.line(to: b)
    path.line(to: c)
    path.close()
    return path
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
    path.appendArc(withCenter: center, radius: radius, startAngle: start, endAngle: end)
    path.stroke()
}
