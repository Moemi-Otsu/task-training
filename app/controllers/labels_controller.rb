class LabelsController < ApplicationController

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to tasks_path, notice: 'ラベルを作成しました'
    else
      render 'new'
    end
  end

  private

  def label_params
    params.require(:label).permit(:label_name)
  end

end