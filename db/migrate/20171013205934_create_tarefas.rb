class CreateTarefas < ActiveRecord::Migration[5.1]
  def change
    create_table :tarefas do |t|
      t.text :descricao
      t.date :deadline
      t.integer :severidade
      t.integer :realizada

      t.timestamps
    end
  end
end
