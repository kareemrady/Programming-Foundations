Kernel.puts("Please Type in 2 numbers seperated by a space ex: 2 3")
numbers_string = Kernel.gets().chomp()
numbers = numbers_string.split(" ").map{|num| num.to_i}
Kernel.puts("Please type the required operation ex: + - / * ")
operation = Kernel.gets().chomp()
operation_fn = operation.to_sym
result = numbers[0].send(operation_fn, numbers[1])
puts result