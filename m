Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0267601701
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJQTJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJQTJa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:30 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AF31039
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:21 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id s17so6093997qkj.12
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oml/P0JaaIw7riWyNo6dLBpwGzmmgNXdcV0f/Wk8FUQ=;
        b=gK0y5ilyAg8NR5euUji2kRTskAygD9OdQzkYBFrFaWyK+LBklfaHH3URMsJ0p0dJ6L
         U4bRDVuf6N/EcSHPAGC6M0SiaF4UqOo3w2Ly1/asAgqglVTkphLT3UaNDLc2XmAPSUz1
         /v7pJpVpf1Vp610ORwe1yebRYdJz+dXDVyLX/zp4gvCB/+/t8JWkDe62Kyc8swOgQLql
         X1iLNyY06HsQFo4a/KCdEgVRhy+H0d9AMXL3JZwbzzcGqpUZhZ7WG94snuUuKDLd5RDh
         5Rz6cnT7cwREQpt+uQubPnZ9hxELgO/hf1mA0YgC/caCsKhBSilMSCZ+yE4MvZNsA5b3
         zTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oml/P0JaaIw7riWyNo6dLBpwGzmmgNXdcV0f/Wk8FUQ=;
        b=iewYQ4gmrpXrmT03rkbsxtlLkBsArFuXzP5s+/feqDInzWaOauvPArOAvBCaDHmCzX
         zZQ0aQgOvg3T5YdvNHVVsX061ay6lDtQvyNO/BMevwkVw3c+45Fr4oWW1KLqn60sUnyB
         58U09Raik+X+ZYTnW2/f11ah0XfZO5XRl5uD9X4OUsQqfp/DI2XUmQJvisJXiiVkrz96
         IEiqZQv4L6JKztU7GH/zMYozmPNBWYzMZ4b38M4qk/aXJwmsql6H16ZFFupa3gyeAta0
         fH13Lhgy1G/D5+MVTlcySQ0lerH7lEU8UyryuMyOGQpG70rQCJUNKguLyYBCUYVLbbRo
         Ax8A==
X-Gm-Message-State: ACrzQf3KklZ6A3y2SIZIzgd+C8/8iI0wEsfJe+DAzdMp4yETFf1NzJJL
        gWRZzbkPs3jDpLi+3yS1uoF02urafCOpnw==
X-Google-Smtp-Source: AMsMyM4DvTMc0TAXIdHUpeSy8bpUkjX0O16R31Nsnj7+94DYVMQlPkjFQMR42zU+GaZJubJW1xLC5w==
X-Received: by 2002:a05:620a:2806:b0:6b8:eced:ba3a with SMTP id f6-20020a05620a280600b006b8ecedba3amr8686811qkp.462.1666033759659;
        Mon, 17 Oct 2022 12:09:19 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a248800b006bb0f9b89cfsm466991qkn.87.2022.10.17.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 03/16] btrfs: move the printk helpers out of ctree.h
Date:   Mon, 17 Oct 2022 15:09:00 -0400
Message-Id: <fa1c5f5da60d7689c51e2bfec0b947dab4de082d.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666033501.git.josef@toxicpanda.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/btrfs/messages.h         | 269 ++++++++++++++++++++++++++++++++++++
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
 create mode 100644 fs/btrfs/messages.h

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 52ae6957b414..f3fabb1b420e 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -7,6 +7,7 @@
 #define BTRFS_BACKREF_H
 
 #include <linux/btrfs.h>
+#include "messages.h"
 #include "ulist.h"
 #include "disk-io.h"
 #include "extent_io.h"
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 98c6e5feab19..e8e1a92b30ac 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -82,6 +82,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <crypto/hash.h>
+#include "messages.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index bd72d64bb179..8deba9cc0ee3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -8,6 +8,7 @@
 #include <linux/rbtree.h>
 #include <linux/mm.h>
 #include <linux/error-injection.h>
+#include "messages.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 52987ee61c72..45df323caa38 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3155,186 +3155,6 @@ int btrfs_sync_fs(struct super_block *sb, int wait);
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
@@ -3391,90 +3211,12 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
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
index 118b2e20b2e1..045545145a2b 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "messages.h"
 #include "ctree.h"
 #include "delalloc-space.h"
 #include "block-rsv.h"
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index a411f04a7b97..8cf5ee646147 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -6,6 +6,7 @@
 
 #include <linux/slab.h>
 #include <linux/iversion.h>
+#include "messages.h"
 #include "misc.h"
 #include "delayed-inode.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 36a3debe9493..c775ff4f1cb1 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include "messages.h"
 #include "ctree.h"
 #include "delayed-ref.h"
 #include "transaction.h"
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 72fb2c518a2b..be5c1c2a8da5 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include "messages.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 618275af19c4..5fcede4080cc 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -2,6 +2,7 @@
 
 #include <linux/slab.h>
 #include <trace/events/btrfs.h>
+#include "messages.h"
 #include "ctree.h"
 #include "extent-io-tree.h"
 #include "btrfs_inode.h"
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 6092a4eedc92..ba8fb176601b 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -3,6 +3,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include "messages.h"
 #include "ctree.h"
 #include "volumes.h"
 #include "extent_map.h"
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 824ff54d8155..675987e2d652 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -9,6 +9,7 @@
 #include <linux/highmem.h>
 #include <linux/sched/mm.h>
 #include <crypto/hash.h>
