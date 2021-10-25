Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57643920E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhJYJLG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:11:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50372 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhJYJLF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:11:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3D2B1FCA3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635152923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rGzgcRwbrZzyx1LJ3DM1G6/s3WRuKBvXXs1ejkmHpAE=;
        b=TMlAXoUK4qMK5LsfshxGk9+JmrJ0TI/Bxnx5fnjnay+nHYgaqAhOC2TaW1U2QMXvvzwo80
        hS8FJlU1Co7nlwlmWObdhbpw6OHgbNlPY0mFuBi6VLBULHGLGObjRzBluvGMVwIoKa7qmq
        QK+gxKsRk6GU/9e69p3/XwjH/1w35Co=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 517D613AAB
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8BAgBxp0dmHDPwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: move btrfs_printk() related macros to messages.h
Date:   Mon, 25 Oct 2021 17:08:21 +0800
Message-Id: <20211025090821.65646-4-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025090821.65646-1-wqu@suse.com>
References: <20211025090821.65646-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This would further reduce the size of ctree.h.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h    | 163 +-----------------------------------------
 fs/btrfs/messages.h | 170 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+), 162 deletions(-)
 create mode 100644 fs/btrfs/messages.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c3ec2eadfe20..5e52eb26c5b2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -29,6 +29,7 @@
 #include <linux/iomap.h>
 #include "ondisk_format.h"
 #include "accessors.h"
+#include "messages.h"
 #include "extent-io-tree.h"
 #include "extent_io.h"
 #include "extent_map.h"
@@ -2175,168 +2176,6 @@ int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
 
