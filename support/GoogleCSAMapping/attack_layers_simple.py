"""
# Generates Attack Navigator Layer JSON from provided CSV file.
# Based of off https://github.com/mitre-attack/attack-navigator example code.

CSV file must have the following columns (order is irrelevant, data extracted by column header):

Mapping, Control, Threat, Log

For example:
Mapping, Control, Threat, Log
T1078.004, 1.4, Login from privileged account, Cloud Identity Logs
T1496, 4.1, Autoscaling usage in past month, Audit Logs - Admin Activity
T1578, 3.2, VMs deleted in last seven days, Audit Logs - Admin Activity
T1578, 3.11, DNS zones modified or deleted, Audit Logs - Admin Activity

In the above example, the technique T1578 would have a score of 2.

# Generates an ATT&CK Navigator layer file with techniques scored and color-coded based on the following algorithm.
# score = sum(number_of_items_mapped_to_technique)
"""
import argparse
import csv
import json
import uuid
import sys

# Static ATT&CK Navigator layer JSON fields
from collections import defaultdict


LAYER_VERSION = "4.3"
NAV_VERSION = "4.5.5"
NAME = "TDaC"
DESCRIPTION = "Threat Detection as Code"
DOMAIN = "enterprise-attack"
GRADIENT_START_COLOR = "#dbd621"  # yellow
GRADIENT_END_COLOR = "#1a73e8"  # blue

# Main
def main():

    # handle arguments
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-i",
        "--input",
        action="store",
        dest="input_fn",
        default="attack.csv",
        required=True,
        help="input ATT&CK csv file with tactic ID, groups, software, etc... fields",
    )

    args = parser.parse_args()

    # Base ATT&CK Navigator layer
    layer_json = {
        "versions": {"layer": LAYER_VERSION, "navigator": NAV_VERSION},
        "name": NAME,
        "description": DESCRIPTION,
        "domain": DOMAIN,
        "selectTechniquesAcrossTactics": True,
        "selectSubtechniquesWithParent": True,
        "layout": {
            "layout": "side",
            "aggregateFunction": "sum",
            "showName": True,
            "showAggregateScores": True,
            "countUnscored": False,
        },
        "techniques": [],
        "links": [
            {
                "label": "TDaC",
                "url": "https://github.com/GoogleCloudPlatform/threat-detection-as-code",
            }
        ],
    }

    # technique_scorer = Counter()
    technique_list = []

    # parse csv file, calculating a score for each technique and adding that to the layer
    with open(args.input_fn, encoding="utf-8-sig") as csvfile:
        # strip whitespace from header keys
        header = [h.strip() for h in next(csv.reader(csvfile))]
        reader = csv.DictReader(csvfile, fieldnames=header)
        for row in reader:
            # score each technique based on a simple formula
            technique = {
                "techniqueID": row["Mapping"].strip(),
                "score": 1,
                "controlID": row["Control"].strip(),
                "logSource": row["Log"].strip(),
                "comment": row["Threat"].strip(),
            }
            technique_list.append(technique)

    result_dict = {}
    for tech_id in technique_list:
        if tech_id["techniqueID"] in result_dict:
            result_dict[tech_id["techniqueID"]]["score"] += 1
            result_dict[tech_id["techniqueID"]]["controlID"].append(
                tech_id["controlID"]
            )
            result_dict[tech_id["techniqueID"]]["comment"].append(tech_id["comment"])
            result_dict[tech_id["techniqueID"]]["logSource"].append(
                tech_id["logSource"]
            )

        else:
            result_dict[tech_id["techniqueID"]] = {}
            result_dict[tech_id["techniqueID"]]["score"] = 1
            result_dict[tech_id["techniqueID"]]["controlID"] = [tech_id["controlID"]]
            result_dict[tech_id["techniqueID"]]["comment"] = [tech_id["comment"]]
            result_dict[tech_id["techniqueID"]]["logSource"] = [tech_id["logSource"]]

    for k in result_dict.keys():
        technique = {
            "techniqueID": k,
            "score": result_dict[k]["score"],
            "comment": f"{', '.join(result_dict[k]['controlID'])} - {', '.join(set(result_dict[k]['logSource']))} - {', '.join(set(result_dict[k]['comment']))}",
        }
        layer_json["techniques"].append(technique)

    # add a color gradient to layer, ranging from defined start (low score) to end (max score) colors
    layer_json["gradient"] = {
        "colors": [GRADIENT_START_COLOR, GRADIENT_END_COLOR],
        "minValue": 0,
        "maxValue": max([technique["score"] for technique in layer_json["techniques"]]),
    }

    # output JSON
    json.dump(layer_json, sys.stdout, indent=4)

    # write layer file with unique filename
    layer_filename = f"{uuid.uuid4().hex}_layer.json"
    with open(layer_filename, "w") as layer_fh:
        json.dump(layer_json, layer_fh)

    print(f"Wrote layer to {layer_filename}")


if __name__ == "__main__":
    main()
