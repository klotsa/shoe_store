class Brand < ActiveRecord::Base
  has_and_belongs_to_many(:stores)
  validates :name, :presence => true,
           :length => {:minimum => 3, :maximum => 100},
           :uniqueness => {:case_sensitive => false}
  validates_numericality_of :price, :presence=>true
  before_save(:uppercase_words)

  private
  def uppercase_words
     self.name=(self.name.split.map(&:capitalize).join(' '))
     self.name=(name().capitalize())
   end
end
