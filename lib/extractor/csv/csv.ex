defmodule CsvParser do
  def read(file_path) do
    File.stream!(file_path) 
    |> Stream.map(&(&1))
    |> CSV.decode!(separator: ?,, strip_fields: true, headers: true) 
  end
end