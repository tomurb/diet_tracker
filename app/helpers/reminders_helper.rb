module RemindersHelper
  def reminder_button(user)
    reminder = user.reminder
    if reminder.present?
      button_to 'Turn off', reminder_path(reminder), method: :delete
    else
      button_to 'Turn on', reminders_path, method: :post
    end
  end
end
