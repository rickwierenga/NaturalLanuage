import NaturalLanguage

enum Emotion: String {
    case superSad = "😭"
    case sad = "😢"
    case unhappy = "😕"
    case OK = "🙂"
    case happy = "😁"
    case awesome = "🤩"
    
    init?(score: Double) {
        if score < -0.8 {
            self = .superSad
        } else if score < -0.4 {
            self = .sad
        } else if score < 0 {
            self = .unhappy
        } else if score < 0.4 {
            self = .OK
        } else if score < 0.8 {
            self = .happy
        } else if score <= 1 {
            self = .awesome
        } else {
            return nil
        }
    }
}
    
func emojiForExpression(_ epxression: String) -> Emotion? {
    let tagger = NLTagger(tagSchemes: [.sentimentScore])
    tagger.string = epxression
    
    if let sentiment = tagger.tag(at: epxression.startIndex, unit: .paragraph, scheme: .sentimentScore).0,
        let score = Double(sentiment.rawValue) {
        return Emotion(score: score)
    }
    return nil
}

emojiForExpression("Test")?.rawValue
emojiForExpression("This is good.")?.rawValue
emojiForExpression("It's fabulous!")?.rawValue // wrong
emojiForExpression("It was OK at first, but it got boring towards the end.")?.rawValue
emojiForExpression("We're having an amazing time!")?.rawValue
emojiForExpression("I'm depressed.")?.rawValue // wrong
