require 'rails_helper'

RSpec.describe 'TaskLabel', type: :feature do
  before { login }

  let(:task) { tasks(:pending_task) }

  describe 'attach label to task' do
    before { visit new_task_label_path(task.id) }

    context 'when create and attach new label' do
      it 'add new label' do
        fill_in 'Name', with: 'New Label'
        click_on 'Create And Attach Label'
        expect(page).to have_content 'New Label'
      end
    end

    context 'when attach exist label' do
      it 'shows labels of user which the task does not have' do
        expect(page).not_to have_content 'test_label'
        expect(page).to have_content 'unused_label'
        expect(page).not_to have_content 'other_user_label'
      end

      it 'add selected label' do
        select 'unused_label', from: 'Label'
        click_on 'Attach Selected Label'
        expect(page).to have_content 'unused_label'
      end
    end
  end

  describe 'detach label from task' do
    it 'detach label' do
      visit task_path(task.id)
      expect(page).to have_content 'test_label'
      click_on 'Remove Label'
      expect(page).not_to have_content 'test_label'
    end
  end
end
