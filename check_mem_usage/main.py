import subprocess
import time
import psutil

def track_memory_usage(command):
    # Start the subprocess
    proc = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    pid = proc.pid
    p = psutil.Process(pid)

    max_rss = 0  # in kilobytes

    try:
        while proc.poll() is None:
            mem_info = p.memory_info()
            rss_kb = mem_info.rss // 1024  # Convert bytes to KB
            if rss_kb > max_rss:
                max_rss = rss_kb
            time.sleep(0.05)  # Polling interval
    except psutil.NoSuchProcess:
        pass  # Process exited during check

    stdout, stderr = proc.communicate()

    print(f"Peak memory usage: {max_rss} KB")
    print("--- STDOUT ---")
    print(stdout.decode())
    print("--- STDERR ---")
    print(stderr.decode())

# Example usage:
# Replace this with your interpreter and args
track_memory_usage(["../build/interpreter", "../temp.lox"])
