# README
# Task Manager

A Task Management App built with **Ruby on Rails 7.2**, **Turbo**, and **Bootstrap 5**.
It supports:
- User authentication (Devise)
- Add/Edit/Delete tasks
- Inline editing with Turbo Frames
- Real-time updates with Turbo Stream
- Responsive Bootstrap UI
- API endpoint to find the largest submatrix of 1's
- Test suite with Minitest

---

##  Features

  User authentication (Sign up / Login / Logout)
  Add new tasks with:

* Title, Description
* Priority (Low/Medium/High)
* Status (Pending/In Progress/Completed)
* Due date (no past dates allowed)

  - View tasks ordered by priority
  - Inline task editing with Turbo Frames
  - Delete tasks with Turbo Stream (no page reload)
  - Badge counter that updates live when tasks are added/deleted
  - Shows “No tasks yet” message when there are no tasks
  - Bootstrap-based clean and responsive UI
  - Server-side validation for due dates
  - API endpoint: **POST /api/v1/matrices/max_ones**
  - to find the largest square submatrix of 1’s

---

##  Setup

### Prerequisites

* Ruby 3.x
* PostgreSQL
* Rails 7.2
* Node.js & Yarn (optional, if you use jsbundling)

### Installation

```bash
git clone <your-repo-url>
cd task_manager

bundle install
rails db:create
rails db:migrate
```

---

## Running the App

```bash
bin/rails server
```

Visit:
[http://localhost:3000](http://localhost:3000)

---

## User Authentication

* Uses Devise
* Signup/Login/Logout from the navbar

---

## Tasks

* Add new task via form
* Tasks listed on right side of the page
* Edit inline with Turbo Frame
* Delete inline with Turbo Stream
* Task counter updates live
* Cannot set due date in the past
* When no tasks, shows a friendly message

---

## API

### POST `/api/v1/matrices/max_ones`

#### Request

```json
{
  "matrix": [
    [1, 0, 1],
    [1, 1, 1],
    [1, 1, 0]
  ]
}
```

#### Response

```json
{
  "max_submatrix": [
    [1, 1],
    [1, 1]
  ]
}
```

Requires authentication.
You can use **Basic Auth (email & password)** to access the API from Postman or cURL.

---

##  Testing

Uses Rails **Minitest**.

Run tests:

```bash
rails test
```

Includes:

* Controller tests for API
* Controller tests for Tasks
* Model validations

---

##  Tech Stack

* Rails 7.2
* Ruby 3.2.4
* PostgreSQL
* Devise
* Turbo (Hotwire)
* Bootstrap 5
* Minitest

---

### Special Notes

Thanks to Turbo + Rails 7’s defaults, this app works like a **Single Page Application (SPA)** without writing much custom JavaScript!
