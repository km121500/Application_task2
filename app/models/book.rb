class Book < ApplicationRecord
  
  	validates :title, presence: true
  	validates :body, presence: true, length: {maximum: 200}
  	validates :rate, presence: true
    validates :rate, numericality: {
    # only_integer: true,
    greater_than_or_equal_to: 1,
  }
  	
  	belongs_to :user
  	has_many :favorites, dependent: :destroy
  	has_many :book_comments, dependent: :destroy
  	
  	
    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
    # 絞り込機能はじまり
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
     # 絞り込機能終わり
  end
  # タグ機能はじまり
  def Book.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end
  # タグ機能おわり
  
end
