Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B30F476D29
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 10:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhLPJPC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 04:15:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhLPJPB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 04:15:01 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D929A2110A
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639646099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qHOpb9IKJ/G1O/x7jBHNn3r2m+9Q2azbDyUvg3mKOdA=;
        b=cF24yGDya+MbfZXHGgxmDig/iX4kbLKzk3j3n9ecG/IZDAav2ekMrUQ3xs1t62v54YuIvQ
        RnscdNpqV8U6c59cHKIDrUX0OiHVn/kEBT5cY2aLIEbcsflD9YVUtTVbJmyQXea6lTb5Vo
        G1dXg3LvcEm4OYlZUQvN+aHBh/HVTF0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D07413C1F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 09:14:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vx7MM5IDu2G2WwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 09:14:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: reject transaction creation for read-only mount except for log recovery
Date:   Thu, 16 Dec 2021 17:14:41 +0800
Message-Id: <20211216091441.53270-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following super simple script would crash btrfs at unmount time, if
CONFIG_BTRFS_ASSERT() is set.

 mkfs.btrfs -f $dev
 mount $dev $mnt
 xfs_io -f -c "pwrite 0 4k" $mnt/file
 umount $mnt
 mount -r ro $dev $mnt
 btrfs scrub start -Br $mnt
 umount $mnt

This will trigger the following ASSERT() introduced by commit
0a31daa4b602 ("btrfs: add assertion for empty list of transactions at
late stage of umount").

That patch is deifnitely not the cause, it just makes enough noise for
us developer.

[CAUSE]
We will start transaction for the following call chain during scrub:

scrub_enumerate_chunks()
|- btrfs_inc_block_group_ro()
   |- btrfs_join_transaction()

However for RO mount, there is no running transaction at all, thus
btrfs_join_transaction() will start a new transaction.

But since the fs is already read-only, there is no way to commit the
transaction, thus triggering the ASSERT().

The bug should be there for a long time. As I can still reproduce the
crash at v5.10 kernel.

[FIX]
Currently I choose to separate the log recovery code transaction with
other transactions, and reject all other transactions if the filesystem
is mounted read-only.

But I'm not sure if this is the best solution, thus this patch still
requires for comments.

There is some alternatives I can thing of:

- Don't start new transaction in btrfs_inc_block_group_ro().
  We have btrfs_join_transaction_nostart(), but even with that we still
  can't ensure there is no new transaction started and committed after
  we called btrfs_join_transaction_nostart() and got -ENOENT.

- Allow btrfs to commit empty transaction without writing any thing
  If we know this transaction contains no dirty metadata, we allow
  it to be "committed" even on RO mount, although no real data will
  be written to disk.

And even with current fix, I'm not 100% sure if we won't get a crash if
we run read-only scrub with frequently ro/rw remount.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c |  6 +++++-
 fs/btrfs/transaction.c | 14 ++++++++++++++
 fs/btrfs/transaction.h |  5 +++++
 fs/btrfs/tree-log.c    |  2 +-
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1db24e6d6d90..13391d562189 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2546,6 +2546,9 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 
 	do {
 		trans = btrfs_join_transaction(root);
+		if (IS_ERR(trans) && PTR_ERR(trans) == -EROFS)
+			return 0;
+
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 
@@ -2621,7 +2624,8 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 	struct btrfs_space_info *sinfo = cache->space_info;
 	u64 num_bytes;
 
-	BUG_ON(!cache->ro);
+	if (cache->ro)
+		return;
 
 	spin_lock(&sinfo->lock);
 	spin_lock(&cache->lock);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 03de89b45f27..306eaeb41ec9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -591,6 +591,13 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	if (BTRFS_FS_ERROR(fs_info))
 		return ERR_PTR(-EROFS);
 
+	/*
+	 * If the FS is mounted RO, we only allow transaction for log recovery,
+	 * no regular transaction can be started.
+	 */
+	if (sb_rdonly(fs_info->sb) && !(type & __TRANS_START_IGNORE_RO))
+		return ERR_PTR(-EROFS);
+
 	if (current->journal_info) {
 		WARN_ON(type & TRANS_EXTWRITERS);
 		h = current->journal_info;
@@ -781,6 +788,13 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 				 BTRFS_RESERVE_FLUSH_ALL, true);
 }
 
+struct btrfs_trans_handle *btrfs_start_transaction_log_recover(
+			struct btrfs_root *root, unsigned int num_items)
+{
+	return start_transaction(root, num_items, TRANS_START_LOG_RECOVER,
+				 BTRFS_RESERVE_FLUSH_ALL, true);
+}
+
 struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 					struct btrfs_root *root,
 					unsigned int num_items)
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 1852ed9de7fd..24a743d91eff 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -106,8 +106,11 @@ struct btrfs_transaction {
 #define __TRANS_JOIN_NOLOCK	(1U << 12)
 #define __TRANS_DUMMY		(1U << 13)
 #define __TRANS_JOIN_NOSTART	(1U << 14)
+#define __TRANS_START_IGNORE_RO	(1U << 15)
 
 #define TRANS_START		(__TRANS_START | __TRANS_FREEZABLE)
+#define TRANS_START_LOG_RECOVER	(__TRANS_START | __TRANS_FREEZABLE | \
+				 __TRANS_START_IGNORE_RO)
 #define TRANS_ATTACH		(__TRANS_ATTACH)
 #define TRANS_JOIN		(__TRANS_JOIN | __TRANS_FREEZABLE)
 #define TRANS_JOIN_NOLOCK	(__TRANS_JOIN_NOLOCK)
@@ -201,6 +204,8 @@ static inline void btrfs_clear_skip_qgroup(struct btrfs_trans_handle *trans)
 int btrfs_end_transaction(struct btrfs_trans_handle *trans);
 struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
 						   unsigned int num_items);
+struct btrfs_trans_handle *btrfs_start_transaction_log_recover(
+			struct btrfs_root *root, unsigned int num_items);
 struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 					struct btrfs_root *root,
 					unsigned int num_items);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 69f901813ea8..42369fa9a038 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6478,7 +6478,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 	set_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
 
-	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	trans = btrfs_start_transaction_log_recover(fs_info->tree_root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto error;
-- 
2.34.1

