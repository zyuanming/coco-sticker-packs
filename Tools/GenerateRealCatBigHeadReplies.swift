import AppKit
import Foundation

struct BigHeadCatSticker {
    let id: String
    let title: String
    let caption: String
    let fileTitle: String
    let sourceURL: String
    let license: String
    let author: String
    let zoom: CGFloat
    let offset: CGPoint
}

let stickers: [BigHeadCatSticker] = [
    BigHeadCatSticker(
        id: "real_cat_big_head_huh",
        title: "啊猫",
        caption: "啊?",
        fileTitle: "Alerted_Cat_(117884479)_(2015;_cropped_2025).jpeg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Alerted_Cat_(117884479)_(2015;_cropped_2025).jpeg",
        license: "CC BY 3.0",
        author: "Ashkan Baharlooe",
        zoom: 1.58,
        offset: CGPoint(x: 0, y: -10)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_help",
        title: "救命猫",
        caption: "救命",
        fileTitle: "Surprised_cat_at_night.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Surprised_cat_at_night.jpg",
        license: "CC BY 4.0",
        author: "Feitidede",
        zoom: 1.52,
        offset: CGPoint(x: 0, y: -4)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_speechless",
        title: "无语猫",
        caption: "无语",
        fileTitle: "Cat_facepalm_1.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Cat_facepalm_1.jpg",
        license: "CC BY-SA 2.0",
        author: "barbostick",
        zoom: 1.36,
        offset: CGPoint(x: 0, y: 4)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_read_wrong",
        title: "乱回猫",
        caption: "已读乱回",
        fileTitle: "Kotetsu_the_Ginger_Cat_double_Facepalming_2011-08-13.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Kotetsu_the_Ginger_Cat_double_Facepalming_2011-08-13.jpg",
        license: "CC BY 2.0",
        author: "yoppy",
        zoom: 1.2,
        offset: CGPoint(x: 0, y: 8)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_lol",
        title: "笑死猫",
        caption: "笑死",
        fileTitle: "LaughingRoofCatGreece.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:LaughingRoofCatGreece.jpg",
        license: "CC BY 2.0",
        author: "DrPete / Pete Coleman",
        zoom: 1.42,
        offset: CGPoint(x: -6, y: 0)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_right",
        title: "你说得对猫",
        caption: "你说得对",
        fileTitle: "British_Shorthair_Smiling.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:British_Shorthair_Smiling.jpg",
        license: "CC BY-SA 4.0",
        author: "Plopatries",
        zoom: 1.48,
        offset: CGPoint(x: 0, y: -6)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_steady",
        title: "稳了猫",
        caption: "稳了",
        fileTitle: "Pleased-looking_cat.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Pleased-looking_cat.jpg",
        license: "CC BY 2.0",
        author: "steve p2008",
        zoom: 1.5,
        offset: CGPoint(x: 2, y: -8)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_blep",
        title: "略略猫",
        caption: "略略略",
        fileTitle: "A_cat_sticks_out_its_tongue.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:A_cat_sticks_out_its_tongue.jpg",
        license: "CC BY-SA 4.0",
        author: "דג קטן",
        zoom: 1.46,
        offset: CGPoint(x: 0, y: -8)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_confused",
        title: "不理解猫",
        caption: "我不理解",
        fileTitle: "False_alarm_-a.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:False_alarm_-a.jpg",
        license: "CC BY 2.0",
        author: "Antti",
        zoom: 1.24,
        offset: CGPoint(x: -2, y: 12)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_dont",
        title: "别惹猫",
        caption: "别惹我",
        fileTitle: "Angry_Cat_(14564413376).jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Angry_Cat_(14564413376).jpg",
        license: "CC BY 2.0",
        author: "James Arup Photography",
        zoom: 1.4,
        offset: CGPoint(x: 0, y: -2)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_angry",
        title: "生气猫",
        caption: "生气了",
        fileTitle: "Cat_Hiss.png",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Cat_Hiss.png",
        license: "CC BY-SA 4.0",
        author: "Asklepios",
        zoom: 1.38,
        offset: CGPoint(x: 4, y: 0)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_tired",
        title: "累了猫",
        caption: "累了",
        fileTitle: "Am_I_Boring_You?.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Am_I_Boring_You%3F.jpg",
        license: "CC BY-SA 2.0",
        author: "Seth Anderson",
        zoom: 1.75,
        offset: CGPoint(x: 250, y: -40)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_crash",
        title: "崩溃猫",
        caption: "崩溃",
        fileTitle: "Cat_yawn_with_exposed_teeth_and_claws.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Cat_yawn_with_exposed_teeth_and_claws.jpg",
        license: "CC BY-SA 4.0",
        author: "DecafPotato",
        zoom: 1.26,
        offset: CGPoint(x: 0, y: 4)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_blank",
        title: "发呆猫",
        caption: "发呆",
        fileTitle: "ChausieBGT.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:ChausieBGT.jpg",
        license: "CC0",
        author: "PiBeseth",
        zoom: 1.5,
        offset: CGPoint(x: -105, y: -80)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_busy",
        title: "在忙猫",
        caption: "在忙",
        fileTitle: "BusinessCat_2006_(cropped).jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:BusinessCat_2006_(cropped).jpg",
        license: "CC BY 2.0",
        author: "Paulo Ordoveza",
        zoom: 1.16,
        offset: CGPoint(x: 0, y: 18)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_ok",
        title: "可以猫",
        caption: "可以",
        fileTitle: "Cat_wearing_sunglasses.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Cat_wearing_sunglasses.jpg",
        license: "CC BY-SA 4.0",
        author: "Smirkybec",
        zoom: 1.3,
        offset: CGPoint(x: 0, y: 4)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_closed",
        title: "不营业猫",
        caption: "不营业",
        fileTitle: "Dont_bother_me_(311536232).jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Dont_bother_me_(311536232).jpg",
        license: "CC BY 2.0",
        author: "Dwight Sipler",
        zoom: 1.3,
        offset: CGPoint(x: 0, y: 8)
    ),
    BigHeadCatSticker(
        id: "real_cat_big_head_yay",
        title: "好耶猫",
        caption: "好耶",
        fileTitle: "Happy-looking_cat.jpg",
        sourceURL: "https://commons.wikimedia.org/wiki/File:Happy-looking_cat.jpg",
        license: "CC BY 2.0",
        author: "Phelyan Sanjoin",
        zoom: 1.44,
        offset: CGPoint(x: 0, y: -4)
    )
]

