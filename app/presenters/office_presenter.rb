class OfficePresenter < SimpleDelegator
  def office_opening_times
    __getobj__.office_opening_times.group_by(&:weekday)
  end

  def telephone_advice_times
    __getobj__.telephone_advice_times.group_by(&:weekday)
  end

  def about_our_advice_service
    __getobj__.about_our_advice_service__c || "We don't have the data for this yet"
  end

  def access_details
    return nil if __getobj__.access_details__c.blank?
    __getobj__.access_details__c.split(";")
  end
end
