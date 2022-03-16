

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

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		id = try values.decodeIfPresent(Int.self, forKey: .id)
//		product_id = try values.decodeIfPresent(Int.self, forKey: .product_id)
//		name = try values.decodeIfPresent(String.self, forKey: .name)
//		position = try values.decodeIfPresent(Int.self, forKey: .position)
//		values = try values.decodeIfPresent([String].self, forKey: .values)
//	}

}
