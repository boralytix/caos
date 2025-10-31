import subprocess
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
TASK_DIR = HERE.parent
BIN = TASK_DIR / "countdown"

class TestCountdown(unittest.TestCase):
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
        return p.stdout.decode()

    def test_negative(self):
        self.assertEqual(self.run_case("-1\n"), "")

    def test_zero(self):
        self.assertEqual(self.run_case("0\n"), "0\n")

    def test_small(self):
        self.assertEqual(self.run_case("3\n"), "3\n2\n1\n0\n")

    def test_medium(self):
        self.assertEqual(self.run_case("5\n"), "5\n4\n3\n2\n1\n0\n")

if __name__ == "__main__":
    unittest.main()
