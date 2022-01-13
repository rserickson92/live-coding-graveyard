# Snapshot of what I did in interview, less memory of ruby
$memo = [0, 1]
def fib_interview(n)
  fibn1 = $memo[n-1] != nil ? $memo[n-1] : ($memo[n-1] = fib(n-1))
  fibn2 = $memo[n-2] != nil ? $memo[n-2] : ($memo[n-2] = fib(n-2))
  fibn1 + fibn2
end

# Syntactically more proper solution
$cache = [0, 1]
def fib(n)
  $cache[n] ||= fib(n-1) + fib(n-2) 
end

binding.irb

