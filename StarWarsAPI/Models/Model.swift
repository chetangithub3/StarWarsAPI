//
//  Model.swift
//  StarWarsAPI
//
//  Created by Chetan Dhowlaghar on 9/11/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let model = try? newJSONDecoder().decode(Model.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.modelTask(with: url) { model, response, error in
//     if let model = model {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Model
struct Model: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.resultTask(with: url) { result, response, error in
//     if let result = result {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Result
struct Result: Codable {
    let name, height, mass, hairColor: String?
    let skinColor, eyeColor, birthYear: String?
    let gender: Gender?
    let homeworld: String?
    let films, species, vehicles, starships: [String]?
    let created, edited: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor
        case skinColor
        case eyeColor
        case birthYear
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
    case nA = "n/a"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func modelTask(with url: URL, completionHandler: @escaping (Model?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
