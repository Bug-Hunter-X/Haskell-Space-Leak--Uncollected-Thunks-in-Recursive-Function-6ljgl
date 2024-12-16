# Haskell Space Leak: Uncollected Thunks

This repository demonstrates a common space leak in Haskell caused by inefficient handling of thunks in a recursive function. The `calculate` function repeatedly generates thunks that are never garbage-collected, leading to a significant memory footprint.

## Bug Description

The `calculate` function recursively processes a list of `Maybe Int` values. For each `Just` value, it calls `expensiveCalculation`, which performs a computationally intensive operation. The issue arises because the results of `expensiveCalculation` are created as thunks, and these thunks are not properly managed, causing a build-up of unevaluated expressions in memory.

## Solution

The solution involves refactoring the `calculate` function to evaluate the `expensiveCalculation` result immediately and avoid creating unnecessary thunks.  This ensures that the memory is released once the result is used.