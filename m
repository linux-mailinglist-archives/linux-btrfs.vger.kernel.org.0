Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F805B8E10
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiINRSn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiINRSb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0047480379
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:28 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z18so11696239qts.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=VJZa1gtx3O+NzNEjinQfaTRsGvcS0yY0/ZnROj0y5eI=;
        b=KAO0iYCx7Z7VOiVe5JfkpzZOvWGL3xPOI+eIYLrAtz7GefkoF7dxAwZPpWORSrECPX
         8xcNmbXYU+hdqusp/xfcff+TOYmXOgKPPEYSJdSm9DuYYKUKY/iobmGvxUlbyGcEb9Jo
         WDuYFMk/RhV/FUAIipRO9v28DYQW98f3WRuRA2n+B0yiamJFnk8iB0D4FSB9Ykhhp6AN
         ppucFXi3PyMDBO3wjb2IYMtyKtH2cDx8/ozKYbhB/GmwHvhvFrs6qifq22Wgd+kpigQ+
         NpqacMsmCS6GjfBY9f2a31mHLwt4lYeGdH9J21a9DpR4ffd5Ej7JktSexgVDggvhcRek
         DDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VJZa1gtx3O+NzNEjinQfaTRsGvcS0yY0/ZnROj0y5eI=;
        b=hdGBtOZixsJcja/N2OyMh0fvVp0JhQcIlPuw0doluV2HMY+l/Y6KcQtOlELDQftuvP
         Mcjgfz1DyRT4FTDevnDiTZftoHJ6KbT/DDIgBCsuTGOqmJilN9Ou17jIrmirbD9VvC50
         T/1XBW+CmF5R208AhprLKXoOyobBEtFYB0W1jY/VYb/LbPQXiGBcOUhGNovSs3UNoCVN
         IsyvH4ZJ9+5QTqKKjt1sojKn2v1laf2aQ5Dq2cQ8890sWkabPMLbvaJxTtc48YJj6ohV
         dwfsH3QhKZT0teg9eZASgFCdE9Got0BGWAX+RiLshQWfsQQAWP8w8O2Q0U9O9jDCI3/1
         FopA==
X-Gm-Message-State: ACgBeo0I30s0OWIxulPf6De4BfMNJd5ObLGT2GiaeuCA4G6VioWHymEj
        La6A2c2NwEwSkEXJgWwXilcXSYrqRAThsw==
X-Google-Smtp-Source: AA6agR5NlVfLK6WY+8D4Rt+ioKfYHrgxAa6vwzUY6JjUjaq3zYsbeBFLhiMk/YfCpA4fWwgTewqiEQ==
X-Received: by 2002:ac8:5d88:0:b0:344:8185:d28a with SMTP id d8-20020ac85d88000000b003448185d28amr32730537qtx.259.1663175907312;
        Wed, 14 Sep 2022 10:18:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 8-20020a370808000000b006a6ab259261sm2152200qki.29.2022.09.14.10.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/16] btrfs: move the printk helpers out of ctree.h
Date:   Wed, 14 Sep 2022 13:18:08 -0400
Message-Id: <c7b5fc75e003087c09502050ab59d542a08e7da7.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a bunch of printk helpers that are in ctree.h.  These have
nothing to do with ctree.c, so move them into their own header.
Subsequent patches will cleanup the printk helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.h          |   1 +
 fs/btrfs/btrfs-printk.h     | 269 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/check-integrity.c  |   1 +
 fs/btrfs/ctree.c            |   1 +
 fs/btrfs/ctree.h            | 258 ----------------------------------
 fs/btrfs/delalloc-space.c   |   1 +
 fs/btrfs/delayed-inode.c    |   1 +
 fs/btrfs/delayed-ref.c      |   1 +
 fs/btrfs/dir-item.c         |   1 +
 fs/btrfs/extent-io-tree.c   |   1 +
 fs/btrfs/extent_map.c       |   1 +
 fs/btrfs/file-item.c        |   1 +
 fs/btrfs/free-space-cache.c |   1 +
 fs/btrfs/free-space-tree.c  |   1 +
 fs/btrfs/fs.c               |   1 +
 fs/btrfs/inode-item.c       |   1 +
 fs/btrfs/lzo.c              |   1 +
 fs/btrfs/ordered-data.c     |   1 +
 fs/btrfs/print-tree.c       |   1 +
 fs/btrfs/props.c            |   1 +
 fs/btrfs/raid56.c           |   1 +
 fs/btrfs/ref-verify.c       |   1 +
 fs/btrfs/reflink.c          |   1 +
 fs/btrfs/root-tree.c        |   1 +
 fs/btrfs/struct-funcs.c     |   1 +
 fs/btrfs/subpage.c          |   1 +
 fs/btrfs/super.c            |   1 +
 fs/btrfs/sysfs.c            |   1 +
 fs/btrfs/tree-checker.c     |   1 +
 fs/btrfs/tree-log.h         |   1 +
 fs/btrfs/tree-mod-log.c     |   1 +
 fs/btrfs/ulist.c            |   1 +
 fs/btrfs/uuid-tree.c        |   1 +
 fs/btrfs/verity.c           |   1 +
 fs/btrfs/xattr.c            |   1 +
 fs/btrfs/zoned.h            |   1 +
 36 files changed, 303 insertions(+), 258 deletions(-)
 create mode 100644 fs/btrfs/btrfs-printk.h

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 52ae6957b414..d60052247a81 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -7,6 +7,7 @@
 #define BTRFS_BACKREF_H
 
 #include <linux/btrfs.h>
