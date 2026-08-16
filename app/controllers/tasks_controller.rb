class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all
  end

  # GET /tasks/:id
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
  @task = Task.new(task_params)
  if @task.save
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path, notice: "เพิ่มงานเรียบร้อยแล้ว" }
    end
  else
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("new_task_form", partial: "form", locals: { task: @task })
      end
      format.html { render :new, status: :unprocessable_entity }
    end
  end
end

  #<%= turbo_stream.append "task_items" do %>
  #  <%= render @task %>
  #<% end %>

  #<%= turbo_stream.update "task_count", 

  # GET /tasks/:id/edit
  def edit
  end

  # PATCH/PUT /tasks/:id
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "แก้ไขงานเรียบร้อยแล้ว"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "ลบงานเรียบร้อยแล้ว"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title)
  end
end