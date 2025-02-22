//
//  AllEventsInteractorTest.swift
//  TimeKeeperTests
//
//  Created by Mina Ashna on 04/02/2025.
//

import Testing
@testable import TimeKeeper
import Foundation

// This is a Test Suite. It will run all the store properties for each @Test function.
struct Guide {

    
//    @Test("Save data successfully") func saveEvent() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
        // to stop the test if the condition is false
        //        try #require(something.isValid)
                
        // to safely unwrap optionals
        //        let method = try #require(paymentMethods.first)
        //        #expect(method.idDefault)
//            }
        
        //    @Test(.enabled(if: AppFeatures.isCommentingEnabled)) func enableIfTest() async throws {
        //
        //    }
        //    @Test(.disabled("Currently broken")) func brokenFunc() async throws {
        //
        //    }
        //    @Test(.disabled("Currently broken"),
        //        .bug("https://linktojiraissue.com", "Issue description")) func brokenFunc() async throws {
        //
        //    }
        //
        //    @Test(.timeLimit(.minutes(1))) func performanceExample() async throws {
        //
        //    }
        //
        //    @Test @available(iOS 17, *) func example() async throws {
        //
        //    }
        //
        //    @Test(.bug("https://linktojiraissue.com", "Issue description")) func flakyTest() {
        //
        //    }
        //      create custom Tag
        //    @Test(.tags(.critical)) func criticalfunc() async throws {
        //
        //    }
    
    
    
    // Parameterized testing
//    @Test("Names", arguments: [
//        "Alice",
//        "Grace",
//        "Charlie"
//    ]) func checkNameLength(_ name: String) async throws {
//        #require(name.contains("a"))
//        #expect(name.count >= 3)
//    }
    
    
//    pass if error happens and fail if error doesn't happen
//    @Test func brewTeaError() throws {
//        let teaLeaves = TeaLeaves(name: "EarlGrey", optimalBrewTime: 4)
//        // To check for any error
//        #expect(throws: (any Error).self) {
//            try teaLeaves.brew(forMinutes: 200)
//        }
//        or
//        
//        // To check for specific error
//        #expect(throws: BrewingError.self) {
//            try teaLeaves.brew(forMinutes: 200)
//        }
//    }
    
    
//    @Test func softServeIceCreamInCone() throws {
//        withKnownIssue {
//            try softServeMachine.makeSoftServe(in: .cone)
//        }
//    }
    
    
    // organize by sub suite
    @Suite("Warm deserts")
    struct WarmDeserts {
        @Test func applePie() async throws {
            
        }
    }
    
    @Suite("cold deserts")
    struct ColdDeserts {
        @Test func cheesecake() async throws {
            
        }
    }
}


// declare tags
//extension Tag {
//    @Tag static var caffeinated: Self 
//}
