import random
import csv


def generate_unique_pairs(volunteer_range, shift_range, num_rows, filename):
    unique_pairs = set()

    while len(unique_pairs) < num_rows:
        pair = (random.randint(1, volunteer_range), random.randint(1, shift_range))
        unique_pairs.add(pair)

    with open(filename, "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["VolunteerID", "ShiftID"])
        writer.writerows(unique_pairs)


generate_unique_pairs(volunteer_range=400, shift_range=400, num_rows=400, filename="WorksIn.csv")
print("WorksIn.csv נוצר בהצלחה!")
