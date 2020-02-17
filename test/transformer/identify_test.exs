defmodule IdentifyTest do
  use ExUnit.Case
  doctest Identify
  alias Yaml

  describe "Identify.generate_client_list/1" do 
    test "should return a string if column exists" do
      parsed_yaml = Yaml.parse("lib/yaml/yaml_mappings/test.yaml")
      assert Identify.from_to(parsed_yaml, "id") == %{"from" =>"CGC/CPF", "to" => "id"}
    end

    test "should return a nil if column doesnt exist" do
      parsed_yaml = Yaml.parse("lib/yaml/yaml_mappings/test.yaml")
      assert Identify.from_to(parsed_yaml, "grg") == nil
    end
  end

  describe "Identify.filter_column_by_yaml_list/3" do
    test "trtr" do
      parsed_yaml = Yaml.parse("lib/yaml/yaml_mappings/test.yaml")
      columns = Yaml.get_yaml_columns_by_dig_list(parsed_yaml, ["identify"], "to")
      customer = %{
        "CodEAN" => "8710755117701",
        "CanalVenda" => "906",
        "RepresCGCCPF" => "7281452780",
        "RepresNmAbrev" => "7281452780",
        "ValorVenda" => "99,5",
        "Nome" => "LEILA CRISTINA MARTINS MORAES",
        "ItemCod" => "4081301119",
        "Bairro" => "HUMAITA",
        "Loja" => "Spicy Rio Sul",
        "UF" => "RJ",
        "Telefone" => "",
        "RepresCod" => "3999",
        "Nome Abrev" => "78434980797",
        "Endereco" => "RUA HUMAITA, 282",
        "TipoPessoa" => "FISICA",
        "TotalItem" => "19,9",
        "Cidade" => "RIO DE JANEIRO",
        "OrigemPedido" => "LOJA 604",
        "" => "268539",
        "Fabricante" => "BRABANTIA SOLID COMPANY",
        "Codigo" => "519156",
        "Sexo" => "",
        "RepresNome" => "¶ngelo de Carvalho Santos",
        "DtNascimento" => "",
        "SubCategoria" => "LIMPEZA",
        "Data Faturamento" => "01/08/2019",
        "CEP" => "22261004.0",
        "PedidoCliente" => "",
        "CGC/CPF" => "78434980797",
        "Artigo" => "PANO",
        "E-Mail" => "",
        "Categoria" => "LIMPEZA E ORGANIZACAO",
        "ItemDesc" => "JOGO DE PANO AZ 2PC 30x30cm",
        "QtFaturada" => "1"
      }

      assert Identify.filter_column_by_yaml_list(parsed_yaml, customer, columns) == %{ "78434980797" => %{
        "id" => "78434980797",
        "name" => "LEILA CRISTINA MARTINS MORAES",
        "email" => "",
        "location" => "RIO DE JANEIRO",
        "created_at" => "01/08/2019"
      }}
    end
  end
end
