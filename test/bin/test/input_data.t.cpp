//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#include <basevorlage/path_info.hpp>
#include <catch2/catch.hpp>
#include <fstream>

extern basevorlage::path_info path_prefix;

TEST_CASE("testvorlage:input_data: 01: verify", "[all][path_info]")
{
  auto const input_filename = path_prefix.input() + std::string("/.vorlage");
  auto input_file = std::ifstream(input_filename);
  std::string input_data;
  input_file >> input_data;
  REQUIRE(input_data == std::string("vorlage"));
}
