////
////  Genome+Json.swift
////  Genome
////
////  Created by Logan Wright on 2/11/16.
////  Copyright © 2016 lowriDevs. All rights reserved.
////
//
//import PureJsonSerializer
//
//// MARK: BackingData
//
//extension Json: BackingData {
//    public func toNode() -> Node {
//        switch self {
//        case let .string(str):
//            return .string(str)
//        case let .number(num):
//            return .number(num)
//        case let .bool(bool):
//            return .bool(bool)
//        case let .array(arr):
//            let mapped = arr.map { $0.toNode() }
//            return .array(mapped)
//        case let .object(obj):
//            var mutable: [String : Node] = [:]
//            obj.forEach { key, val in
//                mutable[key] = val.toNode()
//            }
//            return .object(mutable)
//        case .null:
//            return .null
//        }
//    }
//    
//    public static func makeWith(node: Node, context: Context) -> Json {
//        switch node {
//        case let .string(str):
//            return .string(str)
//        case let .number(num):
//            return .number(num)
//        case let .bool(bool):
//            return .bool(bool)
//        case let .array(arr):
//            let mapped = arr.map { Json.makeWith($0, context: context) }
//            return .array(mapped)
//        case let .object(obj):
//            var mutable: [String : Json] = [:]
//            obj.forEach { key, val in
//                mutable[key] = Json.makeWith(node, context: context)
//            }
//            return .object(mutable)
//        case .null:
//            return .null
//        }
//
//    }
//}
//
//// MARK: Convenience
//
//extension MappableBase {
//    public func toJson() throws -> Json {
//        let node = try toNode()
//        return try node.toData()
//    }
//}
//
//extension NodeConvertible {
//    public func toJson() throws -> Json {
//        let node = try toNode()
//        return try node.toData()
//    }
//}
//
//extension Sequence where Iterator.Element: NodeConvertible {
//    public func toJson() throws -> Json {
//        let array = try map { try $0.toJson() }
//        return .init(array)
//    }
//}
//
//extension Dictionary where Key: CustomStringConvertible, Value: NodeConvertible {
//    public func toJson() throws -> Json {
//        var mutable: [String : Json] = [:]
//        try self.forEach { key, value in
//            mutable["\(key)"] = try value.toJson()
//        }
//        return .object(mutable)
//    }
//}
//
//extension Map {
//    public var json: Json {
//        return Json.makeWith(node, context: node)
//    }
//}
//
//// MARK: Deprecations
//
//extension MappableObject {
//    public init(js: Json, context: Context = EmptyNode) throws {
//        try self.init(node: js, context: context)
//    }
//}
//
//public protocol JsonConvertibleType: NodeConvertible {
//    static func makeWith(json: Json, context: Context) throws -> Self
//    func toJson() throws -> Json
//}
//
//extension JsonConvertibleType {
//    static func makeWith(node: Node, context: Context) throws -> Self {
//        let json: Json = try node.toData()
//        return try makeWith(json, context: context)
//    }
//    
//    func toNode() throws -> Node {
//        return try toJson().toNode()
//    }
//}
//
//// MARK: Json
//
//extension Json : JsonConvertibleType {
//    public static func makeWith(json: Json, context: Context = EmptyNode) -> Json {
//        return json
//    }
//    
//    public func toJson() -> Json {
//        return self
//    }
//}
//
//// MARK: Deprecations
//
//@available(*, deprecated: 3.0, renamed: "EmptyNode")
//public let EmptyJson = Json.object([:])
//
//extension Map {
//    @available(*, deprecated: 3.0, renamed: "init(node: context: default)")
//    public convenience init(json: Json, context: Context = EmptyNode) {
//        self.init(node: json, context: context)
//    }
//}
//
//extension Array where Element : JsonConvertibleType {
//    @available(*, deprecated: 3.0, renamed: "init(node: context:)")
//    public init(js: Json, context: Context = EmptyJson) throws {
//        let array = js.arrayValue ?? [js]
//        try self.init(js: array, context: context)
//    }
//    
//    @available(*, deprecated: 3.0, renamed: "init(node: context:)")
//    public init(js: [Json], context: Context = EmptyJson) throws {
//        self = try js.map { try Element.makeWith($0, context: context) }
//    }
//}
//
//extension Set where Element : JsonConvertibleType {
//    @available(*, deprecated: 3.0, renamed: "init(node: context:)")
//    public init(js: Json, context: Context = EmptyJson) throws {
//        let array = js.arrayValue ?? [js]
//        try self.init(js: array, context: context)
//    }
//    
//    @available(*, deprecated: 3.0, renamed: "init(node: context:)")
//    public init(js: [Json], context: Context = EmptyJson) throws {
//        let array = try js.map { try Element.makeWith($0, context: context) }
//        self.init(array)
//    }
//}
//
//extension FromNodeTransformer {
//    @available(*, deprecated: 3.0, renamed: "transformToNode")
//    public func transformToJson<OutputJsonType: NodeConvertible>(transformer: TransformedType throws -> OutputJsonType) -> TwoWayTransformer<NodeType, TransformedType, OutputJsonType> {
//        let toJsonTransformer = ToNodeTransformer(map: map, transformer: transformer)
//        return TwoWayTransformer(fromNodeTransformer: self, toNodeTransformer: toJsonTransformer)
//    }
//}
//
//extension ToNodeTransformer {
//    @available(*, deprecated: 3.0, renamed: "transformFromNode")
//    public func transformFromJson<InputJsonType>(transformer: InputJsonType throws -> ValueType) -> TwoWayTransformer<InputJsonType, ValueType, OutputNodeType> {
//        let fromJsonTransformer = FromNodeTransformer(map: map, transformer: transformer)
//        return TwoWayTransformer(fromNodeTransformer: fromJsonTransformer, toNodeTransformer: self)
//    }
//    
//    @available(*, deprecated: 3.0, renamed: "transformFromNode")
//    public func transformFromJson<InputJsonType>(transformer: InputJsonType? throws -> ValueType) -> TwoWayTransformer<InputJsonType, ValueType, OutputNodeType> {
//        let fromJsonTransformer = FromNodeTransformer(map: map, transformer: transformer)
//        return TwoWayTransformer(fromNodeTransformer: fromJsonTransformer, toNodeTransformer: self)
//    }
//}
//
//public extension Map {
//    @available(*, deprecated: 3.0, renamed: "transformFromNode")
//    public func transformFromJson<JsonType: NodeConvertible, TransformedType>(transformer: JsonType throws -> TransformedType) -> FromNodeTransformer<JsonType, TransformedType> {
//        return FromNodeTransformer(map: self, transformer: transformer)
//    }
//    
//    @available(*, deprecated: 3.0, renamed: "transformFromNode")
//    public func transformFromJson<JsonType: NodeConvertible, TransformedType>(transformer: JsonType? throws -> TransformedType) -> FromNodeTransformer<JsonType, TransformedType> {
//        return FromNodeTransformer(map: self, transformer: transformer)
//    }
//    
//    @available(*, deprecated: 3.0, renamed: "transformToNode")
//    public func transformToJson<ValueType, JsonOutputType: NodeConvertible>(transformer: ValueType throws -> JsonOutputType) -> ToNodeTransformer<ValueType, JsonOutputType> {
//        return ToNodeTransformer(map: self, transformer: transformer)
//    }
//}