/// <reference types="Cypress" />
import users from "../fixtures/Users.json";

describe("Test-cases for Authentication module in Kubera-core", () => {
  it("Visiting the Login Page", () => {
    cy.clearCookie("core-token");
    indexedDB.deleteDatabase("localforage");
    cy.visit("/login");
    cy.contains("Login to Kubera");
    cy.url().should("include", "/login");
    cy.log("Visited the Login page Successfully");
  });

  it("Logging in using Correct details", () => {
    cy.login(users.adminName, users.adminPassword);
    // Home Page Checks
    cy.contains("Welcome, ADMIN").should("be.visible");
    cy.get("[data-cy=launchPropel]").should("be.visible");
    cy.get("[data-cy=launchChaos]").should("be.visible");
    cy.get("[data-cy=headerComponent]").should("be.visible");
    cy.get("[data-cy=sidebarComponent]").should("be.visible");
    // Confirmation of Logout and Signin Page
    cy.logout();
    cy.url().should("include", "/login");
  });

  it("Logging in using Incorrect details (Empty password)", () => {
    cy.login(users.adminName, " ");
    cy.contains(
      "Wrong Credentials - Try again with correct username or password"
    ).should("be.visible");
  });

  it("Logging in using Incorrect details (Empty Username)", () => {
    cy.login(" ", users.adminPassword);
    cy.contains(
      "Wrong Credentials - Try again with correct username or password"
    ).should("be.visible");
  });

  it("Testing Change Password Utility with Same Current Password ", () => {
    cy.login(users.adminName, users.adminPassword);
    cy.get("[data-cy=settings]").click();
    cy.get("[data-cy=currPassword]").type(users.adminPassword);
    cy.get("[data-cy=newPassword]").type(users.adminPassword);
    cy.get("[data-cy=confPassword]").type(users.adminPassword);
    cy.contains("New password cannot be the same as current password").should(
      "be.visible"
    );
    cy.get("[data-cy=button]").should("be.disabled");
  });

  it("Testing Change Password Utility with Wrong current Password ", () => {
    cy.login(users.adminName, users.adminPassword);
    cy.get("[data-cy=settings]").click();
    cy.get("[data-cy=currPassword]").type("kubera2");
    cy.get("[data-cy=newPassword]").type(users.adminNewPassword);
    cy.get("[data-cy=confPassword]").type(users.adminNewPassword);
    cy.get("[data-cy=button]").click();
    cy.contains("Error: User authentication failed").should("be.visible");
    cy.get("[data-cy=done]").click();
  });

  it("Testing Change Password Utility with Wrong Confirmation Password ", () => {
    cy.login(users.adminName, users.adminPassword);
    cy.get("[data-cy=settings]").click();
    cy.get("[data-cy=currPassword]").type(users.adminPassword);
    cy.get("[data-cy=newPassword]").type(users.adminNewPassword);
    cy.get("[data-cy=confPassword]").type(users.adminPassword);
    cy.get("[data-cy=button]").should("be.disabled");
  });

  it("Testing Change Password Utility", () => {
    cy.login(users.adminName, users.adminPassword);
    cy.get("[data-cy=settings]").click();
    cy.get("[data-cy=currPassword]").type(users.adminPassword);
    cy.get("[data-cy=newPassword]").type(users.adminNewPassword);
    cy.get("[data-cy=confPassword]").type(users.adminNewPassword);
    cy.get("[data-cy=button]").click();
    cy.contains(
      "You can now use your new password to login to your account"
    ).should("be.visible");
    cy.get("[data-cy=done]").click();
    cy.logout();
    cy.login(users.adminName, users.adminNewPassword);
    // Resetting the Password
    cy.get("[data-cy=settings]").click();
    cy.get("[data-cy=currPassword]").type(users.adminNewPassword);
    cy.get("[data-cy=newPassword]").type(users.adminPassword);
    cy.get("[data-cy=confPassword]").type(users.adminPassword);
    cy.get("[data-cy=button]").click();
    cy.contains(
      "You can now use your new password to login to your account"
    ).should("be.visible");
    cy.get("[data-cy=done]").click();
  });
});
