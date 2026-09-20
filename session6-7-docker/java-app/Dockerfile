# ---- Stage 1: compile ----
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /build
COPY HelloWorld.java .
RUN javac HelloWorld.java

# ---- Stage 2: run on a JRE only ----
# The JDK is only needed to compile. Shipping the smaller JRE keeps the final
# image lean and removes the compiler from the runtime surface.
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /build/HelloWorld.class .

EXPOSE 8080
CMD ["java", "HelloWorld"]
