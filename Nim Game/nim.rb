# @param {Integer} n
# @return {Boolean}
def can_win_nim(n)
    if n%4 == 0
        return false
    else
        return true
    end
end


# Nim is a mathematical game of strategy in which 
# two players take turns removing objects from distinct
# heaps or piles. On each turn, a player must remove at least one object, 
# and may remove any number of objects provided they all come from the same heap/pile. 
# The goal of the game is to avoid taking the last object.