import Foundation

func matches(for regex: String, in text: String) -> [String] {
    
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

func removeAndparseFilters(text: String) -> [Any] {
    let match = matches(for: "\\S*:\\S*", in: text)
    var t = text
    var out = [Any]()
    match.forEach { (filter) in
        let split = filter.split(separator: ":")
        let name = String(split[0])
        let f = String(split[1])
        out.append([name, f])
        // remove text
        if let range = text.range(of: filter) {
            t.removeSubrange(range)
        }
        
    }
    out.append(t)
    return out
}


let text = "Why? type:article"

let object: [Any] = removeAndparseFilters(text: text)
