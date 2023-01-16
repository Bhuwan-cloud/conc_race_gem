# ConcRace

Welcome to your  `CONCURRENT RACE (conc_race)`  gem! 
`conc_race`  is a simple ruby gem that illustrates the working of concurrent programming using `Thread` class in ruby.
It takes `number of threads` as `Cars` and cars have names with indivisual `power`, power acts as the fuel for racing between threads. Once Car(Threads names) and Power(Thread execution time) are entered we can start a `Race` between them and see who wins. This is simple console game and after watching the threads running, a `winner` is declared on the basis of `score` the threads took to finish. `Score` is determined by `speed of thread executiion` and `machine's processor multithreading` capability. After Winner of game is declared we can see the `scorecard` in our Web Browser in [localhost](http://localhost:3000). I have also implemented `WEBrick` for web view and `Benchmark` to calculate tim in seconds for each Thread.

# Console Demo 

![Alt](https://res.cloudinary.com/bhuwan/image/upload/v1673886678/bhuwan/conc_race_concole_uwf4sj.png)

# Web Browser Demo 

![Alt](https://res.cloudinary.com/bhuwan/image/upload/v1673886664/bhuwan/conc_race_web_mt15w7.png)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add conc_race

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install conc_race

## Usage


Run the Gem Code by opening IRB and  calling 'run' method in module 'ConcRace' (do follwowing in irb>): 

    $  Conc_race.run

OR (do follwowing in irb>) :

    $ extend ConcRace 
    $ run 



## Development


To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Bhuwan-cloud/conc_race_gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Bhuwan-cloud/conc_race_gem/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ConcRace project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct]((https://github.com/Bhuwan-cloud/conc_race_gem/blob/master/CODE_OF_CONDUCT.md)).
