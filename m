Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002CD575BE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiGOG6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiGOG6N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 02:58:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073459241
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 23:58:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C33721FACC
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657868290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQMniJ1zDblsrsJ2juimLo90qaL/athyHUyOEUN9vYQ=;
        b=fSvlgPYFyuqJoxt4PM4BR9+m78X3HYgXk9UNvl0ZVegVx45pey+Gu5J6cTUNeXltFblEbN
        Du0r2XISwoF4xdyFDJo5nS9h5/ick5fXRG0uDxxqzK/VVrl6aXcJDHMryRrXUbgfB5WL50
        0w/PwIz4gdDcCVLfzTDidigt1zqUqqQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 163EE13754
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6EljMwEQ0WKtfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: dump all space infos if we abort transaction due to ENOSPC
Date:   Fri, 15 Jul 2022 14:57:47 +0800
Message-Id: <e37365946a5b98e5c93e8d0169ba0e19765a3418.1657867842.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657867842.git.wqu@suse.com>
References: <cover.1657867842.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 <skip stack dump>
 ---[ end trace 0000000000000000 ]---
 BTRFS info (device dm-1: state A): dumpping space info:
 BTRFS info (device dm-1: state A): space_info DATA has 1175552 free, is not full
 BTRFS info (device dm-1: state A):   total:         8388608
 BTRFS info (device dm-1: state A):   used:          7163904
 BTRFS info (device dm-1: state A):   pinned:        49152
 BTRFS info (device dm-1: state A):   reserved:      0
 BTRFS info (device dm-1: state A):   may_use:       0
 BTRFS info (device dm-1: state A):   read_only:     0
 BTRFS info (device dm-1: state A): space_info META has 263798784 free, is not full
 BTRFS info (device dm-1: state A):   total:         268435456
 BTRFS info (device dm-1: state A):   used:          180224
 BTRFS info (device dm-1: state A):   pinned:        196608
 BTRFS info (device dm-1: state A):   reserved:      0
 BTRFS info (device dm-1: state A):   may_use:       4194304
 BTRFS info (device dm-1: state A):   read_only:     65536
 BTRFS info (device dm-1: state A): space_info SYS has 8372224 free, is not full
 BTRFS info (device dm-1: state A):   total:         8388608
 BTRFS info (device dm-1: state A):   used:          16384
 BTRFS info (device dm-1: state A):   pinned:        0
 BTRFS info (device dm-1: state A):   reserved:      0
 BTRFS info (device dm-1: state A):   may_use:       0
 BTRFS info (device dm-1: state A):   read_only:     0
 BTRFS info (device dm-1: state A): dumpping metadata reservation:
 BTRFS info (device dm-1: state A):   global:          (3670016/3670016)
 BTRFS info (device dm-1: state A):   trans:           (0/0)
 BTRFS info (device dm-1: state A):   chuuk:           (0/0)
 BTRFS info (device dm-1: state A):   delayed_inode:   (0/0)
 BTRFS info (device dm-1: state A):   delayed_refs:    (524288/524288)
 BTRFS: error (device dm-1: state A) in cleanup_transaction:1971: errno=-28 No space left
 BTRFS info (device dm-1: state EA): forced readonly

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h      |  6 ++++--
 fs/btrfs/space-info.c | 46 ++++++++++++++++++++++++++++++++-----------
 fs/btrfs/space-info.h |  2 ++
 fs/btrfs/super.c      |  4 +++-
 4 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e2569f84aab..3d6fd7f6b339 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3739,7 +3739,7 @@ const char * __attribute_const__ btrfs_decode_error(int errno);
 __cold
 void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
 			       const char *function,
