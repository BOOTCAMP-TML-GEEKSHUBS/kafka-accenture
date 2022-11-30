const { Kafka, CompressionTypes, logLevel } = require('kafkajs')

const topic = process.env.topic; 

const kafka = new Kafka({
  clientId: 'producer-js',
  brokers: ['broker1:9092', 'broker2:9092', 'broker3:9092'],
})


const getRandomNumber = () => Math.round(Math.random(10) * 1000)
const createMessage = num => ({
    key: `key-${num}`,
    value: `value-${num}-${new Date().toISOString()}`,
  })
  partition = partition >= partitions ? 1 : partition;  

  const sendMessage = topic => producer.send({
        topic,
        partition: partition += 2,
        compression: CompressionTypes.GZIP,
        messages: [createMessage(getRandomNumber())],
      })


const producer = kafka.producer();

producer.connect().then(() => {
    let counter = 0;
    setInterval(async () => {
        const response = await sendMessage(topic);
        console.log(response);
    },100);
});


