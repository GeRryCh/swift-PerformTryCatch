# swift-PerformTryCatch

Let's look at the example
```swift
func loadSearchData(matching query: String) throws -> Data {
    let urlString = "https://my.api.com/search?q=\(query)"

    guard let url = URL(string: urlString) else {
        throw SearchError.invalidQuery(query)
    }

    do {
        return try Data(contentsOf: url)
    } catch {
        throw SearchError.dataLoadingFailed(url)
    }
}
```

With this utility, you can rewrite the method in a cleaner way, without `do, try, catch` dance, which could quickly make our code harder to read, like this:

```swift
func loadSearchData(matching query: String) throws -> Data {
    let urlString = "https://my.api.com/search?q=\(query)"
    
    let url = try perform(??URL(string: urlString),
                          orThrow: SearchError.invalidQuery(query))
    
    return try perform(Data(contentsOf: url),
                       orThrow: SearchError.dataLoadingFailed(url))
}
```
> Note: In the example above used `?? infix operator` in order to convert optionals unwrapping syntax into  `try-catch` feature. For more information: https://github.com/GeRryCh/swift-tryOptional

`perform` method comes with variations (overloads) depends on how you want to treat errors. Read the documentation in the source file and have a look on the examples in Playground.

### The Story Behind

I came up with an idea while developing one of the work projects and implemented it myslef. Later on, I encountered this [article](https://www.swiftbysundell.com/articles/providing-a-unified-swift-error-api/) and discovered that the author also used the utility. I actually liked his utility method signature, which was slightly different from mine, as it made a little more sense. So, I must thank you [@johnsundell](https://twitter.com/johnsundell "John's Twitter") for `perform` method, and `loadData(matching query: String)` used as an example. 

P.S. That article is totally worth reading as many of his other great works!