+#include "btrfs-printk.h"
 #include "ulist.h"
 #include "disk-io.h"
 #include "extent_io.h"
diff --git a/fs/btrfs/btrfs-printk.h b/fs/btrfs/btrfs-printk.h
new file mode 100644
index 000000000000..dd7a9fd4791c
--- /dev/null
+++ b/fs/btrfs/btrfs-printk.h
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_PRINTK_H
+#define BTRFS_PRINTK_H
+
+#include <linux/printk.h>
+#include <asm/bug.h>
+
+struct btrfs_fs_info;
+struct btrfs_trans_handle;
+
+static inline __printf(2, 3) __cold
+void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
+{
+}
+
+#ifdef CONFIG_PRINTK_INDEX
+
+#define btrfs_printk(fs_info, fmt, args...)					\
+do {										\
+	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);	\
+	_btrfs_printk(fs_info, fmt, ##args);					\
+} while (0)
+
+__printf(2, 3)
+__cold
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+
+#elif defined(CONFIG_PRINTK)
+
+#define btrfs_printk(fs_info, fmt, args...)				\
+	_btrfs_printk(fs_info, fmt, ##args)
+
+__printf(2, 3)
+__cold
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+
+#else
+
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
+		DEFAULT_RATELIMIT_BURST);			\
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
+__cold
+static inline void btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
+{
+	btrfs_err(fs_info,
+"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
+}
+
+__printf(5, 6)
+__cold
+void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
+		     unsigned int line, int errno, const char *fmt, ...);
+
+const char * __attribute_const__ btrfs_decode_error(int errno);
+
+__cold
+void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
+			       const char *function,
+			       unsigned int line, int errno, bool first_hit);
+
+/*
+ * Call btrfs_abort_transaction as early as possible when an error condition is
+ * detected, that way the exact line number is reported.
+ */
+#define btrfs_abort_transaction(trans, errno)		\
+do {								\
+	bool first = false;					\
+	/* Report first abort since mount */			\
+	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
+			&((trans)->fs_info->fs_state))) {	\
+		first = true;					\
+		if ((errno) != -EIO && (errno) != -EROFS) {		\
+			WARN(1, KERN_DEBUG				\
+			"BTRFS: Transaction aborted (error %d)\n",	\
+			(errno));					\
+		} else {						\
+			btrfs_debug((trans)->fs_info,			\
+				    "Transaction aborted (error %d)", \
+				  (errno));			\
+		}						\
+	}							\
+	__btrfs_abort_transaction((trans), __func__,		\
+				  __LINE__, (errno), first);	\
+} while (0)
+
+#ifdef CONFIG_PRINTK_INDEX
+
+#define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
+do {									\
+	printk_index_subsys_emit(					\
+		"BTRFS: error (device %s%s) in %s:%d: errno=%d %s",	\
+		KERN_CRIT, fmt);					\
+	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
+				(errno), fmt, ##args);			\
+} while (0)
+
+#else
+
+#define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
+	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
+				(errno), fmt, ##args)
+
+#endif
+
+__printf(5, 6)
+__cold
+void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
+		   unsigned int line, int errno, const char *fmt, ...);
+/*
+ * If BTRFS_MOUNT_PANIC_ON_FATAL_ERROR is in mount_opt, __btrfs_panic
+ * will panic().  Otherwise we BUG() here.
+ */
+#define btrfs_panic(fs_info, errno, fmt, args...)			\
+do {									\
+	__btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args);	\
+	BUG();								\
+} while (0)
+
+#endif /* BTRFS_PRINTK_H */
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 98c6e5feab19..60ff8ce1820e 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -82,6 +82,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <crypto/hash.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0f7f93bc2582..c4a0228322fe 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -8,6 +8,7 @@
 #include <linux/rbtree.h>
 #include <linux/mm.h>
 #include <linux/error-injection.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dd776cdc73b5..52efb662fdf9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3188,186 +3188,6 @@ int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
 
