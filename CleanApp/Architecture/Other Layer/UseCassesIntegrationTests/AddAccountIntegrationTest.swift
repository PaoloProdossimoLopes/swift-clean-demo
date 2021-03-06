import XCTest // <- Standard

import Data // <- Personal
import Infra // <- Personal
import Domain // <- Personal

final class AddAccountIntegrationTest: XCTestCase {

    func test_add_account() {
        //executeTest()
    }
    
    private func executeTest() {
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let adapter = AlamofireAdapter()
        let sut = RemoteAddAccount(to: url, client: adapter)
        let model = AddAccountModel(
            name: "Carlos", email: "ccCarlos@gmail.com",
            password: "secret", passwordConfirmation: "secret"
        )
        
        let expectation = XCTestExpectation(description: "waiting")
        sut.add(model: model) { result in
            switch result {
            case .failure:
                XCTFail("Expected success ...")
            case .success(let accountModel):
                XCTAssertNotNil(accountModel.id)
                XCTAssertEqual(accountModel.name, model.name)
                XCTAssertEqual(accountModel.email, model.email)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 7)
    }
}
