class RemindToUpdateWeightJob < ApplicationJob
  queue_as :default

  def perform(*args)
    query.find_in_batches do |group|
      group.pluck(:email).each do |email|
        UserNotifierMailer.remind_to_enter_weight(email).deliver_later
      end
    end
  end

  private

  def query
    UserQuery.to_be_reminded.out_of_date_biometric.relation
  end
end
