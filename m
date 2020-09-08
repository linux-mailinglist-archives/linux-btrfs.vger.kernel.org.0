Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E1260FB7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 12:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgIHK1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 06:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbgIHK1f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 06:27:35 -0400
Received: from falcondesktop.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC16C20C09;
        Tue,  8 Sep 2020 10:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560853;
        bh=qZz/UTqN/EPMChNLRCg9ejsFhu7Aqk4AOOX2eOLeZmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=a3mNeqf4M6s7lkNHcPnsV2GFf5pKqsvUqnzTjMGdcrnk+qkhmmW2BE1rjLVB7KZz+
         +DE3L7k0ISGGuBo7pFANbsKsn1Yc6X0XWpmXM4ws7GdqwT9VNQkuFVN6aZ8DDxpocE
         uW3AafMEJ1/qzXYb995Pn9PJDB7uxWa0oJibZ7qc=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/5] btrfs: fix metadata reservation for fallocate that leads to transaction aborts
Date:   Tue,  8 Sep 2020 11:27:20 +0100
Message-Id: <31a60143d7f01172265ed3120f2133a84722422e.1599560101.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1599560101.git.fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
In-Reply-To: <cover.1599560101.git.fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing an fallocate(), specially a zero range operation, we assume
that reserving 3 units of metadata space is enough, that at most we touch
one leaf in subvolume/fs tree for removing existing file extent items and
inserting a new file extent item. This assumption is generally true for
most common use cases. However when we end up needing to remove file extent
items from multiple leaves, we can end up failing with -ENOSPC and abort
the current transaction, turning the filesystem to RO mode. When this
happens a stack trace like the following is dumped in dmesg/syslog:

[ 1500.620934] ------------[ cut here ]------------
[ 1500.620938] BTRFS: Transaction aborted (error -28)
[ 1500.620973] WARNING: CPU: 2 PID: 30807 at fs/btrfs/inode.c:9724 __btrfs_prealloc_file_range+0x512/0x570 [btrfs]
[ 1500.620974] Modules linked in: btrfs intel_rapl_msr intel_rapl_common kvm_intel (...)
[ 1500.621010] CPU: 2 PID: 30807 Comm: xfs_io Tainted: G        W         5.9.0-rc3-btrfs-next-67 #1
[ 1500.621012] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[ 1500.621023] RIP: 0010:__btrfs_prealloc_file_range+0x512/0x570 [btrfs]
[ 1500.621026] Code: 8b 40 50 f0 48 (...)
[ 1500.621028] RSP: 0018:ffffb05fc8803ca0 EFLAGS: 00010286
[ 1500.621030] RAX: 0000000000000000 RBX: ffff9608af276488 RCX: 0000000000000000
[ 1500.621032] RDX: 0000000000000001 RSI: 0000000000000027 RDI: 00000000ffffffff
[ 1500.621033] RBP: ffffb05fc8803d90 R08: 0000000000000001 R09: 0000000000000001
[ 1500.621035] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000003200000
[ 1500.621037] R13: 00000000ffffffe4 R14: ffff9608af275fe8 R15: ffff9608af275f60
[ 1500.621039] FS:  00007fb5b2368ec0(0000) GS:ffff9608b6600000(0000) knlGS:0000000000000000
[ 1500.621041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1500.621043] CR2: 00007fb5b2366fb8 CR3: 0000000202d38005 CR4: 00000000003706e0
[ 1500.621046] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1500.621047] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1500.621049] Call Trace:
[ 1500.621076]  btrfs_prealloc_file_range+0x10/0x20 [btrfs]
[ 1500.621087]  btrfs_fallocate+0xccd/0x1280 [btrfs]
[ 1500.621108]  vfs_fallocate+0x14d/0x290
[ 1500.621112]  ksys_fallocate+0x3a/0x70
[ 1500.621117]  __x64_sys_fallocate+0x1a/0x20
[ 1500.621120]  do_syscall_64+0x33/0x80
[ 1500.621123]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1500.621126] RIP: 0033:0x7fb5b248c477
[ 1500.621128] Code: 89 7c 24 08 (...)
[ 1500.621130] RSP: 002b:00007ffc7bee9060 EFLAGS: 00000293 ORIG_RAX: 000000000000011d
[ 1500.621132] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fb5b248c477
[ 1500.621134] RDX: 0000000000000000 RSI: 0000000000000010 RDI: 0000000000000003
[ 1500.621136] RBP: 0000557718faafd0 R08: 0000000000000000 R09: 0000000000000000
[ 1500.621137] R10: 0000000003200000 R11: 0000000000000293 R12: 0000000000000010
[ 1500.621139] R13: 0000557718faafb0 R14: 0000557718faa480 R15: 0000000000000003
[ 1500.621151] irq event stamp: 1026217
[ 1500.621154] hardirqs last  enabled at (1026223): [<ffffffffba965570>] console_unlock+0x500/0x5c0
[ 1500.621156] hardirqs last disabled at (1026228): [<ffffffffba9654c7>] console_unlock+0x457/0x5c0
[ 1500.621159] softirqs last  enabled at (1022486): [<ffffffffbb6003dc>] __do_softirq+0x3dc/0x606
[ 1500.621161] softirqs last disabled at (1022477): [<ffffffffbb4010b2>] asm_call_on_stack+0x12/0x20
[ 1500.621162] ---[ end trace 2955b08408d8b9d4 ]---
[ 1500.621167] BTRFS: error (device sdj) in __btrfs_prealloc_file_range:9724: errno=-28 No space left

