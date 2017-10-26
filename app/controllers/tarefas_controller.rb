class TarefasController < ApplicationController
  before_action :set_tarefa, only: [:show, :update, :destroy]

  # GET /tarefas
  def index
    @tarefas = Tarefa.where(realizada: 0).order(deadline: :asc, severidade: :desc)

    render json: @tarefas
  end

  def estatisticas
    finalizadas = Tarefa.where(realizada: 1)
    abertas = Tarefa.where(realizada: 0)
    todas = Tarefa.all
    @stats = {
      finalizadas: {
        total: finalizadas.count,
        com_atraso: finalizadas.where("updated_at > deadline").count,
        no_prazo: finalizadas.where("updated_at <= deadline").count,
        baixa: finalizadas.where(severidade: 0).count,
        media: finalizadas.where(severidade: 1).count,
        alta: finalizadas.where(severidade: 2).count,
        urgente: finalizadas.where(severidade: 3).count,
      },
      abertas: {
        total: abertas.count,
        baixa: abertas.where(severidade: 0).count,
        media: abertas.where(severidade: 1).count,
        alta: abertas.where(severidade: 2).count,
        urgente: abertas.where(severidade: 3).count,
      },
      todas: {
        total: todas.count,
        baixa: todas.where(severidade: 0).count,
        media: todas.where(severidade: 1).count,
        alta: todas.where(severidade: 2).count,
        urgente: todas.where(severidade: 3).count,
      }
    }

    render json: @stats
  end

  # GET /tarefas/1
  def show
    render json: @tarefa
  end

  # POST /tarefas
  def create
    @tarefa = Tarefa.new(tarefa_params)
    puts "Tarefa: #{@tarefa}"

    if @tarefa.save
      render json: @tarefa, status: :created, location: @tarefa
    else
      render json: @tarefa.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tarefas/1
  def update
    if @tarefa.update(tarefa_params)
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
      params.fetch(:tarefa, {}).permit(:descricao, :deadline, :severidade, :realizada)
    end
end
