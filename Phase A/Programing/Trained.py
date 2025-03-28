import random
import csv


def generate_unique_pairs(volunteer_range, training_range, num_rows, filename):
    unique_pairs = set()

    while len(unique_pairs) < num_rows:
        pair = (random.randint(1, volunteer_range), random.randint(1, training_range))
        unique_pairs.add(pair)

    with open(filename, "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["VolunteerID", "TrainingID"])
        writer.writerows(unique_pairs)


generate_unique_pairs(volunteer_range=400, training_range=400, num_rows=400, filename="Trained.csv")
print("Trained.csv נוצר בהצלחה!")
