import subprocess
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
TASK_DIR = HERE.parent
BIN = TASK_DIR / "mul_shift_add"

class TestMulShiftAdd(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        subprocess.run(["make", "clean"], cwd=TASK_DIR, check=True)
        subprocess.run(["make"], cwd=TASK_DIR, check=True)

    def run_case(self, a: int, b: int) -> int:
        p = subprocess.run(
            [str(BIN), str(a), str(b)],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            cwd=TASK_DIR,
            check=True,
        )
        return int(p.stdout.decode().strip())

    def test_basic(self):
        self.assertEqual(self.run_case(0, 0), 0)
        self.assertEqual(self.run_case(7, 5), 35)
        self.assertEqual(self.run_case(-3, 6), -18)
        self.assertEqual(self.run_case(-4, -8), 32)

    def test_more(self):
        pairs = [(1, 0), (0, 9), (1, -7), (-1, 9), (12, -11), (-12, 11)]
        for a, b in pairs:
            with self.subTest(a=a, b=b):
                self.assertEqual(self.run_case(a, b), a * b)

if __name__ == "__main__":
    unittest.main()
