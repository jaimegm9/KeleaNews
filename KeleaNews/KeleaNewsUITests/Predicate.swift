//
//  Predicate.swift
//  KeleaNewsUITests
//
//  Created by jaime.gutierrez.m on 1/2/24.
//

import XCTest

enum Predicate {
    case contains(String), doesNotContain(String)
    case exists, doesNotExist
    case isHittable, isNotHittable

    var format: String {
        switch self {
        case .contains(let label):
            return "label == '\(label)'"
        case .doesNotContain(let label):
            return "label != '\(label)'"
        case .exists:
            return "exists == true"
        case .doesNotExist:
            return "exists == false"
        case .isHittable:
            return "isHittable == true"
        case .isNotHittable:
            return "isHittable == false"
        }
    }
}
