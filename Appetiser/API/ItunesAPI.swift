//
//  GedditAPI.swift
//  Core
//
//  Created by Alvin John Tandoc on 19/03/2020.
//  Copyright © 2020 Alvin John Tandoc. All rights reserved.
//

import Foundation
import Moya

enum MediaType: String {
    case music
    case movie
}

private enum Constants {
	static let baseUrl = "https://itunes.apple.com"
	
	static let searchPath = "search"
}

enum ItunesAPI {
    case search(keyword: String, country: String, media: MediaType)
}

extension ItunesAPI: TargetType {
	
	public var sampleData: Data {return Data() }
	
	public var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	public var baseURL: URL {
		return URL(string: Constants.baseUrl)!
	}
	
	public var path: String {
		switch self {
        case .search:
            return Constants.searchPath
		}
	}
	
	public var method: Moya.Method {
		switch self {
        case .search:
			return .get
		}
	}
		
	public var task: Task {
		return .requestParameters(parameters: params, encoding: parameterEncoding)
	}

	private var parameterEncoding: ParameterEncoding {
		switch self {
        case .search:
			return URLEncoding()
		}
	}
	
	private var params: [String: Any] {
		switch self {
		case .search(let keyword, let country, let media):
            return ["term": keyword, "country": country, "media": media.rawValue]
		}
	}
	
}

