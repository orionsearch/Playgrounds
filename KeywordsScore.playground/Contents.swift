import Foundation

let extracted = ["pizza", "chopsticks", "pizza", "restaurant"]

func scoreKeywords(keys: [String]) -> [String: Double] {
    let l = keys.count
    let uniq = Array(Set(keys))
    var out: [String: Double] = [:]
    uniq.forEach { (key) in
        let n = keys.enumerated()
                .compactMap { $0.element == key ? $0.offset : nil }
                .count
        let d = Double(n)
        let ld = Double(l)
        out[key] = d / ld
    }
    return out
}

let scores = scoreKeywords(keys: extracted)
