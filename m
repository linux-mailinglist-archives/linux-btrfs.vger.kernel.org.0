Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4794C149
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFSTML (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 15:12:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42651 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFSTML (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 15:12:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id b18so244760qkc.9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=LFqTbyeDts3mb7aRWKhK6QDwhYXFTlc+lnPgBq0ZynY=;
        b=DOXpCtl9kJomTHBXSaLwdyPjL7Zwg8xoXrGu5ItTgcmXQnCSPZoMZqMXjaYPAIc/NQ
         ttFsk/tMJu43XBELBFRPEwZM4K/L0CkxXaUaslh+aInzfjdRsIRVsSHwjyInXJAgVdmV
         RooiYl2U1G8wzUY0aeTCWOBH3S+C7LfmURxVdRn5XKtNc5jHfZ4lkXTiRyvRhuh0GdWP
         LT0MLCZXkImBWBkbOWggNk0irm2Y3LauT3sTR4JRnDSleHA76scTfqXlqsfO2d6R7yOX
         xvofA99H1xF+7dCTq0HXdYvbXiXVoMoWQgPYII8Kmz0pCC1Oir/IxkszuIpoV64i95Ip
         GPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=LFqTbyeDts3mb7aRWKhK6QDwhYXFTlc+lnPgBq0ZynY=;
        b=P8bg4+fgzpvQEWZL4lVBXUxOXv+bb4doyCiNRRCYSyHIRjjI9ADECT+FtB98xI6dl7
         S+fr0bpw//ditrdUVDsbK6Wy/dSzL7xEIrdLmWC9tIKLNEKyMLZGhUWTOD1BwHCsNGjI
         IKsgVPC8hiygcXi0ZMaiolvTX9YPSgwQDaYVYLEE0qt0URmKlqS1OJrBUvwVghXPUsZK
         ctmvSkMgDJXVAbK9IR3ZaXiCn+bAyDK9xOUePDyRwNVgnt4ybYTYnh9jxqoG/cG6yET9
         5NiOGp88W7iJX/PklDSD4uiuCMSU9i1kQCDt8H5/uJXgrhDVlfyc1H+aHy0bx+6/Rhtg
         p5Ig==
X-Gm-Message-State: APjAAAXshN/MXrS+BVHcKXMy0X97qGWb0N9HbPI6UAbSJoAQTAwBfFNR
        tE1WJiNIIqyUluVhoXyfpcEZegCcXf5gJQ==
X-Google-Smtp-Source: APXvYqzWcVRcxlWS3wLKx/+WNItzF4d0cCxW64TGi1BcVTz778YxK00rTpxLMZYE62oSPlckhKCnYg==
X-Received: by 2002:a37:47d1:: with SMTP id u200mr67369616qka.21.1560971528834;
        Wed, 19 Jun 2019 12:12:08 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o6sm12817014qtc.47.2019.06.19.12.12.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 12:12:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: migrate the delalloc space stuff to it's own home
Date:   Wed, 19 Jun 2019 15:12:00 -0400
Message-Id: <20190619191201.16689-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619191201.16689-1-josef@toxicpanda.com>
References: <20190619191201.16689-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have code for data and metadata reservations for delalloc.  There's
quite a bit of code here, and it's used in a lot of places so I've
separated it out to it's own file.  inode.c and file.c are already
pretty large, and this code is complicated enough to live in its own
space.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/ctree.h            |  14 --
 fs/btrfs/delalloc-space.c   | 497 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/delalloc-space.h   |  25 +++
 fs/btrfs/extent-tree.c      | 486 +------------------------------------------
 fs/btrfs/file.c             |   1 +
 fs/btrfs/free-space-cache.c |   1 +
 fs/btrfs/inode-map.c        |   1 +
 fs/btrfs/inode.c            |   1 +
 fs/btrfs/ioctl.c            |   1 +
 fs/btrfs/ordered-data.c     |   1 +
 fs/btrfs/relocation.c       |   1 +
 12 files changed, 531 insertions(+), 500 deletions(-)
 create mode 100644 fs/btrfs/delalloc-space.c
 create mode 100644 fs/btrfs/delalloc-space.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 032700ae7704..76a843198bcb 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -11,7 +11,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
-	   block-rsv.o
+	   block-rsv.o delalloc-space.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index afd329184e36..73e28d9c14bd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2742,16 +2742,6 @@ enum btrfs_chunk_alloc_enum {
 
 int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 		      enum btrfs_chunk_alloc_enum force);
-int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes);
-int btrfs_check_data_free_space(struct inode *inode,
-			struct extent_changeset **reserved, u64 start, u64 len);
-void btrfs_free_reserved_data_space(struct inode *inode,
-			struct extent_changeset *reserved, u64 start, u64 len);
-void btrfs_delalloc_release_space(struct inode *inode,
-				  struct extent_changeset *reserved,
-				  u64 start, u64 len, bool qgroup_free);
-void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
-					    u64 len);
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
@@ -2761,10 +2751,6 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes,
 				    bool qgroup_free);
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
-void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
-				     bool qgroup_free);
-int btrfs_delalloc_reserve_space(struct inode *inode,
-			struct extent_changeset **reserved, u64 start, u64 len);
 int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
 void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
