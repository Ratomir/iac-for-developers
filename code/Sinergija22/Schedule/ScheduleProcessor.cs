using Azure.Storage.Queues;
using Common;
using System.Text.Json;

namespace Schedule;

public class ScheduleProcessor : BackgroundService
{
    private readonly ILogger<ScheduleProcessor> logger;
    private readonly QueueClient queueClient;

    public ScheduleProcessor(ILogger<ScheduleProcessor> logger, QueueClient queueClient)
    {
        this.logger = logger;
        this.queueClient = queueClient;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            logger.LogInformation("Reading from queue");
            var queueMessage = await queueClient.ReceiveMessageAsync(cancellationToken: stoppingToken);

            if (queueMessage.Value != null)
            {
                try
                {
                    var weatherData = JsonSerializer.Deserialize<WeatherForecast>(queueMessage.Value.MessageText);
                    logger.LogInformation("New Mesasge Read: {weatherData}", queueMessage.Value.MessageText);
                    // APplication process
                }
                catch (Exception ex)
                {
                    logger.LogError(ex.Message);
                }


                await queueClient.DeleteMessageAsync(queueMessage.Value.MessageId, queueMessage.Value.PopReceipt, stoppingToken);
            }

            await Task.Delay(TimeSpan.FromSeconds(10), stoppingToken);
        }
    }
}
