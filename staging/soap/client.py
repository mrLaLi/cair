from zeep import CachingClient

client = CachingClient(wsdl="http://localhost:12312/scheme.wsdl")
result = client.service.login("user", "pass")

print(result)
