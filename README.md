🧠 Collective Conscience Contract

Overview

The Collective Conscience Contract is a decentralized thought ledger built on the Stacks blockchain.
It allows participants to permanently record their thoughts on-chain, creating a transparent, immutable “collective mind” of contributors.
Each thought is linked to its author and timestamped for posterity, representing a shared on-chain consciousness.

✨ Features

Immutable Thought Recording:
Every participant can submit a thought (up to 500 ASCII characters) that becomes a permanent entry.

Contributor History Tracking:
Each participant’s thoughts are tracked via a dedicated record listing up to 100 thought IDs.

Global Counter:
A global counter keeps track of the total number of submitted thoughts.

Public Transparency:
Anyone can query individual thoughts, contributor histories, or the total number of thoughts.

Timestamped Records:
Each thought includes the block height as a trusted timestamp.

🧩 Data Structures
Data Variables

thought-counter (uint) – Keeps count of total thoughts submitted.

Data Maps

thoughts – Stores each thought along with contributor and timestamp.

{ thought-id: uint } => {
    contributor: principal,
    content: (string-ascii 500),
    timestamp: uint
}


contributor-thoughts – Keeps a list of all thought IDs for a contributor.

{ contributor: principal } => { thought-ids: (list 100 uint) }

⚙️ Functions
🔹 Public Functions
(submit-thought (content (string-ascii 500))) → (response uint uint)

Submits a new thought and returns its unique ID.

Validations:

Limits total thoughts per contributor to 100.

Ensures string content is ≤ 500 characters.

Effects:

Increments global thought-counter.

Updates contributor’s thought list.

Stores new entry in thoughts.

🔹 Read-Only Functions
(get-thought (thought-id uint)) → (optional { ... })

Fetches the details of a specific thought by ID.

(get-contributor-thoughts (contributor principal)) → (optional { thought-ids: (list 100 uint) })

Returns all thought IDs submitted by a particular contributor.

(get-total-thoughts) → uint

Returns the current total number of thoughts in the collective.

(get-thoughts-range (start-id uint) (end-id uint)) → (response { start: uint, end: uint, total: uint } uint)

Provides metadata about the requested range of thoughts — useful for pagination or analytics.

🧠 Example Usage
;; Submit a new thought
(contract-call? .collective-conscience submit-thought "Every idea begins as a thought.")

;; Retrieve the first thought
(contract-call? .collective-conscience get-thought u1)

;; View all thoughts by a specific user
(contract-call? .collective-conscience get-contributor-thoughts tx-sender)

;; Get the total number of thoughts
(contract-call? .collective-conscience get-total-thoughts)

📜 Design Philosophy

This contract symbolizes the collective memory of contributors — where each thought, once shared, becomes part of an immutable record.
It demonstrates how decentralized permanence can be used for creative, philosophical, and collaborative expression beyond financial use cases.

🔒 Future Enhancements

Add moderation or encryption layers for private thoughts.

Introduce upvote/downvote mechanisms for community sentiment.

Implement pagination and thought retrieval by timestamp.

Connect with off-chain interfaces for real-time visualization of the collective mind.