-static inline __printf(2, 3) __cold
-void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
-{
-}
-
-#ifdef CONFIG_PRINTK
-__printf(2, 3)
-__cold
-void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
-#else
-#define btrfs_printk(fs_info, fmt, args...) \
-	btrfs_no_printk(fs_info, fmt, ##args)
-#endif
-
-#define btrfs_emerg(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_EMERG fmt, ##args)
-#define btrfs_alert(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_ALERT fmt, ##args)
-#define btrfs_crit(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
-#define btrfs_err(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_ERR fmt, ##args)
-#define btrfs_warn(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_WARNING fmt, ##args)
-#define btrfs_notice(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_NOTICE fmt, ##args)
-#define btrfs_info(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_INFO fmt, ##args)
-
-/*
- * Wrappers that use printk_in_rcu
- */
-#define btrfs_emerg_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_EMERG fmt, ##args)
-#define btrfs_alert_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_ALERT fmt, ##args)
-#define btrfs_crit_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
-#define btrfs_err_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_ERR fmt, ##args)
-#define btrfs_warn_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_WARNING fmt, ##args)
-#define btrfs_notice_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_NOTICE fmt, ##args)
-#define btrfs_info_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
-
-/*
- * Wrappers that use a ratelimited printk_in_rcu
- */
-#define btrfs_emerg_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_EMERG fmt, ##args)
-#define btrfs_alert_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_ALERT fmt, ##args)
-#define btrfs_crit_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
-#define btrfs_err_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_ERR fmt, ##args)
-#define btrfs_warn_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_WARNING fmt, ##args)
-#define btrfs_notice_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_NOTICE fmt, ##args)
-#define btrfs_info_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_INFO fmt, ##args)
-
-/*
- * Wrappers that use a ratelimited printk
- */
-#define btrfs_emerg_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_EMERG fmt, ##args)
-#define btrfs_alert_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_ALERT fmt, ##args)
-#define btrfs_crit_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_CRIT fmt, ##args)
-#define btrfs_err_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_ERR fmt, ##args)
-#define btrfs_warn_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_WARNING fmt, ##args)
-#define btrfs_notice_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_NOTICE fmt, ##args)
-#define btrfs_info_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_INFO fmt, ##args)
-
-#if defined(CONFIG_DYNAMIC_DEBUG)
-#define btrfs_debug(fs_info, fmt, args...)				\
-	_dynamic_func_call_no_desc(fmt, btrfs_printk,			\
-				   fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_in_rcu(fs_info, fmt, args...)			\
-	_dynamic_func_call_no_desc(fmt, btrfs_printk_in_rcu,		\
-				   fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...)			\
-	_dynamic_func_call_no_desc(fmt, btrfs_printk_rl_in_rcu,		\
-				   fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_rl(fs_info, fmt, args...)				\
-	_dynamic_func_call_no_desc(fmt, btrfs_printk_ratelimited,	\
-				   fs_info, KERN_DEBUG fmt, ##args)
-#elif defined(DEBUG)
-#define btrfs_debug(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_DEBUG fmt, ##args)
-#else
-#define btrfs_debug(fs_info, fmt, args...) \
-	btrfs_no_printk(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_in_rcu(fs_info, fmt, args...) \
-	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_rl(fs_info, fmt, args...) \
-	btrfs_no_printk(fs_info, KERN_DEBUG fmt, ##args)
-#endif
-
-#define btrfs_printk_in_rcu(fs_info, fmt, args...)	\
-do {							\
-	rcu_read_lock();				\
-	btrfs_printk(fs_info, fmt, ##args);		\
-	rcu_read_unlock();				\
-} while (0)
-
-#define btrfs_no_printk_in_rcu(fs_info, fmt, args...)	\
-do {							\
-	rcu_read_lock();				\
-	btrfs_no_printk(fs_info, fmt, ##args);		\
-	rcu_read_unlock();				\
-} while (0)
-
-#define btrfs_printk_ratelimited(fs_info, fmt, args...)		\
-do {								\
-	static DEFINE_RATELIMIT_STATE(_rs,			\
-		DEFAULT_RATELIMIT_INTERVAL,			\
-		DEFAULT_RATELIMIT_BURST);       		\
-	if (__ratelimit(&_rs))					\
-		btrfs_printk(fs_info, fmt, ##args);		\
-} while (0)
-
-#define btrfs_printk_rl_in_rcu(fs_info, fmt, args...)		\
-do {								\
-	rcu_read_lock();					\
-	btrfs_printk_ratelimited(fs_info, fmt, ##args);		\
-	rcu_read_unlock();					\
-} while (0)
-
-#ifdef CONFIG_BTRFS_ASSERT
-__cold __noreturn
-static inline void assertfail(const char *expr, const char *file, int line)
-{
-	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
-	BUG();
-}
-
-#define ASSERT(expr)						\
-	(likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__))
-
-#else
-static inline void assertfail(const char *expr, const char* file, int line) { }
-#define ASSERT(expr)	(void)(expr)
-#endif
-
 #if BITS_PER_LONG == 32
 #define BTRFS_32BIT_MAX_FILE_SIZE (((u64)ULONG_MAX + 1) << PAGE_SHIFT)
 /*
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
new file mode 100644
index 000000000000..1b347f5ef6a1
--- /dev/null
+++ b/fs/btrfs/messages.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_MESSAGES_H
+#define BTRFS_MESSAGES_H
+
+#include <linux/printk.h>
+
+static inline __printf(2, 3) __cold
+void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
+{
+}
+
+#ifdef CONFIG_PRINTK
+__printf(2, 3)
+__cold
+void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+#else
+#define btrfs_printk(fs_info, fmt, args...) \
+	btrfs_no_printk(fs_info, fmt, ##args)
+#endif
+
+#define btrfs_emerg(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_INFO fmt, ##args)
+
+/*
+ * Wrappers that use printk_in_rcu
+ */
+#define btrfs_emerg_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
+
+/*
+ * Wrappers that use a ratelimited printk_in_rcu
+ */
+#define btrfs_emerg_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_INFO fmt, ##args)
+
+/*
+ * Wrappers that use a ratelimited printk
+ */
+#define btrfs_emerg_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_INFO fmt, ##args)
+
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#define btrfs_debug(fs_info, fmt, args...)				\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk,			\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_in_rcu(fs_info, fmt, args...)			\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_in_rcu,		\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...)			\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_rl_in_rcu,		\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl(fs_info, fmt, args...)				\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_ratelimited,	\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#elif defined(DEBUG)
+#define btrfs_debug(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_DEBUG fmt, ##args)
+#else
+#define btrfs_debug(fs_info, fmt, args...) \
+	btrfs_no_printk(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_in_rcu(fs_info, fmt, args...) \
+	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl(fs_info, fmt, args...) \
+	btrfs_no_printk(fs_info, KERN_DEBUG fmt, ##args)
+#endif
+
+#define btrfs_printk_in_rcu(fs_info, fmt, args...)	\
+do {							\
+	rcu_read_lock();				\
+	btrfs_printk(fs_info, fmt, ##args);		\
+	rcu_read_unlock();				\
+} while (0)
+
+#define btrfs_no_printk_in_rcu(fs_info, fmt, args...)	\
+do {							\
+	rcu_read_lock();				\
+	btrfs_no_printk(fs_info, fmt, ##args);		\
+	rcu_read_unlock();				\
+} while (0)
+
+#define btrfs_printk_ratelimited(fs_info, fmt, args...)		\
+do {								\
+	static DEFINE_RATELIMIT_STATE(_rs,			\
+		DEFAULT_RATELIMIT_INTERVAL,			\
+		DEFAULT_RATELIMIT_BURST);       		\
+	if (__ratelimit(&_rs))					\
+		btrfs_printk(fs_info, fmt, ##args);		\
+} while (0)
+
+#define btrfs_printk_rl_in_rcu(fs_info, fmt, args...)		\
+do {								\
+	rcu_read_lock();					\
+	btrfs_printk_ratelimited(fs_info, fmt, ##args);		\
+	rcu_read_unlock();					\
+} while (0)
+
+#ifdef CONFIG_BTRFS_ASSERT
+__cold __noreturn
+static inline void assertfail(const char *expr, const char *file, int line)
+{
+	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
+	BUG();
+}
+
+#define ASSERT(expr)						\
+	(likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__))
+
+#else
+static inline void assertfail(const char *expr, const char* file, int line) { }
+#define ASSERT(expr)	(void)(expr)
+#endif
+
+#endif
-- 
2.33.1

