import XCTest
@testable import HugoHttp

final class HugoHttpTests: XCTestCase {
    func testExample() throws {
        NetworkManager.shared.baseURL = "http://localhost:8848";
        testPost()
        testGet()
        testPut()
        testDel()
    }
    
    func testGet(){
        // 创建一个 XCTestExpectation 对象
       let expectation = XCTestExpectation(description: "Alamofire request")
        NetworkManager.shared.baseURL = "http://localhost:8848";
        NetworkManager.shared.get("/api/app/v1/user/1") { (res:APIResult<User>) in
            switch res {
            case .success(let data):
                print(true,"GET请求成功，返回数据：\(data)")
            case .failure(let code, let msg, let reson):
                print("GET请求失败，错误：\(code) \(msg) \(reson) ")
            }
            // 标记 XCTestExpectation 为已完成
           expectation.fulfill()
        }
        // 等待 XCTestExpectation 被满足或超时
        wait(for: [expectation], timeout: 10) // 这里设置一个适当的超时时间
    }
    func testPost(){
        // 创建一个 XCTestExpectation 对象
        let expectation = XCTestExpectation(description: "Alamofire request")
        //NetworkManager.shared.baseURL = "http://localhost:8848";
        let req = AddUserReq(age: 20, name: "sdfasdfa")
        NetworkManager.shared.post("/api/app/v1/user",parameters: req) { (res:APIResult<NullData>) in
            switch res {
            case .success(let data):
                print("Post请求成功，返回数据：\(data)")
            case .failure(let code, let msg, let reson):
                print("Post请求失败，错误：\(code) \(msg) \(reson) ")
            }
            // 标记 XCTestExpectation 为已完成
           expectation.fulfill()
        }
        // 等待 XCTestExpectation 被满足或超时
        wait(for: [expectation], timeout: 10) // 这里设置一个适当的超时时间
    }
    func testPut(){
        // 创建一个 XCTestExpectation 对象
        let expectation = XCTestExpectation(description: "Alamofire request")
       // NetworkManager.shared.baseURL = "http://localhost:8848";
        let req = UpdateUserReq(id:1,age: 20, name: "ios修改")
        NetworkManager.shared.put("/api/app/v1/user",parameters: req) { (res:APIResult<NullData>) in
            switch res {
            case .success(let data):
                print("Put请求成功，返回数据：\(data)")
            case .failure(let code, let msg, let reson):
                print("Put请求失败，错误：\(code) \(msg) \(reson) ")
            }
            // 标记 XCTestExpectation 为已完成
           expectation.fulfill()
        }
        // 等待 XCTestExpectation 被满足或超时
        wait(for: [expectation], timeout: 10) // 这里设置一个适当的超时时间
    }
    
    func testDel(){
        // 创建一个 XCTestExpectation 对象
       let expectation = XCTestExpectation(description: "Alamofire request")
       // NetworkManager.shared.baseURL = "http://localhost:8848";
        NetworkManager.shared.delete("/api/app/v1/user/1") { (res:APIResult<NullData>) in
            switch res {
            case .success(let data):
                print(true,"Del请求成功，返回数据：\(data)")
            case .failure(let code, let msg, let reson):
                print("Del请求失败，错误：\(code) \(msg) \(reson) ")
            }
            // 标记 XCTestExpectation 为已完成
           expectation.fulfill()
        }
        // 等待 XCTestExpectation 被满足或超时
        wait(for: [expectation], timeout: 10) // 这里设置一个适当的超时时间
    }
}
