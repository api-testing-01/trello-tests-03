package org.fundacionjala.core.cucumber.hooks;

import java.util.List;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.specification.RequestSpecification;

import org.fundacionjala.core.api.DynamicIdHelper;
import org.fundacionjala.core.api.RequestManager;
import org.fundacionjala.core.ScenarioContext;

public class CommonHook {

    private ScenarioContext context;

    public CommonHook(final ScenarioContext context) {
        this.context = context;
    }

    @Before(value = "@createBaseObjects")
    public void beforeEscenario() {
        String jsonBody = "{\"name\": \"Board1 created by cucumber\"}";
        String endpoint = "/boards";
        createObject(endpoint, jsonBody);

        endpoint = "/lists";
        jsonBody = "{\"name\": \"To_Do\",\"idBoard\": \"(B.id)}";
        createObject(endpoint, jsonBody);
    }

    @After(value = "@cleanData")
    public void afterScenario() {
        RequestSpecification requestSpec = (RequestSpecification) context.get("REQUEST_SPEC");
        List<String> endpoints = context.getEndpoints();
        for (String endpoint : endpoints) {
            RequestManager.delete(requestSpec, endpoint);
        }
    }

    public void createObject(String endPoint, String jsonBody) {
        RequestSpecification requestSpecification = (RequestSpecification) context.get("REQUEST_SPEC");
        String builtEndpoint = DynamicIdHelper.buildEndpoint(context, endPoint);
        RequestManager.doRequest("POST", requestSpecification, builtEndpoint,
                DynamicIdHelper.replaceIds(context, jsonBody));
    }
}
