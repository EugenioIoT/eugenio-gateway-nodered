Eugenio Gateway Node-RED
=================

Eugenio is a IoT end-to-end platform (hardware and software-as-a-service) created by Logicalis for simplifying the building of custom IoT solution.

Node-RED is a programming tool for wiring together hardware devices, APIs and online services.

Together, this two tecnologies can simulate the whole proccess of create, connect, send messages and streaming data in our IoT plataform.

## Links

More information about Node-RED:

- Node-RED: <https://github.com/node-red>

More information about Eugenio:

- Eugenio: <https://eugenio.io/>
- Eugenio Documentation: <https://portal.stg.eugenio.io/docs>


## Installing

See <https://docs.docker.com/get-started/part2/#build-the-app> for details about how to build a Dockerfile file, after that, see <https://docs.docker.com/get-started/> for details about running a docker container.

It's important to know that you need to export the port 1880 of your container to access the Node-RED running in it. To do this, you can just run the command below, that will run the container exposing the port 1880:

    docker run -p 1880:1880 --name EugenioNodeRED eugenio-gateway-nodered

## Creating a Gateway in Eugenio

You will need to use the Eugenio APIs to register a new gateway. This is necessary to get the ID of your device, and then configure the MQTT node in Node-RED flow.

The API used is described in [Eugenio Documentation link](Links/README.md), but you can access its directly by the links below:

- Swagger: <https://portal.stg.eugenio.io/api/v1/apis/devicemanager?swagger-ui#/Gateways/post_gateways>
- Redoc: <https://portal.stg.eugenio.io/api/v1/apis/devicemanager?doc#tag/Gateways/paths/~1gateways/post>

## Configuring Node-RED

After get up the `EugenioNodeRED` container and register a new gateway (obteining in this way your device ID), you can access your container in your server link in the port 1880 (in case of running localy, you can access <http://localhost:1880> for example) in your browser.

A flow with an Inject, Trigger, Function and MQTT nodes will be already prepared.

Accessing the MQTT node, replace every field containing the string `{deviceId}` by your device ID. The list of fields where is necessary to replace are listed below:

- `Topic` field in MQTT Properties (accessed by double clicking in the MQTT node)
- `Client ID` field in Connection Tab at MQTT-Broker Properties (accessed by editing the _Server_ field in MQTT node)
- `Username` field in Security Tab at MQTT-Broker Properties (accessed by editing the _Server_ field in MQTT node)
- `Topic` field in Messages Tab at MQTT-Broker Properties (accessed by editing the _Server_ field in MQTT node)

Doing this, you can update all the modifications and deploy your flow. The MQTT node will conect in a few seconds, and your device will be prepared to send the messages.

You can modify the json object that will be send by double clicking the Funcion node.

If you are ready to send messages, just click in Injection's node button, and done.

