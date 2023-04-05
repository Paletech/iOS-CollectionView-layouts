
import Foundation
import UIKit

struct MSection: Decodable, Hashable {
    var type: String
    var title: String
    var items: [MChat]
}
