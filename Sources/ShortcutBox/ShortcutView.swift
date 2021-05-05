//
//  Created by Artem Novichkov on 05.05.2021.
//

import SwiftUI

struct ShortcutView: View {
    
    let shortcut: Shortcut
    
    var body: some View {
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

struct ShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutView(shortcut: .init(key: "⌃ + ⌘ + E", command: "Edit all in scope"))
    }
}
