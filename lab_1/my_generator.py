from my_constants import *
from faker import *
from random import choice, randint, random
from copy import deepcopy

all_nominations = []
nominations = []
fighters = []


def create_nominations():
    all_nominations.clear()
    for nomination in NOMINATION:
        for age_category in AGE_CATEGORY:
            for weight_category in WEIGHT:
                for gender in NOMINATIONS_GENDER:
                    for battle_scheme in BATTLE_SCHEME:
                        new_nomination = {'nomination': nomination,
                                          'min_age': age_category[0],
                                          'max_age': age_category[1],
                                          'weight': weight_category,
                                          'gender': gender,
                                          'scheme': battle_scheme}
                        all_nominations.append(new_nomination)


def generate_clubs():
    '''Генерация таблицы клубов'''
    faker = Faker()

    file = open(CLUBS_FILE, "w")

    for _ in range(COUNT_RECORDS):
        club = choice(CLUBS)
        found_date = faker.date()
        branch = randint(MIN_BRANCHS, MAX_BRANCHS)
        town = faker.city()
        file.write(f'{club}|{found_date}|{branch}|{town}\n')

    file.close()


def generate_fighters():
    '''Генерация таблицы бойцов'''
    file = open(FIGHTERS_FILE, "w")

    faker = Faker()

    for _ in range(COUNT_RECORDS):
        first_name = faker.first_name()
        last_name = faker.last_name()
        age = randint(MIN_AGE, MAX_AGE)
        gender = choice(GENDER)
        club = randint(1, COUNT_RECORDS)
        file.write(f'{first_name}|{last_name}|{age}|{gender}|{club}\n')
        fighters.append([first_name, last_name, age, gender, club])

    file.close()


def generate_nominations():
    '''Генерация таблицы номинаций'''
    file = open(NOMINATIONS_FILE, "w")

    nominations.clear()
    all_local_nomination = deepcopy(all_nominations)

    for _ in range(COUNT_RECORDS):
        nomination = choice(all_local_nomination)
        all_local_nomination.remove(nomination)
        nominations.append(nomination)
        file.write(f'{nomination["nomination"]}|{nomination["min_age"]}|{nomination["max_age"]}|{nomination["weight"]}'
                   f'|{nomination["gender"]}|{nomination["scheme"]}\n')

    file.close()


def generate_judges():
    '''Генерация таблицы судей'''
    file = open(JUDGES_FILE, "w")
    faker = Faker()

    for _ in range(COUNT_RECORDS):
        first_name = faker.first_name()
        last_name = faker.last_name()
        experience = round(random() * 10, 1)
        category = randint(MIN_CATEGORY, MAX_CATEGORY)
        salary = randint(MIN_SALARY, MAX_SALARY)

        file.write(f'{first_name}|{last_name}|{experience}|{category}|{salary}\n')

    file.close()


def generate_judging():
    '''Генерация таблицы судейства'''
    file = open(JUDGING_FILE, "w")

    for _ in range(COUNT_RECORDS):
        judge_id = randint(1, COUNT_RECORDS)
        nomination_id = randint(1, COUNT_RECORDS)
        file.write(f'{judge_id}|{nomination_id}\n')

    file.close()


def generate_tournament():
    '''Генерация таблицы турнира'''
    file = open(TOURNAMENT_FILE, "w")

    for _ in range(COUNT_RECORDS):
        warnings = randint(MIN_COUNT_WARNINGS, MAX_COUNT_WARNINGS)
        skipped_hits = randint(0, 500)
        applied_hits = randint(0, 500)

        fighter_id = randint(0, COUNT_RECORDS - 1)
        nomination_id = randint(0, COUNT_RECORDS - 1)

        while nominations[nomination_id]["gender"] != fighters[fighter_id][3] and nominations[nomination_id]["gender"] != "united":
            nomination_id = randint(0, COUNT_RECORDS - 1)

        while fighters[fighter_id][2] < nominations[nomination_id]["min_age"] or \
                fighters[fighter_id][2] > nominations[nomination_id]["max_age"]:
            fighter_id = randint(0, COUNT_RECORDS - 1)

        file.write(f'{fighter_id + 1}|{nomination_id + 1}|{warnings}|{applied_hits}|{skipped_hits}\n')

    file.close()


def main():
    create_nominations()
    generate_nominations()
    generate_clubs()
    generate_fighters()
    generate_judges()
    generate_judging()
    generate_tournament()



if __name__ == '__main__':
    main()
