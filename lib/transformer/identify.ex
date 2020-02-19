defmodule Identify do
  alias CsvParser
  alias Yaml

  def get_clients_by_csv do 
    CsvParser.read("lib/base_teste.csv")
  end

  def from_to(parsed_yaml, to) do
    row = parsed_yaml
    |> Yaml.dig_parsed_yaml(["identify"])
    |> Enum.filter(fn x -> x["to"] == to end)
    List.first(row)
  end

  def expose_client_id(client) do
    %{
      client["id"] => client
    }
  end

  def filter_column_by_yaml_list(parsed_yaml, customer, columns_to) do
    Enum.reduce(columns_to, %{}, fn elem, acc -> 
      from = from_to(parsed_yaml, elem)["from"] 
      Map.put(acc, elem, customer[from] || "") 
    end)
    |> expose_client_id
  end
end