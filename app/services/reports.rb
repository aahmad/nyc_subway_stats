class Reports
  def sanitize_value(value)
    return unless value.present?

    ActiveRecord::Base.sanitize_sql(value)
  end
end
