class Kardex < ActiveRecord::Base
	belongs_to :product
	attr_accessible :detail, :date, :income, :output
	validates_uniqueness_of :detail, :scope => :product_id
end
