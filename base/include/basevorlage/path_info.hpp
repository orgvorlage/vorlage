//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#ifndef BASEVORLAGE_PATH_INFO_HPP
#define BASEVORLAGE_PATH_INFO_HPP

#include <string>

namespace basevorlage {
class path_info {

public:
  path_info() = default;

  path_info(std::string input, std::string output);

  [[nodiscard]] auto input() const noexcept -> std::string const&;
  [[nodiscard]] auto output() const noexcept -> std::string const&;

private:
  std::string input_;
  std::string output_;
};

auto module_prefix(std::string const& module_name) -> path_info;
auto test_path(path_info const& module_prefix, std::size_t index)
  -> std::tuple<std::string, std::string>;
} // namespace basevorlage

#endif // BASEVORLAGE_PATH_INFO_HPP