let outputDirectory = URL(fileURLWithPath: CommandLine.arguments.dropFirst().first ?? "packs/real-cat-big-head-replies-v1/stickers")
try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)

for sticker in stickers {
    let data = try fetchCommonsImage(fileTitle: sticker.fileTitle)
    guard let image = NSImage(data: data) else {
        throw CocoaError(.fileReadCorruptFile)
    }

    let rendered = drawSticker(source: image, sticker: sticker)
    guard let tiffData = rendered.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiffData),
          let pngData = bitmap.representation(using: .png, properties: [.compressionFactor: 0.86]) else {
        throw CocoaError(.fileWriteUnknown)
    }

    try pngData.write(to: outputDirectory.appendingPathComponent("\(sticker.id).png"), options: .atomic)
    Thread.sleep(forTimeInterval: 0.8)
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
            request.timeoutInterval = 35
            return try fetchData(request: request)
        } catch {
            lastError = error
            Thread.sleep(forTimeInterval: Double(attempt) * 1.3)
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

private func drawSticker(source: NSImage, sticker: BigHeadCatSticker) -> NSImage {
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

    let stickerRect = NSRect(x: 34, y: 88, width: 444, height: 378)
    let imageRect = stickerRect.insetBy(dx: 13, dy: 13)
    let outlinePath = NSBezierPath(roundedRect: stickerRect, xRadius: 56, yRadius: 56)
    let imagePath = NSBezierPath(roundedRect: imageRect, xRadius: 44, yRadius: 44)

    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.24)
    shadow.shadowBlurRadius = 18
    shadow.shadowOffset = NSSize(width: 0, height: -8)
    shadow.set()
    NSColor.white.setFill()
    outlinePath.fill()
    NSShadow().set()

    NSGraphicsContext.saveGraphicsState()
    imagePath.addClip()
    drawAspectFill(source, in: imageRect, zoom: sticker.zoom, offset: sticker.offset)
    NSGraphicsContext.restoreGraphicsState()

    NSColor.white.setStroke()
    outlinePath.lineWidth = 16
    outlinePath.stroke()

    drawCaption(sticker.caption, in: NSRect(x: 48, y: 38, width: 416, height: 96))

    let image = NSImage(size: size)
    image.addRepresentation(bitmap)
    return image
}

private func drawAspectFill(_ image: NSImage, in rect: NSRect, zoom: CGFloat, offset: CGPoint) {
    let imageSize = image.size
    let scale = max(rect.width / imageSize.width, rect.height / imageSize.height) * zoom
    let drawSize = NSSize(width: imageSize.width * scale, height: imageSize.height * scale)
    let drawRect = NSRect(
        x: rect.midX - drawSize.width / 2 + offset.x,
        y: rect.midY - drawSize.height / 2 + offset.y,
        width: drawSize.width,
        height: drawSize.height
    )
    image.draw(in: drawRect, from: .zero, operation: .sourceOver, fraction: 1)
}

private func drawCaption(_ caption: String, in rect: NSRect) {
    let pill = NSBezierPath(roundedRect: rect, xRadius: 40, yRadius: 40)

    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.2)
    shadow.shadowBlurRadius = 10
    shadow.shadowOffset = NSSize(width: 0, height: -4)
    shadow.set()
    NSColor.white.withAlphaComponent(0.96).setFill()
    pill.fill()
    NSShadow().set()

    NSColor.black.withAlphaComponent(0.12).setStroke()
    pill.lineWidth = 3
    pill.stroke()

    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    paragraph.lineBreakMode = .byClipping

    let fontSize: CGFloat
    switch caption.count {
    case 0...2:
        fontSize = 56
    case 3...4:
        fontSize = 50
    default:
        fontSize = 42
    }

    let attributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: fontSize, weight: .heavy),
        .foregroundColor: NSColor(calibratedRed: 0.08, green: 0.08, blue: 0.08, alpha: 1),
        .paragraphStyle: paragraph,
        .strokeColor: NSColor.white,
        .strokeWidth: -2
    ]

    let textRect = rect.insetBy(dx: 16, dy: 18)
    (caption as NSString).draw(in: textRect, withAttributes: attributes)
}
