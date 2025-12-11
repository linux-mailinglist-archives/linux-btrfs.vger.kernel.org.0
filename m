Return-Path: <linux-btrfs+bounces-19660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC00CB65C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 16:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DA39300F9F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 15:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD45730F7F8;
	Thu, 11 Dec 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEsC36Yg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E52B2DA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765467618; cv=none; b=H41CBiZKamQyKpVdsjxrigo41RFZYGDuCT24NLYvO2mqrXnxSvdu897AyRxGOaSIYjwYincf51ppymJ/k24VGfc+KDx5BNUWMSp1VpcMLPBvhBJ1S+Z3KGpqshgkHo2a9tLhe2j0uDCUCqngi+mODRQeVaATAF3SjARKXwkCu+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765467618; c=relaxed/simple;
	bh=MUfnE2aP+U28yrWr+tbhiOR3pHooQk2PSj1/JdM3SJI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Abs0R4R5gj3tUFnrzbR9Z74CZnpFK9YVshirrcVAKYI5pPDrgqEtYxW4kbUcMxc6mKsnMfxreStn6xCQ5fWhQIGG2hklaqbqarMdXh9VXo8HGSzQ7j7tS/vNLxDXUHXLhNrTPcopbeDsxPyI5emV1Wkbmy2dQ4ZJttHU5hfs1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEsC36Yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047DEC4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765467616;
	bh=MUfnE2aP+U28yrWr+tbhiOR3pHooQk2PSj1/JdM3SJI=;
	h=From:To:Subject:Date:From;
	b=sEsC36Yg6DTppMep+Xf/etUO3/Fmhk/GleDxm1ojN5wB87neheDk3acngXPMnsIri
	 2pbzmlp5iG+xoxGP+8U/a6alyR7GikqjA+jcQ2NCCDNMc7nWfUN1Ue4cXJT1OuS+fn
	 EgNUPLoUa0vZ4TPS9eK7CHs7RGfRJ9b07ckkI/0WdkwF7R9B/rSpg9j1PgulWV6hud
	 OTea+2Ixx/XG18nCgIHi2BdE0z5tJ5mSvQNj5s8WQhBAg9k4PkTHNw4mBd9fr10Lh5
	 uLb0MebsAXACNlhZW+CZAegDZEcMB3CPpckoTzolGzVnttwRAV4z88P4113FhdaQDh
	 Yr8EM8uH0LjDw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: always detect conflicting inodes when logging inode refs
Date: Thu, 11 Dec 2025 15:40:12 +0000
Message-ID: <499db40a3737c8517f4702d85a7d969664ded734.1765466831.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After rename exchanging (either with the rename exchange operation or
regular renames in multiple non-atomic steps) two inodes and at least
one of them is a directory, we can end up with a log tree that contains
only of the inodes and after a power failure that can result in an attempt
to delete the other inode when it should not because it was not deleted
before the power failure. In some case that delete attempt fails when
the target inode is a directory that contains a subvolume inside it, since
the log replay code is not prepared to deal with directory entries that
point to root items (only inode items).

1) We have directories "dir1" (inode A) and "dir2" (inode B) under the
   same parent directory;

2) We have a file (inode C) under directory "dir1" (inode A);

3) We have a subvolume inside directory "dir2" (inode B);

4) All these inodes were persisted in a past transaction and we are
   currently at transaction N;

5) We rename the file (inode C), so at btrfs_log_new_name() we update
   inode C's last_unlink_trans to N;

6) We get a rename exchange for "dir1" (inode A) and "dir2" (inode B),
   so after the exchange "dir1" is inode B and "dir2" is inode A.
   During the rename exchange we call btrfs_log_new_name() for inodes
   A and B, but because they are directories, we don't update their
   last_unlink_trans to N;

7) An fsync against the file (inode C) is done, and because its inode
   has a last_unlink_trans with a value of N we log its parent directory
   (inode A) (through btrfs_log_all_parents(), called from
   btrfs_log_inode_parent()).

8) So we end up with inode B not logged, which now has the old name
   of inode A. At copy_inode_items_to_log(), when logging inode A, we
   did not check if we had any conflicting inode to log because inode
   A has a generation lower than the current transaction (created in
   a past transaction);

