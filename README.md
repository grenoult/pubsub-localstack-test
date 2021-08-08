# Introduction
This is a small example on how to implement pubsub (Publish / Subscribe) while using [Terraform](https://www.terraform.io/) with [Localstack](https://github.com/localstack/localstack), [SNS](https://aws.amazon.com/sns/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc) and [SQS](https://aws.amazon.com/sqs/).

## What is pubsub?
It's similar to the [Observer Pattern](https://refactoring.guru/design-patterns/observer) but in a more general way. The Observer Pattern is mostly used within the same codebase, whereas pubsub can be used across multiple products. The idea remains similar:
* Application A publish a message to a channel.
* Application B registered interested in this channel and now can receive or read message published by Application A.
* Although the channel can be written, it's better / faster / simpler to reuse an existing providers' solution, such as AWS SQS/SNS in this example.

# Steps
1. Start Docker
2. Run localstack with Docker: `docker run --rm -it -p 4566:4566 -p 4571:4571 localstack/localstack -e "SERVICES=sns DEBUG=1"`
3. Run `terraform apply` to create SNS and SQS queues. Topic's ARN (SNS) and SQS URL will be output to `env.json` file.
4. Run `node main.js` to add and read messages in the queue.
5. Run `terraform destroy` to remove resources when testing is done.

# Example of output:
```
➜  pubsub-localstack-test node main.js
┌──────────────┬───────────────────────────────────────────────┐
│   (index)    │                    Values                     │
├──────────────┼───────────────────────────────────────────────┤
│ Message sent │ '[1] Hello world! (2021-08-08T20:59:06.493Z)' │
└──────────────┴───────────────────────────────────────────────┘
┌──────────────┬───────────────────────────────────────────────┐
│   (index)    │                    Values                     │
├──────────────┼───────────────────────────────────────────────┤
│ Message sent │ '[2] Hello world! (2021-08-08T20:59:07.009Z)' │
└──────────────┴───────────────────────────────────────────────┘
┌──────────────────┬───────────────────────────────────────────────┐
│     (index)      │                       0                       │
├──────────────────┼───────────────────────────────────────────────┤
│ Message received │ '[1] Hello world! (2021-08-08T20:59:06.493Z)' │
└──────────────────┴───────────────────────────────────────────────┘
┌──────────────┬───────────────────────────────────────────────┐
│   (index)    │                    Values                     │
├──────────────┼───────────────────────────────────────────────┤
│ Message sent │ '[3] Hello world! (2021-08-08T20:59:07.514Z)' │
└──────────────┴───────────────────────────────────────────────┘
┌──────────────────┬───────────────────────────────────────────────┐
│     (index)      │                       0                       │
├──────────────────┼───────────────────────────────────────────────┤
│ Message received │ '[2] Hello world! (2021-08-08T20:59:07.009Z)' │
└──────────────────┴───────────────────────────────────────────────┘
┌──────────────┬───────────────────────────────────────────────┐
│   (index)    │                    Values                     │
├──────────────┼───────────────────────────────────────────────┤
│ Message sent │ '[4] Hello world! (2021-08-08T20:59:08.019Z)' │
└──────────────┴───────────────────────────────────────────────┘
┌──────────────────┬───────────────────────────────────────────────┐
│     (index)      │                       0                       │
├──────────────────┼───────────────────────────────────────────────┤
│ Message received │ '[3] Hello world! (2021-08-08T20:59:07.514Z)' │
└──────────────────┴───────────────────────────────────────────────┘
┌──────────────┬───────────────────────────────────────────────┐
│   (index)    │                    Values                     │
├──────────────┼───────────────────────────────────────────────┤
│ Message sent │ '[5] Hello world! (2021-08-08T20:59:08.525Z)' │
└──────────────┴───────────────────────────────────────────────┘
┌──────────────────┬───────────────────────────────────────────────┐
│     (index)      │                       0                       │
├──────────────────┼───────────────────────────────────────────────┤
│ Message received │ '[4] Hello world! (2021-08-08T20:59:08.019Z)' │
└──────────────────┴───────────────────────────────────────────────┘
┌──────────────┬───────────────────────────────────────────────┐
│   (index)    │                    Values                     │
├──────────────┼───────────────────────────────────────────────┤
│ Message sent │ '[6] Hello world! (2021-08-08T20:59:09.030Z)' │
└──────────────┴───────────────────────────────────────────────┘
┌──────────────────┬───────────────────────────────────────────────┐
│     (index)      │                       0                       │
├──────────────────┼───────────────────────────────────────────────┤
│ Message received │ '[5] Hello world! (2021-08-08T20:59:08.525Z)' │
└──────────────────┴───────────────────────────────────────────────┘
┌──────────────┬───────────────────────────────────────────────┐
│   (index)    │                    Values                     │
├──────────────┼───────────────────────────────────────────────┤
│ Message sent │ '[7] Hello world! (2021-08-08T20:59:09.535Z)' │
└──────────────┴───────────────────────────────────────────────┘
┌──────────────────┬───────────────────────────────────────────────┐
│     (index)      │                       0                       │
├──────────────────┼───────────────────────────────────────────────┤
│ Message received │ '[6] Hello world! (2021-08-08T20:59:09.030Z)' │
└──────────────────┴───────────────────────────────────────────────┘
┌──────────────┬───────────────────────────────────────────────┐
│   (index)    │                    Values                     │
├──────────────┼───────────────────────────────────────────────┤
│ Message sent │ '[8] Hello world! (2021-08-08T20:59:10.040Z)' │
└──────────────┴───────────────────────────────────────────────┘
┌──────────────────┬───────────────────────────────────────────────┐
│     (index)      │                       0                       │
├──────────────────┼───────────────────────────────────────────────┤
│ Message received │ '[7] Hello world! (2021-08-08T20:59:09.535Z)' │
└──────────────────┴───────────────────────────────────────────────┘
┌──────────────┬───────────────────────────────────────────────┐
│   (index)    │                    Values                     │
├──────────────┼───────────────────────────────────────────────┤
│ Message sent │ '[9] Hello world! (2021-08-08T20:59:10.545Z)' │
└──────────────┴───────────────────────────────────────────────┘
┌──────────────────┬───────────────────────────────────────────────┐
│     (index)      │                       0                       │
├──────────────────┼───────────────────────────────────────────────┤
│ Message received │ '[8] Hello world! (2021-08-08T20:59:10.040Z)' │
└──────────────────┴───────────────────────────────────────────────┘
┌──────────────┬────────────────────────────────────────────────┐
│   (index)    │                     Values                     │
├──────────────┼────────────────────────────────────────────────┤
│ Message sent │ '[10] Hello world! (2021-08-08T20:59:11.050Z)' │
└──────────────┴────────────────────────────────────────────────┘
┌──────────────────┬───────────────────────────────────────────────┐
│     (index)      │                       0                       │
├──────────────────┼───────────────────────────────────────────────┤
│ Message received │ '[9] Hello world! (2021-08-08T20:59:10.545Z)' │
└──────────────────┴───────────────────────────────────────────────┘
┌──────────────────┬────────────────────────────────────────────────┐
│     (index)      │                       0                        │
├──────────────────┼────────────────────────────────────────────────┤
│ Message received │ '[10] Hello world! (2021-08-08T20:59:11.050Z)' │
└──────────────────┴────────────────────────────────────────────────┘
```