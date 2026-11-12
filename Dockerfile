# ---------- 1단계: 빌드 ----------
FROM eclipse-temurin:21-jdk AS build
WORKDIR /workspace

# 의존성 관련 파일 먼저 (캐시 활용)
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./
RUN ./gradlew dependencies --no-daemon > /dev/null

# 소스는 나중에
COPY src src
RUN ./gradlew bootJar --no-daemon -x test

# ---------- 2단계: 실행 ----------
FROM eclipse-temurin:21-jre
WORKDIR /app

RUN useradd -r -u 1001 spring
COPY --from=build /workspace/build/libs/*.jar app.jar

USER 1001
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]