import AppKit
import Foundation

struct RealCatSticker {
    let id: String
    let title: String
    let fileTitle: String
    let sourceURL: String
    let license: String
    let author: String
}

let stickers: [RealCatSticker] = [
    RealCatSticker(
        id: "real_cat_happy_yay",
        title: "好耶猫",
        fileTitle: "Happy-looking_cat.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Happy-looking_cat.jpg",
        license: "CC BY 2.0",
        author: "Phelyan Sanjoin"
    ),
    RealCatSticker(
        id: "real_cat_steady",
        title: "稳了猫",
        fileTitle: "Pleased-looking_cat.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Pleased-looking_cat.jpg",
        license: "CC BY 2.0",
        author: "steve p2008"
    ),
    RealCatSticker(
        id: "real_cat_shocked",
        title: "震惊猫",
        fileTitle: "Surprised_cat.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Surprised_cat.jpg",
        license: "CC BY 2.0",
        author: "TOBERTZ CHAVEZ"
    ),
    RealCatSticker(
        id: "real_cat_facepalm",
        title: "无语猫",
        fileTitle: "Cat_facepalm_1.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Cat_facepalm_1.jpg",
        license: "CC BY-SA 2.0",
        author: "barbostick"
    ),
    RealCatSticker(
        id: "real_cat_closed",
        title: "不营业猫",
        fileTitle: "Dont_bother_me_(311536232).jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Dont_bother_me_(311536232).jpg",
        license: "CC BY 2.0",
        author: "Dwight Sipler"
    ),
    RealCatSticker(
        id: "real_cat_tired",
        title: "累了猫",
        fileTitle: "Am_I_Boring_You?.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Am_I_Boring_You%3F.jpg",
        license: "CC BY-SA 2.0",
        author: "Seth Anderson"
    ),
    RealCatSticker(
        id: "real_cat_crash",
        title: "崩溃猫",
        fileTitle: "Cat_yawn_with_exposed_teeth_and_claws.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Cat_yawn_with_exposed_teeth_and_claws.jpg",
        license: "CC BY-SA 4.0",
        author: "DecafPotato"
    ),
    RealCatSticker(
        id: "real_cat_blank",
        title: "发呆猫",
        fileTitle: "ChausieBGT.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:ChausieBGT.jpg",
        license: "CC0",
        author: "PiBeseth"
    ),
    RealCatSticker(
        id: "real_cat_mischief",
        title: "偷笑猫",
        fileTitle: "Funny_Kitten_(2008;_cropped_2023).jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Funny_Kitten_(2008;_cropped_2023).jpg",
        license: "CC BY 2.0",
        author: "Tela Chhe"
    ),
    RealCatSticker(
        id: "real_cat_cool",
        title: "可以猫",
        fileTitle: "Cat_wearing_sunglasses.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Cat_wearing_sunglasses.jpg",
        license: "CC BY-SA 4.0",
        author: "Smirkybec"
    ),
    RealCatSticker(
        id: "real_cat_busy",
        title: "在忙猫",
        fileTitle: "BusinessCat_2006_(cropped).jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:BusinessCat_2006_(cropped).jpg",
        license: "CC BY 2.0",
        author: "Paulo Ordoveza"
    ),
    RealCatSticker(
        id: "real_cat_silly",
        title: "略略猫",
        fileTitle: "A_cat_sticks_out_its_tongue.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:A_cat_sticks_out_its_tongue.jpg",
        license: "CC BY-SA 4.0",
        author: "דג קטן"
    )
]

let outputDirectory = URL(fileURLWithPath: CommandLine.arguments.dropFirst().first ?? "packs/real-cat-moods-v1/stickers")
try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)

for sticker in stickers {
    let data = try fetchCommonsImage(fileTitle: sticker.fileTitle)
    guard let image = NSImage(data: data) else {
        throw CocoaError(.fileReadCorruptFile)
    }

    let rendered = drawSticker(source: image, title: sticker.title)
    guard let tiffData = rendered.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiffData),
          let pngData = bitmap.representation(using: .png, properties: [.compressionFactor: 0.82]) else {
        throw CocoaError(.fileWriteUnknown)
    }

    try pngData.write(to: outputDirectory.appendingPathComponent("\(sticker.id).png"), options: .atomic)
    Thread.sleep(forTimeInterval: 1.1)
}

