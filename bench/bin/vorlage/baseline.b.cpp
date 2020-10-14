//------------------------------------------------------------------------------
// SPDX-License-Identifier: "Apache-2.0 OR MIT"
// Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
//------------------------------------------------------------------------------
#include <benchmark/benchmark.h>
#include <chrono>
#include <thread>

// NOLINTNEXTLINE(google-runtime-references)
void benchmark_baseline(benchmark::State& state);

// NOLINTNEXTLINE(google-runtime-references)
void benchmark_baseline(benchmark::State& state)
{
  for ([[maybe_unused]] auto run : state) {
    using namespace std::chrono_literals;
    std::this_thread::sleep_for(1us);
  }
}

BENCHMARK(benchmark_baseline);
