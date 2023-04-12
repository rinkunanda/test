#!/bin/bash
gcloud auth activate-service-account --key-file=/tmp/test_creds.json
gcloud compute instances describe test-instance --zone us-central1-a --format="value(metadata.test-key)" >> /tmp/test-key.txt