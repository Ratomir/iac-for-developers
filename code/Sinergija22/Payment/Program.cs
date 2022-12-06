using Azure.Core;
using Azure.Identity;
using Azure.Storage.Queues;
using Microsoft.Extensions.Azure;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Payment;

var builder = WebApplication.CreateBuilder(args);
ConfigurationManager configuration = builder.Configuration;
var environment = builder.Environment;
var storageQueueUri = $"{configuration.GetConnectionString("StorageAccountQueue")}/{configuration.GetValue<string>("queueInName")}";

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddHostedService<PaymentProcessor>();
builder.Services.AddAzureClients(builder =>
{
    builder.AddClient<QueueClient, QueueClientOptions>((options, _, _) =>
    {
        options.MessageEncoding = QueueMessageEncoding.Base64;
        TokenCredential credential = new DefaultAzureCredential();
        if (environment.IsProduction())
        {
            credential = new ManagedIdentityCredential(configuration.GetValue<string>("clientId"));
        }
        var queueUri = new Uri(storageQueueUri);
        return new QueueClient(queueUri, credential, options);

    });
});

builder.Services.AddHealthChecks()
    .AddCheck("self", () => HealthCheckResult.Healthy());

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapHealthChecks("/hc");
app.MapHealthChecks("/liveness",
    new Microsoft.AspNetCore.Diagnostics.HealthChecks.HealthCheckOptions()
    { Predicate = r => r.Name.Contains("self") });

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
