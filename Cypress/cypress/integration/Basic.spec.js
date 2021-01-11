/// <reference types="Cypress" />

describe("Testing the accessibility of Login page", () => {
  it("Visiting the Login Page", () => {
    cy.clearCookie("token");
    indexedDB.deleteDatabase("localforage");
    cy.visit("/login");
    cy.contains("Login to Kubera");
    cy.url().should("include", "/login");
    cy.log("Visited the Login page Successfully");
  });
});