When we use fallocate() internally, for reserving an extent for a space
cache, inode cache or relocation, we can't hit this problem since either
there aren't any file extent items to remove from the subvolume tree or
there is at most one.

When using plain fallocate() it's very unlikely, since that would require
having many file extent items representing holes for the target range and
crossing multiple leafs - we attempt to increase the range (merge) of such
file extent items when punching holes, so at most we end up with 2 file
extent items for holes at leaf boundaries.

However when using the zero range operation of fallocate() for a large
range (100+ MiB for example) that's fairly easy to trigger. The following
example reproducer triggers the issue:

  $ cat reproducer.sh
  #!/bin/bash

  umount /dev/sdj &> /dev/null
  mkfs.btrfs -f -n 16384 -O ^no-holes /dev/sdj > /dev/null
  mount /dev/sdj /mnt/sdj

  # Create a 100M file with many file extent items. Punch a hole every 8K
  # just to speedup the file creation - we could do 4K sequential writes
  # followed by fsync (or O_SYNC) as well, but that takes a lot of time.
  file_size=$((100 * 1024 * 1024))
  xfs_io -f -c "pwrite -S 0xab -b 10M 0 $file_size" /mnt/sdj/foobar
  for ((i = 0; i < $file_size; i += 8192)); do
      xfs_io -c "fpunch $i 4096" /mnt/sdj/foobar
  done

  # Force a transaction commit, so the zero range operation will be forced
  # to COW all metadata extents it need to touch.
  sync

  xfs_io -c "fzero 0 $file_size" /mnt/sdj/foobar

  umount /mnt/sdj

  $ ./reproducer.sh
  wrote 104857600/104857600 bytes at offset 0
  100 MiB, 10 ops; 0.0669 sec (1.458 GiB/sec and 149.3117 ops/sec)
  fallocate: No space left on device

  $ dmesg
  <shows the same stack trace pasted before>

To fix this use the existing infrastructure that hole punching and
extent cloning use for replacing a file range with another extent. This
deals with doing the removal of file extent items and inserting the new
one using an incremental approach, reserving more space when needed and
always ensuring we don't leave an implicit hole in the range in case
we need to do multiple iterations and a crash happens between iterations.

