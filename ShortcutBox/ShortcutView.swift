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
            Text(shortcut.command)
                .font(.body)
                .foregroundColor(Color.gray)
        }
        .padding()
    }
}
