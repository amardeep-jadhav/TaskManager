require "test_helper"
class TasksControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  setup do
    @user = users(:one) || User.find_or_create_by!(email: "task_user@example.com") do |u|
      u.name = "Task User"
      u.password = "password"
    end

    @task = Task.create!(
      title: "Sample Task",
      description: "Testing task",
      priority: "medium",
      status: "pending",
      due_date: Date.today,
      user: @user
    )
  end

  # helper to log in via Devise
  def sign_in(user)
    post user_session_path, params: {
      user: { email: user.email, password: "password" }
    }
    follow_redirect!
  end

  test "should get index when logged in" do
    sign_in(@user)

    get tasks_url
    assert_response :success
    assert_select "h2", "My Tasks"
  end

  test "should redirect index if not logged in" do
    get tasks_url
    assert_redirected_to new_user_session_path
  end

  test "should create task with valid params" do
    sign_in(@user)

    assert_difference("Task.count", 1) do
      post tasks_url, params: {
        task: {
          title: "New Task",
          description: "A valid task",
          priority: "high",
          status: "pending",
          due_date: Date.today
        }
      }
    end

    assert_redirected_to tasks_path
  end

  test "should not create task with invalid params" do
    sign_in(@user)

    assert_no_difference("Task.count") do
      post tasks_url, params: {
        task: {
          title: "", # invalid
          priority: "high",
          status: "pending",
          due_date: Date.today
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should update task" do
    sign_in(@user)

    patch task_url(@task), params: {
      task: { title: "Updated Task Title" }
    }

    assert_redirected_to tasks_path
    @task.reload
    assert_equal "Updated Task Title", @task.title
  end

  test "should destroy task" do
    sign_in(@user)

    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_path
  end
end
