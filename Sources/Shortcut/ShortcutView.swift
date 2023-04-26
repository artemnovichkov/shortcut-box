//
//  Created by Artem Novichkov on 05.05.2021.
//

import SwiftUI
import AppKit

public struct ShortcutView: View {
    
    public let shortcut: Shortcut
    
    public init(shortcut: Shortcut) {
        self.shortcut = shortcut
    }
    
    public var body: some View {
        ZStack {
            Color(nsColor: .windowBackgroundColor)
            VStack(alignment: .leading, spacing: 4) {
                Text(shortcut.key)
                    .font(.title)
                    .foregroundColor(Color(nsColor: .labelColor))
                Text(shortcut.command)
                    .font(.body)
                    .foregroundColor(Color(nsColor: .tertiaryLabelColor))
            }
        }
    }
}

public extension ShortcutView {

    @MainActor
    func makeImageData(size: CGSize) -> Data? {
        let imageRenderer = ImageRenderer(content: self.frame(width: size.width, height: size.height))
        guard let cgImage = imageRenderer.cgImage else {
            return nil
        }
        let bitmapImageRep = NSBitmapImageRep(cgImage: cgImage)
        return bitmapImageRep.representation(using: .jpeg, properties: [:])
    }
}

struct ShortcutView_Previews: PreviewProvider {

    static var previews: some View {
        ShortcutView(shortcut: .init(key: "⌃ + ⌘ + E",
                                     command: "Edit all in scope"))
        .previewLayout(.fixed(width: 422, height: 100))
    }
}