private func fetchCommonsImage(fileTitle: String) throws -> Data {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "commons.wikimedia.org"
    components.path = "/wiki/Special:Redirect/file/\(fileTitle)"

    guard let url = components.url else {
        throw CocoaError(.fileReadInvalidFileName)
    }

    var lastError: Error?
    for attempt in 1...4 {
        do {
            var request = URLRequest(url: url)
            request.setValue("CocoStickerPacks/1.0 (https://github.com/zyuanming/coco-sticker-packs)", forHTTPHeaderField: "User-Agent")
            request.timeoutInterval = 30
            return try fetchData(request: request)
        } catch {
            lastError = error
            Thread.sleep(forTimeInterval: Double(attempt) * 1.4)
        }
    }

    throw lastError ?? CocoaError(.fileReadUnknown)
}

private func fetchData(request: URLRequest) throws -> Data {
    let semaphore = DispatchSemaphore(value: 0)
    var result: Result<Data, Error>!

    URLSession.shared.dataTask(with: request) { data, response, error in
        defer { semaphore.signal() }

        if let error {
            result = .failure(error)
            return
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data else {
            result = .failure(CocoaError(.fileReadUnknown))
            return
        }

        result = .success(data)
    }.resume()

    semaphore.wait()
    return try result.get()
}

private func drawSticker(source: NSImage, title: String) -> NSImage {
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

    let cardRect = NSRect(x: 28, y: 42, width: 456, height: 420)
    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.22)
    shadow.shadowBlurRadius = 18
    shadow.shadowOffset = NSSize(width: 0, height: -8)
    shadow.set()

    let outline = NSBezierPath(roundedRect: cardRect, xRadius: 44, yRadius: 44)
    NSColor.white.setFill()
    outline.fill()
    NSShadow().set()

    let imageRect = cardRect.insetBy(dx: 14, dy: 14)
    let clipPath = NSBezierPath(roundedRect: imageRect, xRadius: 32, yRadius: 32)
    clipPath.addClip()
    drawAspectFill(source, in: imageRect)

    NSGraphicsContext.restoreGraphicsState()
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context

    NSColor.white.setStroke()
    outline.lineWidth = 12
    outline.stroke()

    drawTitle(title, in: NSRect(x: 68, y: 44, width: 376, height: 86))

    let image = NSImage(size: size)
    image.addRepresentation(bitmap)
    return image
}

private func drawAspectFill(_ image: NSImage, in rect: NSRect) {
    let imageSize = image.size
    let scale = max(rect.width / imageSize.width, rect.height / imageSize.height)
    let drawSize = NSSize(width: imageSize.width * scale, height: imageSize.height * scale)
    let drawRect = NSRect(
        x: rect.midX - drawSize.width / 2,
        y: rect.midY - drawSize.height / 2,
        width: drawSize.width,
        height: drawSize.height
    )
    image.draw(in: drawRect, from: .zero, operation: .sourceOver, fraction: 1)
}

private func drawTitle(_ title: String, in rect: NSRect) {
    let pill = NSBezierPath(roundedRect: rect, xRadius: 34, yRadius: 34)
    NSColor.white.withAlphaComponent(0.92).setFill()
    pill.fill()
    NSColor.black.withAlphaComponent(0.16).setStroke()
    pill.lineWidth = 3
    pill.stroke()

    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center

    let attributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 38, weight: .heavy),
        .foregroundColor: NSColor(calibratedRed: 0.1, green: 0.09, blue: 0.08, alpha: 1),
        .paragraphStyle: paragraph
    ]

    let string = NSAttributedString(string: title, attributes: attributes)
    string.draw(in: rect.insetBy(dx: 12, dy: 21))
}
