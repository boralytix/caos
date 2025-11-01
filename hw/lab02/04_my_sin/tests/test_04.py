import math
import subprocess
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
TASK_DIR = HERE.parent
BIN = TASK_DIR / "my_sin_bin"

class TestMySin(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        subprocess.run(["make", "clean"], cwd=TASK_DIR, check=True)
        subprocess.run(["make"], cwd=TASK_DIR, check=True)

    def run_case(self, x: float) -> float:
        p = subprocess.run(
            [str(BIN)],
            input=(f"{x}\n").encode(),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            cwd=TASK_DIR,
            check=True,
        )
        return float(p.stdout.decode().strip())

    def assertClose(self, got, want, tol=1e-7):
        self.assertTrue(abs(got - want) <= tol, f"got={got}, want={want}, tol={tol}")

    def test_small_values(self):
        for x in [0.0, 0.1, -0.1, 0.5, -0.5, 1.0, -1.0]:
            with self.subTest(x=x):
                self.assertClose(self.run_case(x), math.sin(x))

    def test_medium_values(self):
        # Ряд из 15 членов даёт приемлемую точность в окрестности |x|<=3
        for x in [2.0, -2.0, 3.0, -3.0]:
            with self.subTest(x=x):
                self.assertClose(self.run_case(x), math.sin(x), tol=1e-6)

if __name__ == "__main__":
    unittest.main()