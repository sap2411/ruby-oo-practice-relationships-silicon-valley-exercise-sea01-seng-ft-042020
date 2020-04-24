class VentureCapitalist
    attr_reader :name, :total_worth
    @@all = []

    def initialize
        @@all << self
    end

    def self.all
        @@all
    end

    def self.tres_commas_club
        all.select {|vc| vc.total_worth > 1,000,000,000}
    end

    def offer_contract(start_up, type, amount)
        FundingRound.new(start_up, self, type, amount)
    end

    def funding_rounds
        FundingRound.all.select {|round| round.venture_capitalist == self}
    end

    def portfolio
        funding_rounds.map {|round| round.startup}.uniq
    end

    def biggest_investment
        funding_rounds.sort_by {|round| round.investment}.last
    end

    def invested(domain)
        our_startups = portfolio.select {|startup| startup.domain == domain}
        our_startups.inject {|total, startup| total += startup.total_funds}
    end
end
