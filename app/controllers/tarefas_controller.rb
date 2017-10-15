class TarefasController < ApplicationController
  before_action :set_tarefa, only: [:show, :update, :destroy]

  # GET /tarefas
  def index
    @tarefas = Tarefa.all

    render json: @tarefas
  end

  # GET /tarefas/1
  def show
    render json: @tarefa
  end

  # POST /tarefas
  def create
    @tarefa = Tarefa.new(tarefa_params.permit!)
    puts "Tarefa: #{@tarefa}"

    if @tarefa.save
      render json: @tarefa, status: :created, location: @tarefa
    else
      render json: @tarefa.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tarefas/1
  def update
    if @tarefa.update(tarefa_params.permit!)
      render json: @tarefa
    else
      render json: @tarefa.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tarefas/1
  def destroy
    @tarefa.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tarefa
      @tarefa = Tarefa.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tarefa_params
      p = params.fetch(:tarefa, {})
      puts "Parametros = #{p}"
      return p
    end
end
