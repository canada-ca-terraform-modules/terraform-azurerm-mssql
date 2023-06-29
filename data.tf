locals {
  str_days = (var.environment == "production") ? "35" : "7"
}