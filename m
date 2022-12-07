Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE187645D7B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 16:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLGPSY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 10:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLGPST (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 10:18:19 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BE35BD6E
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 07:18:07 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v8so10163992qkg.12
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 07:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sor5ChdYEWEeXEFpQFhM+5GnGDwBJ3TG/oYGgLsvE7A=;
        b=wEiVirMog1r9q4K//mdy2kERp3EgDYZtlHy7YgRbd0ZekI///CE06tDOZXVXxIZIpi
         Cgdgvw+dZ1ZModbDoTMhg0XTjk3OfxTl1yyscLmYgcO0VPeC8u5Wc4yyHj2HHxgT/B8I
         KlwJmeqj6eRYLG01LsL9NZ/rw6clBF8GoGanwTcBb2tWa3d2DF0OFoL4DcCmFZDvATBt
         7RtOqXorjVkI8hIJT/iMIHZq9e7j0qtMvKVlBFQltc3f/8NHpbwDAovzXhaSaCLZe0/v
         mKgMyAHBCPbFtsJi3VisxPjKc8xQaz3g6E9+d4EPozz2iCDJEoVogr4k3Qt3E4cyNvCZ
         yn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sor5ChdYEWEeXEFpQFhM+5GnGDwBJ3TG/oYGgLsvE7A=;
        b=KxEaeg7gXAvV1ymoRcRWoQd4SHO2r7QqVZRMVcBdCgaBlzKNEAgTlNhm+Tfo/0MpHV
         H/NRQ3tB4b2TsO/ulTm6CLfdUcQ/E7OoGshXptLWC3WoMjJ0x3MoJ4+BCSS6bMRu/Nkb
         9D9VIuhWYwlQY3/6WCgn2jDPd9rIqN6elu0V/5uoRb452w6f7bb6kk3OTlIm8hpEn7ZG
         Ab3N1R3fVoeEFDX1yLmcK5JfY3Rz7wPLeaUR9TL6/3C4HFVfcq/Ik4CXMHka3/igS5xX
         8TEfFVjoVWP78lt/B670Q7fE2hmwt46QX+/NonVjf9YJUnOh5qImAar07ofbQsL7b/oP
         EM3w==
X-Gm-Message-State: ANoB5plcEb5QZgeWWYsgGwacKyTKEMjGxsVQ+8cdNCJsJv/vbZMh6x1y
        CoSjCKLmqSi4Ub9vPm7bWLaiihGLblDrvyPI
X-Google-Smtp-Source: AA0mqf4eISjJCnzt7NyRYGSbtG8f6rTn4w3kv3hkB6ek9flrsvH8k0GsJq8BiqNGRFn8CuYReUaJQQ==
X-Received: by 2002:a37:6047:0:b0:6ea:6c07:6e57 with SMTP id u68-20020a376047000000b006ea6c076e57mr71739176qkb.254.1670426286332;
        Wed, 07 Dec 2022 07:18:06 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id o6-20020ac85546000000b003a69225c2cdsm12036255qtr.56.2022.12.07.07.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:18:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: move btrfs_abort_transaction to transaction.c
Date:   Wed,  7 Dec 2022 10:18:04 -0500
Message-Id: <edc2981f978e80b1cd1e4196dcf4a109831a6354.1670426276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

While trying to sync messages.[ch] I ended up with this dependency on
messages.h in the rest of the progs codebase because it's where
btrfs_transaction_abort() was now held.  We want to keep messages.[ch]
limited to the kernel code, and the btrfs_transaction_abort() code
better fits in the transaction code and not in messages.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/messages.c    | 30 ------------------------------
 fs/btrfs/messages.h    | 32 --------------------------------
 fs/btrfs/transaction.c | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/transaction.h | 31 +++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 5ad375463a90..4b63ba82a5ab 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -292,36 +292,6 @@ void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
 }
 #endif
 
