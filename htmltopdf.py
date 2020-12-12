import pdfkit
link=line
op=link.split('/bgm')[1].strip('/')
config = pdfkit.configuration(wkhtmltopdf="C:\\Program Files\\wkhtmltopdf\\bin\\wkhtmltopdf.exe")
pdfkit.from_url(link, op,configuration=config)



with open('check.txt', 'r') as inf, open('test1.txt', 'w') as outf:
    for line in inf:
        link = line.strip()
        print (link)
        if link:
            try:
                print ("check" + link)
                op=link.split('/bgm')[1].strip('/')+".pdf"
                print("op is"   +  op)
                config = pdfkit.configuration(wkhtmltopdf="C:\\Program Files\\wkhtmltopdf\\bin\\wkhtmltopdf.exe")
                pdfkit.from_url(link, op,configuration=config)
            except ValueError:
                print("Could not parse '{0}'".format(link))



with open('check.txt', 'r') as inf, open('test1.txt', 'w') as outf:
    for line in inf:
        link = line.strip()
        if line:
            try:
                print (link)
                op=link.split('/bgm')[1].strip('/')+".pdf"
                print("op is"   +  op)
                config = pdfkit.configuration(wkhtmltopdf="C:\\Program Files\\wkhtmltopdf\\bin\\wkhtmltopdf.exe")
                pdfkit.from_url(link, op,configuration=config)
            except ValueError:
                print("Could not parse '{0}'".format(line))


with open('check.txt', 'r') as inf:
    for line in inf:
        link = line.strip()
        if line:
            try:
                print (link)
                op=link.split('/bgm')[1].strip('/')+".pdf"
                print("op is"   +  op)
            except ValueError:
                print("Could not parse '{0}'".format(line))
