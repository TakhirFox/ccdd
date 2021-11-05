//
//  Contacts.swift
//  ccdd
//
//  Created by Zakirov Tahir on 05.11.2021.
//

import Foundation

struct Contacts: Decodable {
    let items: [ContactsItem]?
}

struct ContactsItem: Decodable {
    let id: String?
    let avatarURL: String?
    let firstName: String?
    let lastName: String?
    let userTag: String?
    let department: String?
    let position: String?
    let birthday: String?
    let phone: String?
}
