import random
import csv


def generate_unique_pairs(volunteer_range, project_range, num_rows, filename):
    unique_pairs = set()

    while len(unique_pairs) < num_rows:
        pair = (random.randint(1, volunteer_range), random.randint(1, project_range))
        unique_pairs.add(pair)

    with open(filename, "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["VolunteerID", "ProjectID"])
        writer.writerows(unique_pairs)


generate_unique_pairs(volunteer_range=400, project_range=400, num_rows=400, filename="AssignedTo.csv")
print("AssignedTo.csv נוצר בהצלחה!")