-/*
- * We only mark the transaction aborted and then set the file system read-only.
- * This will prevent new transactions from starting or trying to join this
- * one.
- *
- * This means that error recovery at the call site is limited to freeing
- * any local memory allocations and passing the error code up without
- * further cleanup. The transaction should complete as it normally would
- * in the call path but will return -EIO.
- *
- * We'll complete the cleanup in btrfs_end_transaction and
- * btrfs_commit_transaction.
- */
-__cold
-void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
-			       const char *function,
-			       unsigned int line, int errno, bool first_hit)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-
-	WRITE_ONCE(trans->aborted, errno);
-	WRITE_ONCE(trans->transaction->aborted, errno);
-	if (first_hit && errno == -ENOSPC)
-		btrfs_dump_space_info_for_trans_abort(fs_info);
-	/* Wake up anybody who may be waiting on this transaction */
-	wake_up(&fs_info->transaction_wait);
-	wake_up(&fs_info->transaction_blocked_wait);
-	__btrfs_handle_fs_error(fs_info, function, line, errno, NULL);
-}
-
 /*
  * We want the transaction abort to print stack trace only for errors where the
  * cause could be a bug, eg. due to ENOSPC, and not for common errors that are
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 295aa874b226..699e4032d37f 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 
 struct btrfs_fs_info;
-struct btrfs_trans_handle;
 
 static inline __printf(2, 3) __cold
 void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
@@ -178,39 +177,8 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 
 const char * __attribute_const__ btrfs_decode_error(int errno);
 
-__cold
-void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
-			       const char *function,
-			       unsigned int line, int errno, bool first_hit);
-
 bool __cold abort_should_print_stack(int errno);
 
-/*
- * Call btrfs_abort_transaction as early as possible when an error condition is
- * detected, that way the exact stack trace is reported for some errors.
- */
-#define btrfs_abort_transaction(trans, errno)		\
-do {								\
-	bool first = false;					\
-	/* Report first abort since mount */			\
-	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
-			&((trans)->fs_info->fs_state))) {	\
-		first = true;					\
-		if (WARN(abort_should_print_stack(errno), 	\
-			KERN_DEBUG				\
-			"BTRFS: Transaction aborted (error %d)\n",	\
-			(errno))) {					\
-			/* Stack trace printed. */			\
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
 #define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
 	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
 				(errno), fmt, ##args)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b8c52e89688c..050928a18a3b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2604,6 +2604,36 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
 	return (ret < 0) ? 0 : 1;
 }
 
+/*
+ * We only mark the transaction aborted and then set the file system read-only.
+ * This will prevent new transactions from starting or trying to join this
+ * one.
+ *
+ * This means that error recovery at the call site is limited to freeing
+ * any local memory allocations and passing the error code up without
+ * further cleanup. The transaction should complete as it normally would
+ * in the call path but will return -EIO.
+ *
+ * We'll complete the cleanup in btrfs_end_transaction and
+ * btrfs_commit_transaction.
+ */
+__cold
+void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
+			       const char *function,
+			       unsigned int line, int errno, bool first_hit)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+
+	WRITE_ONCE(trans->aborted, errno);
+	WRITE_ONCE(trans->transaction->aborted, errno);
+	if (first_hit && errno == -ENOSPC)
+		btrfs_dump_space_info_for_trans_abort(fs_info);
+	/* Wake up anybody who may be waiting on this transaction */
+	wake_up(&fs_info->transaction_wait);
+	wake_up(&fs_info->transaction_blocked_wait);
+	__btrfs_handle_fs_error(fs_info, function, line, errno, NULL);
+}
+
 int __init btrfs_transaction_init(void)
 {
 	btrfs_trans_handle_cachep = kmem_cache_create("btrfs_trans_handle",
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 97f6c39f59c8..8d62d41804ae 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -202,6 +202,32 @@ static inline void btrfs_clear_skip_qgroup(struct btrfs_trans_handle *trans)
 	delayed_refs->qgroup_to_skip = 0;
 }
 
+/*
+ * Call btrfs_abort_transaction as early as possible when an error condition is
+ * detected, that way the exact stack trace is reported for some errors.
+ */
+#define btrfs_abort_transaction(trans, errno)		\
+do {								\
+	bool first = false;					\
+	/* Report first abort since mount */			\
+	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
+			&((trans)->fs_info->fs_state))) {	\
+		first = true;					\
+		if (WARN(abort_should_print_stack(errno),	\
+			KERN_DEBUG				\
+			"BTRFS: Transaction aborted (error %d)\n",	\
+			(errno))) {					\
+			/* Stack trace printed. */			\
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
 int btrfs_end_transaction(struct btrfs_trans_handle *trans);
 struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 						   unsigned int num_items);
@@ -236,6 +262,11 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction);
 void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
 void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans);
+__cold
+void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
+			       const char *function,
+			       unsigned int line, int errno, bool first_hit);
+
 
 int __init btrfs_transaction_init(void);
 void __cold btrfs_transaction_exit(void);
-- 
2.26.3

