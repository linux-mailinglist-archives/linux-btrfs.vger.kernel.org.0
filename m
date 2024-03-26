Return-Path: <linux-btrfs+bounces-3628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD5088D02B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4BA1F816E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD1513D88B;
	Tue, 26 Mar 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YMsWxaHb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TX2CL0ew"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76313D898
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489070; cv=none; b=p1obbVXhOUsNKkARldj+B41fUPcUTIlmZUlK1UEPjvWvd304MLHElPWBqJeAIJKLkXJwWvlqTum9lbon+qXfNvh3hGn39v+6MWxT9Y7BMH1y5JD6Az6ANsG9iv91Hl0BMwnA1tD7LfpVq0r3PVerxZS61RUXMxO6vF+OyNdOzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489070; c=relaxed/simple;
	bh=Xh5ZZhgH4SWzJjQicbvfxNBuzp+JbWLWzOd/jrmG04o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRhNB5ciXc9kGLXo/McetnhJ9iHc6aQZOITLPiEkbuloX7jU51zdV+yKw2YD4XaCei1cfIfgH4Yq5pYvlAZRqakFtIw7uT10IcWZ7QLw7ozdVzvnv1kkXYxR13wQcgvv1NZGWPbBhrOC4VB/cPB30Hi/KV4m56PqNsA3Pw9bzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YMsWxaHb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TX2CL0ew; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id A4B123200A02;
	Tue, 26 Mar 2024 17:37:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 17:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711489067; x=
	1711575467; bh=jd+5cAW6LzqI5yoBgGOnQvFIM2GqhsAC2GG+ZsW2aJk=; b=Y
	MsWxaHbPabrj0IPLVsG5gyt7VA/VrxRlfNExTXCLW9vOmTNnw6kbyrJd5mL9vmDK
	MW8dJh4Lt3IgSu994LOp1m1wdR1V+98HEGqCrCNC2B5nJHsMj0zvGO0JAP8hcopX
	g85Nh5kqBA+GuwCZ91s3ma/mJJ7UH6vWLNqntlBYhIsMHldPVUTbFuYr4E9nqO+L
	YedihQwVlabMNZf/g3BubwURNLZQn6OK4eE0UMW80aWeiHwonmg4W7EJBiY5Fd1Y
	FhjmDiEUuFAjrI7et+bCSpOwtMdKiKnq/Kypnp1ReNB55thGlaHBAKh4Scl/FpwJ
	C/QsDBVtPWOvcqqCqvOlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711489067; x=1711575467; bh=jd+5cAW6LzqI5
	yoBgGOnQvFIM2GqhsAC2GG+ZsW2aJk=; b=TX2CL0ewdGBpkfhmlSQMop4fhqrSe
	FFUEGsDk30/bdAD1egcbDp089eQCCAOVZB4fT+Vw2QsFYIi0oJXS1hc0ZGAa7wgt
	Dc/qN0BFoLLOaO+GhnBv9I+JNRTi74pjkXfSfBA9VetLddFsE3TJRaMZt/6yAou8
	Z7pamEpISQjk1l0DEzh8aBmTgvYuSZ26wAZBMsWNMNDsl/AELMYSqFVG3m2aduDY
	CYNHv+yaeamQwRv1euKeqxzidTB1sr6TVd0lxXSXuCoHHBVCoXWgEPH7k6V7F+FO
	vsiWsNBn6LS6JG9wy1g3vZZZAJXz1uRXhWFz1YwNr8zKSMsT/8FddHi1Q==
X-ME-Sender: <xms:KkADZgJrNAP61keRbBbVf-B3sBkYzXG0OWUnVXQEvJO33i6X4LOJkg>
    <xme:KkADZgJ4Qx8q3G1-5dlPW_QmIpd83h1gelWGOfKc-1uh9HhwJq0pvlHFDz7Fc_ylh
    TpggzttMxs_gt5rp1A>
