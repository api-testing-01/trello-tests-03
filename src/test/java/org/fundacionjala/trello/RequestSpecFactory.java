package org.fundacionjala.trello;

import java.util.HashMap;
import java.util.Map;
import java.util.function.Supplier;

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import org.fundacionjala.core.Environment;

public final class RequestSpecFactory {

    private static final Environment ENV = Environment.getInstance();

    private RequestSpecFactory() {
    }

    private static RequestSpecification getRequestSpecTrello(final String account) {
        RequestSpecification requestSpecification = new RequestSpecBuilder()
                .setBaseUri(ENV.getValue("baseUri"))
                .addQueryParam("key", ENV.getValue(String.format("credentials.%s.appKey", account)))
                .addQueryParam("token", ENV.getValue(String.format("credentials.%s.token", account)))
                .build();
        return requestSpecification
                .log().method()
                .log().uri()
                .log().params()
                .log().body();
    }

    private static Map<String, Supplier<RequestSpecification>> getRequestSpecMap(final String account) {
    Map<String, Supplier<RequestSpecification>> requestSpecMap = new HashMap<>();
        requestSpecMap.put("trello", () -> getRequestSpecTrello(account));
        return requestSpecMap;
    }

    public static RequestSpecification getRequestSpec(final String serviceName, final String account) {
        return getRequestSpecMap(account).get(serviceName).get();
    }
}
