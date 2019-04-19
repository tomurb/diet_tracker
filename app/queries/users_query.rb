class UsersQuery
  attr_reader :relation

  def initialize(relation = User.all)
    @relation = relation
  end

  def to_be_reminded
    self.class.new(@relation.joins(:reminder))
  end

  def out_of_date_biometric
   self.class.new(
     @relation.joins(:biometric)
              .where('biometrics.updated_at < :today', today: Date.today)
   )
  end
end
