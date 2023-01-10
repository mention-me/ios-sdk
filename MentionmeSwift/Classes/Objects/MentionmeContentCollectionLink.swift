//
//  MentionmeContentCollectionLink.swift
//  TestMentionme
//
//  Created by Andreas Bagias on 05/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeContentCollectionLink {

  /**
     * Relationship of the link between the two resources
     */
  public var relationship: String = ""
  /**
     * The target resource being linked
     */
  public var resource: [MentionmeContent]?

  init(withDictionary dict: NSDictionary) {

    if let relationship = dict["relationship"] as? String {
      self.relationship = relationship
    }
    if let resourceDicts = dict["resource"] as? [NSDictionary] {
      resource = [MentionmeContent]()
      for resourceDict in resourceDicts {
        resource?.append(MentionmeContent(withDictionary: resourceDict))
      }
    }

  }

}