A test case for fstests will follow up soon.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h   | 16 +++++++++++
 fs/btrfs/file.c    | 38 +++++++++++++++++++-------
 fs/btrfs/inode.c   | 68 +++++++++++++++++++++++++++++++---------------
 fs/btrfs/reflink.c |  1 +
 4 files changed, 91 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index af2bd059daae..67ca25daf9c8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1191,6 +1191,22 @@ struct btrfs_clone_extent_info {
 	u64 file_offset;
 	char *extent_buf;
 	u32 item_size;
+	/*
+	 * Set to true when attempting to replace a file range with a new extent
+	 * described by this structure, set to false when attempting to clone an
+	 * existing extent into a file range.
+	 */
+	bool is_new_extent;
+	/* Meaningful only if is_new_extent is true. */
+	int qgroup_reserved;
+	/*
+	 * Meaningful only if is_new_extent is true.
+	 * Used to track how many extent items we have already inserted in a
+	 * subvolume tree that refer to the extent described by this structure,
+	 * so that we know when to create a new delayed ref or update an existing
+	 * one.
+	 */
+	int insertions;
 };
 
 struct btrfs_file_private {
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index af4eab9cbc51..73827c9c7a70 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2583,7 +2583,6 @@ static int btrfs_insert_clone_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int slot;
 	struct btrfs_ref ref = { 0 };
-	u64 ref_offset;
 	int ret;
 
 	if (clone_len == 0)
@@ -2608,6 +2607,8 @@ static int btrfs_insert_clone_extent(struct btrfs_trans_handle *trans,
 	extent = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 	btrfs_set_file_extent_offset(leaf, extent, clone_info->data_offset);
 	btrfs_set_file_extent_num_bytes(leaf, extent, clone_len);
+	if (clone_info->is_new_extent)
+		btrfs_set_file_extent_generation(leaf, extent, trans->transid);
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
@@ -2621,13 +2622,29 @@ static int btrfs_insert_clone_extent(struct btrfs_trans_handle *trans,
 		return 0;
 
 	inode_add_bytes(inode, clone_len);
-	btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
-			       clone_info->disk_offset,
-			       clone_info->disk_len, 0);
-	ref_offset = clone_info->file_offset - clone_info->data_offset;
-	btrfs_init_data_ref(&ref, root->root_key.objectid,
-			    btrfs_ino(BTRFS_I(inode)), ref_offset);
-	ret = btrfs_inc_extent_ref(trans, &ref);
+
+	if (clone_info->is_new_extent && clone_info->insertions == 0) {
+		key.objectid = clone_info->disk_offset;
+		key.type = BTRFS_EXTENT_ITEM_KEY;
+		key.offset = clone_info->disk_len;
+		ret = btrfs_alloc_reserved_file_extent(trans, root,
+						       btrfs_ino(BTRFS_I(inode)),
+						       clone_info->file_offset,
+						       clone_info->qgroup_reserved,
+						       &key);
+	} else {
+		u64 ref_offset;
+
+		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
+				       clone_info->disk_offset,
+				       clone_info->disk_len, 0);
+		ref_offset = clone_info->file_offset - clone_info->data_offset;
+		btrfs_init_data_ref(&ref, root->root_key.objectid,
+				    btrfs_ino(BTRFS_I(inode)), ref_offset);
+		ret = btrfs_inc_extent_ref(trans, &ref);
+	}
+
+	clone_info->insertions++;
 
 	return ret;
 }
@@ -2705,7 +2722,8 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			 * returned by __btrfs_drop_extents() without having
 			 * changed anything in the file.
 			 */
-			if (clone_info && ret && ret != -EOPNOTSUPP)
+			if (clone_info && !clone_info->is_new_extent &&
+			    ret && ret != -EOPNOTSUPP)
 				btrfs_abort_transaction(trans, ret);
 			break;
 		}