+#include "messages.h"
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index bd68fafcccc7..83d866f5ab6c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -11,6 +11,7 @@
 #include <linux/ratelimit.h>
 #include <linux/error-injection.h>
 #include <linux/sched/mm.h>
+#include "messages.h"
 #include "misc.h"
 #include "ctree.h"
 #include "free-space-cache.h"
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index bfc21eb8ec63..026214d74a02 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/sched/mm.h>
+#include "messages.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "locking.h"
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index d4ba948eba56..a59504b59435 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "messages.h"
 #include "ctree.h"
 #include "fs.h"
 
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 366f3a788c6a..b301d8e3df87 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include "messages.h"
 #include "ctree.h"
 #include "inode-item.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 89bc5f825e0a..6751874a3e69 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -13,6 +13,7 @@
 #include <linux/bio.h>
 #include <linux/lzo.h>
 #include <linux/refcount.h>
+#include "messages.h"
 #include "compression.h"
 #include "ctree.h"
 
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
new file mode 100644
index 000000000000..e4bf08d4fd54
--- /dev/null
+++ b/fs/btrfs/messages.h
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_MESSAGES_H
+#define BTRFS_MESSAGES_H
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
+#endif /* BTRFS_MESSAGES_H */
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e54f8280031f..cf6b2a466e59 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include <linux/writeback.h>
 #include <linux/sched/mm.h>
+#include "messages.h"
 #include "misc.h"
 #include "ctree.h"
 #include "transaction.h"
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index dd8777872143..708facaede2c 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include "messages.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "print-tree.h"
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index ef17014221e2..6e11eda7acd4 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/hashtable.h>
+#include "messages.h"
 #include "props.h"
 #include "btrfs_inode.h"
 #include "transaction.h"
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f6395e8288d6..d1b38ca0be82 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -13,6 +13,7 @@
 #include <linux/list_sort.h>
 #include <linux/raid/xor.h>
 #include <linux/mm.h>
+#include "messages.h"
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index a248f46cfe72..f7535b8b62f5 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -5,6 +5,7 @@
 
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
+#include "messages.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "locking.h"
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f50586ff85c8..6179864de6e7 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -2,6 +2,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/iversion.h>
+#include "messages.h"
 #include "compression.h"
 #include "ctree.h"
 #include "delalloc-space.h"
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index e1f599d7a916..44c8c8ad0a16 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -5,6 +5,7 @@
 
 #include <linux/err.h>
 #include <linux/uuid.h>
+#include "messages.h"
 #include "ctree.h"
 #include "transaction.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 12455b2b41de..6ba16c018d7f 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -5,6 +5,7 @@
 
 #include <asm/unaligned.h>
 
+#include "messages.h"
 #include "ctree.h"
 
 static bool check_setget_bounds(const struct extent_buffer *eb,
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 6fc2b77ae5c3..a2a9bb629a13 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/slab.h>
+#include "messages.h"
 #include "ctree.h"
 #include "subpage.h"
 #include "btrfs_inode.h"
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ebd59dc448dd..6fdcb4104dc2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -26,6 +26,7 @@
 #include <linux/ratelimit.h>
 #include <linux/crc32c.h>
 #include <linux/btrfs.h>
+#include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 699b54b3acaa..404a314ec8a2 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/bug.h>
 #include <crypto/hash.h>
 
+#include "messages.h"
 #include "ctree.h"
 #include "discard.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 862d67798de5..fa9536110d69 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/error-injection.h>
+#include "messages.h"
 #include "ctree.h"
 #include "tree-checker.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index aed1e05e9879..f5770829d075 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -6,6 +6,7 @@
 #ifndef BTRFS_TREE_LOG_H
 #define BTRFS_TREE_LOG_H
 
+#include "messages.h"
 #include "ctree.h"
 #include "transaction.h"
 
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 8a3a14686d3e..bf894de47731 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "messages.h"
 #include "tree-mod-log.h"
 #include "disk-io.h"
 
diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index 3374c9e9be67..f2f20c8d84aa 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/slab.h>
+#include "messages.h"
 #include "ulist.h"
 #include "ctree.h"
 
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 2d7eb290fb9c..190f752a2e10 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -5,6 +5,7 @@
 
 #include <linux/uuid.h>
 #include <asm/unaligned.h>
+#include "messages.h"
 #include "ctree.h"
 #include "transaction.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index ab0b39badbbe..35445855df4d 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -10,6 +10,7 @@
 #include <linux/iversion.h>
 #include <linux/fsverity.h>
 #include <linux/sched/mm.h>
+#include "messages.h"
 #include "ctree.h"
 #include "btrfs_inode.h"
 #include "transaction.h"
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 5bb8d8c86311..d12903f01f83 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -12,6 +12,7 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/iversion.h>
 #include <linux/sched/mm.h>
+#include "messages.h"
 #include "ctree.h"
 #include "btrfs_inode.h"
 #include "transaction.h"
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e17462db3a84..8d7e6be853c6 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -5,6 +5,7 @@
 
 #include <linux/types.h>
 #include <linux/blkdev.h>
+#include "messages.h"
 #include "volumes.h"
 #include "disk-io.h"
 #include "block-group.h"
-- 
2.26.3

