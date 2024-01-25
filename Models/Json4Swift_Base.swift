/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Json4Swift_Base : Codable {

	let results : [Results]?

	enum CodingKeys: String, CodingKey {


		case results = "results"
	}


}
struct Results : Codable {
    let slug_name : String?
    let section : String?
    let subsection : String
    let title : String
    let abstract : String
    let uri : String
    let url : String
    let byline : String?
    let item_type : String?
    let source : String?
    let updated_date : String?
    let created_date : String?
    let published_date : String?
    let first_published_date : String?
    let material_type_facet : String?
    let kicker : String?
    let multimedia : [Multimedia]?

    enum CodingKeys: String, CodingKey {

        case slug_name = "slug_name"
        case section = "section"
        case subsection = "subsection"
        case title = "title"
        case abstract = "abstract"
        case uri = "uri"
        case url = "url"
        case byline = "byline"
        case item_type = "item_type"
        case source = "source"
        case updated_date = "updated_date"
        case created_date = "created_date"
        case published_date = "published_date"
        case first_published_date = "first_published_date"
        case material_type_facet = "material_type_facet"
        case kicker = "kicker"
        case multimedia = "multimedia"
    }

    

}

struct Multimedia : Codable {
    let urls : String?
    let format : String?
    let height : Int?
    let width : Int?
    let type : String?
    let subtype : String?
    let caption : String?
    let copyright : String?

    enum CodingKeys: String, CodingKey {

        case urls = "url"
        case format = "format"
        case height = "height"
        case width = "width"
        case type = "type"
        case subtype = "subtype"
        case caption = "caption"
        case copyright = "copyright"
    }

}


