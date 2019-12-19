//
//  MovieService.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import NetworkLayer

enum MovieService {
    case popularMovies
    case movie(id: Int)
}

extension MovieService: NetworkService {
    var baseURL: URL { URL(string: "https://api.themoviedb.org/3")! }

    var path: String {
        switch self {
        case .popularMovies: return "/movie/popular"
        case .movie(let id): return "/movie/\(id)"
        }
    }

    var method: HTTPMethod { .get }

    var task: HTTPTask { .requestPlain }

    var headers: Headers? { nil }

}