new file mode 100644
index 000000000000..260c152d0d84
--- /dev/null
+++ b/fs/btrfs/delalloc-space.c
@@ -0,0 +1,497 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Facebook.  All rights reserved.
+ */
+
+#include "ctree.h"
+#include "delalloc-space.h"
+#include "block-rsv.h"
+#include "btrfs_inode.h"
+#include "space-info.h"
+#include "transaction.h"
+#include "qgroup.h"
+
+int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
+	u64 used;
+	int ret = 0;
+	int need_commit = 2;
+	int have_pinned_space;
+
+	/* make sure bytes are sectorsize aligned */
+	bytes = ALIGN(bytes, fs_info->sectorsize);
+
+	if (btrfs_is_free_space_inode(inode)) {
+		need_commit = 0;
+		ASSERT(current->journal_info);
+	}
+
+again:
+	/* make sure we have enough space to handle the data first */
+	spin_lock(&data_sinfo->lock);
+	used = btrfs_space_info_used(data_sinfo, true);
+
+	if (used + bytes > data_sinfo->total_bytes) {
+		struct btrfs_trans_handle *trans;
+
+		/*
+		 * if we don't have enough free bytes in this space then we need
+		 * to alloc a new chunk.
+		 */
+		if (!data_sinfo->full) {
+			u64 alloc_target;
+
+			data_sinfo->force_alloc = CHUNK_ALLOC_FORCE;
+			spin_unlock(&data_sinfo->lock);
+
+			alloc_target = btrfs_data_alloc_profile(fs_info);
+			/*
+			 * It is ugly that we don't call nolock join
+			 * transaction for the free space inode case here.
+			 * But it is safe because we only do the data space
+			 * reservation for the free space cache in the
+			 * transaction context, the common join transaction
+			 * just increase the counter of the current transaction
+			 * handler, doesn't try to acquire the trans_lock of
+			 * the fs.
+			 */
+			trans = btrfs_join_transaction(root);
+			if (IS_ERR(trans))
+				return PTR_ERR(trans);
+
+			ret = btrfs_chunk_alloc(trans, alloc_target,
+						CHUNK_ALLOC_NO_FORCE);
+			btrfs_end_transaction(trans);
+			if (ret < 0) {
+				if (ret != -ENOSPC)
+					return ret;
+				else {
+					have_pinned_space = 1;
+					goto commit_trans;
+				}
+			}
+
+			goto again;
+		}
+
+		/*
+		 * If we don't have enough pinned space to deal with this
+		 * allocation, and no removed chunk in current transaction,
+		 * don't bother committing the transaction.
+		 */
+		have_pinned_space = __percpu_counter_compare(
+			&data_sinfo->total_bytes_pinned,
+			used + bytes - data_sinfo->total_bytes,
+			BTRFS_TOTAL_BYTES_PINNED_BATCH);
+		spin_unlock(&data_sinfo->lock);
+
+		/* commit the current transaction and try again */
+commit_trans:
+		if (need_commit) {
+			need_commit--;
+
+			if (need_commit > 0) {
+				btrfs_start_delalloc_roots(fs_info, -1);
+				btrfs_wait_ordered_roots(fs_info, U64_MAX, 0,
+							 (u64)-1);
+			}
+
+			trans = btrfs_join_transaction(root);
+			if (IS_ERR(trans))
+				return PTR_ERR(trans);
+			if (have_pinned_space >= 0 ||
+			    test_bit(BTRFS_TRANS_HAVE_FREE_BGS,
+				     &trans->transaction->flags) ||
+			    need_commit > 0) {
+				ret = btrfs_commit_transaction(trans);
+				if (ret)
+					return ret;
+				/*
+				 * The cleaner kthread might still be doing iput
+				 * operations. Wait for it to finish so that
+				 * more space is released.  We don't need to
+				 * explicitly run the delayed iputs here because
+				 * the commit_transaction would have woken up
+				 * the cleaner.
+				 */
+				ret = btrfs_wait_on_delayed_iputs(fs_info);
+				if (ret)
+					return ret;
+				goto again;
+			} else {
+				btrfs_end_transaction(trans);
+			}
+		}
+
+		trace_btrfs_space_reservation(fs_info,
+					      "space_info:enospc",
+					      data_sinfo->flags, bytes, 1);
+		return -ENOSPC;
+	}
+	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
+	trace_btrfs_space_reservation(fs_info, "space_info",
+				      data_sinfo->flags, bytes, 1);
+	spin_unlock(&data_sinfo->lock);
+
+	return 0;
+}
+
+int btrfs_check_data_free_space(struct inode *inode,
+			struct extent_changeset **reserved, u64 start, u64 len)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	int ret;
+
+	/* align the range */
+	len = round_up(start + len, fs_info->sectorsize) -
+	      round_down(start, fs_info->sectorsize);
+	start = round_down(start, fs_info->sectorsize);
+
+	ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode), len);
+	if (ret < 0)
+		return ret;
+
+	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
+	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
+	if (ret < 0)
+		btrfs_free_reserved_data_space_noquota(inode, start, len);
+	else
+		ret = 0;
+	return ret;
+}
+
+/*
+ * Called if we need to clear a data reservation for this inode
+ * Normally in a error case.
+ *
+ * This one will *NOT* use accurate qgroup reserved space API, just for case
+ * which we can't sleep and is sure it won't affect qgroup reserved space.
+ * Like clear_bit_hook().
+ */
+void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
+					    u64 len)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_space_info *data_sinfo;
+
+	/* Make sure the range is aligned to sectorsize */
+	len = round_up(start + len, fs_info->sectorsize) -
+	      round_down(start, fs_info->sectorsize);
+	start = round_down(start, fs_info->sectorsize);
+
+	data_sinfo = fs_info->data_sinfo;
+	spin_lock(&data_sinfo->lock);
+	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
+	trace_btrfs_space_reservation(fs_info, "space_info",
+				      data_sinfo->flags, len, 0);
+	spin_unlock(&data_sinfo->lock);
+}
+
+/*
+ * Called if we need to clear a data reservation for this inode
+ * Normally in a error case.
+ *
+ * This one will handle the per-inode data rsv map for accurate reserved
+ * space framework.
+ */
+void btrfs_free_reserved_data_space(struct inode *inode,
+			struct extent_changeset *reserved, u64 start, u64 len)
+{
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+
+	/* Make sure the range is aligned to sectorsize */
+	len = round_up(start + len, root->fs_info->sectorsize) -
+	      round_down(start, root->fs_info->sectorsize);
+	start = round_down(start, root->fs_info->sectorsize);
+
+	btrfs_free_reserved_data_space_noquota(inode, start, len);
+	btrfs_qgroup_free_data(inode, reserved, start, len);
+}
+
+/**
+ * btrfs_inode_rsv_release - release any excessive reservation.
+ * @inode - the inode we need to release from.
+ * @qgroup_free - free or convert qgroup meta.
+ *   Unlike normal operation, qgroup meta reservation needs to know if we are
+ *   freeing qgroup reservation or just converting it into per-trans.  Normally
+ *   @qgroup_free is true for error handling, and false for normal release.
+ *
+ * This is the same as btrfs_block_rsv_release, except that it handles the
+ * tracepoint for the reservation.
+ */
+static void btrfs_inode_rsv_release(struct btrfs_inode *inode, bool qgroup_free)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_block_rsv *block_rsv = &inode->block_rsv;
+	u64 released = 0;
+	u64 qgroup_to_release = 0;
+
+	/*
+	 * Since we statically set the block_rsv->size we just want to say we
+	 * are releasing 0 bytes, and then we'll just get the reservation over
+	 * the size free'd.
+	 */
+	released = __btrfs_block_rsv_release(fs_info, block_rsv, 0,
+					     &qgroup_to_release);
+	if (released > 0)
+		trace_btrfs_space_reservation(fs_info, "delalloc",
+					      btrfs_ino(inode), released, 0);
+	if (qgroup_free)
+		btrfs_qgroup_free_meta_prealloc(inode->root, qgroup_to_release);
+	else
+		btrfs_qgroup_convert_reserved_meta(inode->root,
+						   qgroup_to_release);
+}
+
+static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
+						 struct btrfs_inode *inode)
+{
+	struct btrfs_block_rsv *block_rsv = &inode->block_rsv;
+	u64 reserve_size = 0;
+	u64 qgroup_rsv_size = 0;
+	u64 csum_leaves;
+	unsigned outstanding_extents;
+
+	lockdep_assert_held(&inode->lock);
+	outstanding_extents = inode->outstanding_extents;
+	if (outstanding_extents)
+		reserve_size = btrfs_calc_trans_metadata_size(fs_info,
+						outstanding_extents + 1);
+	csum_leaves = btrfs_csum_bytes_to_leaves(fs_info,
+						 inode->csum_bytes);
+	reserve_size += btrfs_calc_trans_metadata_size(fs_info,
+						       csum_leaves);
+	/*
+	 * For qgroup rsv, the calculation is very simple:
+	 * account one nodesize for each outstanding extent
+	 *
+	 * This is overestimating in most cases.
+	 */
+	qgroup_rsv_size = (u64)outstanding_extents * fs_info->nodesize;
+
+	spin_lock(&block_rsv->lock);
+	block_rsv->size = reserve_size;
+	block_rsv->qgroup_rsv_size = qgroup_rsv_size;
+	spin_unlock(&block_rsv->lock);
+}
+
+static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
+				    u64 num_bytes, u64 *meta_reserve,
+				    u64 *qgroup_reserve)
+{
+	u64 nr_extents = count_max_extents(num_bytes);
+	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
+
+	/* We add one for the inode update at finish ordered time */
+	*meta_reserve = btrfs_calc_trans_metadata_size(fs_info,
+						nr_extents + csum_leaves + 1);
+	*qgroup_reserve = nr_extents * fs_info->nodesize;
+}
+
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_block_rsv *block_rsv = &inode->block_rsv;
+	u64 meta_reserve, qgroup_reserve;
+	unsigned nr_extents;
+	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_FLUSH_ALL;
+	int ret = 0;
+	bool delalloc_lock = true;
+
+	/* If we are a free space inode we need to not flush since we will be in
+	 * the middle of a transaction commit.  We also don't need the delalloc
+	 * mutex since we won't race with anybody.  We need this mostly to make
+	 * lockdep shut its filthy mouth.
+	 *
+	 * If we have a transaction open (can happen if we call truncate_block
+	 * from truncate), then we need FLUSH_LIMIT so we don't deadlock.
+	 */
+	if (btrfs_is_free_space_inode(inode)) {
+		flush = BTRFS_RESERVE_NO_FLUSH;
+		delalloc_lock = false;
+	} else {
+		if (current->journal_info)
+			flush = BTRFS_RESERVE_FLUSH_LIMIT;
+
+		if (btrfs_transaction_in_commit(fs_info))
+			schedule_timeout(1);
+	}
+
+	if (delalloc_lock)
+		mutex_lock(&inode->delalloc_mutex);
+
+	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
+
+	/*
+	 * We always want to do it this way, every other way is wrong and ends
+	 * in tears.  Pre-reserving the amount we are going to add will always
+	 * be the right way, because otherwise if we have enough parallelism we
+	 * could end up with thousands of inodes all holding little bits of
+	 * reservations they were able to make previously and the only way to
+	 * reclaim that space is to ENOSPC out the operations and clear
+	 * everything out and try again, which is bad.  This way we just
+	 * over-reserve slightly, and clean up the mess when we are done.
+	 */
+	calc_inode_reservations(fs_info, num_bytes, &meta_reserve,
+				&qgroup_reserve);
+	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
+	if (ret)
+		goto out_fail;
+	ret = btrfs_reserve_metadata_bytes(root, block_rsv, meta_reserve,
+					   flush);
+	if (ret)
+		goto out_qgroup;
+
+	/*
+	 * Now we need to update our outstanding extents and csum bytes _first_
+	 * and then add the reservation to the block_rsv.  This keeps us from
+	 * racing with an ordered completion or some such that would think it
+	 * needs to free the reservation we just made.
+	 */
+	spin_lock(&inode->lock);
+	nr_extents = count_max_extents(num_bytes);
+	btrfs_mod_outstanding_extents(inode, nr_extents);
+	inode->csum_bytes += num_bytes;
+	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
+	spin_unlock(&inode->lock);
+
+	/* Now we can safely add our space to our block rsv */
+	btrfs_block_rsv_add_bytes(block_rsv, meta_reserve, false);
+	trace_btrfs_space_reservation(root->fs_info, "delalloc",
+				      btrfs_ino(inode), meta_reserve, 1);
+
+	spin_lock(&block_rsv->lock);
+	block_rsv->qgroup_rsv_reserved += qgroup_reserve;
+	spin_unlock(&block_rsv->lock);
+
+	if (delalloc_lock)
+		mutex_unlock(&inode->delalloc_mutex);
+	return 0;
+out_qgroup:
+	btrfs_qgroup_free_meta_prealloc(root, qgroup_reserve);
+out_fail:
+	btrfs_inode_rsv_release(inode, true);
+	if (delalloc_lock)
+		mutex_unlock(&inode->delalloc_mutex);
+	return ret;
+}
+
+/**
+ * btrfs_delalloc_release_metadata - release a metadata reservation for an inode
+ * @inode: the inode to release the reservation for.
+ * @num_bytes: the number of bytes we are releasing.
+ * @qgroup_free: free qgroup reservation or convert it to per-trans reservation
+ *
+ * This will release the metadata reservation for an inode.  This can be called
+ * once we complete IO for a given set of bytes to release their metadata
+ * reservations, or on error for the same reason.
+ */
+void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				     bool qgroup_free)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
+	spin_lock(&inode->lock);
+	inode->csum_bytes -= num_bytes;
+	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
+	spin_unlock(&inode->lock);
+
+	if (btrfs_is_testing(fs_info))
+		return;
+
+	btrfs_inode_rsv_release(inode, qgroup_free);
+}
+
+/**
+ * btrfs_delalloc_release_extents - release our outstanding_extents
+ * @inode: the inode to balance the reservation for.
+ * @num_bytes: the number of bytes we originally reserved with
+ * @qgroup_free: do we need to free qgroup meta reservation or convert them.
+ *
+ * When we reserve space we increase outstanding_extents for the extents we may
+ * add.  Once we've set the range as delalloc or created our ordered extents we
+ * have outstanding_extents to track the real usage, so we use this to free our
+ * temporarily tracked outstanding_extents.  This _must_ be used in conjunction
+ * with btrfs_delalloc_reserve_metadata.
+ */
+void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes,
+				    bool qgroup_free)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	unsigned num_extents;
+
+	spin_lock(&inode->lock);
+	num_extents = count_max_extents(num_bytes);
+	btrfs_mod_outstanding_extents(inode, -num_extents);
+	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
+	spin_unlock(&inode->lock);
+
+	if (btrfs_is_testing(fs_info))
+		return;
+
+	btrfs_inode_rsv_release(inode, qgroup_free);
+}
+
+/**
+ * btrfs_delalloc_reserve_space - reserve data and metadata space for
+ * delalloc
+ * @inode: inode we're writing to
+ * @start: start range we are writing to
+ * @len: how long the range we are writing to
+ * @reserved: mandatory parameter, record actually reserved qgroup ranges of
+ * 	      current reservation.
+ *
+ * This will do the following things
+ *
+ * o reserve space in data space info for num bytes
+ *   and reserve precious corresponding qgroup space
+ *   (Done in check_data_free_space)
+ *
+ * o reserve space for metadata space, based on the number of outstanding
+ *   extents and how much csums will be needed
+ *   also reserve metadata space in a per root over-reserve method.
+ * o add to the inodes->delalloc_bytes
+ * o add it to the fs_info's delalloc inodes list.
+ *   (Above 3 all done in delalloc_reserve_metadata)
+ *
+ * Return 0 for success
+ * Return <0 for error(-ENOSPC or -EQUOT)
+ */
+int btrfs_delalloc_reserve_space(struct inode *inode,
+			struct extent_changeset **reserved, u64 start, u64 len)
+{
+	int ret;
+
+	ret = btrfs_check_data_free_space(inode, reserved, start, len);
+	if (ret < 0)
+		return ret;
+	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len);
+	if (ret < 0)
+		btrfs_free_reserved_data_space(inode, *reserved, start, len);
+	return ret;
+}
+
+/**
+ * btrfs_delalloc_release_space - release data and metadata space for delalloc
+ * @inode: inode we're releasing space for
+ * @start: start position of the space already reserved
+ * @len: the len of the space already reserved
+ * @release_bytes: the len of the space we consumed or didn't use
+ *
+ * This function will release the metadata space that was not used and will
+ * decrement ->delalloc_bytes and remove it from the fs_info delalloc_inodes
+ * list if there are no delalloc bytes left.
+ * Also it will handle the qgroup reserved space.
+ */
+void btrfs_delalloc_release_space(struct inode *inode,
+				  struct extent_changeset *reserved,
+				  u64 start, u64 len, bool qgroup_free)
+{
+	btrfs_delalloc_release_metadata(BTRFS_I(inode), len, qgroup_free);
+	btrfs_free_reserved_data_space(inode, reserved, start, len);
+}
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
new file mode 100644
index 000000000000..8f7ceb264a30
--- /dev/null
+++ b/fs/btrfs/delalloc-space.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Facebook.  All rights reserved.
+ */
+
+#ifndef BTRFS_DELALLOC_SPACE_H
+#define BTRFS_DELALLOC_SPACE_H
+
+struct extent_changeset;
+
+int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes);
+int btrfs_check_data_free_space(struct inode *inode,
+			struct extent_changeset **reserved, u64 start, u64 len);
+void btrfs_free_reserved_data_space(struct inode *inode,
+			struct extent_changeset *reserved, u64 start, u64 len);
+void btrfs_delalloc_release_space(struct inode *inode,
+				  struct extent_changeset *reserved,
+				  u64 start, u64 len, bool qgroup_free);
+void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
+					    u64 len);
+void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				     bool qgroup_free);
+int btrfs_delalloc_reserve_space(struct inode *inode,
+			struct extent_changeset **reserved, u64 start, u64 len);
+#endif /* BTRFS_DELALLOC_SPACE_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 20b9b3284af2..c407e3188845 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -30,6 +30,7 @@
 #include "ref-verify.h"
 #include "space-info.h"
 #include "block-rsv.h"
