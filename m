Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C40B38C63F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhEUMKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:10:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231521AbhEUMK2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:10:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621598943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zuuy465uti4w66gYu6VLcI9W3XR+eOYrPicQCfLwKR8=;
        b=g+sCMCxcXUMk9HJ8in9AC/bjdeIvjosD8a2YsxaspSssb7L8/S1auEUfXRJbMJteTKCAuE
        0MTWtLH9B1KAOFoWcQEqOnmkteDhqnJyHKNDwn/UxV+Fdg9O74HnKSH2SctuOyYlzgmKG+
        wiAWxAhT0LElfHcq8yum0okFk6+j9H4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1E19AAA6;
        Fri, 21 May 2021 12:09:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7C5F8DA725; Fri, 21 May 2021 14:06:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/6] btrfs: add cancelable chunk relocation support
Date:   Fri, 21 May 2021 14:06:29 +0200
Message-Id: <79a09502c532bc9939645d2711c72ebad5fce2e7.1621526221.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621526221.git.dsterba@suse.com>
References: <cover.1621526221.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add support code that will allow canceling relocation on the chunk
granularity. This is different and independent of balance, that also
uses relocation but is a higher level operation and manages it's own
state and pause/cancelation requests.

Relocation is used for resize (shrink) and device deletion so this will
be a common point to implement cancelation for both. The context is
entirely in btrfs_relocate_block_group and btrfs_recover_relocation,
enclosing one chunk relocation. The status bit is set and unset between
the chunks. As relocation can take long, the effects may not be
immediate and the request and actual action can slightly race.

The fs_info::reloc_cancel_req is only supposed to be increased and does
not pair with decrement like fs_info::balance_cancel_req.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h      |  9 +++++++
 fs/btrfs/disk-io.c    |  1 +
 fs/btrfs/relocation.c | 60 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a142e56b6b9a..3dfc32a3ebab 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -565,6 +565,12 @@ enum {
 	 */
 	BTRFS_FS_BALANCE_RUNNING,
 
+	/*
+	 * Indicate that relocation of a chunk has started, it's set per chunk
+	 * and is toggled between chunks.
+	 */
+	BTRFS_FS_RELOC_RUNNING,
+
 	/* Indicate that the cleaner thread is awake and doing something. */
 	BTRFS_FS_CLEANER_RUNNING,
 
@@ -871,6 +877,9 @@ struct btrfs_fs_info {
 	struct btrfs_balance_control *balance_ctl;
 	wait_queue_head_t balance_wait_q;
 
+	/* Cancelation requests for chunk relocation */
+	atomic_t reloc_cancel_req;
+
 	u32 data_chunk_allocations;
 	u32 metadata_ratio;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8c3db9076988..93c994b78d61 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2251,6 +2251,7 @@ static void btrfs_init_balance(struct btrfs_fs_info *fs_info)
 	atomic_set(&fs_info->balance_cancel_req, 0);
 	fs_info->balance_ctl = NULL;
 	init_waitqueue_head(&fs_info->balance_wait_q);
+	atomic_set(&fs_info->reloc_cancel_req, 0);
 }
 
 static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b70be2ac2e9e..9b84eb86e426 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2876,11 +2876,12 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 }
 
 /*
- * Allow error injection to test balance cancellation
+ * Allow error injection to test balance/relocation cancellation
  */
 noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
 {
 	return atomic_read(&fs_info->balance_cancel_req) ||
+		atomic_read(&fs_info->reloc_cancel_req) ||
 		fatal_signal_pending(current);
 }
 ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
@@ -3780,6 +3781,47 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	return inode;
 }
 
+/*
+ * Mark start of chunk relocation that is cancelable. Check if the cancelation
+ * has been requested meanwhile and don't start in that case.
+ *
+ * Return:
+ *   0             success
+ *   -EINPROGRESS  operation is already in progress, that's probably a bug
+ *   -ECANCELED    cancelation request was set before the operation started
+ */
+static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
+{
+	if (test_and_set_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags)) {
+		/* This should not happen */
+		btrfs_err(fs_info, "reloc already running, cannot start");
+		return -EINPROGRESS;
+	}
+
+	if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
+		btrfs_info(fs_info, "chunk relocation canceled on start");
+		/*
+		 * On cancel, clear all requests but let the caller mark
+		 * the end after cleanup operations.
+		 */
+		atomic_set(&fs_info->reloc_cancel_req, 0);
+		return -ECANCELED;
+	}
+	return 0;
+}
+
+/*
+ * Mark end of chunk relocation that is cancelable and wake any waiters.
+ */
+static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
+{
+	/* Requested after start, clear bit first so any waiters can continue */
+	if (atomic_read(&fs_info->reloc_cancel_req) > 0)
+		btrfs_info(fs_info, "chunk relocation canceled during operation");
+	clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
+	atomic_set(&fs_info->reloc_cancel_req, 0);
+}
+
 static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 {
 	struct reloc_control *rc;
@@ -3862,6 +3904,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		return -ENOMEM;
 	}
 
+	ret = reloc_chunk_start(fs_info);
+	if (ret < 0) {
+		err = ret;
+		goto out_end;
+	}
+
 	rc->extent_root = extent_root;
 	rc->block_group = bg;
 
@@ -3953,6 +4001,8 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		btrfs_dec_block_group_ro(rc->block_group);
 	iput(rc->data_inode);
 	btrfs_put_block_group(rc->block_group);
+out_end:
+	reloc_chunk_end(fs_info);
 	free_reloc_control(rc);
 	return err;
 }
@@ -4073,6 +4123,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		goto out;
 	}
 
+	ret = reloc_chunk_start(fs_info);
+	if (ret < 0) {
+		err = ret;
+		goto out_end;
+	}
+
 	rc->extent_root = fs_info->extent_root;
 
 	set_reloc_control(rc);
@@ -4137,6 +4193,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		err = ret;
 out_unset:
 	unset_reloc_control(rc);
+out_end:
+	reloc_chunk_end(fs_info);
 	free_reloc_control(rc);
 out:
 	free_reloc_roots(&reloc_roots);
-- 
2.29.2

