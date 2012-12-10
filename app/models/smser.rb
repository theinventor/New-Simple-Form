class Smser

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :to, :from, :message

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    errors.add(:to, "To must be 10 digits") unless @to.length == 10
    errors.add(:from, "From must be 10 digits") unless @from.length == 10
    errors.add(:message, "Message can't be over 140 characters") unless @message.length < 141
    return true if errors.blank?
  end

  def send_sms
    puts "SENDING SMS TO #{@to} with body: #{@message}"*100
  end

end