docker run -it --rm \
  -v ./data:/input \
  -v ./fmu-output:/output \
  energyplus-with-fmu bash
  