X-ME-Received: <xmr:KkADZgs9xEJaA79q-Afw5_mls1XeHeRiBuXykgEnIuevjn0r5UAZzU-AMOlaQjYVUhzodnbW8roB1ks3LQSsr0IlktI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:KkADZtZLbdHXiJxVWQ4eEZUVFPY1F5-vgckAle0QLACFJ-qOSkUATA>
    <xmx:K0ADZnZSNxeJuEpviH1LKDE_jESs7RjX2JtBk9cxzHeFM2GSFYK5uw>
    <xmx:K0ADZpC8UnC5bv41UX54f1zHwjIdo7Uwj2aV-ZbyQJMNU-lMH0780Q>
    <xmx:K0ADZtY6AVBZtcVTc1_0gWOatMWuDqz8yAa87mZXgiwu5pJFGQ9kBg>
    <xmx:K0ADZuy7ddz-A0lVSf5JciOPJxCFZdldAM_pEegPDN39KdWJuPXDRA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 17:37:46 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/7] btrfs: fix qgroup prealloc rsv leak in subvolume operations
Date: Tue, 26 Mar 2024 14:39:36 -0700
Message-ID: <c39e9aea5fa5e22c42fcea3d810d78cb499312ff.1711488980.git.boris@bur.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711488980.git.boris@bur.io>
References: <cover.1711488980.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create subvol, create snapshot and delete subvol all use
btrfs_subvolume_reserve_metadata to reserve metadata for the changes
done to the parent subvolume's fs tree, which cannot be mediated in the
normal way via start_transaction. When quota groups (squota or qgroups)
are enabled, this reserves qgroup metadata of type PREALLOC. Once the
operation is associated to a transaction, we convert PREALLOC to
PERTRANS, which gets cleared in bulk at the end of the transaction.

However, the error paths of these three operations were not implementing
this lifecycle correctly. They unconditionally converted the PREALLOC to
PERTRANS in a generic cleanup step regardless of errors or whether the
operation was fully associated to a transaction or not. This resulted in
error paths occasionally converting this rsv to PERTRANS without calling
record_root_in_trans successfully, which meant that unless that root got
recorded in the transaction by some other thread, the end of the
transaction would not free that root's PERTRANS, leaking it. Ultimately,
this resulted in hitting a WARN in CONFIG_BTRFS_DEBUG builds at unmount
for the leaked reservation.

The fix is to ensure that every qgroup PREALLOC reservation observes the
following properties:
1. any failure before record_root_in_trans is called successfully
   results in freeing the PREALLOC reservation.
2. after record_root_in_trans, we convert to PERTRANS, and now the
   transaction owns freeing the reservation.

This patch enforces those properties on the three operations. Without
it, generic/269 with squotas enabled at MKFS time would fail in ~5-10
runs on my system. With this patch, it ran successfully 1000 times in a
row.

Fixes: e85fde5162bf ("btrfs: qgroup: fix qgroup meta rsv leak for subvolume operations")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c     | 13 ++++++++++++-
 fs/btrfs/ioctl.c     | 37 ++++++++++++++++++++++++++++---------
 fs/btrfs/root-tree.c | 10 ----------
 fs/btrfs/root-tree.h |  2 --
 4 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 09f0a20b5ce8..2587a2e25e44 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4503,6 +4503,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_block_rsv block_rsv;
 	u64 root_flags;
+	u64 qgroup_reserved = 0;
 	int ret;
 
 	down_write(&fs_info->subvol_sem);
@@ -4547,12 +4548,20 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
 	if (ret)
 		goto out_undead;
+	qgroup_reserved = block_rsv.qgroup_rsv_reserved;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_release;
 	}
+	ret = btrfs_record_root_in_trans(trans, root);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out_end_trans;
+	}
+	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+	qgroup_reserved = 0;
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
 
@@ -4611,7 +4620,9 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	ret = btrfs_end_transaction(trans);
 	inode->i_flags |= S_DEAD;
 out_release:
-	btrfs_subvolume_release_metadata(root, &block_rsv);
+	btrfs_block_rsv_release(fs_info, &block_rsv, (u64)-1, NULL);
+	if (qgroup_reserved)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 out_undead:
 	if (ret) {
 		spin_lock(&dest->root_item_lock);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e3a72292eda9..888dc92c6c75 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -613,6 +613,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	int ret;
 	dev_t anon_dev;
 	u64 objectid;
+	u64 qgroup_reserved = 0;
 
 	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
 	if (!root_item)
@@ -650,13 +651,18 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 					       trans_num_items, false);
 	if (ret)
 		goto out_new_inode_args;
