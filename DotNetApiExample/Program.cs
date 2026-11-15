using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddOpenApi();

var app = builder.Build();

app.MapOpenApi();
app.MapScalarApiReference();

app.MapPost("/echo", (MessageRequest request) => Results.Ok(new MessageResponse($"[version 2] Your message is: {request.Message}")))
    .WithName("Echo")
    .WithSummary("Returns the received message")
    .WithDescription("Receives a message in the request body and returns it prefixed with \"Your message is:\".")
    .Produces<MessageResponse>();

app.Run();

public record MessageRequest(string Message);
public record MessageResponse(string Message);
