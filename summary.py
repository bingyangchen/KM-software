import os

DIRECTORIES_TO_IGNORE = (
    ".git",
    ".obsidian",
    ".trash",
    "node_modules",
    "img",
    "Pinkoi",
)

FILES_TO_IGNORE = ("./DEVNOTE.md", "./SUMMARY.md")

UNIT_INDENT = "  "

BULLET_POINT = "- "


def generate_summary(path: str, indent: str = ""):
    # Avoid generating the root layer
    if (basename := os.path.basename(path)) != ".":
        with open("SUMMARY.md", "a") as file_object:
            file_object.write(f"{indent}{BULLET_POINT}{basename}\n")

    for sub_directory in os.listdir(path):
        full_path = os.path.join(path, sub_directory)
        if os.path.isdir(full_path) and (sub_directory not in DIRECTORIES_TO_IGNORE):
            generate_summary(full_path, "" if path == "." else f"{indent}{UNIT_INDENT}")
        elif (
            os.path.isfile(full_path)
            and sub_directory.endswith(".md")
            and (full_path not in FILES_TO_IGNORE)
        ):
            with open("SUMMARY.md", "a") as file_object:
                file_object.write(
                    f"{indent}{UNIT_INDENT}{BULLET_POINT}[{os.path.splitext(sub_directory)[0]}](<./{full_path}>)\n"
                )


with open("SUMMARY.md", "w") as file_object:
    file_object.write("# Summary\n\n")

generate_summary(".")

print("GitBook summary file (SUMMARY.md) generated.")
