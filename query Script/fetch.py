import pyperclip  # Pip install pyperclip

QUERY_TYPE = {
    "stored procedure" : "PROCEDURE",
    "view" : "VIEW",
    "function" : "FUNCTION"}
TXT_PATH = "txt.txt"

txt_file = open(TXT_PATH, "r+")
reqs = txt_file.read().split("type: ")[1:]
txt_file.close()

sql = ""
for req in reqs:
    for type in QUERY_TYPE:
        if req.__contains__(type):
            print(type)
            view_name = req.split("name:")[1].split("\n")[0]
            sql += f"CREATE {QUERY_TYPE[type]}{view_name} AS\n    SELECT *\n    FROM;"
            sql += "\nGO\n\n"
            break

pyperclip.copy(sql)
pyperclip.paste()




    
