class Pay::CustomerResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :processor
  attribute :processor_id
  attribute :default
  attribute :deleted_at
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :plan, index: false
  attribute :quantity, index: false
  attribute :payment_method_token, index: false
  attribute :stripe_account
  attribute :braintree_account

  # Associations
  attribute :owner
  attribute :charges
  attribute :subscriptions
  attribute :payment_methods
  attribute :default_payment_method

  # Uncomment this to customize the display name of records in the admin area.
  # def self.display_name(record)
  #   record.name
  # end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end
end
