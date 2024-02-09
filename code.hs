
import Test.Hspec 

-- Use the following data types for the questions below
data Tree a = Nil | TreeNode (Tree a) a (Tree a) deriving (Show, Eq)

data LinkedList a = Null | ListNode a (LinkedList a) deriving (Show, Eq) 

--Category: Easy

-- Question 1
targetSum :: [Int] -> Int -> [[Int]]
targetSum [] _ = []
targetSum (x:xs) k = ascendingOrder ((checkSum x xs k) ++ (targetSum xs k))


checkSum :: Int -> [Int] -> Int -> [[Int]]
checkSum _ [] _ = []
checkSum n (x:xs) k = if (n + x == k) && (n >= x) then [[n, x]]
                      else if (n + x == k) && (n < x) then [[x, n]]
                      else checkSum n xs k 

ascendingOrder :: [[Int]] -> [[Int]]
ascendingOrder [] = []
ascendingOrder matrix = let minPair = findMin matrix in
                          minPair : ascendingOrder (removeMin minPair matrix)

findMin :: [[Int]] -> [Int]
findMin [row] = row
findMin (row1:row2:matrix) = if myhead row1 < myhead row2 then findMin (row1:matrix)
                             else findMin (row2:matrix)


removeMin :: [Int] -> [[Int]] -> [[Int]]
removeMin _ [] = []
removeMin row (x:xs) = if row == x then xs
                       else x : removeMin row xs
    
myhead :: [Int] -> Int
myhead [x] = x
myhead (x:xs) = x

myfst :: ([a], b) -> [a]
myfst (x, _) = x

mysnd :: ([a], b) -> b
mysnd (_, x) = x


-- Question 2

-- checking if left subtree is the same as right subtree. 
-- can check by going over each node in each subtree and making a list for each subtree. then checking if both lists are the same.
-- this would only work if the traversal order is the same for both subtrees.

-- run a 'traverseTree' function on each subtree to return a list. 
-- if traverseTree left == traverseTree right then True

symmetricTree :: Eq a => Tree a -> Bool
symmetricTree Nil = True
symmetricTree (TreeNode left val right) = checkMirror left right

checkMirror :: Eq a => Tree a -> Tree a -> Bool
checkMirror Nil Nil = True
checkMirror (TreeNode l_left l_val l_right) (TreeNode r_left r_val r_right) = if (l_val == r_val) then (checkMirror l_left r_right) && (checkMirror l_right r_left)
                                                                              else False
checkMirror _ _ = False

-- Question 3

-- reverse the given linked list and check for sameness with original.

palindromList :: Eq a => LinkedList a -> Bool
palindromList Null = True
palindromList (ListNode x xs) = if (reverseList (ListNode x xs) (Null)) == (ListNode x xs) then True
                                else False

reverseList :: LinkedList a -> LinkedList a -> LinkedList a
reverseList Null list = list
reverseList (ListNode x xs) list = (reverseList xs (ListNode x list))

-- Question 4

-- start with root, level order traversal
-- at every odd numbered level load nodes left-right
-- at even numbered level reverse the list
snakeTraversal :: Tree a -> [a]
snakeTraversal = undefined


-- snakeOrder :: Tree a -> [a] -> Int -> [a]
-- -- first call: frontier only contains root, and mainAcc is empty
-- -- snakeOrder (TreeNode left val right) (x:[]) [] y  = if y % 2 == 0 then -- return a reversed loaded children

-- -- snakeOrder (TreeNode left val right) (x:xs) y  = if y % 2 == 0 then 


-- loadChildren :: TreeNode a -> Int -> [a]
-- loadChildren (TreeNode left val right) x = drop 1 (val ++ loadChildren left x+1 ++ loadChildren right x+1)

-- Question 5

treeConstruction :: String -> Tree Char
treeConstruction string  = undefined

extractFirst :: String -> Char
-- extractFirst "" = ""
extractFirst (x:xs) = x

-- Category: Medium

-- Attempy any 4 questions from this category

