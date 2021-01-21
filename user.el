(server-start)

;;; Set everything

(defcustom mpv-url-patterns '("youtu\\.?be")
  "List of regex patterns of urls which can be opened by mpv"
  :type 'list)

(setq
 local-root (concat user-home-directory ".local/")
 java-home "/usr/lib/jvm/java-8-openjdk-amd64/jre/"
 goroot (getenv "GOROOT")
 goroot-bin (concat goroot "/bin")
 history-delete-duplicates t
 gopath (getenv "GOPATH")
 gopath-bin (concat gopath "/bin")
 java-bin (concat java-home "/bin")
 exec-path (append exec-path (list java-bin))
 org-reveal-root (concat  "file://" local-root "reveal.js")
 eclim-eclipse-dirs (list (concat local-root "eclipse/java-2019-03/eclipse"))
 eclim-executable (concat user-home-directory ".p2/pool/plugins/org.eclim_2.8.0/bin/eclim")
 browse-url-browser-function 'eww-browse-url
 helm-man-format-switches "%s"
 org-babel-python-command "python3"
 kafka-root (concat local-root "kafka_2.12-2.1.0")
 kafka-cli-bin-path (concat kafka-root "/bin")
 kafka-cli-config-path (concat kafka-root "/config")
 neo-theme (if (display-graphic-p) 'icons 'arrow)

 browse-url-browser-function
 '(("https://www.youtube.com/results" . eww-browse-url)
   ("\\(youtu\\.?be\\)\\|\\(\\.mp[34]$\\)" . mpv-play-url)
   ("." . eww-browse-url)))

(setq org-publish-project-alist
      '(("bsless.github.io"
         ;; Path to org files.
         :base-directory "~/Projects/bsless.github.io/org"
         :base-extension "org"

         ;; Path to Jekyll Posts
         :publishing-directory "~/Projects/bsless.github.io/_posts/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :html-extension "html"
         :body-only t
         )))

(setq
 cascadia-ligatures
 '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
   ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
   "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
   "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
   "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
   "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
   "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
   "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
   ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
   "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
   "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
   "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
   "\\" "://"))

