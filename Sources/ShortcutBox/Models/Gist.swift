//
//  Created by Artem Novichkov on 05.05.2021.
//

import Foundation

struct Gist: Encodable {

    let description: String
    let files: [String: File]
}
