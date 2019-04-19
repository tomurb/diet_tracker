require 'rails_helper'

RSpec.describe 'Reminders', type: :request do
  let(:user) { create(:user) }
  let(:user_with_reminder) { create(:user, reminder: create(:reminder)) }
  describe 'create new reminder' do
    before { sign_in user }
    it 'signed in user signs up to reminder and redirects back' do
      get '/'
      from_path = request.path
      post reminders_path
      expect(Reminder.count).to eq(1)
      expect(Reminder.last.user_id).to eq(user.id)
      expect(response).to redirect_to(from_path)
    end
  end
  describe 'destroy reminder' do
    before { sign_in user }
    it 'signed in user signs out from reminder and redirects back' do
      create(:reminder, user: user)
      expect(Reminder.count).to eq(1)
      get '/'
      from_path = request.path
      delete reminder_path(user.reminder.id)
      expect(Reminder.count).to eq(0)
      expect(response).to redirect_to(from_path)
    end
  end
end
