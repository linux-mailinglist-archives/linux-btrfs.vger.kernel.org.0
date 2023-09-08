Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F191B798EE2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjIHTQu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjIHTQu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 15:16:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83448E
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:16:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 41FFE2204A;
        Fri,  8 Sep 2023 19:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694200600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HMMBr0rkfEL/PO3wVZGgoQF3A8OD3Emi7JLanvdPDDM=;
        b=CJQEkuotA9iPCH/k9Cnj0ADcrdPrwx436j5o6U5fbzG/gqYtqkVL2Lnp+fOYlWtYE85qZb
        n2ecy64iF42SzV4p/nxAur13OlbGWX5w5Hq2s3l++pB5/FACnhuqJA6/r5QrLEE/D5Iipu
        RDIMtS8jS91Tl9zaOU4ayGvy1pggqyE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 359972C142;
        Fri,  8 Sep 2023 19:16:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2CF16DA8C5; Fri,  8 Sep 2023 21:10:07 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: rename errno identifiers to error
Date:   Fri,  8 Sep 2023 21:10:06 +0200
Message-ID: <20230908191006.31940-1-dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We sync the kernel files to userspace and the 'errno' symbol is defined
by standard library, which does not matter in kernel but the parameters
or local variables could clash. Rename them all.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.h     |  4 ++--
 fs/btrfs/compression.c |  6 +++---
 fs/btrfs/ctree.c       |  4 ++--
 fs/btrfs/messages.c    | 24 ++++++++++++------------
 fs/btrfs/messages.h    | 14 +++++++-------
 fs/btrfs/transaction.c | 10 +++++-----
 fs/btrfs/transaction.h | 14 +++++++-------
 7 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 79742935399f..3b077d10bbc0 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -533,9 +533,9 @@ void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 void btrfs_backref_release_cache(struct btrfs_backref_cache *cache);
 
 static inline void btrfs_backref_panic(struct btrfs_fs_info *fs_info,
-				       u64 bytenr, int errno)
+				       u64 bytenr, int error)
 {
-	btrfs_panic(fs_info, errno,
+	btrfs_panic(fs_info, error,
 		    "Inconsistency in backref cache found at offset %llu",
 		    bytenr);
 }
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8818ed5c390f..19b22b4653c8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -193,12 +193,12 @@ static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 	unsigned long index = cb->start >> PAGE_SHIFT;
 	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
 	struct folio_batch fbatch;
-	const int errno = blk_status_to_errno(cb->bbio.bio.bi_status);
+	const int error = blk_status_to_errno(cb->bbio.bio.bi_status);
 	int i;
 	int ret;
 
-	if (errno)
-		mapping_set_error(inode->i_mapping, errno);
+	if (error)
+		mapping_set_error(inode->i_mapping, error);
 
 	folio_batch_init(&fbatch);
 	while (index <= end_index) {
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6d18f6d5a8b3..c362472a112f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -230,9 +230,9 @@ noinline void btrfs_release_path(struct btrfs_path *p)
  * cause could be a bug, eg. due to ENOSPC, and not for common errors that are
  * caused by external factors.
  */
-bool __cold abort_should_print_stack(int errno)
+bool __cold abort_should_print_stack(int error)
 {
-	switch (errno) {
+	switch (error) {
 	case -EIO:
 	case -EROFS:
 	case -ENOMEM:
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 5be060cb6ef5..b8f9c9e56c8c 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -72,11 +72,11 @@ static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
  *        over the error.  Each subsequent error that doesn't have any context
  *        of the original error should use EROFS when handling BTRFS_FS_STATE_ERROR.
  */
-const char * __attribute_const__ btrfs_decode_error(int errno)
+const char * __attribute_const__ btrfs_decode_error(int error)
 {
 	char *errstr = "unknown";
 
-	switch (errno) {
+	switch (error) {
 	case -ENOENT:		/* -2 */
 		errstr = "No such entry";
 		break;
@@ -115,7 +115,7 @@ const char * __attribute_const__ btrfs_decode_error(int errno)
  */
 __cold
 void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
-		       unsigned int line, int errno, const char *fmt, ...)
+		       unsigned int line, int error, const char *fmt, ...)
 {
 	struct super_block *sb = fs_info->sb;
 #ifdef CONFIG_PRINTK
@@ -132,11 +132,11 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	 * Special case: if the error is EROFS, and we're already under
 	 * SB_RDONLY, then it is safe here.
 	 */
-	if (errno == -EROFS && sb_rdonly(sb))
+	if (error == -EROFS && sb_rdonly(sb))
 		return;
 
 #ifdef CONFIG_PRINTK
-	errstr = btrfs_decode_error(errno);
+	errstr = btrfs_decode_error(error);
 	btrfs_state_to_string(fs_info, statestr);
 	if (fmt) {
 		struct va_format vaf;
@@ -147,11 +147,11 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 		vaf.va = &args;
 
 		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s (%pV)\n",
-			sb->s_id, statestr, function, line, errno, errstr, &vaf);
+			sb->s_id, statestr, function, line, error, errstr, &vaf);
 		va_end(args);
 	} else {
 		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s\n",
-			sb->s_id, statestr, function, line, errno, errstr);
+			sb->s_id, statestr, function, line, error, errstr);
 	}
 #endif
 
@@ -159,7 +159,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	 * Today we only save the error info to memory.  Long term we'll also
 	 * send it down to the disk.
 	 */
-	WRITE_ONCE(fs_info->fs_error, errno);
+	WRITE_ONCE(fs_info->fs_error, error);
 
 	/* Don't go through full error handling during mount. */
 	if (!(sb->s_flags & SB_BORN))
@@ -288,7 +288,7 @@ void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
  */
 __cold
 void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
-		   unsigned int line, int errno, const char *fmt, ...)
+		   unsigned int line, int error, const char *fmt, ...)
 {
 	char *s_id = "<unknown>";
 	const char *errstr;
@@ -301,13 +301,13 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
 	va_start(args, fmt);
 	vaf.va = &args;
 
-	errstr = btrfs_decode_error(errno);
+	errstr = btrfs_decode_error(error);
 	if (fs_info && (btrfs_test_opt(fs_info, PANIC_ON_FATAL_ERROR)))
 		panic(KERN_CRIT "BTRFS panic (device %s) in %s:%d: %pV (errno=%d %s)\n",
-			s_id, function, line, &vaf, errno, errstr);
+			s_id, function, line, &vaf, error, errstr);
 
 	btrfs_crit(fs_info, "panic in %s:%d: %pV (errno=%d %s)",
-		   function, line, &vaf, errno, errstr);
+		   function, line, &vaf, error, errstr);
 	va_end(args);
 	/* Caller calls BUG() */
 }
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 1ae6f8e23e07..4d04c1fa5899 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -184,25 +184,25 @@ do {								\
 __printf(5, 6)
 __cold
 void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
-		     unsigned int line, int errno, const char *fmt, ...);
+		     unsigned int line, int error, const char *fmt, ...);
 
