#!/bin/bash

# Path to your IDF file
IDF_FILE="./data/ASHRAE901_OfficeLarge_STD2019_Albuquerque.idf"

# Add ExternalInterface configuration to the IDF file
cat >> "$IDF_FILE" << 'EOL'

ExternalInterface,
  FunctionalMockupUnitExport;  !- Name of External Interface

EOL

echo "Added ExternalInterface configuration to $IDF_FILE"