Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE65A099A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 09:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiHYHJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiHYHJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 03:09:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6039E2C2
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 00:09:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5881433934
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 07:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661411371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1iE0tpNlzgALWU0T27m9cXm28re76VzBwOMcNxpDbGY=;
        b=r9S9w1zACDRYG/YFVqx4hY6FEymUcATQu8zLUKyz9PPKcvadA7woyEMKETlh1CIrHpMBvl
        3F8o5C05SoL1KsTZzNsiDxcCHhEvV8VQ2jSfxDBIHijf85jsAllDKJZx0Ea9+CvZJOw866
        9225QD2QEbvuMbNtv21y2hz4ollCqUo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B20C313A47
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 07:09:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oERMHyogB2PZRgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 07:09:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: dump all space infos if we abort transaction due to ENOSPC
Date:   Thu, 25 Aug 2022 15:09:10 +0800
Message-Id: <81564013f3f6a7997f9e2ca13f2a42431c0a55eb.1661410915.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661410915.git.wqu@suse.com>
References: <cover.1661410915.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have hit some transaction abort due to -ENOSPC internally.

Normally we should always reserve enough space for metadata for every
transaction, thus hitting -ENOSPC should really indicate some cases we
didn't expect.

But unfrotunately current error reporting will only give a kernel
wanring and backtrace, not really helpful to debug what's causing the
problem.

And debug_enospc can only help when user can reproduce the problem, but
under most cases, such transaction abort by -ENOSPC is really hard to
reproduce.

So this patch will dump all space infos (data, metadata, system) when we
abort the first transaction with -ENOSPC.

This should at least provide some clue to us.

The example of a dump would look like this:

 ------------[ cut here ]------------
 BTRFS: Transaction aborted (error -28)
 WARNING: CPU: 8 PID: 3366 at fs/btrfs/transaction.c:2137 btrfs_commit_transaction+0xf81/0xfb0 [btrfs]
 <call trace skipped>
 ---[ end trace 0000000000000000 ]---
 BTRFS info (device dm-1: state A): dumping space info:
 BTRFS info (device dm-1: state A): space_info DATA has 6791168 free, is not full
 BTRFS info (device dm-1: state A): space_info total=8388608, used=1597440, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
 BTRFS info (device dm-1: state A): space_info METADATA has 257114112 free, is not full
 BTRFS info (device dm-1: state A): space_info total=268435456, used=131072, pinned=180224, reserved=65536, may_use=10878976, readonly=65536 zone_unusable=0
 BTRFS info (device dm-1: state A): space_info SYS has 8372224 free, is not full
 BTRFS info (device dm-1: state A): space_info total=8388608, used=16384, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
 BTRFS info (device dm-1: state A): global_block_rsv: size 3670016 reserved 3670016
 BTRFS info (device dm-1: state A): trans_block_rsv: size 0 reserved 0
 BTRFS info (device dm-1: state A): chunk_block_rsv: size 0 reserved 0
 BTRFS info (device dm-1: state A): delayed_block_rsv: size 4063232 reserved 4063232
 BTRFS info (device dm-1: state A): delayed_refs_rsv: size 3145728 reserved 3145728
 BTRFS: error (device dm-1: state A) in btrfs_commit_transaction:2137: errno=-28 No space left
 BTRFS info (device dm-1: state EA): forced readonly

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h      |  6 ++++--
 fs/btrfs/space-info.c | 31 ++++++++++++++++++++++++-------
 fs/btrfs/space-info.h |  2 ++
 fs/btrfs/super.c      |  4 +++-
 4 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3dc30f5e6fd0..8781f86aa534 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3830,7 +3830,7 @@ const char * __attribute_const__ btrfs_decode_error(int errno);
 __cold
 void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 			       const char *function,
-			       unsigned int line, int errno);
+			       unsigned int line, int errno, bool first_hit);
 
 /*
  * Call btrfs_abort_transaction as early as possible when an error condition is
@@ -3838,9 +3838,11 @@ void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
  */
 #define btrfs_abort_transaction(trans, errno)		\
 do {								\
+	bool first = false;					\
 	/* Report first abort since mount */			\
 	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
 			&((trans)->fs_info->fs_state))) {	\
+		first = true;					\
 		if ((errno) != -EIO && (errno) != -EROFS) {		\
 			WARN(1, KERN_DEBUG				\
 			"BTRFS: Transaction aborted (error %d)\n",	\
@@ -3852,7 +3854,7 @@ do {								\
 		}						\
 	}							\
 	__btrfs_abort_transaction((trans), __func__,		\
-				  __LINE__, (errno));		\
+				  __LINE__, (errno), first);	\
 } while (0)
 
 #ifdef CONFIG_PRINTK_INDEX
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 1f524b62313c..b0a9ba34eca2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -492,6 +492,15 @@ static const char *space_info_flag_to_str(struct btrfs_space_info *space_info)
 	}
 }
 
+static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
+{
+	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
+	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
+	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
+	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
+	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
+}
+
 static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *info)
 {
@@ -508,13 +517,6 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		info->total_bytes, info->bytes_used, info->bytes_pinned,
 		info->bytes_reserved, info->bytes_may_use,
 		info->bytes_readonly, info->bytes_zone_unusable);
-
-	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
-
 }
 
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
@@ -526,6 +528,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 
 	spin_lock(&info->lock);
 	__btrfs_dump_space_info(fs_info, info);
+	dump_global_block_rsv(fs_info);
 	spin_unlock(&info->lock);
 
 	if (!dump_block_groups)
@@ -1770,3 +1773,17 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 	}
 	return ret;
 }
+
+/* Dump all the space infos when we abort a transaction due to ENOSPC. */
+__cold void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *space_info;
+
+	btrfs_info(fs_info, "dumping space info:");
+	list_for_each_entry(space_info, &fs_info->space_info, list) {
+		spin_lock(&space_info->lock);
+		__btrfs_dump_space_info(fs_info, space_info);
+		spin_unlock(&space_info->lock);
+	}
+	dump_global_block_rsv(fs_info);
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 2039096803ed..8f5948740941 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -157,4 +157,6 @@ static inline void btrfs_space_info_free_bytes_may_use(
 }
 int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush);
+void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
+
 #endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f1c6ca59299e..019141371c14 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -346,12 +346,14 @@ void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
 __cold
 void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 			       const char *function,
-			       unsigned int line, int errno)
+			       unsigned int line, int errno, bool first_hit)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
 	WRITE_ONCE(trans->aborted, errno);
 	WRITE_ONCE(trans->transaction->aborted, errno);
+	if (first_hit && errno == -ENOSPC)
+		btrfs_dump_space_info_for_trans_abort(fs_info);
 	/* Wake up anybody who may be waiting on this transaction */
 	wake_up(&fs_info->transaction_wait);
 	wake_up(&fs_info->transaction_blocked_wait);
-- 
2.37.2

