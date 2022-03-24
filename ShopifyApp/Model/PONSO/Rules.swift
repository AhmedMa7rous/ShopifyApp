

import Foundation
struct Rules : Codable {
	let column : String?
	let relation : String?
	let condition : String?

	enum CodingKeys: String, CodingKey {

		case column = "column"
		case relation = "relation"
		case condition = "condition"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		column = try values.decodeIfPresent(String.self, forKey: .column)
		relation = try values.decodeIfPresent(String.self, forKey: .relation)
		condition = try values.decodeIfPresent(String.self, forKey: .condition)
	}

}