-static inline __printf(2, 3) __cold
-void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
-{
-}
-
-#ifdef CONFIG_PRINTK_INDEX
-
-#define btrfs_printk(fs_info, fmt, args...)					\
-do {										\
-	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);	\
-	_btrfs_printk(fs_info, fmt, ##args);					\
-} while (0)
-
-__printf(2, 3)
-__cold
-void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
-
-#elif defined(CONFIG_PRINTK)
-
-#define btrfs_printk(fs_info, fmt, args...)				\
-	_btrfs_printk(fs_info, fmt, ##args)
-
-__printf(2, 3)
-__cold
-void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
-
-#else
-
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
@@ -3424,90 +3244,12 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
 #define EXPORT_FOR_TESTS
 #endif
 
-__cold
-static inline void btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
-{
-	btrfs_err(fs_info,
-"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
-}
-
-__printf(5, 6)
-__cold
-void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
-		     unsigned int line, int errno, const char *fmt, ...);
-
-const char * __attribute_const__ btrfs_decode_error(int errno);
-
-__cold
-void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
-			       const char *function,
-			       unsigned int line, int errno, bool first_hit);
-
-/*
- * Call btrfs_abort_transaction as early as possible when an error condition is
- * detected, that way the exact line number is reported.
- */
-#define btrfs_abort_transaction(trans, errno)		\
-do {								\
-	bool first = false;					\
-	/* Report first abort since mount */			\
-	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
-			&((trans)->fs_info->fs_state))) {	\
-		first = true;					\
-		if ((errno) != -EIO && (errno) != -EROFS) {		\
-			WARN(1, KERN_DEBUG				\
-			"BTRFS: Transaction aborted (error %d)\n",	\
-			(errno));					\
-		} else {						\
-			btrfs_debug((trans)->fs_info,			\
-				    "Transaction aborted (error %d)", \
-				  (errno));			\
-		}						\
-	}							\
-	__btrfs_abort_transaction((trans), __func__,		\
-				  __LINE__, (errno), first);	\
-} while (0)
-
-#ifdef CONFIG_PRINTK_INDEX
-
-#define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
-do {									\
-	printk_index_subsys_emit(					\
-		"BTRFS: error (device %s%s) in %s:%d: errno=%d %s",	\
-		KERN_CRIT, fmt);					\
-	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
-				(errno), fmt, ##args);			\
-} while (0)
-
-#else
-
-#define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
-	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
-				(errno), fmt, ##args)
-
-#endif
-
 #define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
 						   &(fs_info)->fs_state)))
 #define BTRFS_FS_LOG_CLEANUP_ERROR(fs_info)				\
 	(unlikely(test_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR,		\
 			   &(fs_info)->fs_state)))
 
-__printf(5, 6)
-__cold
-void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
-		   unsigned int line, int errno, const char *fmt, ...);
-/*
- * If BTRFS_MOUNT_PANIC_ON_FATAL_ERROR is in mount_opt, __btrfs_panic
- * will panic().  Otherwise we BUG() here.
- */
-#define btrfs_panic(fs_info, errno, fmt, args...)			\
-do {									\
-	__btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args);	\
-	BUG();								\
-} while (0)
-
-
 /* acl.c */
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 1e8f17ff829e..006b12ee12af 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "delalloc-space.h"
 #include "block-rsv.h"
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index a411f04a7b97..f3ff22ce3a7b 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -6,6 +6,7 @@
 
 #include <linux/slab.h>
 #include <linux/iversion.h>
+#include "btrfs-printk.h"
 #include "misc.h"
 #include "delayed-inode.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 36a3debe9493..6d30f74a4574 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "delayed-ref.h"
 #include "transaction.h"
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 72fb2c518a2b..e53640dfacca 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 52a9dbca79bc..f76f3ec6fc9e 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -2,6 +2,7 @@
 
 #include <linux/slab.h>
 #include <trace/events/btrfs.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "extent-io-tree.h"
 #include "btrfs_inode.h"
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d5640e695e6b..1ee4d0c4c20a 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -3,6 +3,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "volumes.h"
 #include "extent_map.h"
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index b5b54140847d..07cfffabbe84 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -9,6 +9,7 @@
 #include <linux/highmem.h>
 #include <linux/sched/mm.h>
 #include <crypto/hash.h>