-- Question 1.1: Overload the (+) operator for Tree. You only need to overload (+). Keep the rest of the operators as undefined.   
instance Num (Tree Int) where
    (+) = addTrees
    (*) = undefined
    abs = undefined
    signum = undefined
    fromInteger = undefined
    negate = undefined

addTrees :: Tree Int -> Tree Int -> Tree Int
addTrees Nil Nil = Nil
addTrees Nil b = b
addTrees a Nil = a
addTrees (TreeNode left1 v1 right1) (TreeNode left2 v2 right2) =
    TreeNode (addTrees left1 left2) (v1 + v2) (addTrees right1 right2)

-- Question 1.2

longestCommonString :: LinkedList Char -> LinkedList Char -> LinkedList Char
longestCommonString = undefined

-- Question 2
commonAncestor :: Ord a => Eq a => Tree a -> a -> a -> Maybe a
commonAncestor = undefined

-- Question 3
gameofLife :: [[Int]] -> [[Int]]
gameofLife = undefined


-- Question 4
waterCollection :: [Int] -> Int
waterCollection = undefined

-- Question 5
minPathMaze :: [[Int]] -> Int
minPathMaze = undefined




-- Main Function
main :: IO ()
main =
   hspec $ do

    -- Test List Target Sum
        describe "targetSum" $ do
            it "should return pairs whose sum is equal to the target" $ do
                targetSum [1,2,3,4,5] 5 `shouldBe` [[3,2], [4,1]]
                targetSum [1,2,3,4,5,6] 10 `shouldBe` [[6,4]]
                targetSum [1,2,3,4,5] 0 `shouldBe` []
                targetSum [1,10,8,7,6,2,3,4,5,-1,9] 10 `shouldBe` [[6,4],[7,3],[8,2],[9,1]]
    
    -- Test Symmetric Tree
        describe "symmetricTree" $ do
            it "should return True if the tree is symmetric" $ do
                symmetricTree (Nil :: Tree Int) `shouldBe` True
                symmetricTree (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 1 Nil)) `shouldBe` True
                symmetricTree (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 2 Nil)) `shouldBe` False
                symmetricTree (TreeNode (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)) 4 (TreeNode (TreeNode Nil 3 Nil) 2 (TreeNode Nil 1 Nil))) `shouldBe` True
                symmetricTree (TreeNode (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)) 4 (TreeNode (TreeNode Nil 3 Nil) 2 (TreeNode Nil 4 Nil))) `shouldBe` False
    
    -- Test Palindrom List
        describe "palindromList" $ do
            it "should return True if the list is a palindrome" $ do
                palindromList (Null :: LinkedList Int) `shouldBe` True
                palindromList (ListNode 1 (ListNode 2 (ListNode 3 (ListNode 2 (ListNode 1 Null))))) `shouldBe` True
                palindromList (ListNode 1 (ListNode 2 (ListNode 3 (ListNode 3 (ListNode 1 Null))))) `shouldBe` False
                palindromList (ListNode 1 (ListNode 2 (ListNode 3 (ListNode 2 (ListNode 2 Null))))) `shouldBe` False
                palindromList (ListNode 1 (ListNode 2 (ListNode 3 (ListNode 2 (ListNode 1 (ListNode 1 Null)))))) `shouldBe` False
                palindromList (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'b' (ListNode 'a' Null))))) `shouldBe` True
                palindromList (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'c' (ListNode 'a' Null))))) `shouldBe` False
    
    -- Test Snake Traversal
        describe "snakeTraversal" $ do
            it "should return the snake traversal of the tree" $ do
                snakeTraversal (Nil:: Tree Int) `shouldBe` []
                snakeTraversal (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)) `shouldBe` [2,3,1]
                snakeTraversal (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode Nil 7 Nil))) `shouldBe` [4,2,3,1,6,5,7]
                snakeTraversal (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode (TreeNode Nil 9 Nil) 7 Nil))) `shouldBe` [4,2,3,1,6,5,7,9]
    
    -- Test Tree Construction
        describe "treeConstruction" $ do
            it "should return the tree constructed from the string" $ do
                treeConstruction "" `shouldBe` Nil
                treeConstruction "a" `shouldBe` TreeNode Nil 'a' Nil
                treeConstruction "^a" `shouldBe` Nil
                treeConstruction "ab^c" `shouldBe` TreeNode (TreeNode Nil 'b' Nil) 'a' (TreeNode Nil 'c' Nil)
                treeConstruction "ab^c^" `shouldBe` TreeNode (TreeNode Nil 'b' Nil) 'a' (TreeNode Nil 'c' Nil)
                treeConstruction "ab^cde^f" `shouldBe` TreeNode (TreeNode Nil 'b' Nil) 'a' (TreeNode (TreeNode (TreeNode Nil 'e' Nil) 'd' (TreeNode Nil 'f' Nil)) 'c' Nil)
                treeConstruction "abcde^f" `shouldBe` TreeNode (TreeNode (TreeNode (TreeNode (TreeNode Nil 'e' Nil) 'd' (TreeNode Nil 'f' Nil)) 'c' Nil) 'b' Nil) 'a' Nil
    
    -- Test (+) operator for Tree
        describe "(+)" $ do
            it "should return the sum of the two trees" $ do
                let result1 = (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil) + TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil) :: Tree Int) 
                result1  `shouldBe` TreeNode (TreeNode Nil 2 Nil) 4 (TreeNode Nil 6 Nil) 
                let result2 = (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil) + TreeNode Nil 2 (TreeNode Nil 3 Nil) :: Tree Int)
                result2 `shouldBe` TreeNode (TreeNode Nil 1 Nil) 4 (TreeNode Nil 6 Nil)
                let result3 = (Nil + Nil :: Tree Int) 
                result3 `shouldBe` Nil
                let result4 = (Nil + TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil):: Tree Int)
                result4 `shouldBe` TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)
                let result5 = (TreeNode (TreeNode (TreeNode Nil 1 (TreeNode Nil (-2) Nil)) 3 Nil) 4 (TreeNode Nil 2 (TreeNode Nil 7 (TreeNode Nil (-7) Nil))) + TreeNode (TreeNode (TreeNode (TreeNode Nil 0 Nil) 1 Nil) 3 (TreeNode (TreeNode Nil 1 Nil) 6 (TreeNode Nil (-2) Nil))) 4 (TreeNode (TreeNode (TreeNode Nil 9 Nil) 5 (TreeNode Nil 4 Nil)) 2 (TreeNode (TreeNode Nil (-5) Nil) 7 Nil)) :: Tree Int) 
                result5 `shouldBe` TreeNode (TreeNode (TreeNode (TreeNode Nil 0 Nil) 2 (TreeNode Nil (-2) Nil)) 6 (TreeNode (TreeNode Nil 1 Nil) 6 (TreeNode Nil (-2) Nil))) 8 (TreeNode (TreeNode (TreeNode Nil 9 Nil) 5 (TreeNode Nil 4 Nil)) 4 (TreeNode (TreeNode Nil (-5) Nil) 14 (TreeNode Nil (-7) Nil)))
                let result6 = (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode Nil 7 Nil)) + TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 6 Nil)) 4 (TreeNode (TreeNode Nil 5 Nil) 2 (TreeNode Nil 7 Nil)) :: Tree Int) 
                result6 `shouldBe` TreeNode (TreeNode (TreeNode Nil 2 Nil) 6 (TreeNode Nil 12 Nil)) 8 (TreeNode (TreeNode Nil 10 Nil) 4 (TreeNode Nil 14 Nil))
    
    -- Test Longest Common String
        describe "longestCommonString" $ do
            it "should return the longest common string" $ do
                longestCommonString Null Null `shouldBe` Null
                longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) Null `shouldBe` Null
                longestCommonString Null (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) `shouldBe` Null
                longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) `shouldBe` ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))
                longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'f' Null))))) `shouldBe` ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' Null)))
                longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'f' (ListNode 'e' Null))))) `shouldBe` ListNode 'a' (ListNode 'b' (ListNode 'c' Null))
                longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) (ListNode 'a' (ListNode 'b' (ListNode 'f' (ListNode 'g' (ListNode 'e' Null))))) `shouldBe` ListNode 'a' (ListNode 'b' Null)
                longestCommonString (ListNode 'a' (ListNode 'b' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) (ListNode 'a' (ListNode 'f' (ListNode 'c' (ListNode 'd' (ListNode 'e' Null))))) `shouldBe` ListNode 'c' (ListNode 'd' (ListNode 'e' Null))
    
    -- Test Common Ancestor
        describe "commonAncestor" $ do
            it "should return the lowest common ancestor of the two nodes" $ do
                commonAncestor Nil 1 2 `shouldBe` Nothing
                commonAncestor (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)) 1 3 `shouldBe` Just 2
                commonAncestor (TreeNode (TreeNode Nil 1 Nil) 2 (TreeNode Nil 3 Nil)) 1 4 `shouldBe` Nothing
                commonAncestor (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 4 Nil)) 5 (TreeNode (TreeNode Nil 6 Nil) 8 (TreeNode Nil 9 Nil))) 1 6 `shouldBe` Just 5
                commonAncestor (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 4 Nil)) 5 (TreeNode (TreeNode Nil 6 Nil) 8 (TreeNode Nil 9 Nil))) 8 9 `shouldBe` Just 8
                commonAncestor (TreeNode (TreeNode (TreeNode Nil 1 Nil) 3 (TreeNode Nil 4 Nil)) 5 (TreeNode (TreeNode Nil 6 Nil) 8 (TreeNode Nil 9 Nil))) 1 3 `shouldBe` Just 3
                
    
    -- Test Game of Life
        describe "gameofLife" $ do
            it "should return the next state" $ do
                gameofLife [[0,1,0],[0,0,1],[1,1,1],[0,0,0]] `shouldBe` [[0,0,0],[1,0,1],[0,1,1],[0,1,0]]
                gameofLife [[1,1],[1,0]] `shouldBe` [[1,1],[1,1]]
                gameofLife [[1,1],[1,1]] `shouldBe` [[1,1],[1,1]]
                gameofLife [[1,0],[0,1]] `shouldBe` [[0,0],[0,0]]
                gameofLife [[0,1,0,0],[0,1,1,1],[1,0,1,1]] `shouldBe` [[0,1,0,0],[1,0,0, 1],[0,0,0,1]]
    
    -- Test Water Collection
        describe "waterCollection" $ do
            it "should return the amount of water that can be trapped" $ do
                waterCollection [0,1,0,2,1,0,1,3,2,1,2,1] `shouldBe` 12
                waterCollection [4,2,0,3,2,5] `shouldBe` 18
                waterCollection [1,2,3,4,5] `shouldBe` 0
                waterCollection [5,4,3,2,1] `shouldBe` 0
                waterCollection [5,4,3,2,1,2,3,4,5] `shouldBe` 32  
                waterCollection [1, 0, 2, 3, 1, 4] `shouldBe` 6
                waterCollection [0, 4, 1, 2, 0, 1, 3] `shouldBe` 16
    
    -- Test Min Path Maze
        describe "minPathMaze" $ do
            it "should return the minimum cost to reach the bottom right cell" $ do
                minPathMaze [[1,3,1],[1,5,1],[4,2,1]] `shouldBe` 7
                minPathMaze [[1,2,3],[4,5,6],[7,8,9]] `shouldBe` 21
                minPathMaze [[1,2,3,4],[4,5,6,7],[7,8,9,9],[10,11,1,13]] `shouldBe` 35
                minPathMaze [[1,2,3,4,5],[4,5,6,7,8],[7,8,9,9,10],[10,11,1,13,14],[15,16,17,18,19]] `shouldBe` 66
                minPathMaze [[1,2,3,4,5,6],[4,1,2,7,8,9],[7,8,1,2,10,11],[10,11,1,2,22,15],[15,16,17,1,2,20],[21,22,23,24,2,26]] `shouldBe` 41