require_relative "conc_race/version"

module ConcRace
  class Error < StandardError; end

  class Game
    # MY MAIN CODE
    def self.start
      require "benchmark"
      require "webrick"
      require "thread"

      # Create an array to store the threads
      threads = []

      #  cars array to store the number of cars
      cars = []
      puts "WELCOME to CONCURRENCY RACE!!!! \n"
      puts "we are going to do a race between CONCURRENT THREADS and see who wins \n"
      puts "Enter the number of cars( that represents each thread ) you want to race(max: 50):"
      num_cars = gets.chomp.to_i

      num_cars.times do |i|
        puts "Enter the name of car #{i + 1}:"
        name = gets.chomp
        puts "Enter the power of car #{i + 1} (max: 50):"
        power = gets.chomp.to_i
        cars << { name: name, power: power }
      end

      #  array to store the scores
      scores = []

      # Create an array to store the benchmark results
      benchmarks = []

      #  thread for the countdown timer
      countdown_thread = Thread.new do
        (3..1).each do |i|
          puts "Starting in #{i} seconds..."
          sleep 0.75
        end
        puts "GO!"
      end
      countdown_thread.join

      #  thread for each car
      cars.each do |car|
        result = Benchmark.measure do
          threads << Thread.new do
            dots = ["🚗", "..🚗", "...🚗", ".....🚗🚗"]
            score = 0
            position = 0
            (1..car[:power]).each do |n|
              dots.each do |dot|
                print "\033[2K"  # Clear the current line (terminal command)
                print "\033[1A"  # Move cursor up one line
                print " " * position + dot + "  #{car[:name]}\n" #  The * operator is used to repeat the string " " the number of times specified by the position variable.
                position += 1
                sleep 0.4
                score += 1
              end
            end
            scores << { name: car[:name], score: score }
            puts "#{car[:name]} finished with score: #{score}"
          end
        end
        benchmarks << { name: car[:name], time: result.real }
      end

      # Wait for all threads to finish
      threads.each(&:join)

      # Find the winner
      winner = cars.max_by { |car| car[:power] }
      puts "Winner is #{winner[:name]}\n"

      puts "Benchmark results:"

      benchmarks.each do |benchmark|
        puts "#{benchmark[:name]} took #{benchmark[:time].round(6)} seconds"
      end
      puts "\n"

      puts "Please visit the localhost:3000 to see score card "

      # Create a WEBrick server
      server = WEBrick::HTTPServer.new(Port: 3000)

      #

      # Define a route for the root path
      server.mount_proc "/" do |req, res|
        res.body = "<h1>Car Racing Game (Demonstration of concurrency using Threads)</h1>"
        scores.each do |score|
          res.body << "<p>#{score[:name]} - Score: #{score[:score]}</p>"
        end
        res.body << "<h2>The winner is #{winner[:name]}</h2> <hr>"
      end

      trap("INT") { server.shutdown }

      # Start the server
      server.start
    end
  end

  # GEM BODY END
end
