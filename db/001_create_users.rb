Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id

      Integer :uid
      text :username
      text :first_name
      text :last_name
      text :language_code
    end
  end
end
