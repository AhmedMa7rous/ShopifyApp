

import Foundation
struct Options : Codable {
	let id : Int?
	let product_id : Int?
	let name : String?
	let position : Int?
	let values : [String]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case product_id = "product_id"
		case name = "name"
		case position = "position"
		case values = "values"
	}


}
