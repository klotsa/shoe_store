class Brand < ActiveRecord::Base
  has_and_belongs_to_many(:stores)
  validates(:name, {:presence => true, :length => {:maximum => 100}})
  before_save(:uppercase_words)

  private
  def uppercase_words
     self.name=(self.name.split.map(&:capitalize).join(' '))
     self.name=(name().capitalize())
   end
end