+	qgroup_reserved = block_rsv.qgroup_rsv_reserved;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
-		btrfs_subvolume_release_metadata(root, &block_rsv);
-		goto out_new_inode_args;
+		goto out_release_rsv;
 	}
+	ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
+	if (ret)
+		goto out;
+	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+	qgroup_reserved = 0;
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
 	/* Tree log can't currently deal with an inode which is a new root. */
@@ -767,9 +773,11 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 out:
 	trans->block_rsv = NULL;
 	trans->bytes_reserved = 0;
-	btrfs_subvolume_release_metadata(root, &block_rsv);
-
 	btrfs_end_transaction(trans);
+out_release_rsv:
+	btrfs_block_rsv_release(fs_info, &block_rsv, (u64)-1, NULL);
+	if (qgroup_reserved)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 out_new_inode_args:
 	btrfs_new_inode_args_destroy(&new_inode_args);
 out_inode:
@@ -791,6 +799,8 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	struct btrfs_pending_snapshot *pending_snapshot;
 	unsigned int trans_num_items;
 	struct btrfs_trans_handle *trans;
+	struct btrfs_block_rsv *block_rsv;
+	u64 qgroup_reserved = 0;
 	int ret;
 
 	/* We do not support snapshotting right now. */
@@ -827,19 +837,19 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		goto free_pending;
 	}
 
-	btrfs_init_block_rsv(&pending_snapshot->block_rsv,
-			     BTRFS_BLOCK_RSV_TEMP);
+	block_rsv = &pending_snapshot->block_rsv;
+	btrfs_init_block_rsv(block_rsv, BTRFS_BLOCK_RSV_TEMP);
 	/*
 	 * 1 to add dir item
 	 * 1 to add dir index
 	 * 1 to update parent inode item
 	 */
 	trans_num_items = create_subvol_num_items(inherit) + 3;
-	ret = btrfs_subvolume_reserve_metadata(BTRFS_I(dir)->root,
-					       &pending_snapshot->block_rsv,
+	ret = btrfs_subvolume_reserve_metadata(BTRFS_I(dir)->root, block_rsv,
 					       trans_num_items, false);
 	if (ret)
 		goto free_pending;
+	qgroup_reserved = block_rsv->qgroup_rsv_reserved;
 
 	pending_snapshot->dentry = dentry;
 	pending_snapshot->root = root;
@@ -852,6 +862,13 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		ret = PTR_ERR(trans);
 		goto fail;
 	}
+	ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
+	if (ret) {
+		btrfs_end_transaction(trans);
+		goto fail;
+	}
+	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+	qgroup_reserved = 0;
 
 	trans->pending_snapshot = pending_snapshot;
 
@@ -881,7 +898,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	if (ret && pending_snapshot->snap)
 		pending_snapshot->snap->anon_dev = 0;
 	btrfs_put_root(pending_snapshot->snap);
-	btrfs_subvolume_release_metadata(root, &pending_snapshot->block_rsv);
+	btrfs_block_rsv_release(fs_info, block_rsv, (u64)-1, NULL);
+	if (qgroup_reserved)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 free_pending:
 	if (pending_snapshot->anon_dev)
 		free_anon_bdev(pending_snapshot->anon_dev);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 4bb538a372ce..7007f9e0c972 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -548,13 +548,3 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 	}
 	return ret;
 }
-
-void btrfs_subvolume_release_metadata(struct btrfs_root *root,
-				      struct btrfs_block_rsv *rsv)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	u64 qgroup_to_release;
-
-	btrfs_block_rsv_release(fs_info, rsv, (u64)-1, &qgroup_to_release);
-	btrfs_qgroup_convert_reserved_meta(root, qgroup_to_release);
-}
diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
index 6f929cf3bd49..8f5739e732b9 100644
--- a/fs/btrfs/root-tree.h
+++ b/fs/btrfs/root-tree.h
@@ -18,8 +18,6 @@ struct btrfs_trans_handle;
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
-void btrfs_subvolume_release_metadata(struct btrfs_root *root,
-				      struct btrfs_block_rsv *rsv);
 int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		       u64 ref_id, u64 dirid, u64 sequence,
 		       const struct fscrypt_str *name);
-- 
2.44.0


