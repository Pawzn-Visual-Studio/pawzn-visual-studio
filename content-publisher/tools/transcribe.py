#!/usr/bin/env python3
"""
Transcribe audio to text using faster-whisper (local, no API key needed).
Usage: python tools/transcribe.py <audio_file_path>
Supports: m4a, ogg, mp3, wav, mp4, webm

Install: venv/bin/pip install faster-whisper (run with venv/bin/python3, not the system python3)
"""
import sys
from datetime import datetime
from pathlib import Path


def transcribe(audio_path: str) -> str:
    from faster_whisper import WhisperModel

    model = WhisperModel("large-v3", device="cpu", compute_type="int8")
    segments, info = model.transcribe(audio_path, beam_size=5)
    print(f"Language: {info.language} ({info.language_probability:.0%})", file=sys.stderr)
    return " ".join(segment.text.strip() for segment in segments)


def main():
    if len(sys.argv) < 2:
        print("Usage: python tools/transcribe.py <audio_file>", file=sys.stderr)
        sys.exit(1)

    audio_path = Path(sys.argv[1])
    if not audio_path.exists():
        print(f"Error: File not found: {audio_path}", file=sys.stderr)
        sys.exit(1)

    result = transcribe(str(audio_path))

    # Save to output/ for persistence
    output_dir = Path("output")
    output_dir.mkdir(exist_ok=True)
    date_str = datetime.now().strftime("%Y-%m-%d")
    output_path = output_dir / f"transcripcion-{date_str}-{audio_path.stem}.txt"
    output_path.write_text(result, encoding="utf-8")
    print(f"Saved: {output_path}", file=sys.stderr)

    # Print to stdout — used by skill !`command` injection
    print(result)


if __name__ == "__main__":
    main()
