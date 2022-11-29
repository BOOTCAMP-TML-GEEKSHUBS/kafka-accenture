const { Kafka } = require('kafkajs')

const kafka = new Kafka({
  clientId: 'producer-js',
  brokers: ['broker1:9092', 'broker2:9092', 'broker3:9092'],
})

const producer = kafka.producer();

producer.connect().then(() => {
    let counter = 0;
    setInterval(async () => {
        const response = await producer.send({
            topic: 'welcome',
            messages: [ 
                    { value: 'Hello KafkaJS user! ' + counter++ },
                ],
        })
        console.log(response);
    },100);
});


