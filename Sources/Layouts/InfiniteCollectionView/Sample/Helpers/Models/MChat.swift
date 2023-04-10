

import Foundation
import UIKit

struct MChat: Decodable, Hashable {
    var id: UUID?
    var friendName: String
    var friendImage: String
    var lastMessage: String
}
