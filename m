Return-Path: <linux-btrfs+bounces-2675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8248618BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 18:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203791F2606E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B612BE99;
	Fri, 23 Feb 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIZjWPdn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234771292DB
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707803; cv=none; b=LDtD0GqRr+lf96LyFAkgjYRYr1STfopO5zI1MIaKMpZO5FdWCgvW0t/Qvcrnsi9t+jkqe+wVa+3PZQ7HInRsA1xvhgMuFbwjg+7S4KMHd3K7V50fX0tLpABWFWFpv9NUb7kQjI89uGFT15dh3ojsd2eb0JacBjfWhS8/TvXK5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707803; c=relaxed/simple;
	bh=XiSBJ4iXRPkQAM9qy87Z7DDGTdNslRRok2erKSadzCo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=KMplVKkFYS5U5eQ52Szd20yKLACvl4uDgIL4ozm76MsGQO1wj+34hX46TUpMv+wetuw6UlU4nchcRkcXVvHMbehmcYJZcTUfWLDs+OHvUOljgTEpnAbevm6L4KIIiGTpJVaDhLkiYRnmSdaXvxFBvudT8fXMisCn7rnRUmpAhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIZjWPdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421B3C433F1
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708707802;
	bh=XiSBJ4iXRPkQAM9qy87Z7DDGTdNslRRok2erKSadzCo=;
	h=From:To:Subject:Date:From;
	b=kIZjWPdnaKKLNbcNeJ7/NQvcdwfhTbGIPHOK3d8OPpYGr2naOX5GFxP8NoKLq1FtF
	 3YQTAPLBG1o130P/tx9omLRuXMObkykKrKCLil4lPzou/YesKMsFBhBDel+n4C8GTh
	 l+a2wZAOIXaQRkv8XKO0/riKm2HLInH7dnwR95uUvL/Y9Z6L8jvicnGEEcginhfNdK
	 BSK5FnQQ8mG+dDsam8c1dbxKXwrfVYtYecNcBoD8+GG3Jt/19gORaMufD1bCPH1NCY
	 C0RFFIAllRsXtG53W2eBbt7dWysxSi7rx5CRK3ZM6YKYQQEHvhWFCfCAqjUsPQaHL7
	 lgMaCmg9af1Ng==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix double free of anonymous device after snapshot creation failure
Date: Fri, 23 Feb 2024 17:03:19 +0000
Message-Id: <2b3c3fd6b5a6b9f9a7aa39cd343b233a11495bce.1708707655.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When creating a snapshot we may do a double free of an anonymous device
in case there's an error comitting the transaction. The second free may
result in freeing an anonymous device number that was allocated by some
other subsystem in the kernel or another btrfs filesystem.

The steps that lead to this:

1) At ioctl.c:create_snapshot() we allocate an anonymous device number
   and assign it to pending_snapshot->anon_dev;

2) Then we call btrfs_commit_transaction() and end up at
   transaction.c:create_pending_snapshot();

3) There we call btrfs_get_new_fs_root() and pass it the anonymous device
   number stored in pending_snapshot->anon_dev;

4) btrfs_get_new_fs_root() frees that anonymous device number because
   btrfs_lookup_fs_root() returned a root - someone else did a lookup
   of the new root already, which could some task doing backref walking;

5) After that some error happens in the transaction commit path, and at
   ioctl.c:create_snapshot() we jump to the 'fail' label, and after
   that we free again the same anonymous device number, which in the
   meanwhile may have been reallocated somewhere else, because
   pending_snapshot->anon_dev still has the same value as in step 1.

Recently syzbot ran into this and reported the following trace:

  ------------[ cut here ]------------
  ida_free called for id=51 which is not allocated.
  WARNING: CPU: 1 PID: 31038 at lib/idr.c:525 ida_free+0x370/0x420 lib/idr.c:525
  Modules linked in:
  CPU: 1 PID: 31038 Comm: syz-executor.2 Not tainted 6.8.0-rc4-syzkaller-00410-gc02197fc9076 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
  RIP: 0010:ida_free+0x370/0x420 lib/idr.c:525
  Code: 10 42 80 3c 28 (...)
  RSP: 0018:ffffc90015a67300 EFLAGS: 00010246
  RAX: be5130472f5dd000 RBX: 0000000000000033 RCX: 0000000000040000
  RDX: ffffc90009a7a000 RSI: 000000000003ffff RDI: 0000000000040000
  RBP: ffffc90015a673f0 R08: ffffffff81577992 R09: 1ffff92002b4cdb4
  R10: dffffc0000000000 R11: fffff52002b4cdb5 R12: 0000000000000246
  R13: dffffc0000000000 R14: ffffffff8e256b80 R15: 0000000000000246
  FS:  00007fca3f4b46c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f167a17b978 CR3: 000000001ed26000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   btrfs_get_root_ref+0xa48/0xaf0 fs/btrfs/disk-io.c:1346
   create_pending_snapshot+0xff2/0x2bc0 fs/btrfs/transaction.c:1837
   create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1931
   btrfs_commit_transaction+0xf1c/0x3740 fs/btrfs/transaction.c:2404
   create_snapshot+0x507/0x880 fs/btrfs/ioctl.c:848
   btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:998
   btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1044
   __btrfs_ioctl_snap_create+0x387/0x4b0 fs/btrfs/ioctl.c:1306
   btrfs_ioctl_snap_create_v2+0x1ca/0x400 fs/btrfs/ioctl.c:1393
   btrfs_ioctl+0xa74/0xd40
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:871 [inline]
   __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:857
   do_syscall_64+0xfb/0x240
   entry_SYSCALL_64_after_hwframe+0x6f/0x77
  RIP: 0033:0x7fca3e67dda9
  Code: 28 00 00 00 (...)
  RSP: 002b:00007fca3f4b40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007fca3e7abf80 RCX: 00007fca3e67dda9
  RDX: 00000000200005c0 RSI: 0000000050009417 RDI: 0000000000000003
  RBP: 00007fca3e6ca47a R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 000000000000000b R14: 00007fca3e7abf80 R15: 00007fff6bf95658
   </TASK>

