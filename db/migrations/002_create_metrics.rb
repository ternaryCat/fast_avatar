Sequel.migration do
  change do
    create_table(:metrics) do
      primary_key :id

      foreign_key :user_id, :users
      text :title
      text :description
    end
  end
end
