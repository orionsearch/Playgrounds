import Foundation

let url = URL(string: "https://raw.githubusercontent.com/stopwords-iso/stopwords-iso/master/stopwords-iso.json")!
let text = "Why?"
// Result: ["eat", "pizza", "chopsticks"]
func extract(text: String, stop: [String: Any], lang: String = "en") -> [String] {
    let stops = stop[lang] as! [String]
    let tokens = text.split(separator: " ")
    var out = [String]()
    tokens.forEach { (substr) in
        if !stops.contains(String(substr).lowercased()) {
            out.append(String(substr))
        }
    }
    if !out.isEmpty {
        return out
    }
    return tokens.map { String($0) }
}

URLSession.shared.dataTask(with: url) { (data, response, error) in
    if error != nil {
        print(error!.localizedDescription)
    }
    
    guard let data = data else { return }
    //Implement JSON decoding and parsing
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let words = extract(text: text, stop: json)
        print(words[0])
    } catch let jsonError {
        print(jsonError)
    }
    
    
}.resume()


