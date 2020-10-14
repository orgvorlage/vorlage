//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#define CATCH_CONFIG_RUNNER
#include <basevorlage/path_info.hpp>
#include <catch2/catch.hpp>
#include <iostream>

extern basevorlage::path_info path_prefix;
basevorlage::path_info path_prefix = basevorlage::path_info();

auto main(int argc, char* argv[]) -> int
{
  Catch::Session session;

  namespace clara = Catch::clara;

  std::string input_prefix;
  std::string output_prefix;
  auto cli
    = session.cli()
      | clara::Opt(input_prefix, "path to input data")["--input-data"](
        "Path to Input Data ")
      | clara::Opt(output_prefix, "Path to test output ")["--output-data"](
        "Path to Test Output");

  session.cli(cli);

  int return_code = session.applyCommandLine(argc, argv);
  if (return_code != 0) {
    return return_code;
  }

  path_prefix = basevorlage::path_info(input_prefix, output_prefix);
  // Run all the Tests
  return session.run();
}
