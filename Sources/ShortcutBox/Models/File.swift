//
//  Created by Artem Novichkov on 05.05.2021.
//

import Foundation

struct File: Encodable {

    let type: String
    let size: Int = 5081
    let truncated: Bool = false
    let language: String? = nil
    let content: String
}
