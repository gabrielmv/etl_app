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
        "CanalVenda" => "906",
        "RepresCGCCPF" => "54534",
        "RepresNmAbrev" => "2342342",
        "ValorVenda" => "99,5",
        "Nome" => "victoria vilas boas",
        "ItemCod" => "423423",
        "Bairro" => "cidade nova",
        "Loja" => "loja da victoria",
        "UF" => "MG",
        "Telefone" => "",
        "RepresCod" => "3999",
        "Nome Abrev" => "02237063290",
        "Endereco" => "av jose candido",
        "TipoPessoa" => "FISICA",
        "TotalItem" => "19,9",
        "Cidade" => "belo horizonte",
        "Fabricante" => "BRABANTIA SOLID COMPANY",
        "Sexo" => "female",
        "RepresNome" => "teste",
        "DtNascimento" => "",
        "Data Faturamento" => "01/08/2019",
        "CEP" => "22261004.0",
        "PedidoCliente" => "",
        "CGC/CPF" => "02237063290",
        "Artigo" => "PANO",
        "E-Mail" => "victoriaovilas@gmail.com",
        "QtFaturada" => "1"
      }

      assert Identify.filter_column_by_yaml_list(parsed_yaml, customer, columns) == %{"02237063290" =>
       %{"created_at" => "01/08/2019", "email" => "", "id" => "02237063290", "location" => "belo horizonte", "name" => "victoria vilas boas"}}

    end
  end
end
