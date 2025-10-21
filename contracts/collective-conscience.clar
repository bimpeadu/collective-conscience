;; Collective Conscience Contract
;; Every participant submits a thought, merged into one immutable record

;; Data Variables
(define-data-var thought-counter uint u0)

;; Data Maps
(define-map thoughts
    { thought-id: uint }
    {
        contributor: principal,
        content: (string-ascii 500),
        timestamp: uint
    }
)

(define-map contributor-thoughts
    { contributor: principal }
    { thought-ids: (list 100 uint) }
)

;; Read-only functions
(define-read-only (get-thought (thought-id uint))
    (map-get? thoughts { thought-id: thought-id })
)

(define-read-only (get-contributor-thoughts (contributor principal))
    (map-get? contributor-thoughts { contributor: contributor })
)

(define-read-only (get-total-thoughts)
    (var-get thought-counter)
)

;; Public functions
(define-public (submit-thought (content (string-ascii 500)))
    (let
        (
            (thought-id (+ (var-get thought-counter) u1))
            (contributor tx-sender)
            (existing-thoughts (default-to
                { thought-ids: (list) }
                (map-get? contributor-thoughts { contributor: contributor })
            ))
            (updated-thought-ids (unwrap!
                (as-max-len?
                    (append (get thought-ids existing-thoughts) thought-id)
                    u100
                )
                (err u100)
            ))
        )
        ;; Store the thought
        (map-set thoughts
            { thought-id: thought-id }
            {
                contributor: contributor,
                content: content,
                timestamp: block-height
            }
        )

        ;; Update contributor's thought list
        (map-set contributor-thoughts
            { contributor: contributor }
            { thought-ids: updated-thought-ids }
        )

        ;; Increment counter
        (var-set thought-counter thought-id)

        ;; Return the thought ID
        (ok thought-id)
    )
)

;; Get all thoughts in the collective conscience (read-only helper)
(define-read-only (get-thoughts-range (start-id uint) (end-id uint))
    (ok {
        start: start-id,
        end: end-id,
        total: (var-get thought-counter)
    })
)

