//
//  LossyField.swift
//  LetMeCook
//
//  Created by Vengatesan Ganesan on 27/6/2026.
//

@propertyWrapper
struct LossyField<T: Decodable>: Decodable {
    
    var wrappedValue: T?
    
    init(wrappedValue: T? = nil) {
        self.wrappedValue = wrappedValue
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try? container.decode(T.self)
    }
}

extension LossyField: Sendable where T: Sendable {}
