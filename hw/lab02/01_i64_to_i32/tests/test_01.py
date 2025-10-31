import subprocess
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
TASK_DIR = HERE.parent
BIN = TASK_DIR / "i64_to_i32"

class TestI64ToI32(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        subprocess.run(["make", "clean"], cwd=TASK_DIR, check=True)
        subprocess.run(["make"], cwd=TASK_DIR, check=True)

    def run_case(self, s: str) -> str:
        p = subprocess.run(
            [str(BIN)],
            input=s.encode(),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            cwd=TASK_DIR,
            check=True,
        )
        return p.stdout.decode().strip()

    # Базовые внутри диапазона
    def test_in_range(self):
        for x in ["0", "1", "-1", "42", "-42", "2147483647", "-2147483648"]:
            with self.subTest(x=x):
                self.assertEqual(self.run_case(x + "\n"), x)

    # Вверх за предел
    def test_above_max(self):
        for x in ["2147483648", "3000000000", "9223372036854775807"]:
            with self.subTest(x=x):
                self.assertEqual(self.run_case(x + "\n"), "2147483647")

    # Вниз за предел
    def test_below_min(self):
        for x in ["-2147483649", "-3000000000", "-9223372036854775808"]:
            with self.subTest(x=x):
                self.assertEqual(self.run_case(x + "\n"), "-2147483648")

    # Пограничные окрестности
    def test_edges_near(self):
        pairs = {
            "2147483646": "2147483646",
            "2147483647": "2147483647",
            "2147483648": "2147483647",
            "-2147483647": "-2147483647",
            "-2147483648": "-2147483648",
            "-2147483649": "-2147483648",
        }
        for inp, out in pairs.items():
            with self.subTest(inp=inp):
                self.assertEqual(self.run_case(inp + "\n"), out)

if __name__ == "__main__":
    unittest.main()
