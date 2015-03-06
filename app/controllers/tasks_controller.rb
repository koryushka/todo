class TasksController < ApplicationController
  include TasksHelper
  before_action :auth!
  before_action :fetch_user, only: [:index, :session_clear, :create, :change_users_tasks]
  before_action :fetch_task, only: [:show, :update, :destroy, :resolve, :unresolve]
  before_action :check_for_last_seen, only: :index

	def index 
    @task = @user.tasks.new
    @tasks_done = @user.tasks.done.order(created_at: :desc)
    @tasks_todo = @user.tasks.to_do.order(created_at: :desc)
    @tasks_done = user_signed_in? ? @tasks_done.all : @tasks_done.demo
    @tasks_todo = user_signed_in? ? @tasks_todo.all : @tasks_todo.demo
    unless user_signed_in?
      if cookies[:demo_user_id].blank?
        cookies[:demo_user_id] = @user.id 
      end
      if cookies[:last_seen].blank?
        cookies[:last_seen] = Time.now
      elsif cookies[:last_seen] < 10.minutes.ago
        session_clear
        @user = DemoUser.create
        cookies[:last_seen] = Time.now
        cookies[:demo_user_id] = @user.id 
      end
    end

    if user_signed_in?  && cookies[:demo_user_id]
      change_users_tasks
    end
  end

  def show
  end

  def create
    @task = @user.tasks.build(tasks_params)
      if @task.save
        if user_signed_in?
          Resque.enqueue(EmailJob, @user.id)
          #UserMailer.new_task(@user.id).deliver_later
        end
        respond_to do |f|
          f.html{redirect_to root_path}
          f.js{}
        end
      end 
  end

  def update
    respond_to do |format|
      if @task.update_attributes(tasks_params)
        format.html { redirect_to(@task, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@task) }
      else
        format.html { render :action => "show" }
        format.json { respond_with_bip(@task) }
      end
    end
  end

  def destroy
    if @task.destroy
      respond_to do |f|
        f.html{redirect_to root_path}
        f.js{}
      end
    end
  end

  def resolve
    @task.resolve! if @task
  end

  def unresolve
    @task.unresolve! if task    
  end

  def session_clear
    clear_cookies
    @user.destroy
  end

  def clear_cookies
    cookies[:demo_user_id] = nil
    cookies[:last_seen] = nil
  end

  def change_users_tasks
    user = DemoUser.find_by_id(cookies[:demo_user_id])
    change_users_tasks!(user) if user
  end

private

  def auth!
    if params[:user_id]
      if !user_signed_in?
        authenticate_user!
      elsif user_signed_in?
        correct_user?
      end
    end
  end

  def correct_user?
    if current_user.id != params[:user_id].to_i
      redirect_to root_path
    end
  end

  def fetch_user
    if DemoUser.find_by_id(cookies[:demo_user_id]).nil?
      clear_cookies
    end
    @user = user_signed_in? ? current_user : (DemoUser.find_by_id(cookies[:demo_user_id]) ? DemoUser.find_by_id(cookies[:demo_user_id]) : DemoUser.create)
  end

  def fetch_task
    @task = Task.find(params[:id])    
  end

  def check_for_last_seen

  end

  def tasks_params
    params.fetch(:task, {}).permit(:content, :is_done, :user_id)    
  end
end
