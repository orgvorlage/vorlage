//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#include <basevorlage/path_info.hpp>
#include <filesystem>
#include <fstream>
#include <tuple>
#include <utility>

extern basevorlage::path_info path_prefix;

namespace basevorlage {
path_info::path_info(std::string input, std::string output)
: input_(std::move(input)), output_(std::move(output))
{
}

auto path_info::input() const noexcept -> std::string const&
{
  return input_;
}

auto path_info::output() const noexcept -> std::string const&
{
  return output_;
}

auto module_prefix(std::string const& module_name) -> path_info
{
  return path_info(
    path_prefix.input() + std::string("/") + module_name,
    path_prefix.output() + std::string("/") + module_name);
}

auto test_path(path_info const& module_prefix, std::size_t test_index)
  -> std::tuple<std::string, std::string>
{
  auto const path = path_info(
    module_prefix.input() + std::string("/") + std::to_string(test_index),
    module_prefix.output() + std::string("/") + std::to_string(test_index));
  return std::make_tuple(path.input(), path.output());
}
} // namespace basevorlage
