answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8 #34 bec. the variable is passed by value so the variable answer outside is not really modified by the method