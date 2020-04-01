//: [Previous](@previous)

import Foundation

//https://github.com/Wolox/ios-style-guide/blob/master/rules/avoid-struct-closure-self.md

struct PredictionChallengeRequest {
    var path: String{ return "http://www.google.com" }
}

struct PredictionChallengeResponse: Decodable {
    let id: Int
    let name: String
    let isActive: Bool
    let isOpen: Bool
}


struct Service<T: Decodable>{
    func request(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://www.stackoverflow.com")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            completion(Result.success(data))
        }

        task.resume()
    }
}

protocol NovileagueGeneralInfoManagerDelegate: class {
    func generalInfoManager(didFetch challengeResponse: Data)
    func generalInfoManager(_:PredictionChallengeRequest, didFail error: Error)
}


struct NovileagueGeneralInfoManager {
    weak var delegate: NovileagueGeneralInfoManagerDelegate?

    func fetchChallenge() {
        let request = PredictionChallengeRequest()
        let service = Service<PredictionChallengeResponse>()
        
        service.request() { [self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("success")
                    self.delegate?.generalInfoManager(didFetch: response)
                case .failure(let error):
                    self.delegate?.generalInfoManager(request,didFail: error)
                    print("fail")
                }
            }
        }
    }
}


class ViewModel:NovileagueGeneralInfoManagerDelegate{
    var manager = NovileagueGeneralInfoManager()
    
    init(){
        manager.delegate = self
        manager.fetchChallenge()
    }
    
    
    func generalInfoManager(_:PredictionChallengeRequest, didFail error: Error){}
    func generalInfoManager(didFetch challengeResponse: Data) {}
}

let vm = ViewModel()

//: [Next](@next)
