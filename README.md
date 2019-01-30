# Comcast Channel Listing Cleaner

Comcast's data on its own channel lineup is a mess. This script cleans it up.

To make input.csv file:

1. Google Comcast Business channel lineup.
1. Copy/paste and use editor to clean up.

To convert to Google Doc (https://docs.google.com/document/d/1jPzNP26Kd6tt8FTCHbO-5qliox9wizxq78FtPUE2Sbg/edit)

1. Run script and pipe to output.csv
1. Import output.csv to https://docs.google.com/spreadsheets/d/1mI6STllcqOEzL8vKMMeqmOU0Yd7aWwlAOVvKUVWti3M/edit#gid=0, selecting 'Replace Spreadsheet'
1. Copy/paste first two rows

To generate Markdown for wiki:

1. Run script as `ruby process.rb md`.
