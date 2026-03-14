#include <string>

#include "mochibot/mochibot.hpp"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("Name is mochibot", "[library]")
{
  auto const exported = exported_class {};
  REQUIRE(std::string("mochibot") == exported.name());
}
