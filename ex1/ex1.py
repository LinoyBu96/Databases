import csv
from io import TextIOWrapper
from zipfile import ZipFile


ATTRIBUTE_INDEX = {'country': 0,
                   'countrycode': 1,
                   'region': 2,
                   'incomegroup': 3,
                   'iau_id1': 4,
                   'eng_name': 5,
                   'orig_name': 6,
                   'foundedyr': 7,
                   'yrclosed': 8,
                   'private01': 9,
                   'latitude': 10,
                   'longitude': 11,
                   'phd_granting': 12,
                   'divisions': 13,
                   'specialized': 14,
                   'year': 15,
                   'students5_estimated': 16}

UNIVERSITY_ATTRIBUTES = {att: i for i, att in enumerate(['iau_id1', 'eng_name', 'orig_name', 'foundedyr', 'private01', 'latitude',
                                                         'longitude', 'phd_granting', 'divisions', 'specialized', 'countrycode'])}
CLOSED_UNIVERSITY_ATTRIBUTES = {att: i for i, att in enumerate(['iau_id1', 'yrclosed'])}
ESTIMATED_IN_ATTRIBUTES = {att: i for i, att in enumerate(['iau_id1', 'year', 'students5_estimated'])}
COUNTRY_ATTRIBUTES = {att: i for i, att in enumerate(['country', 'countrycode', 'region', 'incomegroup'])}

UNIVERSITY = 0
CLOSED_UNIVERSITY = 1
# YEAR = 2
ESTIMATED_IN = 2
COUNTRY = 3

# opens file.
enrollment_outwriters = []
enrollment_outfiles = []
for name in  ["university", "closed_university", "estimated_in", "country"]:
    enrollment_outfile = open(name + ".csv", 'w' , encoding='UTF8')
    enrollment_outfiles.append(enrollment_outfile)
    enrollment_outwriters.append(csv.writer(enrollment_outfile, delimiter=",", quoting=csv.QUOTE_MINIMAL))

def update_university(row, prev_university, null_atts_university):
    if row[ATTRIBUTE_INDEX['iau_id1']] != prev_university[0]:
        enrollment_outwriters[UNIVERSITY].writerow(prev_university)
        prev_university = []
        null_atts_university = []
        for att in UNIVERSITY_ATTRIBUTES:
            att_i = ATTRIBUTE_INDEX[att]
            prev_university.append(row[att_i])
            if row[att_i] == '' or (att_i == 12 and row[att_i] == '0'):  # 12 == phd col
                null_atts_university.append(att)
    else:
        for i, att in enumerate(null_atts_university):
            att_i = ATTRIBUTE_INDEX[att]
            if row[att_i] != prev_university[UNIVERSITY_ATTRIBUTES[att]]:
                prev_university[UNIVERSITY_ATTRIBUTES[att]] = row[att_i]
    return prev_university, null_atts_university

def update_closed_university(row, prev_closed_university):
    iau_id1 = row[ATTRIBUTE_INDEX['iau_id1']]
    yrclosed = row[ATTRIBUTE_INDEX['yrclosed']]
    if yrclosed != '' and iau_id1 != prev_closed_university:
        prev_closed_university = iau_id1
        enrollment_outwriters[CLOSED_UNIVERSITY].writerow([iau_id1, yrclosed])
    return prev_closed_university


# process_file goes over all rows in original csv file, and sends each row to process_row()
def process_file():
    with ZipFile('enrollment.zip') as zf:
        with zf.open('enrollment.csv', 'r') as infile:
            reader = csv.reader(TextIOWrapper(infile, 'utf-8'))

            null_atts_university = []
            prev_university = []
            prev_closed_university = ''
            # years = set()
            countries = set()

            is_header = True
            for row in reader:
                if is_header:
                    prev_university = [row[ATTRIBUTE_INDEX[att]] for att in UNIVERSITY_ATTRIBUTES]
                    enrollment_outwriters[COUNTRY].writerow([row[ATTRIBUTE_INDEX[att]] for att in COUNTRY_ATTRIBUTES])
                    enrollment_outwriters[CLOSED_UNIVERSITY].writerow([row[ATTRIBUTE_INDEX[att]] for att in CLOSED_UNIVERSITY_ATTRIBUTES])
                    enrollment_outwriters[ESTIMATED_IN].writerow([row[ATTRIBUTE_INDEX[att]] for att in ESTIMATED_IN_ATTRIBUTES])
                    is_header = False
                    continue
                # TO DO splits row into the different csv table files
                prev_university, null_atts_university = update_university(row, prev_university, null_atts_university)
                # cur_year = row[ATTRIBUTE_INDEX['year']]
                # if cur_year not in years:
                #     enrollment_outwriters[YEAR].writerow([cur_year])
                #     years.add(cur_year)
                cur_countrycode = row[ATTRIBUTE_INDEX['countrycode']]
                if cur_countrycode not in countries:
                    enrollment_outwriters[COUNTRY].writerow([row[ATTRIBUTE_INDEX[att]] for att in COUNTRY_ATTRIBUTES])
                    countries.add(cur_countrycode)
                prev_closed_university = update_closed_university(row, prev_closed_university)
                enrollment_outwriters[ESTIMATED_IN].writerow([row[ATTRIBUTE_INDEX[att]] for att in ESTIMATED_IN_ATTRIBUTES])
                
            enrollment_outwriters[UNIVERSITY].writerow(prev_university)
            for f in enrollment_outfiles:
                f.close()
              
# return the list of all tables
def get_names():
    return ["country", "university", "closed_university", "estimated_in"]


if __name__ == "__main__":
    process_file()