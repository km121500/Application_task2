class Book < ApplicationRecord
  
  	validates :title, presence: true
  	validates :body, presence: true, length: {maximum: 200}
  	validates :rate, presence: true
    validates :rate, numericality: {
    # only_integer: true,
    less_than_or_equal_to: 3,
    greater_than_or_equal_to: 1,
  }
  	
  	belongs_to :user
  	has_many :favorites, dependent: :destroy
  	has_many :book_comments, dependent: :destroy
  	
  	
    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
    
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end
  
end
