class Article < ApplicationRecord
  has_rich_text :content
  belongs_to :user # campo adicional
  has_many :has_categories
  has_many :categories, through: :has_categories
  attr_accessor :category_elements
  
  def save_categories
    #category_elements 1,2,3
    # iterar ese arreglo
    return has_categories.destroy_all if category_elements.nil? || category_elements.empty? 
    has_categories.where.not(category_id: category_elements).destroy_all
    category_elements.each do |category_id|
      # crear HasCategory, crear un registro de la tabla asociativa para que se establezca la relacion
      HasCategory.find_or_create_by(article: self, category_id: category_id)
    end
  end
  
end