Where we get an explicit message where we attempt to free an anonymous
device number that is not currently allocated. It happens in a different
code path from the example below, at btrfs_get_root_ref(), so this change
may not fix the case triggered by syzbot.

To fix at least the code path from the example above, change
btrfs_get_root_ref() and its callers to receive a dev_t pointer argument
for the anonymous device number, so that in case it frees the number, it
also resets it to 0, so that up in the call chain we don't attempt to do
the double free.

Link: https://lore.kernel.org/linux-btrfs/000000000000f673a1061202f630@google.com/
Fixes: e03ee2fe873e ("btrfs: do not ASSERT() if the newly created subvolume already got read")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c     | 22 +++++++++++-----------
 fs/btrfs/disk-io.h     |  2 +-
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/transaction.c |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a2e45ed6ef14..3df5477d48a8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1308,12 +1308,12 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
  *
  * @objectid:	root id
  * @anon_dev:	preallocated anonymous block device number for new roots,
- * 		pass 0 for new allocation.
+ *		pass NULL for a new allocation.
  * @check_ref:	whether to check root item references, If true, return -ENOENT
  *		for orphan roots
  */
 static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
-					     u64 objectid, dev_t anon_dev,
+					     u64 objectid, dev_t *anon_dev,
 					     bool check_ref)
 {
 	struct btrfs_root *root;
@@ -1343,9 +1343,9 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 		 * that common but still possible.  In that case, we just need
 		 * to free the anon_dev.
 		 */
-		if (unlikely(anon_dev)) {
-			free_anon_bdev(anon_dev);
-			anon_dev = 0;
+		if (unlikely(anon_dev && *anon_dev)) {
+			free_anon_bdev(*anon_dev);
+			*anon_dev = 0;
 		}
 
 		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
@@ -1367,7 +1367,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 		goto fail;
 	}
 
-	ret = btrfs_init_fs_root(root, anon_dev);
+	ret = btrfs_init_fs_root(root, anon_dev ? *anon_dev : 0);
 	if (ret)
 		goto fail;
 
@@ -1403,7 +1403,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 	 * root's anon_dev to 0 to avoid a double free, once by btrfs_put_root()
 	 * and once again by our caller.
 	 */
-	if (anon_dev)
+	if (anon_dev && *anon_dev)
 		root->anon_dev = 0;
 	btrfs_put_root(root);
 	return ERR_PTR(ret);
@@ -1419,7 +1419,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     u64 objectid, bool check_ref)
 {
-	return btrfs_get_root_ref(fs_info, objectid, 0, check_ref);
+	return btrfs_get_root_ref(fs_info, objectid, NULL, check_ref);
 }
 
 /*
@@ -1427,11 +1427,11 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
  * the anonymous block device id
  *
  * @objectid:	tree objectid
- * @anon_dev:	if zero, allocate a new anonymous block device or use the
- *		parameter value
+ * @anon_dev:	if NULL, allocate a new anonymous block device or use the
+ *		parameter value if not NULL
  */
 struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
-					 u64 objectid, dev_t anon_dev)
+					 u64 objectid, dev_t *anon_dev)
 {
 	return btrfs_get_root_ref(fs_info, objectid, anon_dev, true);
 }
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 375f62ae3709..76eb53fe7a11 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -73,7 +73,7 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     u64 objectid, bool check_ref);
 struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
-					 u64 objectid, dev_t anon_dev);
+					 u64 objectid, dev_t *anon_dev);
 struct btrfs_root *btrfs_get_fs_root_commit_root(struct btrfs_fs_info *fs_info,
 						 struct btrfs_path *path,
 						 u64 objectid);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8b80fbea1e72..29e2b8e23363 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -731,7 +731,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	free_extent_buffer(leaf);
 	leaf = NULL;
 
-	new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
+	new_root = btrfs_get_new_fs_root(fs_info, objectid, &anon_dev);
 	if (IS_ERR(new_root)) {
 		ret = PTR_ERR(new_root);
 		btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ea080ec2f927..31ac5a04cc02 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1832,7 +1832,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 
 	key.offset = (u64)-1;
-	pending->snap = btrfs_get_new_fs_root(fs_info, objectid, pending->anon_dev);
+	pending->snap = btrfs_get_new_fs_root(fs_info, objectid, &pending->anon_dev);
 	if (IS_ERR(pending->snap)) {
 		ret = PTR_ERR(pending->snap);
 		pending->snap = NULL;
-- 
2.40.1


