// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })

// Custom Login Fuction.
Cypress.Commands.add("login", (username, password) => {
  cy.clearCookie("core-token");
  indexedDB.deleteDatabase("localforage");
  cy.visit("/login");
  cy.get("[data-cy=inputName]").type(username);
  cy.get("[data-cy=inputPassword]").type(password);
  cy.get("[data-cy=loginButton]").click();
});

// Custom Logout Fucntion.
Cypress.Commands.add("logout", () => {
  cy.get("[data-cy=header-dropdown]").click();
  cy.get("[data-cy=logout]").click();
  // Confirmation of Signout Page
  cy.url().should("include", "/signout");
  cy.get("[data-cy=logoutButton]").click();
});
