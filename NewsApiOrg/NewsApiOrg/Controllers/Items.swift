//
//  Items.swift
//  NewsApiOrg
//
//  Created by deniss.lobacs on 20/11/2021.
//

import CoreData

@objc(Items)
class Item: NSManagedObject {
    @NSManaged var image: String
    @NSManaged var newsContent: String
    @NSManaged var newsTitle: String
    @NSManaged var url: String
}
