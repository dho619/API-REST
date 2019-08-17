class Anime < ApplicationRecord
  validates :name, presence:true
  validates :number_eps, presence:true
end
#Colocar aqui os campos que desejam ser obrigatorios pelo rails