(setq
 fira-ligatures
 '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
   ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
   "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
   "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
   "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
   "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
   "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
   "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
   "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
   "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))

;;; local functions

(defun mpv-playable-url-p (url)
  "Returns true if `url' matches patterns defined in `mpv-url-patterns'"
  (string-match mpv-yt-pattern url))

(defun mpv-play-url (url &rest args)
  ""
  (interactive)
  (make-comint-in-buffer "mpv" nil "mpv" nil url))

(defun brows-url-or-play (url)
  "Checks if url matches patterns, if it does, uses play function
     else uses brows-url
     Credit u/ambrevar@https://www.reddit.com/r/emacs/comments/7usz5q/youtube_subscriptions_using_elfeed_mpv_no_browser/dtpqra5/ for drilling down the patterns"
  (interactive)
  (let ((patterns mpv-url-patterns))
    (while (and patterns (not (string-match (car mpv-url-patterns) url)))
      (setq patterns (cdr patterns)))
    (if patterns
        (mpv-play-url url)
      (brows-url url))))

(defun path-append (path)
  "Append path to PATH"
  (setenv "PATH" (concat (getenv "PATH") ":" path)))

(defun align-whitespace (start end)
  "Align columns by whitespace"
  (interactive "r")
  (align-regexp start end
                "\\(\\s-*\\)\\s-" 1 0 t))

;; native json
(defun my-slack-parse()
  (json-parse-buffer :object-type 'plist
                     :array-type 'list
                     :null-object nil
                     :false-object :json-false))

(defun my-slack-request-parse-payload (payload)
  (condition-case err-var
      (json-parse-string payload
                         :object-type 'plist
                         :array-type 'list
                         :null-object nil
                         :false-object :json-false)
    (error (message "[Slack] Error on parse JSON: %S, ERR: %S"
                    payload
                    err-var)
           nil)))

(use-package ligature
  :load-path "https://github.com/mickeynp/ligature.el"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode fira-ligatures)
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

;; (require 'semantic/db-file)

;; (require 'window-purpose) ; workaround until https://github.com/bmag/emacs-purpose/issues/158 is fixed



;; (when (fboundp 'json-parse-string)
;;   (with-eval-after-load "slack-request"
;;     (fset 'slack-parse 'my-slack-parse)
;;     (fset 'slack-request-parse-payload 'my-slack-request-parse-payload)))

(defun javap-handler (op &rest args)
  "Handle .class files by putting the output of javap in the buffer."
  (cond
   ((eq op 'get-file-buffer)
    (let ((file (car args)))
      (with-current-buffer (create-file-buffer file)
        (call-process "javap" nil (current-buffer) nil "-verbose"
                      "-classpath" (file-name-directory file)
                      (file-name-sans-extension
                       (file-name-nondirectory file)))
        (setq buffer-file-name file)
        (setq buffer-read-only t)
        (set-buffer-modified-p nil)
        (goto-char (point-min))
        (java-mode)
        (current-buffer))))
   ((javap-handler-real op args))))

(defun javap-handler-real (operation args)
  "Run the real handler without the javap handler installed."
  (let ((inhibit-file-name-handlers
         (cons 'javap-handler
               (and (eq inhibit-file-name-operation operation)
                    inhibit-file-name-handlers)))
        (inhibit-file-name-operation operation))
    (apply operation args)))

(defun cider-eval-parent-sexp ()
  "Evaluate the immediate parent sexp"
  (interactive)
  (save-excursion
    (sp-end-of-sexp)
    (evil-jump-item)
    (cider-eval-sexp-at-point)))

(spacemacs|forall-clojure-modes m
  (spacemacs/set-leader-keys-for-major-mode m
    "e," 'cider-eval-parent-sexp))

(setenv "GPG_AGENT_INFO" nil)
(setenv "JAVA_HOME" java-home)
(path-append java-bin)

(add-to-list 'file-name-handler-alist '("\\.class$" . javap-handler))

;; (path-append goroot-bin)
;; (setq exec-path (append exec-path (list goroot-bin)))
;; (path-append gopath-bin)
;; (setq exec-path (append exec-path (list gopath-bin)))
;; (spacemacs/dap-bind-keys-for-mode 'go-mode)

;;; Org extra

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-hook
 'org-mode-hook
 (lambda ()
   (eval-after-load 'org
     '(progn
        (require 'ox-reveal)
        (require 'org-tempo)))))

;;; CIDER extra

(add-hook
 'cider-mode-hook
 (lambda ()
   (eval-after-load 'cider
     '(progn
        (require 'clj-decompiler)
        (clj-decompiler-setup)
        (spacemacs|forall-clojure-modes m
          (spacemacs/set-leader-keys-for-major-mode m
            "ed" 'clj-decompiler-decompile)
          (spacemacs/set-leader-keys-for-major-mode m
            "eD" 'clj-decompiler-disassemble))))))

(define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance)
(define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

(setq org-capture-templates
      '("t" "Task" entry (file+headline "" "Tasks")
		    "* TODO %?\n  %u\n  %a"))

;; see https://github.com/sprig/org-capture-extension
(defun transform-square-brackets-to-round-ones(string-to-transform)
  "Transforms [ into ( and ] into ), other chars left unchanged."
  (concat
   (mapcar #'(lambda (c) (if (equal c ?[) ?\( (if (equal c ?]) ?\) c))) string-to-transform)))

(require 'org-protocol)
(with-eval-after-load 'org
  (add-to-list 'org-modules 'org-protocol)
  (setq
   org-capture-templates
   (append
    (list org-capture-templates)
    `(
      ("p" "Protocol" entry (file+headline ,(concat org-directory "/notes.org") "Inbox")
        "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
       ("L" "Protocol Link" entry (file+headline ,(concat org-directory "/notes.org") "Inbox")
        "* %? [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n")
))))
