_PROJECT.java.vmArgs = table.concat({
	"-Dserver.port=8088",
	"-Dspring.output.ansi.enabled=ALWAYS",
	"-Dspring.datasource.username=postgres",
	"-Dspring.datasource.password=mysecretpassword",
	"-Dspring.datasource.driver-class-name=org.postgresql.Driver",
	"-Dspring.datasource.hikari.schema=public",
	"-Dspring.datasource.hikari.maximum-pool-size=10",
	"-Dhibernate.dialect=au.com.geometry.gep.db.dialect.Postgis10DialectWithJSON",
	"-Dspring.datasource.url=jdbc:postgresql://localhost:5432/geo",
}, " ")