+#include "delalloc-space.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -3867,206 +3868,6 @@ u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
 	return get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 }
 
-int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
-{
-	struct btrfs_root *root = inode->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
-	u64 used;
-	int ret = 0;
-	int need_commit = 2;
-	int have_pinned_space;
-
-	/* make sure bytes are sectorsize aligned */
-	bytes = ALIGN(bytes, fs_info->sectorsize);
-
-	if (btrfs_is_free_space_inode(inode)) {
-		need_commit = 0;
-		ASSERT(current->journal_info);
-	}
-
-again:
-	/* make sure we have enough space to handle the data first */
-	spin_lock(&data_sinfo->lock);
-	used = btrfs_space_info_used(data_sinfo, true);
-
-	if (used + bytes > data_sinfo->total_bytes) {
-		struct btrfs_trans_handle *trans;
-
-		/*
-		 * if we don't have enough free bytes in this space then we need
-		 * to alloc a new chunk.
-		 */
-		if (!data_sinfo->full) {
-			u64 alloc_target;
-
-			data_sinfo->force_alloc = CHUNK_ALLOC_FORCE;
-			spin_unlock(&data_sinfo->lock);
-
-			alloc_target = btrfs_data_alloc_profile(fs_info);
-			/*
-			 * It is ugly that we don't call nolock join
-			 * transaction for the free space inode case here.
-			 * But it is safe because we only do the data space
-			 * reservation for the free space cache in the
-			 * transaction context, the common join transaction
-			 * just increase the counter of the current transaction
-			 * handler, doesn't try to acquire the trans_lock of
-			 * the fs.
-			 */
-			trans = btrfs_join_transaction(root);
-			if (IS_ERR(trans))
-				return PTR_ERR(trans);
-
-			ret = btrfs_chunk_alloc(trans, alloc_target,
-						CHUNK_ALLOC_NO_FORCE);
-			btrfs_end_transaction(trans);
-			if (ret < 0) {
-				if (ret != -ENOSPC)
-					return ret;
-				else {
-					have_pinned_space = 1;
-					goto commit_trans;
-				}
-			}
-
-			goto again;
-		}
-
-		/*
-		 * If we don't have enough pinned space to deal with this
-		 * allocation, and no removed chunk in current transaction,
-		 * don't bother committing the transaction.
-		 */
-		have_pinned_space = __percpu_counter_compare(
-			&data_sinfo->total_bytes_pinned,
-			used + bytes - data_sinfo->total_bytes,
-			BTRFS_TOTAL_BYTES_PINNED_BATCH);
-		spin_unlock(&data_sinfo->lock);
-
-		/* commit the current transaction and try again */
-commit_trans:
-		if (need_commit) {
-			need_commit--;
-
-			if (need_commit > 0) {
-				btrfs_start_delalloc_roots(fs_info, -1);
-				btrfs_wait_ordered_roots(fs_info, U64_MAX, 0,
-							 (u64)-1);
-			}
-
-			trans = btrfs_join_transaction(root);
-			if (IS_ERR(trans))
-				return PTR_ERR(trans);
-			if (have_pinned_space >= 0 ||
-			    test_bit(BTRFS_TRANS_HAVE_FREE_BGS,
-				     &trans->transaction->flags) ||
-			    need_commit > 0) {
-				ret = btrfs_commit_transaction(trans);
-				if (ret)
-					return ret;
-				/*
-				 * The cleaner kthread might still be doing iput
-				 * operations. Wait for it to finish so that
-				 * more space is released.  We don't need to
-				 * explicitly run the delayed iputs here because
-				 * the commit_transaction would have woken up
-				 * the cleaner.
-				 */
-				ret = btrfs_wait_on_delayed_iputs(fs_info);
-				if (ret)
-					return ret;
-				goto again;
-			} else {
-				btrfs_end_transaction(trans);
-			}
-		}
-
-		trace_btrfs_space_reservation(fs_info,
-					      "space_info:enospc",
-					      data_sinfo->flags, bytes, 1);
-		return -ENOSPC;
-	}
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
-	trace_btrfs_space_reservation(fs_info, "space_info",
-				      data_sinfo->flags, bytes, 1);
-	spin_unlock(&data_sinfo->lock);
-
-	return 0;
-}
-
-int btrfs_check_data_free_space(struct inode *inode,
-			struct extent_changeset **reserved, u64 start, u64 len)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	int ret;
-
-	/* align the range */
-	len = round_up(start + len, fs_info->sectorsize) -
-	      round_down(start, fs_info->sectorsize);
-	start = round_down(start, fs_info->sectorsize);
-
-	ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode), len);
-	if (ret < 0)
-		return ret;
-
-	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
-	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
-	if (ret < 0)
-		btrfs_free_reserved_data_space_noquota(inode, start, len);
-	else
-		ret = 0;
-	return ret;
-}
-
-/*
- * Called if we need to clear a data reservation for this inode
- * Normally in a error case.
- *
- * This one will *NOT* use accurate qgroup reserved space API, just for case
- * which we can't sleep and is sure it won't affect qgroup reserved space.
- * Like clear_bit_hook().
- */
-void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
-					    u64 len)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_space_info *data_sinfo;
-
-	/* Make sure the range is aligned to sectorsize */
-	len = round_up(start + len, fs_info->sectorsize) -
-	      round_down(start, fs_info->sectorsize);
-	start = round_down(start, fs_info->sectorsize);
-
-	data_sinfo = fs_info->data_sinfo;
-	spin_lock(&data_sinfo->lock);
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
-	trace_btrfs_space_reservation(fs_info, "space_info",
-				      data_sinfo->flags, len, 0);
-	spin_unlock(&data_sinfo->lock);
-}
-
-/*
- * Called if we need to clear a data reservation for this inode
- * Normally in a error case.
- *
- * This one will handle the per-inode data rsv map for accurate reserved
- * space framework.
- */
-void btrfs_free_reserved_data_space(struct inode *inode,
-			struct extent_changeset *reserved, u64 start, u64 len)
-{
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-
-	/* Make sure the range is aligned to sectorsize */
-	len = round_up(start + len, root->fs_info->sectorsize) -
-	      round_down(start, root->fs_info->sectorsize);
-	start = round_down(start, root->fs_info->sectorsize);
-
-	btrfs_free_reserved_data_space_noquota(inode, start, len);
-	btrfs_qgroup_free_data(inode, reserved, start, len);
-}
-
 static void force_metadata_allocation(struct btrfs_fs_info *info)
 {
 	struct list_head *head = &info->space_info;
@@ -4306,41 +4107,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	return ret;
 }
 
