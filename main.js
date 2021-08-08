const env = require('./env.json');
const AWS = require('aws-sdk');

const topicArn = env.sns_topic_arn.value;
const queueUrl = env.sqs_queue_url.value;
const endPoint = 'http://localhost:4566';
const sns = new AWS.SNS({
    apiVersion: '2010-03-31',
    endpoint: endPoint,
    region: 'us-east-1',
});
const sqs = new AWS.SQS({
    apiVersion: '2012-11-05',
    region: 'us-east-1',
});

let idMessage = 1;

/**
 * Publish a message to localstack SNS queue.
 */
const publish = async () => {
    var params = {
        Message: `[${idMessage}] Hello world! (${new Date().toISOString()})`, /* required */
        TopicArn: topicArn
    };
    const publishPromise = sns.publish(params).promise();
    idMessage++;

    await publishPromise.then((data) => {
        console.table({'Message sent': params.Message});
    }).catch(
        function (err) {
            console.error(err, err.stack);
        }
    )
}

/**
 * Read a message from SQS, then delete it.
 */
const readMessage = async () => {
    await sqs.receiveMessage({
        QueueUrl: queueUrl
    }, async function (err, data) {
        if (err) {
            console.log("Receive Error", err);
        } else if (data.Messages) {
            console.table({
                'Message received': data.Messages.map(message => JSON.parse(message.Body).Message)
            });

            // Once message has been read, remove them. 
            // Otherwise they'll return to the queue 30 seconds later
            for (i in data.Messages) {
                await sqs.deleteMessage({
                    QueueUrl: queueUrl,
                    ReceiptHandle: data.Messages[i].ReceiptHandle
                }, function (err, data) {
                    if (err) {
                        console.log("Delete Error", err);
                    } else {
                        // console.log("Message Deleted", data);
                    }
                })
            }
        }
    });
};


(async() => {
    let i = 0;
    do {
        publish();
        await new Promise(r => setTimeout(r, 500));
        readMessage();
        i++;
    } while (i < 10);
})();