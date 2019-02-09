import Foundation

let url = URL(string: "https://raw.githubusercontent.com/stopwords-iso/stopwords-iso/master/stopwords-iso.json")!
let text = "Why? type:article"
// Result: ["eat", "pizza", "chopsticks"]
func extract(text: String, stop: [String: Any], lang: String = "en") -> [String] {
    let stops = stop[lang] as! [String]
    let tokens = text.components(separatedBy: .punctuationCharacters)
        .joined()
        .components(separatedBy: .whitespaces)
        .filter{!$0.isEmpty}
    var out = [String]()
    tokens.forEach { (str) in
        if !stops.contains(str.lowercased()) {
            out.append(str)
        }
    }
    if !out.isEmpty {
        return out
    }
    return tokens
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


