# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Task Managemenet', type: :feature do
  context 'when login' do
    before { login }

    context 'show specific task' do
      let(:task) { tasks(:pending_task) }

      it 'shows your tasks' do
        visit task_path(task.id)
        expect(page).to have_content(task.name)
        expect(page).to have_content(task.description)
        expect(page).to have_content(task.priority)
        expect(page).to have_content(task.status)
        expect(page).to have_content(task.start_date)
        expect(page).to have_content(task.end_date)
      end
    end

    context 'visit task list' do
      before { visit tasks_path }

      it 'show all task' do
        expect(page).to have_content(tasks(:pending_task).name)
        expect(page).to have_content(tasks(:progressing_task).name)
        expect(page).to have_content(tasks(:completed_task).name)
      end

      it 'does not show tasks of other user' do
        expect(page).not_to have_content('other user task')
      end

      context 'when sorting' do
        it 'sorts by created_at in desc by default' do
          expect(page).to have_text(/test3.+test2.+test1/m)
        end

        it 'sorts by created_at' do
          click_link 'Created At'
          expect(page).to have_text(/.+test1.+test2.+test3/m)
          click_link 'Created At'
          expect(page).to have_text(/test3.+test2.+test1/m)
        end

        it 'sorts by end_date' do
          click_link 'End At'
          expect(page).to have_text(/test1.+test2.+test3/m)
          click_link 'End At'
          expect(page).to have_text(/test3.+test2.+test1/m)
        end

        it 'sorts by priority' do
          click_link 'Priority'
          expect(page).to have_text(/test1.+test2.+test3/m)
          click_link 'Priority'
          expect(page).to have_text(/test3.+test2.+test1/m)
        end
      end

      context 'when searching' do
        it 'searh by name' do
          fill_in 'Name', with: 'test1'
          click_on 'Search'
          expect(page).to have_text 'test1'
          expect(page).not_to have_text 'test2'
        end

        it 'search by status' do
          select 'Pending', from: 'Status'
          click_on 'Search'
          expect(page).to have_text 'pending'
          expect(page).not_to have_text 'in_progress'
          expect(page).not_to have_text 'completed'
        end

        it 'search by label' do
          select 'test_label', from: 'Label'
          click_on 'Search'
          within '#task-table' do
            expect(page).to have_text 'test_label'
            expect(page).not_to have_text 'unused_label'
            expect(page).not_to have_text 'other_user_label'
          end
        end

        it 'search by name and status' do
          fill_in 'Name', with: 'test1'
          select 'Pending', from: 'Status'
          click_on 'Search'

          expect(page).to have_text 'test1'
          expect(page).not_to have_text 'test2'
          expect(page).to have_text 'pending'
          expect(page).not_to have_text 'in_progress'
          expect(page).not_to have_text 'completed'
        end
      end
    end

    context 'create task' do
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

      context 'when create fail' do
        it 'shows alert and errors' do
          visit new_task_path
          select('2022', from: 'task_start_date_1i')
          select('2020', from: 'task_end_date_1i')
          click_on 'Create Task'
          expect(page).to have_content('Task Create Fail')
          expect(page).to have_content("Name can't be blank")
          expect(page).to have_content('Start date should not larger than end date')
        end
      end
    end

    context 'edit task' do
      let(:task) { tasks(:pending_task) }

      it 'update task' do
        visit edit_task_path(task)
        select('Pending', from: 'Status')
        click_on 'Update Task'
        expect(page).to have_content('Task Update Success')
        expect(page).to have_content('pending')
      end

      context 'when update fail' do
        it 'shows alert and errors' do
          visit edit_task_path(task)
          fill_in 'Name', with: ''
          select('2022', from: 'task_start_date_1i')
          select('2020', from: 'task_end_date_1i')
          click_on 'Update Task'
          expect(page).to have_content('Task Update Fail')
          expect(page).to have_content("Name can't be blank")
          expect(page).to have_content('Start date should not larger than end date')
        end
      end
    end

    context 'delete task', js: true do
      let(:task) { tasks(:pending_task) }
      it do
        visit task_path(task)
        page.accept_alert 'Do you really want to delete this task ?' do
          click_on('Delete')
        end
        expect(page).not_to have_content(task.name)
        expect(page).to have_content('Task Delete Success')
      end
    end
  end

  context 'when not login' do
    it 'asks user to login' do
      [tasks_path, task_path(id: 1), edit_task_path(id: 1), new_task_path].each do |path|
        visit path
        expect(page).to have_current_path login_path
        expect(page).to have_content 'please login first'
      end
    end
  end
end