9) After a power failure, when replaying the log tree, since we find that
   inode A has a new name that conflicts with the name of inode B in the
   fs tree, we attempt to delete inode B... this is wrong since that
   directory was never deleted before the power failure, and because there
   is a subvolume inside that directory, attempting to delete it will fail
   since replay_dir_deletes() and btrfs_unlink_inode() are not prepared
   to deal with dir items that point to roots instead of inodes.

   When that happens the mount fails and we get a stack trace like the
   following:

   [690687.231453] BTRFS info (device dm-0): start tree-log replay
   [690687.231838] BTRFS critical (device dm-0): failed to delete reference to subvol, root 5 inode 256 parent 259
   [690687.233257] ------------[ cut here ]------------
   [690687.233871] BTRFS: Transaction aborted (error -2)
   [690687.234627] WARNING: CPU: 1 PID: 638968 at fs/btrfs/inode.c:4345 __btrfs_unlink_inode+0x416/0x440 [btrfs]
   [690687.236894] Modules linked in: btrfs loop dm_thin_pool (...)
   [690687.247065] CPU: 1 UID: 0 PID: 638968 Comm: mount Tainted: G        W           6.18.0-rc7-btrfs-next-218+ #2 PREEMPT(full)
   [690687.248926] Tainted: [W]=WARN
   [690687.249433] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
   [690687.251471] RIP: 0010:__btrfs_unlink_inode+0x416/0x440 [btrfs]
   [690687.253828] Code: c0 89 04 24 (...)
   [690687.256806] RSP: 0018:ffffc0e741f4b9b8 EFLAGS: 00010286
   [690687.257439] RAX: 0000000000000000 RBX: ffff9d3ec8a6cf60 RCX: 0000000000000000
   [690687.258273] RDX: 0000000000000002 RSI: ffffffff84ab45a1 RDI: 00000000ffffffff
   [690687.259150] RBP: ffff9d3ec8a6ef20 R08: 0000000000000000 R09: ffffc0e741f4b840
   [690687.259953] R10: ffff9d45dc1fffa8 R11: 0000000000000003 R12: ffff9d3ee26d77e0
   [690687.260871] R13: ffffc0e741f4ba98 R14: ffff9d4458040800 R15: ffff9d44b6b7ca10
   [690687.261883] FS:  00007f7b9603a840(0000) GS:ffff9d4658982000(0000) knlGS:0000000000000000
   [690687.262976] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   [690687.263765] CR2: 00007ffc9ec33b98 CR3: 000000011273e003 CR4: 0000000000370ef0
   [690687.264827] Call Trace:
   [690687.265160]  <TASK>
   [690687.265442]  btrfs_unlink_inode+0x15/0x40 [btrfs]
   [690687.266106]  unlink_inode_for_log_replay+0x27/0xf0 [btrfs]
   [690687.266949]  check_item_in_log+0x1ea/0x2c0 [btrfs]
   [690687.267664]  replay_dir_deletes+0x16b/0x380 [btrfs]
   [690687.268485]  fixup_inode_link_count+0x34b/0x370 [btrfs]
   [690687.269675]  fixup_inode_link_counts+0x41/0x160 [btrfs]
   [690687.270397]  btrfs_recover_log_trees+0x1ff/0x7c0 [btrfs]
   [690687.271164]  ? __pfx_replay_one_buffer+0x10/0x10 [btrfs]
   [690687.271993]  open_ctree+0x10bb/0x15f0 [btrfs]
   [690687.272672]  btrfs_get_tree.cold+0xb/0x16c [btrfs]
   [690687.273414]  ? fscontext_read+0x15c/0x180
   [690687.274000]  ? rw_verify_area+0x50/0x180
   [690687.274610]  vfs_get_tree+0x25/0xd0
   [690687.275071]  vfs_cmd_create+0x59/0xe0
   [690687.275513]  __do_sys_fsconfig+0x4f6/0x6b0
   [690687.276013]  do_syscall_64+0x50/0x1220
   [690687.276474]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
   [690687.277082] RIP: 0033:0x7f7b9625f4aa
   [690687.277522] Code: 73 01 c3 48 (...)
   [690687.280368] RSP: 002b:00007ffc9ec35b08 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
   [690687.281714] RAX: ffffffffffffffda RBX: 0000558bfa91ac20 RCX: 00007f7b9625f4aa
   [690687.282977] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
   [690687.284214] RBP: 0000558bfa91b120 R08: 0000000000000000 R09: 0000000000000000
   [690687.285475] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
   [690687.286427] R13: 00007f7b963f1580 R14: 00007f7b963f326c R15: 00007f7b963d8a23
   [690687.287788]  </TASK>
   [690687.288265] ---[ end trace 0000000000000000 ]---
   [690687.289129] BTRFS: error (device dm-0 state A) in __btrfs_unlink_inode:4345: errno=-2 No such entry
   [690687.290487] BTRFS: error (device dm-0 state EAO) in do_abort_log_replay:191: errno=-2 No such entry
   [690687.291528] BTRFS critical (device dm-0 state EAO): log tree (for root 5) leaf currently being processed (slot 7 key (258 12 257)):
   [690687.292979] BTRFS info (device dm-0 state EAO): leaf 30736384 gen 10 total ptrs 7 free space 15712 owner 18446744073709551610
   [690687.292982] BTRFS info (device dm-0 state EAO): refs 3 lock_owner 0 current 638968
   [690687.292984]      item 0 key (257 INODE_ITEM 0) itemoff 16123 itemsize 160
   [690687.292986]              inode generation 9 transid 10 size 0 nbytes 0
   [690687.292988]              block group 0 mode 40755 links 1 uid 0 gid 0
   [690687.292989]              rdev 0 sequence 7 flags 0x0
   [690687.292990]              atime 1765464494.678070921
   [690687.292991]              ctime 1765464494.686606513
   [690687.292992]              mtime 1765464494.686606513
   [690687.292993]              otime 1765464494.678070921
   [690687.292994]      item 1 key (257 INODE_REF 256) itemoff 16109 itemsize 14
   [690687.292995]              index 4 name_len 4
   [690687.292996]      item 2 key (257 DIR_LOG_INDEX 2) itemoff 16101 itemsize 8
   [690687.292997]              dir log end 2
   [690687.292998]      item 3 key (257 DIR_LOG_INDEX 3) itemoff 16093 itemsize 8
   [690687.292999]              dir log end 18446744073709551615
   [690687.293000]      item 4 key (257 DIR_INDEX 3) itemoff 16060 itemsize 33
   [690687.293001]              location key (258 1 0) type 1
   [690687.293002]              transid 10 data_len 0 name_len 3
   [690687.293003]      item 5 key (258 INODE_ITEM 0) itemoff 15900 itemsize 160
   [690687.293004]              inode generation 9 transid 10 size 0 nbytes 0
   [690687.293006]              block group 0 mode 100644 links 1 uid 0 gid 0
   [690687.293007]              rdev 0 sequence 2 flags 0x0
   [690687.293007]              atime 1765464494.678456467
   [690687.293008]              ctime 1765464494.686606513
   [690687.293009]              mtime 1765464494.678456467
   [690687.293010]              otime 1765464494.678456467
   [690687.293011]      item 6 key (258 INODE_REF 257) itemoff 15887 itemsize 13
   [690687.293012]              index 3 name_len 3
   [690687.293013] BTRFS critical (device dm-0 state EAO): log replay failed in unlink_inode_for_log_replay:1045 for root 5, stage 3, with error -2: failed to unlink inode 256 parent dir 259 name subvol root 5
   [690687.296322] BTRFS: error (device dm-0 state EAO) in btrfs_recover_log_trees:7743: errno=-2 No such entry
   [690687.298121] BTRFS: error (device dm-0 state EAO) in btrfs_replay_log:2083: errno=-2 No such entry (Failed to recover log tr

So fix this by changing copy_inode_items_to_log() to always detect if
there are conflicting inodes for the ref/extref of the inode being logged
even if the inode was created in a past transaction.

A test case for fstests will follow soon.

CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 31edc93a383e..5831754bb01c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6341,10 +6341,8 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 			 * and no keys greater than that, so bail out.
 			 */
 			break;
-		} else if ((min_key->type == BTRFS_INODE_REF_KEY ||
-			    min_key->type == BTRFS_INODE_EXTREF_KEY) &&
-			   (inode->generation == trans->transid ||
-			    ctx->logging_conflict_inodes)) {
+		} else if (min_key->type == BTRFS_INODE_REF_KEY ||
+			   min_key->type == BTRFS_INODE_EXTREF_KEY) {
 			u64 other_ino = 0;
 			u64 other_parent = 0;
 
-- 
2.47.2


