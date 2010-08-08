class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "is not an email") unless value =~ email_regex
  end
  
  def email_regex
    @email_name_regex  ||= '[\w\.%\+\-]+'.freeze
    @domain_head_regex ||= '(?:[A-Z0-9\-]+\.)+'.freeze
    @domain_tld_regex  ||= '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'.freeze
    /\A#{@email_name_regex}@#{@domain_head_regex}#{@domain_tld_regex}\z/i
  end
end