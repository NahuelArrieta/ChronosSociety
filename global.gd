extends Node

## Constants
const gravity = 980.0
const log_delay = 0.05
const _max_history_length = (10 /  log_delay) * 1.2

## Gropus
const TIME_TRAVEL_GROUP = "time_travelable"

## Signals
signal revert_started(player: int)
signal revert_stopped()