+#include "btrfs-printk.h"
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ee03c5e6db4c..3027c709a7cf 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -11,6 +11,7 @@
 #include <linux/ratelimit.h>
 #include <linux/error-injection.h>
 #include <linux/sched/mm.h>
+#include "btrfs-printk.h"
 #include "misc.h"
 #include "ctree.h"
 #include "free-space-cache.h"
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index bfc21eb8ec63..5e0829456eb9 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/sched/mm.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "locking.h"
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index d4ba948eba56..31cac6c6f062 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "fs.h"
 
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 366f3a788c6a..02cd4210edf3 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "inode-item.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 89bc5f825e0a..69e7c6cc6a6f 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -13,6 +13,7 @@
 #include <linux/bio.h>
 #include <linux/lzo.h>
 #include <linux/refcount.h>
+#include "btrfs-printk.h"
 #include "compression.h"
 #include "ctree.h"
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 40a364c11178..60de19da09e1 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include <linux/writeback.h>
 #include <linux/sched/mm.h>
+#include "btrfs-printk.h"
 #include "misc.h"
 #include "ctree.h"
 #include "transaction.h"
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index dd8777872143..40576965d3da 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "print-tree.h"
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index ef17014221e2..f95bc8e8d90a 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/hashtable.h>
+#include "btrfs-printk.h"
 #include "props.h"
 #include "btrfs_inode.h"
 #include "transaction.h"
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f6395e8288d6..cb8e3a362f50 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -13,6 +13,7 @@
 #include <linux/list_sort.h>
 #include <linux/raid/xor.h>
 #include <linux/mm.h>
+#include "btrfs-printk.h"
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index a248f46cfe72..0d74ebd07159 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -5,6 +5,7 @@
 
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "locking.h"
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f50586ff85c8..6bc2231a7874 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -2,6 +2,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/iversion.h>
+#include "btrfs-printk.h"
 #include "compression.h"
 #include "ctree.h"
 #include "delalloc-space.h"
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index e1f599d7a916..ab9e891ddb79 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -5,6 +5,7 @@
 
 #include <linux/err.h>
 #include <linux/uuid.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "transaction.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 12455b2b41de..ec6b0436d09a 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -5,6 +5,7 @@
 
 #include <asm/unaligned.h>
 
+#include "btrfs-printk.h"
 #include "ctree.h"
 
 static bool check_setget_bounds(const struct extent_buffer *eb,
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 6fc2b77ae5c3..271776f217c5 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/slab.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "subpage.h"
 #include "btrfs_inode.h"
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index fc474d472566..1b713c75ca08 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -26,6 +26,7 @@
 #include <linux/ratelimit.h>
 #include <linux/crc32c.h>
 #include <linux/btrfs.h>
+#include "btrfs-printk.h"
 #include "delayed-inode.h"
 #include "ctree.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 699b54b3acaa..24079df977ff 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/bug.h>
 #include <crypto/hash.h>
 
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "discard.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 862d67798de5..ec7de2a42b99 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/error-injection.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "tree-checker.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index aed1e05e9879..d8501f4988dd 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -6,6 +6,7 @@
 #ifndef BTRFS_TREE_LOG_H
 #define BTRFS_TREE_LOG_H
 
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "transaction.h"
 
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 8a3a14686d3e..51ace0ac5c2d 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "btrfs-printk.h"
 #include "tree-mod-log.h"
 #include "disk-io.h"
 
diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index 3374c9e9be67..2535f9482112 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/slab.h>
+#include "btrfs-printk.h"
 #include "ulist.h"
 #include "ctree.h"
 
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 2d7eb290fb9c..a24c5b13cf85 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -5,6 +5,7 @@
 
 #include <linux/uuid.h>
 #include <asm/unaligned.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "transaction.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index ab0b39badbbe..5b38625f915e 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -10,6 +10,7 @@
 #include <linux/iversion.h>
 #include <linux/fsverity.h>
 #include <linux/sched/mm.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "btrfs_inode.h"
 #include "transaction.h"
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 5bb8d8c86311..69ead7e90478 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -12,6 +12,7 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/iversion.h>
 #include <linux/sched/mm.h>
+#include "btrfs-printk.h"
 #include "ctree.h"
 #include "btrfs_inode.h"
 #include "transaction.h"
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e17462db3a84..1fd53e1a6fca 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -5,6 +5,7 @@
 
 #include <linux/types.h>
 #include <linux/blkdev.h>
+#include "btrfs-printk.h"
 #include "volumes.h"
 #include "disk-io.h"
 #include "block-group.h"
-- 
2.26.3

