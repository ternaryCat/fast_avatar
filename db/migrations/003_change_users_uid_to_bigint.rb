Sequel.migration do
  change do
    alter_table(:users) do
      set_column_type :uid, :Bignum
    end
  end
end