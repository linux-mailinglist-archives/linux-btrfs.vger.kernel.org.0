Return-Path: <linux-btrfs+bounces-14921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CFDAE69DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E55D1C2827A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9F22E0B75;
	Tue, 24 Jun 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu1L22E3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A92E0B6D
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776152; cv=none; b=NvbQZKr2Z0tDE5/6sHV4pr7Sa7dpXbj2osi0cQWSmn9cmp/56juk//Fb+Pm2dcDwe7Um9AV2k73/pusuI9curH67ahzCvMoLPBTrHrE4WR1oqYs8g+jSZtVAdI8NdH4R5SsWOAgXwqDkCmxOWRr7cBYVX+8f/JlPfRi3ORGoiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776152; c=relaxed/simple;
	bh=rK4jodbkLYE4WYwwIOkGFnckgPjP/CJ0qpudhvruQo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9hNMgoaDRTV3E20lZ320Y8XotBcfu9A1CfdhZpH6cjqFRT5zcFHffu9iKDHhw8nmnVxgweQADtKBVTBSrpUUyUAMV4bGMn4Ye5b2jYVJJIiL38CIjIsMppPocMVfso8sJE/zJAj/Wnzc4xMAw5lNZ/uU/De7f2bvp3vv8Oxf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu1L22E3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D9C4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776151;
	bh=rK4jodbkLYE4WYwwIOkGFnckgPjP/CJ0qpudhvruQo4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hu1L22E3LAzM/k4XMDyOeQ1QB1n5XqjvPB3gFeaYHCDdLx/i4DKdM9OMUxmPdW1SL
	 qy4ckbUQx1qVC9+n6RDDjcqC5ldBHnIA8Vm0MLOnOtbzf0wcVIxFJH1+Rc5Kuq7246
	 KYVcfzgfdlighZeXLkAYwD/iUh6eKhDMOMleSSALTxmyMFGpUH/ZgI/83fyVSc0b9s
	 QMsE5xlP/JUm8xhW8AF4VsyfURGhxelp9IBXhlDR5TH3by05NfgVTB2jUeLsXO4aGB
	 +s0BZf0DB0HeIq5VnNgvG/KI2BhbdZ21G0wcQMm0ZqKbx0xMD535eePH4b3yHuPTvf
	 ywNjAshltyKWg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/12] btrfs: propagate last_unlink_trans earlier when doing a rmdir
Date: Tue, 24 Jun 2025 15:42:15 +0100
Message-ID: <cb814b7a99065d951af9ae37b31a986e6c4eb3aa.1750709411.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750709410.git.fdmanana@suse.com>
References: <cover.1750709410.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In case the removed directory had a snapshot that was deleted, we are
propagating its inode's last_unlink_trans to the parent directory after
we removed the entry from the parent directory. This leaves a small race
window where someone can log the parent directory after we removed the
entry and before we updated last_unlink_trans, and as a result if we ever
try to replay such a log tree, we will fail since we will attempt to
remove a snapshot during log replay, which is currently not possible and
results in the log replay (and mount) to fail. This is the type of failure
described in commit 1ec9a1ae1e30 ("Btrfs: fix unreplayable log after
snapshot delete + parent dir fsync").

So fix this by propagating the last_unlink_trans to the parent directory
before we remove the entry from it.

Fixes: 44f714dae50a ("Btrfs: improve performance on fsync against new inode after rename/unlink")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 80c72c594b19..252271cbde28 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4707,7 +4707,6 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	int ret = 0;
 	struct btrfs_trans_handle *trans;
-	u64 last_unlink_trans;
 	struct fscrypt_name fname;
 
 	if (inode->i_size > BTRFS_EMPTY_DIR_SIZE)
@@ -4733,6 +4732,23 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 		goto out_notrans;
 	}
 
+	/*
+	 * Propagate the last_unlink_trans value of the deleted dir to its
+	 * parent directory. This is to prevent an unrecoverable log tree in the
+	 * case we do something like this:
+	 * 1) create dir foo
+	 * 2) create snapshot under dir foo
+	 * 3) delete the snapshot
+	 * 4) rmdir foo
+	 * 5) mkdir foo
+	 * 6) fsync foo or some file inside foo
+	 *
+	 * This is because we can't unlink other roots when replaying the dir
+	 * deletes for directory foo.
+	 */
+	if (BTRFS_I(inode)->last_unlink_trans >= trans->transid)
+		BTRFS_I(dir)->last_unlink_trans = BTRFS_I(inode)->last_unlink_trans;
+
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 		ret = btrfs_unlink_subvol(trans, BTRFS_I(dir), dentry);
 		goto out;
@@ -4742,27 +4758,11 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	if (ret)
 		goto out;
 
-	last_unlink_trans = BTRFS_I(inode)->last_unlink_trans;
-
 	/* now the directory is empty */
 	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
 				 &fname.disk_name);
-	if (!ret) {
+	if (!ret)
 		btrfs_i_size_write(BTRFS_I(inode), 0);
-		/*
-		 * Propagate the last_unlink_trans value of the deleted dir to
-		 * its parent directory. This is to prevent an unrecoverable
-		 * log tree in the case we do something like this:
-		 * 1) create dir foo
-		 * 2) create snapshot under dir foo
-		 * 3) delete the snapshot
-		 * 4) rmdir foo
-		 * 5) mkdir foo
-		 * 6) fsync foo or some file inside foo
-		 */
-		if (last_unlink_trans >= trans->transid)
-			BTRFS_I(dir)->last_unlink_trans = last_unlink_trans;
-	}
 out:
 	btrfs_end_transaction(trans);
 out_notrans:
-- 
2.47.2


