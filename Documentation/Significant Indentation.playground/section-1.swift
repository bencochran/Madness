import Box
import Madness
import Prelude

let newline = %"\n"
let header = ((%"#" * (1..<7)) --> { $0.count }) ++ ignore(%" ") ++ (any+ --> { "".join($0) }) ++ newline
