require 'pp'

def generate_spiral_lists(row_count, col_count)
  grid = row_count.times.map{ [] }
  x, y = 0, 0
  x_low_bound, y_low_bound = 0, 0
  x_up_bound, y_up_bound = col_count - 1, row_count - 1
  direction = :right

  (1..(row_count * col_count)).each do |current_number|
    grid[y][x] = current_number
    
    if direction == :right && x == x_up_bound
      direction = :down
      y_low_bound += 1
    elsif direction == :down && y == y_up_bound
      direction = :left
      x_up_bound -= 1
    elsif direction == :left && x == x_low_bound
      direction = :up
      y_up_bound -= 1
    elsif direction == :up && y == y_low_bound
      direction = :right
      x_low_bound += 1
    end

    case direction
    when :right
      x += 1
    when :down
      y += 1
    when :left
      x -= 1
    when :up
      y -= 1
    end
  end
  
  grid
end

pp generate_spiral_lists(1, 1)
pp generate_spiral_lists(2, 2)
pp generate_spiral_lists(3, 3)
pp generate_spiral_lists(4, 4)
pp generate_spiral_lists(5, 5)
pp generate_spiral_lists(3, 4)
pp generate_spiral_lists(4, 3)
pp generate_spiral_lists(1, 2)
pp generate_spiral_lists(2, 1)
pp generate_spiral_lists(10, 5)
pp generate_spiral_lists(5, 10)
pp generate_spiral_lists(10, 4)
binding.irb
