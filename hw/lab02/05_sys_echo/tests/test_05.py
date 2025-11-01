import subprocess
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
TASK_DIR = HERE.parent
BIN = TASK_DIR / "sys_echo"

class TestSysEcho(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        subprocess.run(["make", "clean"], cwd=TASK_DIR, check=True)
        subprocess.run(["make"], cwd=TASK_DIR, check=True)

    def run_case(self, input_bytes: bytes) -> bytes:
        p = subprocess.run(
            [str(BIN)],
            input=input_bytes,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            cwd=TASK_DIR,
            check=True,
        )
        return p.stdout

    def test_basic(self):
        self.assertEqual(self.run_case(b"hello\n"), b"ECHO: hello\n")
        self.assertEqual(self.run_case(b"ABC\n"),   b"ECHO: ABC\n")

    def test_empty(self):
        # EOF → ничего не печатаем
        self.assertEqual(self.run_case(b""), b"")

    def test_no_newline(self):
        self.assertEqual(self.run_case(b"xyz"), b"ECHO: xyz")

    def test_limit(self):
        # читаем максимум 64 байта
        data = b"a" * 100
        out  = self.run_case(data)
        self.assertEqual(out, b"ECHO: " + b"a"*64)

if __name__ == "__main__":
    unittest.main()