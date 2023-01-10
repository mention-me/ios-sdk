//
//  MentionmeReferrerEnrollment.swift
//  MentionmeSwift
//
//  Created by Andreas Bagias on 11/03/2019.
//  Copyright © 2019 Mention-me. All rights reserved.
//

import Foundation

public class MentionmeReferrerEnrollmentRequest: MentionmeRequest {

  public override init() {
    super.init()

    super.method = MethodType.post
    super.urlSuffix = "referrer"
    super.urlEndpoint = "entry-point"

  }

  func createBodyParameters() {
    bodyParameters = [String: Any]()
  }

  override func createRequest(requestParameters: MentionmeRequestParameters) -> NSMutableURLRequest
  {
    createBodyParameters()
    return super.createRequest(requestParameters: requestParameters)
  }

}
