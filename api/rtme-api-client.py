#!/usr/bin/env python3

import argparse
import requests

KEY_API      =  ''                       # This needs to be <----------
URL_API_BASE = "https://rtme.com/api"


def broadcast(text, url_api_base=URL_API_BASE, key_api=KEY_API):
    # Params for the API end-point.
    jdata   = {'text': text}
    headers = {'key': key_api}

    req = requests.post(url_api_base+'/broadcast', headers=headers, json=jdata)
    print(f"status_code: {req.status_code}")
    print(f"data: {req.text}")

    print(f"result: ", end='')
    if req.status_code == 200:
        print('success')
    else:
        print('failed')


def main():
    parser = argparse.ArgumentParser(description="Command-line argument parser.")
    parser.add_argument('--url', type=str, default=URL_API_BASE, help="URL for the API.")
    parser.add_argument('--key', type=str, default=KEY_API, help="Key to be used.")
    parser.add_argument('text', nargs='+', type=str, help="Message to broadcast.")
    args = parser.parse_args()
    broadcast(text=' '.join(args.text), url_api_base=args.url, key_api=args.key)


if __name__ == "__main__":
    main()
