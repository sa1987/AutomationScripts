 curl https://api.smartsheet.com/2.0/sheets/{5802696138614660}/search?query=28 -H "Authorization: Bearer 1pqifa4phr6rou9w3fey7cx4ru"

 curl https://api.smartsheet.com/2.0/sheets/{5802696138614660}/columns/{4667306551863172} -H "Authorization: Bearer 1pqifa4phr6rou9w3fey7cx4ru" -X PUT \
 -d '{"index":"1","title":"12345","type":"TEXT_NUMBER","primary":true,"width":150}'
-d '{"title":"First Column","index":0, "type" : "PICKLIST", "options" :["One","Two"]}'

curl https://api.smartsheet.com/2.0/sheets/{5802696138614660}/columns/{1}/search?query=P

curl https://api.smartsheet.com/2.0/sheets/{sheetId}/rows/{rowId}?include=discussions,attachments,columns,columnType \


curl https://api.smartsheet.com/2.0/sheets/{5802696138614660}/columns -H "Authorization: Bearer 1pqifa4phr6rou9w3fey7cx4ru"
curl https://api.smartsheet.com/2.0/sheets/{sheetId}/rows/{2}?include=discussions,attachments,columns,columnType -H "Authorization: Bearer 1pqifa4phr6rou9w3fey7cx4ru"
-H "Authorization: Bearer ACCESS_TOKEN"
curl https://api.smartsheet.com/2.0/search/sheets/{5802696138614660}?query=stuff -H "Authorization: Bearer 1pqifa4phr6rou9w3fey7cx4ru"
cisco.account.box.com


In [27]:  for row in sheet.rows:
    ...:      if row.row_number==5:
    ...:         count=6
    ...:         for c in range(0, len(sheet.columns)):
    ...:            if ( (row.cells[c].value) == 'P' ):
    ...:               count +=1;
    ...: print (count)

	
import smartsheet
smartsheet = smartsheet.Smartsheet('1pqifa4phr6rou9w3fey7cx4ru')
sheet = smartsheet.Sheets.get_sheet(5802696138614660)
count=0
sheetId=5802696138614660
query = '05-03-2017'
result = smartsheet.Search.search_sheet(sheetId, query)
s=str(result)
start = s.find('Row ') + 4
end = s.find(': "' )
rowId = s[start:end]
row_id=sheet.rows[rowId]
rowId=int(rowId)
for row in sheet.rows:
		if ( rowId == row.row_number ):
			for c in range(0, len(sheet.columns)):
				if ( (row.cells[c].value) == 'P' ):
					count +=1;
print (count)	 
 for j in range(0,len(sheet.rows)):
	for i in range(0,len(sheet.columns)):
		if ( 'check' ==  sheet.rows[2].cells[i].value):
			print (i)
			print (j)



 row_a = smartsheet.Sheets.get_row(sheetId,3186214370076548)
 cell_a = row_a.get_column(3541406645020548)
  cell_a.value = 'B'
 row_a.set_column(cell_a.column_id, cell_a)
  smartsheet.Sheets.update_rows(sheetId, [row_a])
