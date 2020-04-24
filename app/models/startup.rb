class Startup
    attr_reader :name, :founder, :domain
    @@all = []

    def initialize
        @@all << self
    end

    def self.all
        @@all
    end

    def pivot(domain, name)
        @domain = domain
        @name = name
    end

    def self.find_by_founder(name)
        all.find {|startup| startup.founder == name}
    end

    def self.domains
        all.map {|startup| startup.domain}
    end

    def sign_contract(vc, type, amount)
        FundingRound.new(self, vc, type, amount)
    end

    def num_funding_rounds
        funding_rounds.count
    end

    def total_funds
        funding_rounds.reduce {|sum, round| sum += round.investment ; sum}
    end

    def investors
        funding_rounds.map {|round| round.investor}.uniq
    end

    def big_investors
        ballers = VentureCapitalist.tres_commas_club #local variable to not repeat class variable calls
        investors.select {|investor| ballers.include?(investor)}
    end

    def funding_rounds 
        FundingRound.select {|round| round.startup == self}
    end
end
