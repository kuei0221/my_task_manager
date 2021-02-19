# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Task Managemenet', type: :feature do
  describe 'show specific task' do
    context 'when task exist' do
      let(:task) { tasks(:pending_task) }

      it 'show task' do
        visit task_path(task.id)
        expect(page).to have_content(task.name)
        expect(page).to have_content(task.description)
        expect(page).to have_content(task.priority)
        expect(page).to have_content(task.status)
        expect(page).to have_content(task.start_date)
        expect(page).to have_content(task.end_date)
      end
    end
  end

  describe 'visit task list' do
    it 'show all task' do
      visit tasks_path
      expect(page).to have_content(tasks(:pending_task).name)
      expect(page).to have_content(tasks(:progressing_task).name)
      expect(page).to have_content(tasks(:completed_task).name)
    end

    context 'when click Created At' do
      it 'sort by create at' do
        visit tasks_path
        expect(page).to have_text(/test1.+test2.+test3/)
        click_link 'Created At'
        expect(page).to have_text(/test3.+test2.+test1/)
        click_link 'Created At'
        expect(page).to have_text(/test1.+test2.+test3/)
      end
    end
  end

  describe 'create task' do
    context 'when create success' do
      it 'create task' do
        visit new_task_path
        fill_in 'Name', with: 'testing create'
        fill_in 'Description', with: 'This is testing the creation of a new test'
        select('High', from: 'Priority')
        select('In Progress', from: 'Status')
        select('2020', from: 'task_start_date_1i')
        select('Jun', from: 'task_start_date_2i')
        select('20', from: 'task_start_date_3i')
        select('2021', from: 'task_end_date_1i')
        select('July', from: 'task_end_date_2i')
        select('30', from: 'task_end_date_3i')
        click_on 'Create Task'

        expect(page).to have_content('Task Create Success')
        expect(page).to have_content('testing create')
        expect(page).to have_content('This is testing the creation of a new test')
        expect(page).to have_content('high')
        expect(page).to have_content('in_progress')
        expect(page).to have_content('2020-06-20')
        expect(page).to have_content('2021-07-30')
      end
    end
  end

  describe 'edit task' do
    let(:task) { tasks(:pending_task) }
    it do
      visit edit_task_path(task)
      select('In Progress', from: 'Status')
      click_on 'Update Task'
      expect(page).to have_content('Task Update Success')
      expect(page).to have_content('in progress')
    end
  end

  describe 'delete task', js: true do
    let(:task) { tasks(:pending_task) }
    it do
      visit task_path(task)
      page.accept_alert 'Do you really want to delete this task ?' do
        click_on('Delete')
      end
      expect(page).not_to have_content(task.name)
    end
  end
end
