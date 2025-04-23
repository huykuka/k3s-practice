# IoT Device Monitoring Dashboard

## Description

Build a system to collect, store, and visualize telemetry data (e.g., temperature, humidity) from IoT devices using K3s for orchestration.

## K3s Components

- **Mosquitto (MQTT broker):** Deploy as a pod to handle IoT device messages.
- **Node-RED:** Use in a pod to process and route IoT data.
- **InfluxDB:** Run for time-series storage.
- **Grafana:** Use for visualization.

## IoT Integration

- **Simulate IoT devices:** Use devices like Raspberry Pi or ESP32 to send MQTT messages with sensor data.
- **Scalability:** Use K3s to scale Mosquitto for handling multiple device connections.

## Practice Goals

- Learn K3s pod deployment, service networking, and persistent storage.
- Explore IoT protocols like MQTT.
- Experiment with scaling and high availability for IoT workloads.
