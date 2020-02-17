defmodule YamlTest do
  use ExUnit.Case
  doctest Yaml

  describe "Yaml.get_yaml_columns_by_event/3" do
    
    test "should return a list of yaml 'from' when you pass a list o levels to search on yaml file" do
      yaml = %{
        "track" => %{
          "flat" => [
            %{"from" => "Nome", "to" => "name"},
            %{"from" => "Email", "to" => "email"},
            %{"from" => "Cidade", "to" => "location"},
            %{"from" => "Faturamento", "to" => "created_at"}
          ]
        }
      }
      assert Yaml.get_yaml_columns_by_dig_list(yaml, ["track", "flat"], "from") == ["Nome", "Email", "Cidade", "Faturamento"]
    end

    test "should return a list of yaml 'to' by event" do
      yaml = %{
        "identify" => [
          %{"from" => "Nome", "to" => "name"},
          %{"from" => "Email", "to" => "email"},
          %{"from" => "Cidade", "to" => "location"},
          %{"from" => "Faturamento", "to" => "created_at"}
        ]
      }
      assert Yaml.get_yaml_columns_by_dig_list(yaml, ["identify"], "to") == ["name", "email", "location", "created_at"]
    end

    test "should return a list of from and to maps" do
      yaml = %{
        "track" => %{
          "flat" => [
            %{"from" => "Nome", "to" => "name"},
            %{"from" => "Email", "to" => "email"},
            %{"from" => "Cidade", "to" => "location"},
            %{"from" => "Faturamento", "to" => "created_at"}
          ]
        }
      }
      
      result = [
          %{"from" => "Nome", "to" => "name"},
          %{"from" => "Email", "to" => "email"},
          %{"from" => "Cidade", "to" => "location"},
          %{"from" => "Faturamento", "to" => "created_at"}
        ]
      assert Yaml.reduce_dig(yaml, "track.flat") == result
    end
  end
end