-			       unsigned int line, int errno);
+			       unsigned int line, int errno, bool first_hit);
 
 /*
  * Call btrfs_abort_transaction as early as possible when an error condition is
@@ -3747,9 +3747,11 @@ void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
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
@@ -3761,7 +3763,7 @@ do {								\
 		}						\
 	}							\
 	__btrfs_abort_transaction((trans), __func__,		\
-				  __LINE__, (errno));		\
+				  __LINE__, (errno), first);	\
 } while (0)
 
 #ifdef CONFIG_PRINTK_INDEX
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6bbf95e8e4f7..6a62cc8dc31a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -441,12 +441,12 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 	}
 }
 
-#define DUMP_BLOCK_RSV(fs_info, member, name)				\
+#define DUMP_BLOCK_RSV(fs_info, member, name, prefix)			\
 do {									\
 	struct btrfs_block_rsv *__rsv = &(fs_info)->member;		\
 	spin_lock(&__rsv->lock);					\
-	btrfs_info(fs_info, "%-16s (%llu/%llu)",			\
-		   name, __rsv->reserved, __rsv->size);			\
+	btrfs_info(fs_info, "%s%-16s (%llu/%llu)",			\
+		   prefix, name, __rsv->reserved, __rsv->size);		\
 	spin_unlock(&__rsv->lock);					\
 } while (0)
 
@@ -465,7 +465,8 @@ static const char *space_info_flag_to_str(struct btrfs_space_info *space_info)
 }
 
 static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *info)
+				    struct btrfs_space_info *info,
+				    bool dump_block_rsvs)
 {
 	const char *flag_str = space_info_flag_to_str(info);
 	lockdep_assert_held(&info->lock);
@@ -485,11 +486,14 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		btrfs_info(fs_info,
 			    "  zone_unusable: %llu", info->bytes_zone_unusable);
 
-	DUMP_BLOCK_RSV(fs_info, global_block_rsv, "global:");
-	DUMP_BLOCK_RSV(fs_info, trans_block_rsv, "trans:");
-	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv, "chunk:");
-	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv, "delayed_inode:");
-	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv, "delayed_refs:");
+	if (!dump_block_rsvs)
+		return;
+
+	DUMP_BLOCK_RSV(fs_info, global_block_rsv, "global:", "");
+	DUMP_BLOCK_RSV(fs_info, trans_block_rsv, "trans:", "");
+	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv, "chunk:", "");
+	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv, "delayed_inode:", "");
+	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv, "delayed_refs:", "");
 }
 
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
@@ -500,7 +504,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	int index = 0;
 
 	spin_lock(&info->lock);
-	__btrfs_dump_space_info(fs_info, info);
+	__btrfs_dump_space_info(fs_info, info, true);
 	spin_unlock(&info->lock);
 
 	if (!dump_block_groups)
@@ -955,7 +959,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 
 	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
-		__btrfs_dump_space_info(fs_info, space_info);
+		__btrfs_dump_space_info(fs_info, space_info, true);
 	}
 
 	while (!list_empty(&space_info->tickets) &&
@@ -1711,3 +1715,23 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 	}
 	return ret;
 }
+
+/* Dump all the space infos when we abort a transaction due to ENOSPC. */
+__cold void btrfs_dump_fs_space_info(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *space_info;
+
+	btrfs_info(fs_info, "dumpping space info:");
+	list_for_each_entry(space_info, &fs_info->space_info, list) {
+		spin_lock(&space_info->lock);
+		__btrfs_dump_space_info(fs_info, space_info, false);
+		spin_unlock(&space_info->lock);
+	}
+	btrfs_info(fs_info, "dumpping metadata reservation:");
+
+	DUMP_BLOCK_RSV(fs_info, global_block_rsv, "global:", "  ");
+	DUMP_BLOCK_RSV(fs_info, trans_block_rsv, "trans:", "  ");
+	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv, "chunk:", "  ");
+	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv, "delayed_inode:", "  ");
+	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv, "delayed_refs:", "  ");
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index e7de24a529cf..01287a7a22a4 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -157,4 +157,6 @@ static inline void btrfs_space_info_free_bytes_may_use(
 }
 int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush);
+void btrfs_dump_fs_space_info(struct btrfs_fs_info *fs_info);
+
 #endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4c7089b1681b..f6bc8aa00f44 100644
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
+		btrfs_dump_fs_space_info(fs_info);
 	/* Wake up anybody who may be waiting on this transaction */
 	wake_up(&fs_info->transaction_wait);
 	wake_up(&fs_info->transaction_blocked_wait);
-- 
2.37.0

