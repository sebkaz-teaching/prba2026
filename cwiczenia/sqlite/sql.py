"""Execute teaching SQL files with per-connection foreign keys and visible results."""
import argparse
from pathlib import Path
import sqlite3
import sys


def statements(text):
    """Yield complete SQLite statements, including trigger bodies."""
    buffer = ''
    for character in text:
        buffer += character
        if character == ';' and sqlite3.complete_statement(buffer):
            yield buffer
            buffer = ''
    if buffer.strip():
        yield buffer


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('database', type=Path)
    parser.add_argument('scripts', type=Path, nargs='+')
    args = parser.parse_args()
    if sqlite3.sqlite_version_info < (3, 37, 0):
        raise SystemExit('SQLite 3.37+ is required for STRICT tables.')
    args.database.parent.mkdir(parents=True, exist_ok=True)
    connection = sqlite3.connect(args.database, isolation_level=None, timeout=3)
    connection.execute('PRAGMA foreign_keys=ON')
    print(f'SQLite {sqlite3.sqlite_version}; database={args.database.resolve()}; foreign_keys=1')
    try:
        for script in args.scripts:
            print(f'\n--- {script.name} ---')
            for statement in statements(script.read_text(encoding='utf-8')):
                cursor = connection.execute(statement)
                if cursor.description:
                    print(' | '.join(column[0] for column in cursor.description))
                    rows = cursor.fetchmany(51)
                    for row in rows[:50]:
                        print(' | '.join('NULL' if value is None else str(value) for value in row))
                    if len(rows) > 50:
                        print('[Output limited to 50 rows]')
                elif cursor.rowcount >= 0:
                    print(f'Changed rows: {cursor.rowcount}')
        if connection.in_transaction:
            connection.rollback()
            raise RuntimeError('Unfinished transaction rolled back. Add COMMIT or ROLLBACK explicitly.')
    except (sqlite3.Error, OSError, RuntimeError) as error:
        connection.rollback()
        print(f'ERROR: {error}', file=sys.stderr)
        return 1
    finally:
        connection.close()
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
