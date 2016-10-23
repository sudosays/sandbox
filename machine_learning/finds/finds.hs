-- An implementation of the Find-S algorithm in Haskell
-- This will transform into the CAE algorithm hopefully

-- Generate a hypothesis of n length filled with s concept
createFilled n s = take n (repeat s)
-- !!! USE replicate n s instead


filterGeneral l = [ e | e <- l, e /= "?"]
