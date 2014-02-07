
class Cell

  attr_writer :neighbors

  def initialize(alive = nil)
    @alive = alive
    @alive = [true, false].sample if @alive.nil?
  end

  def tick!
  # if(@alive == true) #this code is the same as the one below
  #   @alive = @neighbors.between?(2,3)
  # else #will come to else if @alive cell = dead or false, not alive
  #   @alive = @neighbors == 3
  # end 

  @alive = @alive ? @neighbors.between?(2,3) : @neighbors == 3
  
  end

  def to_s
    @alive ? "o" : " "
  end

  def to_i
    @alive ? 1 : 0
  end  

end  

class Game

  def initialize(size)
    @size = size
    @cells = Array.new(size) { Array.new(size) { Cell.new } }
    @counter = 0
  end

  def play!
    while(true)
      tick!
      puts self
      sleep(2)
    end  
  end

  def counter
    @counter += 1
  end
 
  def tick!
    @cells.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        cell.neighbors = living_neighbors(y, x)
      end
    end

    @cells.each { |row| row.each { |cell| cell.tick! } }
  end  

  def living_neighbors(y, x)
    [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]].reduce(0) do |sum, pos| 
      sum + @cells[(y + pos[0]) % @size][(x + pos[1]) % @size].to_i    
    
    end
  end  

  def to_s
    @cells.map { |row| row.join(" ") }.join("\n") + "\n" + "Tick #{counter}"
  end 
end  

