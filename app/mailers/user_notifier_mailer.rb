class UserNotifierMailer < ApplicationMailer
  def remind_to_enter_weight(email)
    mail(to: email, subject: "We're curious about how much you weight")
  end
end
