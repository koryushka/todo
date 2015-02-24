class TasksController < ApplicationController
	def index  
    @tasks_done = Task.all.done.order(created_at: :desc)
    @tasks_todo = Task.all.to_do
    @task = Task.new
  end

  def create
    @task = Task.new(tasks_params)
    @tasks_done = Task.all.done.order(created_at: :desc)
    @tasks_todo = Task.all.to_do
    if @task.save
      respond_to do |f|
        f.html{redirect_to root_path}
        f.js{}
      end
    end 

    
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(tasks_params)
      respond_to do |f|
        f.html{
          redirect_to root_path
          flash[:notice] = "Task rebuild"
        }
        f.js{}
      end

    
  
    end
    
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      respond_to do |f|
        f.html{redirect_to root_path}
        f.js{}
      end
    end
  end

  private

  def tasks_params
    params.require(:task).permit(:content, :is_not_done)    
  end
end
