class ServiceType < ApplicationRecord
	validates :name, uniqueness:true
	validates :description, uniqueness:true
	has_many :client_requests, :dependent => :nullify
	
	filterrific(
	    default_filter_params: { sorted_by: 'created_at_desc' },
		available_filters:[
			:sorted_by,
			:with_name,
			:search_query
		
		]
	)
	
	scope :with_name, lambda { |names|
	  where(name: [*names])
	}
	
	scope :sorted_by, lambda { |sort_option|
	  # extract the sort direction from the param value.
	  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
	  case sort_option.to_s
	  when /^created_at_/
		# Simple sort on the created_at column.
		# Make sure to include the table name to avoid ambiguous column names.
		# Joining on other tables is quite common in Filterrific, and almost
		# every ActiveRecord table has a 'created_at' column.
		order("service_types.created_at #{ direction }")

	  else
		raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
	  end
}
	
	def self.options_for_sorted_by
		[
		['Name (a-z)', 'name_asc']

		]
	end
	
	def self.options_for_select
		order('LOWER(name)').map { |e| [e.name] }
	end
		scope :search_query, lambda { |query|
		# Searches the students table on the 'first_name' and 'last_name' columns.
		# Matches using LIKE, automatically appends '%' to each term.
		# LIKE is case INsensitive with MySQL, however it is case
		# sensitive with PostGreSQL. To make it work in both worlds,
		# we downcase everything.
		return nil  if query.blank?

		# condition query, parse into individual keywords
		terms = query.downcase.split(/\s+/)

		# replace "*" with "%" for wildcard searches,
		# append '%', remove duplicate '%'s
		terms = terms.map { |e|
		(e.gsub('*', '%') + '%').gsub(/%+/, '%')
		}
		# configure number of OR conditions for provision
		# of interpolation arguments. Adjust this if you
		# change the number of OR conditions.
		num_or_conds = 1
		where(
			terms.map { |term|
			  "(LOWER(ServiceTypes.name) LIKE ?)"
			}.join(' AND '),
			*terms.map { |e| [e] * num_or_conds }.flatten
		)
	}
end