-/**
- * btrfs_inode_rsv_release - release any excessive reservation.
- * @inode - the inode we need to release from.
- * @qgroup_free - free or convert qgroup meta.
- *   Unlike normal operation, qgroup meta reservation needs to know if we are
- *   freeing qgroup reservation or just converting it into per-trans.  Normally
- *   @qgroup_free is true for error handling, and false for normal release.
- *
- * This is the same as btrfs_block_rsv_release, except that it handles the
- * tracepoint for the reservation.
- */
-static void btrfs_inode_rsv_release(struct btrfs_inode *inode, bool qgroup_free)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_block_rsv *block_rsv = &inode->block_rsv;
-	u64 released = 0;
-	u64 qgroup_to_release = 0;
-
-	/*
-	 * Since we statically set the block_rsv->size we just want to say we
-	 * are releasing 0 bytes, and then we'll just get the reservation over
-	 * the size free'd.
-	 */
-	released = __btrfs_block_rsv_release(fs_info, block_rsv, 0,
-					     &qgroup_to_release);
-	if (released > 0)
-		trace_btrfs_space_reservation(fs_info, "delalloc",
-					      btrfs_ino(inode), released, 0);
-	if (qgroup_free)
-		btrfs_qgroup_free_meta_prealloc(inode->root, qgroup_to_release);
-	else
-		btrfs_qgroup_convert_reserved_meta(inode->root,
-						   qgroup_to_release);
-}
-
 /*
  * btrfs_subvolume_reserve_metadata() - reserve space for subvolume operation
  * root: the root of the parent directory
@@ -4395,256 +4161,6 @@ void btrfs_subvolume_release_metadata(struct btrfs_fs_info *fs_info,
 	btrfs_block_rsv_release(fs_info, rsv, (u64)-1);
 }
 
-static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
-						 struct btrfs_inode *inode)
-{
-	struct btrfs_block_rsv *block_rsv = &inode->block_rsv;
-	u64 reserve_size = 0;
-	u64 qgroup_rsv_size = 0;
-	u64 csum_leaves;
-	unsigned outstanding_extents;
-
-	lockdep_assert_held(&inode->lock);
-	outstanding_extents = inode->outstanding_extents;
-	if (outstanding_extents)
-		reserve_size = btrfs_calc_trans_metadata_size(fs_info,
-						outstanding_extents + 1);
-	csum_leaves = btrfs_csum_bytes_to_leaves(fs_info,
-						 inode->csum_bytes);
-	reserve_size += btrfs_calc_trans_metadata_size(fs_info,
-						       csum_leaves);
-	/*
-	 * For qgroup rsv, the calculation is very simple:
-	 * account one nodesize for each outstanding extent
-	 *
-	 * This is overestimating in most cases.
-	 */
-	qgroup_rsv_size = (u64)outstanding_extents * fs_info->nodesize;
-
-	spin_lock(&block_rsv->lock);
-	block_rsv->size = reserve_size;
-	block_rsv->qgroup_rsv_size = qgroup_rsv_size;
-	spin_unlock(&block_rsv->lock);
-}
-
-static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
-				    u64 num_bytes, u64 *meta_reserve,
-				    u64 *qgroup_reserve)
-{
-	u64 nr_extents = count_max_extents(num_bytes);
-	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
-
-	/* We add one for the inode update at finish ordered time */
-	*meta_reserve = btrfs_calc_trans_metadata_size(fs_info,
-						nr_extents + csum_leaves + 1);
-	*qgroup_reserve = nr_extents * fs_info->nodesize;
-}
-
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
-{
-	struct btrfs_root *root = inode->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *block_rsv = &inode->block_rsv;
-	u64 meta_reserve, qgroup_reserve;
-	unsigned nr_extents;
-	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_FLUSH_ALL;
-	int ret = 0;
-	bool delalloc_lock = true;
-
-	/* If we are a free space inode we need to not flush since we will be in
-	 * the middle of a transaction commit.  We also don't need the delalloc
-	 * mutex since we won't race with anybody.  We need this mostly to make
-	 * lockdep shut its filthy mouth.
-	 *
-	 * If we have a transaction open (can happen if we call truncate_block
-	 * from truncate), then we need FLUSH_LIMIT so we don't deadlock.
-	 */
-	if (btrfs_is_free_space_inode(inode)) {
-		flush = BTRFS_RESERVE_NO_FLUSH;
-		delalloc_lock = false;
-	} else {
-		if (current->journal_info)
-			flush = BTRFS_RESERVE_FLUSH_LIMIT;
-
-		if (btrfs_transaction_in_commit(fs_info))
-			schedule_timeout(1);
-	}
-
-	if (delalloc_lock)
-		mutex_lock(&inode->delalloc_mutex);
-
-	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
-
-	/*
-	 * We always want to do it this way, every other way is wrong and ends
-	 * in tears.  Pre-reserving the amount we are going to add will always
-	 * be the right way, because otherwise if we have enough parallelism we
-	 * could end up with thousands of inodes all holding little bits of
-	 * reservations they were able to make previously and the only way to
-	 * reclaim that space is to ENOSPC out the operations and clear
-	 * everything out and try again, which is bad.  This way we just
-	 * over-reserve slightly, and clean up the mess when we are done.
-	 */
-	calc_inode_reservations(fs_info, num_bytes, &meta_reserve,
-				&qgroup_reserve);
-	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
-	if (ret)
-		goto out_fail;
-	ret = btrfs_reserve_metadata_bytes(root, block_rsv, meta_reserve,
-					   flush);
-	if (ret)
-		goto out_qgroup;
-
-	/*
-	 * Now we need to update our outstanding extents and csum bytes _first_
-	 * and then add the reservation to the block_rsv.  This keeps us from
-	 * racing with an ordered completion or some such that would think it
-	 * needs to free the reservation we just made.
-	 */
-	spin_lock(&inode->lock);
-	nr_extents = count_max_extents(num_bytes);
-	btrfs_mod_outstanding_extents(inode, nr_extents);
-	inode->csum_bytes += num_bytes;
-	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
-	spin_unlock(&inode->lock);
-
-	/* Now we can safely add our space to our block rsv */
-	btrfs_block_rsv_add_bytes(block_rsv, meta_reserve, false);
-	trace_btrfs_space_reservation(root->fs_info, "delalloc",
-				      btrfs_ino(inode), meta_reserve, 1);
-
-	spin_lock(&block_rsv->lock);
-	block_rsv->qgroup_rsv_reserved += qgroup_reserve;
-	spin_unlock(&block_rsv->lock);
-
-	if (delalloc_lock)
-		mutex_unlock(&inode->delalloc_mutex);
-	return 0;
-out_qgroup:
-	btrfs_qgroup_free_meta_prealloc(root, qgroup_reserve);
-out_fail:
-	btrfs_inode_rsv_release(inode, true);
-	if (delalloc_lock)
-		mutex_unlock(&inode->delalloc_mutex);
-	return ret;
-}
-
-/**
- * btrfs_delalloc_release_metadata - release a metadata reservation for an inode
- * @inode: the inode to release the reservation for.
- * @num_bytes: the number of bytes we are releasing.
- * @qgroup_free: free qgroup reservation or convert it to per-trans reservation
- *
- * This will release the metadata reservation for an inode.  This can be called
- * once we complete IO for a given set of bytes to release their metadata
- * reservations, or on error for the same reason.
- */
-void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
-				     bool qgroup_free)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-
-	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
-	spin_lock(&inode->lock);
-	inode->csum_bytes -= num_bytes;
-	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
-	spin_unlock(&inode->lock);
-
-	if (btrfs_is_testing(fs_info))
-		return;
-
-	btrfs_inode_rsv_release(inode, qgroup_free);
-}
-
-/**
- * btrfs_delalloc_release_extents - release our outstanding_extents
- * @inode: the inode to balance the reservation for.
- * @num_bytes: the number of bytes we originally reserved with
- * @qgroup_free: do we need to free qgroup meta reservation or convert them.
- *
- * When we reserve space we increase outstanding_extents for the extents we may
- * add.  Once we've set the range as delalloc or created our ordered extents we
- * have outstanding_extents to track the real usage, so we use this to free our
- * temporarily tracked outstanding_extents.  This _must_ be used in conjunction
- * with btrfs_delalloc_reserve_metadata.
- */
-void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes,
-				    bool qgroup_free)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	unsigned num_extents;
-
-	spin_lock(&inode->lock);
-	num_extents = count_max_extents(num_bytes);
-	btrfs_mod_outstanding_extents(inode, -num_extents);
-	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
-	spin_unlock(&inode->lock);
-
-	if (btrfs_is_testing(fs_info))
-		return;
-
-	btrfs_inode_rsv_release(inode, qgroup_free);
-}
-
-/**
- * btrfs_delalloc_reserve_space - reserve data and metadata space for
- * delalloc
- * @inode: inode we're writing to
- * @start: start range we are writing to
- * @len: how long the range we are writing to
- * @reserved: mandatory parameter, record actually reserved qgroup ranges of
- * 	      current reservation.
- *
- * This will do the following things
- *
- * o reserve space in data space info for num bytes
- *   and reserve precious corresponding qgroup space
- *   (Done in check_data_free_space)
- *
- * o reserve space for metadata space, based on the number of outstanding
- *   extents and how much csums will be needed
- *   also reserve metadata space in a per root over-reserve method.
- * o add to the inodes->delalloc_bytes
- * o add it to the fs_info's delalloc inodes list.
- *   (Above 3 all done in delalloc_reserve_metadata)
- *
- * Return 0 for success
- * Return <0 for error(-ENOSPC or -EQUOT)
- */
-int btrfs_delalloc_reserve_space(struct inode *inode,
-			struct extent_changeset **reserved, u64 start, u64 len)
-{
-	int ret;
-
-	ret = btrfs_check_data_free_space(inode, reserved, start, len);
-	if (ret < 0)
-		return ret;
-	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len);
-	if (ret < 0)
-		btrfs_free_reserved_data_space(inode, *reserved, start, len);
-	return ret;
-}
-
-/**
- * btrfs_delalloc_release_space - release data and metadata space for delalloc
- * @inode: inode we're releasing space for
- * @start: start position of the space already reserved
- * @len: the len of the space already reserved
- * @release_bytes: the len of the space we consumed or didn't use
- *
- * This function will release the metadata space that was not used and will
- * decrement ->delalloc_bytes and remove it from the fs_info delalloc_inodes
- * list if there are no delalloc bytes left.
- * Also it will handle the qgroup reserved space.
- */
-void btrfs_delalloc_release_space(struct inode *inode,
-				  struct extent_changeset *reserved,
-				  u64 start, u64 len, bool qgroup_free)
-{
-	btrfs_delalloc_release_metadata(BTRFS_I(inode), len, qgroup_free);
-	btrfs_free_reserved_data_space(inode, reserved, start, len);
-}
-
 static int update_block_group(struct btrfs_trans_handle *trans,
 			      u64 bytenr, u64 num_bytes, int alloc)
 {
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7c1e2984bb72..c41188df562d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -26,6 +26,7 @@
 #include "volumes.h"
 #include "qgroup.h"
 #include "compression.h"
+#include "delalloc-space.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 390cd3d7d5ea..062be9dde4c6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -19,6 +19,7 @@
 #include "inode-map.h"
 #include "volumes.h"
 #include "space-info.h"
+#include "delalloc-space.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_32K
diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index ffca2abf13d0..2e8bb402050b 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -11,6 +11,7 @@
 #include "free-space-cache.h"
 #include "inode-map.h"
 #include "transaction.h"
+#include "delalloc-space.h"
 
 static int caching_kthread(void *data)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c311bf6d52f4..8e389c51f4e9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -47,6 +47,7 @@
 #include "props.h"
 #include "qgroup.h"
 #include "dedupe.h"
+#include "delalloc-space.h"
 
 struct btrfs_iget_args {
 	struct btrfs_key *location;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1af3af3d708c..bae04a4f09d2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -44,6 +44,7 @@
 #include "tree-log.h"
 #include "compression.h"
 #include "space-info.h"
+#include "delalloc-space.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 3f67b7827393..1744ba8b2754 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -13,6 +13,7 @@
 #include "extent_io.h"
 #include "disk-io.h"
 #include "compression.h"
+#include "delalloc-space.h"
 
 static struct kmem_cache *btrfs_ordered_extent_cache;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 22a3c69864fa..7f219851fa23 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -20,6 +20,7 @@
 #include "inode-map.h"
 #include "qgroup.h"
 #include "print-tree.h"
+#include "delalloc-space.h"
 
 /*
  * backref_node, mapping_node and tree_block start with this
-- 
2.14.3

