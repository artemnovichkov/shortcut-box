//
//  Created by Artem Novichkov on 05.05.2021.
//

import SwiftUI

public struct ShortcutView: View {
    
    public let shortcut: Shortcut
    
    public init(shortcut: Shortcut) {
        self.shortcut = shortcut
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(shortcut.key)
                .font(.title)
                .foregroundColor(Color.black)
            Text(shortcut.command)
                .font(.body)
                .foregroundColor(Color.gray)
        }
        .padding()
    }
}
