defmodule ApexECS.Component do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @table_name __MODULE__

      def init do
        :ets.new(@table_name, [:named_table, :set])
      end

      def list_all do
        @table_name
        |> :ets.tab2list()
      end

      def create(entity_id, value) do
        :ets.insert(@table_name, {entity_id, value})
      end
    end
  end
end
