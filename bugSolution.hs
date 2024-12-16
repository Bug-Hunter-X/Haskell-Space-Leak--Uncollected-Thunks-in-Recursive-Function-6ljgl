The solution is to force evaluation of the `expensiveCalculation` result to prevent thunk accumulation.  This can be achieved using a strict version of addition:

```haskell
import Data.Maybe (fromMaybe)

data = [Just 1, Nothing, Just 2, Just 3, Nothing]

calculate :: [Maybe Int] -> Maybe Int
calculate [] = Nothing
calculate (x:xs) = case x of
  Just n -> Just $! n + fromMaybe 0 (calculate xs)
  Nothing -> calculate xs

expensiveCalculation :: Int -> Int
expensiveCalculation n = sum [1..n*1000000]

main :: IO ()
main = do
  let result = calculate data
  print result
```

The `$!` operator forces strict evaluation of the right-hand expression. This ensures that `expensiveCalculation` is executed immediately, preventing the creation of lingering thunks.  The exclamation mark is crucial for strict evaluation in the context of the `+` operator.