//
//  Experience.swift
//  Pods
//
//  Created by Cesar on 9/9/15.
//
//

import Foundation



public final class Experience: ResponseObject,ResponseCollection {
    public let name: String
    public let plans: [Plan]
    public let uuid: String
   
    @objc required public init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.name = representation.valueForKeyPath("name") as! String
        self.plans = Plan.collection(response:response, representation: representation.valueForKeyPath("plans")!)
        self.uuid = representation.valueForKeyPath("uuid") as! String
    }
    
    
    @objc public static func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [Experience] {
        var experiences: [Experience] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for experienceRepresentation in representation {
                if let experience = Experience(response: response, representation: experienceRepresentation) {
                    experiences.append(experience)
                }
            }
        }
        return experiences
    }
}