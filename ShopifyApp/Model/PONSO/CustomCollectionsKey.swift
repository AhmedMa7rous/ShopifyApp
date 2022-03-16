
import Foundation
struct CustomCollectionsKey : Codable {
	let smart_collections : [Smart_collections]?

	enum CodingKeys: String, CodingKey {

		case smart_collections = "smart_collections"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		smart_collections = try values.decodeIfPresent([Smart_collections].self, forKey: .smart_collections)
	}

}
