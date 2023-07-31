//
//  CustomErrors.swift
//  OneStepTodo
//
//  Created by Yang Jianqi on 2023/7/29.
//
import Foundation

enum Error: Swift.Error, CustomLocalizedStringResourceConvertible {
    case notFound,
         coreDataSave,
         unknownId(id: String),
         unknownError(message: String),
         deletionFailed,
         addFailed(title: String)

    var localizedStringResource: LocalizedStringResource {
        switch self {
            case .addFailed(let title): return "An error occurred trying to add '\(title)'"
            case .deletionFailed: return "An error occured trying to delete the book"
            case .unknownError(let message): return "An unknown error occurred: \(message)"
            case .unknownId(let id): return "No books with an ID matching: \(id)"
            case .notFound: return "Book not found"
            case .coreDataSave: return "Couldn't save to CoreData"
        }
    }
}
