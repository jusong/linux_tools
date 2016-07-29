;;设置load-path
(add-to-list 'load-path "~/.emacs.d/lisp")

;;矩形选取
(require 'rect-mark)
(global-set-key (kbd "C-S-SPC") 'rm-set-mark)

;;加载主题
(require 'color-theme)
(color-theme-initialize)
;; Pierson/Calm Forest/Midnight
(color-theme-oswald)

;;加载php-mode
(require 'php-mode)

;;Emacs中shell启用ansi color
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t) 
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)

;;Ctrl-c ← (左箭头)，退回y上一个窗口设置
(when (fboundp 'winner-mode) 
  (winner-mode) 
  (windmove-default-keybindings))

(global-set-key (kbd "C-c s") 'shell) 
(global-set-key (kbd "C-c r") 'rename-buffer)

;;回车自动缩进
(global-set-key (kbd "RET") 'newline-and-indent)
(add-hook 'html-mode-hook
	  (lambda ()
	    ;; Default indentation is usually 2 spaces, changing to 4.
	    (set (make-local-variable 'sgml-basic-offset) 4)))


;;设置字体及大小
;;(set-default-font "-bitstream-Courier 10 Pitch-normal-normal-normal-*-24-*-*-*-m-0-iso10646-1")
;;格式:字体名称-字号
(set-default-font "Courier 10 Pitch-18")

;;注释代码(dwim: Do What I Mean)(Alt-;)
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected and current line is not blank and we are not at the end of the line, then comment current line. Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line) 


					;解决emacs shell 乱码
(setq ansi-color-for-comint-mode t)
(customize-group 'ansi-colors)
(kill-this-buffer);关闭customize窗口


					;自定义按键
(global-set-key [f1] 'shell);F1进入Shell
(global-set-key [f2] 'rename-buffer);F2修改缓冲区名字
(global-set-key [f5] 'gdb);F5调试程序
(setq compile-command "make -f Makefile")
(global-set-key [f7] 'do-compile);F7编译文件
(global-set-key [f8] 'other-window);F8窗口间跳转
(global-set-key [C-return] 'kill-this-buffer);C-return关闭当前buffer
(global-set-key [f10] 'split-window-vertically);F10分割窗口
;;(global-set-key [f11] 'delete-other-windows);F11 关闭其它窗口
;;(global-set-key [f12] 'my-fullscreen);F12 全屏
(global-set-key [f11] 'my-fullscreen);F11 全屏
(global-set-key (kbd "M-,") 'backward-page);文件首
(global-set-key (kbd "M-.") 'forward-page);文件尾
(global-set-key (kbd "C-g") 'goto-line);跳转指定行

					;普通设置
(setq inhibit-startup-message t);关闭起动时闪屏
(setq visible-bell t);关闭出错时的提示声
(setq make-backup-files 0);不产生备份文件
(setq default-major-mode 'text-mode);一打开就起用 text 模式
(global-font-lock-mode t);语法高亮
(auto-image-file-mode t);打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no
(column-number-mode t);显示列号
(show-paren-mode t);显示括号匹配
(display-time-mode 1);显示时间，格式如下
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(tool-bar-mode 0);去掉那个大大的工具栏
(menu-bar-mode 0);去掉菜单栏
(scroll-bar-mode 0);去掉滚动条
(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t);支持中键粘贴
(transient-mark-mode t);允许临时设置标记
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
(setq frame-title-format '("" buffer-file-name "@emacs" ));在标题栏显示buffer名称
(setq default-fill-column 80);默认显示 80列就换行 


					;鼠标滚轮，默认的滚动太快，这里改为3行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

;;设置透明度
(global-set-key [(f9)] 'loop-alpha)
;;(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))
(setq alpha-list '((100 100) (85 55) (65 35)))
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))                ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
  )

;; ;非交互式编译
;; (defun do-compile ()
;;   "Save buffers and start compile"
;;   (interactive)
;;   (save-some-buffers t)
;;   (setq compilation-read-command nil)
;;   (compile compile-command)
;;   (setq compilation-read-command t))


;; ;shell,gdb退出后，自动关闭该buffer
;; (add-hook 'shell-mode-hook 'mode-hook-func)
;; (add-hook 'gdb-mode-hook 'mode-hook-func)
;; (defun mode-hook-func  ()
;;   (set-process-sentinel (get-buffer-process (current-buffer))
;;          #'kill-buffer-on-exit))
;; (defun kill-buffer-on-exit (process state)
;;   (message "%s" state)
;;   (if (or
;;        (string-match "exited abnormally with code.*" state)
;;        (string-match "finished" state))
;;       (kill-buffer (current-buffer))))


					;全屏
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
;;(my-fullscreen)

;; 最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  )
;; 启动emacs时窗口最大化
(my-maximized)


;; ;加入会话功能
;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)
;; (load "desktop")
;; (desktop-save-mode)


;; ;加入标签功能
;; (require 'tabbar)
;; (tabbar-mode)
;; ;(global-set-key (kbd "") 'tabbar-backward-group)
;; ;(global-set-key (kbd "") 'tabbar-forward-group)
;; (global-set-key (kbd "C-`") 'tabbar-backward)
;; (global-set-key (kbd "C-<tab>") 'tabbar-forward)
;; ;设置tabbar字体
;; (set-face-attribute 'tabbar-default-face
;;           nil :family "Tahoma")


;; ;加入color-theme插件
;; (require 'color-theme)
;; (color-theme-classic)

;; ;加入xcscope插件
;; (require 'xcscope)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;C/C++设定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;缩进策略
;; (defun my-indent-or-complete ()
;;   (interactive)
;;   (if (looking-at "\\>")
;;       (hippie-expand nil)
;;     (indent-for-tab-command)))
;; ;补全优先级
;; (autoload 'senator-try-expand-semantic "senator")
;; (setq hippie-expand-try-functions-list
;;       '(
;;    senator-try-expand-sematic
;;    try-expand-dabbrev
;;    try-expand-dabbrev-visible
;;    try-expand-dabbrev-all-buffers
;;    try-expand-dabbrev-from-kill
;;    try-complete-file-name-partially
;;    try-complete-file-name
;;    try-expand-all-abbrevs
;;    try-expand-list
;;    try-expand-line
;;    try-complete-lisp-symbol-partially
;;    try-complete-lisp-symbol))
;; ;;;; CC-mode配置  http://cc-mode.sourceforge.net/
;; (require 'cc-mode)
;; (c-set-offset 'inline-open 0)
;; (c-set-offset 'friend '-)
;; (c-set-offset 'substatement-open 0)
;; ;;;;根据后缀判断所用的mode
;; ;;;;注意：我在这里把.h关联到了c++-mode
;; (setq auto-mode-alist
;;       (append '(("\\.h$" . c++-mode)) auto-mode-alist))
;; ;;;;我的C语言编辑策略
;; (defun my-c-mode-common-hook()
;;   (setq default-tab-width 4 indent-tabs-mode nil)
;;   (setq tab-width 4 indent-tabs-mode nil)
;;   (setq c-basic-offset 4)
;;   ;;; hungry-delete and auto-newline
;;   (c-toggle-auto-hungry-state 1)
;;   ;;按键定义
;;   ;(define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
;;   (define-key c-mode-base-map [(return)] 'newline-and-indent)
;;   (define-key c-mode-base-map [(f7)] 'do-compile)
;;   ;(define-key c-mode-base-map [(f8)] 'ff-get-other-file)
;;   (define-key c-mode-base-map [(meta \`)] 'c-indent-command)

;;   ;(define-key c-mode-base-map [(tab)] 'hippie-expand)
;;   (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
;;   (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
;;   ;;预处理设置
;;   (setq c-macro-shrink-window-flag t)
;;   (setq c-macro-preprocessor "cpp")
;;   (setq c-macro-cppflags " ")
;;   (setq c-macro-prompt-flag t)
;;   (setq hs-minor-mode t)
;;   (setq abbrev-mode t))
;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
;; ;;;;我的C++语言编辑策略
;; (defun my-c++-mode-hook()
;;   (setq default-tab-width 4 indent-tabs-mode nil)
;;   (setq tab-width 4 indent-tabs-mode nil)
;;   (setq c-basic-offset 4)
;;   ;;(define-key c++-mode-map [f3] 'replace-regexp)
;;   (c-set-style "stroustrup"))
;; (add-hook 'c++-mode-hook 'my-c++-mode-hook)


;; ;加入cedet插件
;; (add-hook 'texinfo-mode-hook (lambda () (require 'sb-texinfo)))
;; (require 'cedet)
;; (semantic-load-enable-code-helpers)
;; (autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
;; (autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
;; (define-key-after (lookup-key global-map [menu-bar tools])
;;   [speedbar]
;;   '("Speedbar" .
;;     speedbar-frame-mode)
;;   [calendar])
;; (global-set-key [f4] 'speedbar);F4打开/关闭speedbar
;; ;;;;semantic /usr/include      
;; (setq semanticdb-search-system-databases t)
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (setq semanticdb-project-system-databases
;;                   (list (semanticdb-create-database
;;           semanticdb-new-database-class
;;           "/usr/include")))))
;; ;project root path
;; (setq semanticdb-project-roots 
;;       (list
;;        (expand-file-name "~/devel")))


;; ;加入ecb插件
;; (require 'ecb)
;; ;ecb设置
;; (require 'ecb-autoloads)
;; (setq ecb-auto-activate t
;;       ecb-tip-of-the-day nil
;;       inhibit-startup-message t
;;       ecb-auto-compatibility-check nil
;;       ecb-version-check nil) 



;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(ecb-layout-window-sizes (quote (("left8" (0.20967741935483872 . 0.27586206896551724) (0.20967741935483872 . 0.2413793103448276) (0.20967741935483872 . 0.27586206896551724) (0.20967741935483872 . 0.1724137931034483)))))
;;  '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1)))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  )


					;scroll other window
(global-set-key (kbd "C-c C-v") 'scroll-other-window)
(global-set-key (kbd "C-c C-b") 'scroll-other-window-down)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(canlock-password "6e74d6d7bdaea929259cf7fd9062955a2fd1925d"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(set-fontset-font "fontset-default"
		  'gb18030 '("Microsoft YaHei" . "unicode-bmp"))
;;tab键
(global-set-key [C-tab] '(lambda () (interactive) (insert-char 9 1)))

;;关闭生成临时文件
(setq auto-save-default nil)
;;关闭生成备份文件
(setq make-backup-files nil)
