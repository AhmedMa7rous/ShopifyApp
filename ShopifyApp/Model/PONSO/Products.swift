

import Foundation
struct Products : Codable {
	let id : Int?
	let title : String?
	let body_html : String?
	let vendor : String?
	let product_type : String?
	let created_at : String?
	let handle : String?
	let updated_at : String?
	let published_at : String?
	let template_suffix : String?
	let status : String?
	let published_scope : String?
	let tags : String?
	let admin_graphql_api_id : String?
	let variants : [Variants]?
	let options : [Options]?
	let images : [Images]?
	let image : Image?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case body_html = "body_html"
		case vendor = "vendor"
		case product_type = "product_type"
		case created_at = "created_at"
		case handle = "handle"
		case updated_at = "updated_at"
		case published_at = "published_at"
		case template_suffix = "template_suffix"
		case status = "status"
		case published_scope = "published_scope"
		case tags = "tags"
		case admin_graphql_api_id = "admin_graphql_api_id"
		case variants = "variants"
		case options = "options"
		case images = "images"
		case image = "image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		body_html = try values.decodeIfPresent(String.self, forKey: .body_html)
		vendor = try values.decodeIfPresent(String.self, forKey: .vendor)
		product_type = try values.decodeIfPresent(String.self, forKey: .product_type)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		handle = try values.decodeIfPresent(String.self, forKey: .handle)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		published_at = try values.decodeIfPresent(String.self, forKey: .published_at)
		template_suffix = try values.decodeIfPresent(String.self, forKey: .template_suffix)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		published_scope = try values.decodeIfPresent(String.self, forKey: .published_scope)
		tags = try values.decodeIfPresent(String.self, forKey: .tags)
		admin_graphql_api_id = try values.decodeIfPresent(String.self, forKey: .admin_graphql_api_id)
		variants = try values.decodeIfPresent([Variants].self, forKey: .variants)
		options = try values.decodeIfPresent([Options].self, forKey: .options)
		images = try values.decodeIfPresent([Images].self, forKey: .images)
		image = try values.decodeIfPresent(Image.self, forKey: .image)
	}

}
