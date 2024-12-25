#!/usr/bin/env python3

import random
import sys
from pathlib import Path
import re


class Roll:
    _pattern = re.compile(
        r"(?P<number>\d+)d(?P<sides>\d+)(?P<modifier>[+-]\d+)?(?P<keep>[><]\d+)?"
    )

    def __init__(self, roll_notation: str):
        match = self._match = self._pattern.match(roll_notation)
        if not match:
            raise ValueError(f"Invalid roll notation: {roll_notation}")
        self.matches = match.groupdict()
        self.number = int(self.matches["number"])
        self.sides = int(self.matches["sides"])
        self.modifier = int(self.matches["modifier"]) if self.matches["modifier"] else 0
        if self.matches["keep"] is None:
            self.keep = 0
        else:
            mult = 1 if self.matches["keep"][0] == ">" else -1
            self.keep = mult * int(self.matches["keep"][1:])

    def roll(self) -> list[int]:
        rolls = roll_die(self.number, self.sides, self.modifier)
        # TODO: keep/drop the highest/lowest
        return rolls

    def __str__(self) -> str:
        s = f"{self.number}d{self.sides}"
        if self.modifier != 0:
            s += "+" if self.modifier > 0 else ""
            s += str(self.modifier)
        if self.keep != 0:
            s += ">" if self.keep > 0 else "<"
            s += f"{abs(self.keep)}"
        return s


# notation
# nDs(+|-)m(>|<)a


def roll_die(num_dice: int, dice_type: int, modifier: int) -> list[int]:
    rolls: list[int] = []
    for _ in range(num_dice):
        rolls.append(random.randint(1, dice_type) + modifier)

    return rolls


def parse_dice_notation(dice_notation: str) -> tuple[int, int, int]:
    # Define the regular expression pattern
    pattern = re.compile(r"(\d+)d(\d+)([+-]\d+)?")

    # Search the pattern in the dice notation string
    match = pattern.match(dice_notation)

    if not match:
        raise ValueError(f"Invalid dice notation: {dice_notation}")

    # Extract the groups from the match
    groups = match.groups()

    # Convert the groups to integers and handle the optional modifier
    num_dice = int(groups[0])
    dice_type = int(groups[1])
    modifier = int(groups[2]) if groups[2] else 0

    return num_dice, dice_type, modifier


def summary(rolls: list[int]) -> None:
    print(rolls)
    print(f"Min: {min(rolls)}")
    print(f"Max: {max(rolls)}")
    if len(rolls) > 1:
        print(f"Total: {sum(rolls)}")
        print(f"Avg: {sum(rolls)/len(rolls):.2f}")


def main():
    if len(sys.argv) != 2:
        path = Path(sys.argv[0]).parts[-1]
        print(f"Usage: {path} xdy[(+|y)z]")
        print("Rolls x number of y sided die, optionally using a modifier z")
        print()
        print("Examples:")
        print("\t2d4+2 Rolls two four sided die adding 2 to each roll")
        print("\t1d20-1 Rolls a single twenty and subtracts 1 from the roll")
        sys.exit(1)

    dice_notation = sys.argv[1]

    try:
        num_die, die_type, modifier = parse_dice_notation(dice_notation)
    except ValueError as e:
        print(e)
        sys.exit(1)

    rolls = roll_die(num_die, die_type, modifier)
    summary(rolls)


if __name__ == "__main__":
    main()
