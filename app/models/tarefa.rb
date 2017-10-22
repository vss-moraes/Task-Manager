class Tarefa < ApplicationRecord
  enum severidade: [:baixa, :media, :alta, :urgente]
  attribute :realizada, :integer, default: 0
end
