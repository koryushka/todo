class TasksController < ApplicationController
	def index  
    @tasks_done = Task.all.done.order(created_at: :desc)
    @tasks_todo = Task.all.to_do.order(created_at: :desc)
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
    
  end

  def create
    @task = Task.new(tasks_params)
    if @task.save
      respond_to do |f|
        f.html{redirect_to root_path}
        f.js{}
      end
    end 
  end

  def update
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
    if @task.destroy
      respond_to do |f|
        f.html{redirect_to root_path}
        f.js{}
      end
    end
  end

  def resolve
    task = Task.find(params[:id])
    task.resolve! if task
  end

  def unresolve
    task = Task.find(params[:id])
    task.unresolve! if task    
  end

private

  def tasks_params
    params.fetch(:task, {}).permit(:content, :is_done)    
  end
end
