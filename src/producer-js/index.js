const { Kafka } = require('kafkajs')

const kafka = new Kafka({
  clientId: 'producer-js',
  brokers: ['broker1:9092', 'broker2:9092', 'broker3:9092'],
})


const producer = kafka.producer();

producer.connect().then(() => {
    setInterval(async () => {
        await producer.send({
        topic: 'test-topic',
            messages: [ 
                { value: 'Hello KafkaJS user!' },
                { value: 'Hello KafkaJS user!' },
                { value: 'Hello KafkaJS user!' },
                { value: 'Hello KafkaJS user!' },
            ],
        })
    },1000);
});


