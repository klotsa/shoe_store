class Store < ActiveRecord::Base
  has_and_belongs_to_many(:brands)
  validates :name, :presence => true,
           :length => {:minimum => 3, :maximum => 100},
           :uniqueness => {:case_sensitive => false}
  before_save(:uppercase_words)

  private
  def uppercase_words
     self.name=(self.name.split.map(&:capitalize).join(' '))
     self.name=(name().capitalize())
   end
end
