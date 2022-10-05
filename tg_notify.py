import requests
import os
from dotenv import load_dotenv

load_dotenv()
BOT_TOKEN = str(os.getenv("BOT_TOKEN"))
LOGFILE_NAMES = ["laststep_1.log", "laststep_2.log", "laststep_3.log"]


def get_users(user_ids_filename: str = "users.txt") -> list:
    users = []

    with open(user_ids_filename, "r") as f:
        for user in f:
            users.append(user)

    return users


def read_logs() -> str:
    logs_content = []

    for logfile in LOGFILE_NAMES:
        with open(logfile, "r") as f:
            logs_content.append(f.read())

    message = "\n\n\n".join(logs_content)
    return message

def check_laststep_has_content():
    for log in LOGFILE_NAMES:
        with open(log, "r") as f:
            if f.read():
                return True

def send_notify(token: str, users: list, message: str) -> None:
    for user in users:
        requests.get(f"https://api.telegram.org/bot{token}/sendMessage?chat_id={user}&text={message}"
                     f"&parse_mode=HTML")


if __name__ == "__main__":
    if check_laststep_has_content():
        send_notify(BOT_TOKEN, get_users(), read_logs())
