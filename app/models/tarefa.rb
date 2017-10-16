class Tarefa < ApplicationRecord
  enum severidade: [:baixa, :media, :alta, :urgente]
end
