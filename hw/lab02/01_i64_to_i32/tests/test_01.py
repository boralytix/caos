import os
import subprocess
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
TASK_DIR = HERE.parent
BIN = TASK_DIR / "i64_to_i32"

class TestI64ToI32(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        # Сборка перед запуском тестов
        subprocess.run(["make"], cwd=TASK_DIR, check=True)

    def run_case(self, input_str: str) -> str:
        """Запуск исполняемого файла с передачей строки на stdin."""
        proc = subprocess.run(
            [str(BIN)],
            input=input_str.encode(),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            cwd=TASK_DIR,
            check=True,
        )
        return proc.stdout.decode().strip()

    def test_in_range(self):
        self.assertEqual(self.run_case("0\n"), "0")
        self.assertEqual(self.run_case("42\n"), "42")
        self.assertEqual(self.run_case("-42\n"), "-42")
        self.assertEqual(self.run_case("-2147483648\n"), "-2147483648")
        self.assertEqual(self.run_case("2147483647\n"), "2147483647")

    def test_below_min(self):
        self.assertEqual(self.run_case("-2147483649\n"), "-2147483648")
        self.assertEqual(self.run_case("-9223372036854775808\n"), "-2147483648")

    def test_above_max(self):
        self.assertEqual(self.run_case("2147483648\n"), "2147483647")
        self.assertEqual(self.run_case("9223372036854775807\n"), "2147483647")

if __name__ == "__main__":
    unittest.main()

