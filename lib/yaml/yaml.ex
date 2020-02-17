defmodule Yaml do
  def parse(file_path) do 
    yaml = YamlElixir.read_from_file(file_path)
    yaml |> Tuple.to_list |> List.last
  end

  def list_join(list) do
    IO.puts list
    unless !is_list(list) do
      Enum.join list, "."
    end
  end

  def dig_parsed_yaml(object, key, size) when size == 0 do
    object[key]
  end

  def dig_parsed_yaml(object, arr) do
    [head | tail] = arr
    size = Enum.count(tail) 
    if size > 0 do
      Yaml.dig_parsed_yaml(object[head], tail)
    else
      Yaml.dig_parsed_yaml(object, head, size)
    end
  end

  def reduce_dig(object, dig_string) do
    dig_string
    |> String.split(".")
    |> Enum.reduce object, fn elem, acc -> 
      acc[elem]
    end
  end

  def get_yaml_columns_by_dig_list(yaml, dig_list, param) do
    dig_list = yaml |> dig_parsed_yaml(dig_list) 
    dig_list |> Enum.reduce([], fn mapping_params, acc ->
      [mapping_params |> Map.get(param) | acc] end) 
    |> Enum.reverse
  end
end