-const char * __attribute_const__ btrfs_decode_error(int errno);
+const char * __attribute_const__ btrfs_decode_error(int error);
 
-#define btrfs_handle_fs_error(fs_info, errno, fmt, args...)		\
+#define btrfs_handle_fs_error(fs_info, error, fmt, args...)		\
 	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
-				(errno), fmt, ##args)
+				(error), fmt, ##args)
 
 __printf(5, 6)
 __cold
 void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
-		   unsigned int line, int errno, const char *fmt, ...);
+		   unsigned int line, int error, const char *fmt, ...);
 /*
  * If BTRFS_MOUNT_PANIC_ON_FATAL_ERROR is in mount_opt, __btrfs_panic
  * will panic().  Otherwise we BUG() here.
  */
-#define btrfs_panic(fs_info, errno, fmt, args...)			\
+#define btrfs_panic(fs_info, error, fmt, args...)			\
 do {									\
-	__btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args);	\
+	__btrfs_panic(fs_info, __func__, __LINE__, error, fmt, ##args);	\
 	BUG();								\
 } while (0)
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 035e7f5747cd..d409e1741a2e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2654,18 +2654,18 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
  */
 void __cold __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 				      const char *function,
-				      unsigned int line, int errno, bool first_hit)
+				      unsigned int line, int error, bool first_hit)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
-	WRITE_ONCE(trans->aborted, errno);
-	WRITE_ONCE(trans->transaction->aborted, errno);
-	if (first_hit && errno == -ENOSPC)
+	WRITE_ONCE(trans->aborted, error);
+	WRITE_ONCE(trans->transaction->aborted, error);
+	if (first_hit && error == -ENOSPC)
 		btrfs_dump_space_info_for_trans_abort(fs_info);
 	/* Wake up anybody who may be waiting on this transaction */
 	wake_up(&fs_info->transaction_wait);
 	wake_up(&fs_info->transaction_blocked_wait);
-	__btrfs_handle_fs_error(fs_info, function, line, errno, NULL);
+	__btrfs_handle_fs_error(fs_info, function, line, error, NULL);
 }
 
 int __init btrfs_transaction_init(void)
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 6b309f8a99a8..eca2f81d9e0b 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -200,32 +200,32 @@ static inline void btrfs_clear_skip_qgroup(struct btrfs_trans_handle *trans)
 	delayed_refs->qgroup_to_skip = 0;
 }
 
-bool __cold abort_should_print_stack(int errno);
+bool __cold abort_should_print_stack(int error);
 
 /*
  * Call btrfs_abort_transaction as early as possible when an error condition is
  * detected, that way the exact stack trace is reported for some errors.
  */
-#define btrfs_abort_transaction(trans, errno)		\
+#define btrfs_abort_transaction(trans, error)		\
 do {								\
 	bool first = false;					\
 	/* Report first abort since mount */			\
 	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
 			&((trans)->fs_info->fs_state))) {	\
 		first = true;					\
-		if (WARN(abort_should_print_stack(errno),	\
+		if (WARN(abort_should_print_stack(error),	\
 			KERN_ERR				\
 			"BTRFS: Transaction aborted (error %d)\n",	\
-			(errno))) {					\
+			(error))) {					\
 			/* Stack trace printed. */			\
 		} else {						\
 			btrfs_debug((trans)->fs_info,			\
 				    "Transaction aborted (error %d)", \
-				  (errno));			\
+				  (error));			\
 		}						\
 	}							\
 	__btrfs_abort_transaction((trans), __func__,		\
-				  __LINE__, (errno), first);	\
+				  __LINE__, (error), first);	\
 } while (0)
 
 int btrfs_end_transaction(struct btrfs_trans_handle *trans);
@@ -264,7 +264,7 @@ void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
 void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans);
 void __cold __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 				      const char *function,
-				      unsigned int line, int errno, bool first_hit);
+				      unsigned int line, int error, bool first_hit);
 
 int __init btrfs_transaction_init(void);
 void __cold btrfs_transaction_exit(void);
-- 
2.41.0

