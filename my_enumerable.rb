module Enumerable

	def my_each
		n = self.length
		i = 0
		for i in (0...n)
			yield(self[i])
		end 
	end

	def my_each_with_index
		n=self.length
		i = 0
		for i in (0...n)
			yield(self[i], i)
		end
	end 

	def my_select
		results = []
		self.my_each do |x|
			if yield x
				results << x
			end
		end 
		results
	end 

	def my_all?
		flag = false
		self.my_each do |x|
			if yield x 
				flag = true
			else 
				return false
			end 
		end 
		flag 
	end 

	def my_any?
		self.my_each do |x|
			if yield x
				return true
			end
		end 
		false
	end

	def my_none?
		self.my_each do |x|
			if yield x
				return false
			end
		end 
		true
	end 

	def my_count(x = false)
		if x
			self.my_select {|y| y == x}.length
		elsif block_given?
			self.my_select {|y| yield y}.length
		else
			self.length	
		end 
	end 

	def my_map(&proc = Proc.new {|x| x})
		results = []
		self.my_each do |x|
			results << (block_given? ?  yield(proc.call(x)) : proc.call(x))
		end 
		results
	end 


	def my_inject(init = nil, sym=nil)
			if init.nil?
				init = self[0]
				flag = true #no params given
			elsif init.class == Symbol 
				sym = init
				init = self[0]
				flag = true
			end 

		if sym
			case sym
			when :+
				self.my_each {|i| init += i}
				init -= self[0] if flag
			when :-
				self.my_each {|i| init -= i}
				init += self[0] if flag
			when :*
				self.my_each {|i| init *= i}
				init /= self[0] if flag
			when :/
				self.my_each {|i| init /= i}
				init *= self[0] if flag
			when :%
				self.my_each {|i| init %= i}
				init *= self[0] if flag
			when :**
				self.my_each {|i| init **= i}
				init **=(self[0]**-1) if flag
			else
				return error
			end 
		end 
		if block_given?
			self.my_each {|i| init = yield(init, i)}
			init -= self[0] if flag
			end 
			init 
		end 

		def multiply_els
			return self.my_inject(:*)
		end 
	end 
