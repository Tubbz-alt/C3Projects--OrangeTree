# Orange Tree
# group: Alice, Elia, Jeri

class OrangeTree
	attr_reader :age, :alive, :grove, :height, :orange_count

	def initialize
		@age = 0
		@alive = true
		@height = 0
		@orange_count = 0
	end

	def grow_oranges
		if @age >= 3
			if @grove.soil_quality == "unhealthy"
				@orange_count = @age
			elsif @grove.soil_quality == "average"
				@orange_count = @age * 2
			else
				@orange_count = @age * 3
			end
		end
	end

	def grow_taller
		if @age < 5
			@height += 2
		else
			@height += 0.1
		end
	end

	def kill_tree
		@alive = false
		@orange_count = 0
		@age = 0 # problems?
		@height = 0
		puts "This tree has died."
	end

	def grow_older
		if @grove
			if @grove.soil_quality == "unhealthy" && @age >= 5
				kill_tree
			elsif @grove.soil_quality == "average" && @age >= 8
				kill_tree
			end
		end

		if age >= 10
			kill_tree
		else
			@age += 1
		end

	end

	def one_year_passes
		grow_older
		if @alive == true
			grow_taller
			grow_oranges
		end

		if @grove
			@grove.soil_quality
		end
	end

	def pick_orange
		if @orange_count != 0
			@orange_count -= 1
			puts "That was a very tasty orange."

		else
			puts "There are no more oranges to pick this year."
		end
	end

	def plant_on(grove_name)
		grove_name.trees.push(self)
		@grove = grove_name
	end
end


class OrangeGrove
	attr_reader :total_orange_count, :trees

	def initialize
		@trees = []
		@total_orange_count = 0
		@soil_quality = "healthy"
	end

	def soil_quality
		# make it based on if trees are alive
		if @trees.length <= 5
			@soil_quality = "healthy"
		elsif @trees.length <=10
			@soil_quality = "average"
		else
			@soil_quality = "unhealthy"
		end
		return @soil_quality
	end

	def plant_trees(number)
		if number.to_i != 0
			number.times do
				new_tree = OrangeTree.new
				new_tree.plant_on(self)
			end
			soil_quality
		else
			puts "You can't plant #{number} trees. Please try again with a number."
		end
	end

	def one_year_passes_grove
		@total_orange_count = 0
		@trees.each do |tree|
			tree.one_year_passes
			@total_orange_count += tree.orange_count
		end
		soil_quality
	end

end