@@ -2800,7 +2818,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 	 * than 16Mb would force the full fsync any way (when
 	 * try_release_extent_mapping() is invoked during page cache truncation.
 	 */
-	if (clone_info)
+	if (clone_info && !clone_info->is_new_extent)
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 			&BTRFS_I(inode)->runtime_flags);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 170a929eec81..a9a4c3d5984c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9575,11 +9575,15 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int insert_prealloc_file_extent(struct btrfs_trans_handle *trans,
+static struct btrfs_trans_handle *insert_prealloc_file_extent(
+				       struct btrfs_trans_handle *trans_in,
 				       struct inode *inode, struct btrfs_key *ins,
 				       u64 file_offset)
 {
 	struct btrfs_file_extent_item stack_fi;
+	struct btrfs_clone_extent_info extent_info;
+	struct btrfs_trans_handle *trans = trans_in;
+	struct btrfs_path *path;
 	u64 start = ins->objectid;
 	u64 len = ins->offset;
 	int ret;
@@ -9596,10 +9600,41 @@ static int insert_prealloc_file_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_qgroup_release_data(BTRFS_I(inode), file_offset, len);
 	if (ret < 0)
-		return ret;
-	return insert_reserved_file_extent(trans, BTRFS_I(inode), file_offset,
-					   &stack_fi, ret);
+		return ERR_PTR(ret);
+
+	if (trans) {
+		ret = insert_reserved_file_extent(trans, BTRFS_I(inode),
+						  file_offset, &stack_fi, ret);
+		if (ret)
+			return ERR_PTR(ret);
+		return trans;
+	}
+
+	extent_info.disk_offset = start;
+	extent_info.disk_len = len;
+	extent_info.data_offset = 0;
+	extent_info.data_len = len;
+	extent_info.file_offset = file_offset;
+	extent_info.extent_buf = (char *)&stack_fi;
+	extent_info.item_size = sizeof(stack_fi);
+	extent_info.is_new_extent = true;
+	extent_info.qgroup_reserved = ret;
+	extent_info.insertions = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	ret = btrfs_punch_hole_range(inode, path, file_offset,
+				     file_offset + len - 1, &extent_info,
+				     &trans);
+	btrfs_free_path(path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return trans;
 }
+
 static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 				       u64 start, u64 num_bytes, u64 min_size,
 				       loff_t actual_len, u64 *alloc_hint,
@@ -9622,14 +9657,6 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 	if (trans)
 		own_trans = false;
 	while (num_bytes > 0) {
-		if (own_trans) {
-			trans = btrfs_start_transaction(root, 3);
-			if (IS_ERR(trans)) {
-				ret = PTR_ERR(trans);
-				break;
-			}
-		}
-
 		cur_bytes = min_t(u64, num_bytes, SZ_256M);
 		cur_bytes = max(cur_bytes, min_size);
 		/*
@@ -9641,11 +9668,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		cur_bytes = min(cur_bytes, last_alloc);
 		ret = btrfs_reserve_extent(root, cur_bytes, cur_bytes,
 				min_size, 0, *alloc_hint, &ins, 1, 0);
-		if (ret) {
-			if (own_trans)
-				btrfs_end_transaction(trans);
+		if (ret)
 			break;
-		}
 
 		/*
 		 * We've reserved this space, and thus converted it from
@@ -9658,13 +9682,11 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 
 		last_alloc = ins.offset;
-		ret = insert_prealloc_file_extent(trans, inode, &ins, cur_offset);
-		if (ret) {
+		trans = insert_prealloc_file_extent(trans, inode, &ins, cur_offset);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
 			btrfs_free_reserved_extent(fs_info, ins.objectid,
 						   ins.offset, 0);
-			btrfs_abort_transaction(trans, ret);
-			if (own_trans)
-				btrfs_end_transaction(trans);
 			break;
 		}
 
@@ -9727,8 +9749,10 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			break;
 		}
 
-		if (own_trans)
+		if (own_trans) {
 			btrfs_end_transaction(trans);
+			trans = NULL;
+		}
 	}
 	if (clear_offset < end)
 		btrfs_free_reserved_data_space(BTRFS_I(inode), NULL, clear_offset,
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 2461be6ccb6f..3c03126b52b1 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -463,6 +463,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			clone_info.file_offset = new_key.offset;
 			clone_info.extent_buf = buf;
 			clone_info.item_size = size;
+			clone_info.is_new_extent = false;
 			ret = btrfs_punch_hole_range(inode, path, drop_start,
 					new_key.offset + datal - 1, &clone_info,
 					&trans);
-- 
2.26.2

