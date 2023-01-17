require "conc_race"

RSpec.describe ConcRace do
  describe ".run" do
    before do
      allow(ConcRace).to receive(:gets).and_return("2\n", "car1\n", "20\n", "car2\n", "30\n")
    end

    it "has a version number" do
      expect(ConcRace::VERSION).not_to be nil
    end

    it "stores the correct number of cars" do
      ConcRace.run
      expect(ConcRace.cars.size).to eq(2)
    end

    it "stores the correct name and power for each car" do
      ConcRace.run
      expect(ConcRace.cars[0]).to eq({ name: "car1", power: 20 })
      expect(ConcRace.cars[1]).to eq({ name: "car2", power: 30 })
    end

    it "returns the correct winner" do
      ConcRace.run
      expect(ConcRace.winner).to eq({ name: "car2", power: 30 })
    end

    it "returns the correct scores" do
      ConcRace.run
      expect(ConcRace.scores).to eq([{ name: "car1", score: 20 }, { name: "car2", score: 30 }])
    end

    it "returns the correct benchmark results" do
      ConcRace.run
      expect(ConcRace.benchmarks).to eq([{ name: "car1", time: 0.8 }, { name: "car2", time: 1.2 }])
    end

    it "starts the countdown timer" do
      expect(Thread).to receive(:new).and_yield
      expect(ConcRace).to receive(:puts).with("Starting in 3 seconds...")
      expect(ConcRace).to receive(:puts).with("Starting in 2 seconds...")
      expect(ConcRace).to receive(:puts).with("Starting in 1 seconds...")
      expect(ConcRace).to receive(:puts).with("GO!")
      ConcRace.run
    end

    it "creates a new thread for each car" do
      expect(Thread).to receive(:new).twice.and_yield
      ConcRace.run
    end

    it "calculates the score for each car" do
      allow(ConcRace).to receive(:sleep)
      ConcRace.run
      expect(ConcRace.scores).to eq([{ name: "car1", score: 20 }, { name: "car2", score: 30 }])
    end

    it "calculates the time for each car" do
      allow(ConcRace).to receive(:sleep)
      expect(Benchmark).to receive(:measure).twice.and_return(double(real: 0.8), double(real: 1.2))
      ConcRace.run
      expect(ConcRace.benchmarks).to eq([{ name: "car1", time: 0.8 }, { name: "car2", time: 1.2 }])
    end
  end
end
