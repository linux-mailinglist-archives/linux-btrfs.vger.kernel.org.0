Return-Path: <linux-btrfs+bounces-15837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711CB1A002
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 12:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9D63B53F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC8253B52;
	Mon,  4 Aug 2025 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk1UyDOh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8D2528EF
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304585; cv=none; b=AKYRlH6t/OrWeTEeq3jCzSVx5L3ICK/pnxNWAS62hGyc/25vCZe/s6a65Z3K0/2o/LsyCEaAIU86ZUSVVsSYo6aU8sty9QqvIVgDJisvgmUAyP6T/93fR/9u0PitsfK0e4EdzjiO6I59mUlIPOztCMKsDoaWgMUEEuj3exrk8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304585; c=relaxed/simple;
	bh=561nzqH13zTkzu6RufF8Hwzp1vtidVspNNJQl4gFIHk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a79tP75ziv2XivriB84aJZig5g5Mrxxq1/L0YH1m3JzgV0fbDMgmfCZBeGIjAohktSJcFRfcjjz3lzX5y7065u37Tos4D/3CUL2Hd0A/urKrGDgK6T+001QNaOCopS5nNrZOZVkZa+I2cwoTX0PKdsXCoy4TvZFEBZZIK5fJEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk1UyDOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1C0C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 10:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754304584;
	bh=561nzqH13zTkzu6RufF8Hwzp1vtidVspNNJQl4gFIHk=;
	h=From:To:Subject:Date:From;
	b=Rk1UyDOhM/A8wLiC+elPQa/XJ7jppGqGAcj8jcKSAVhOQYU/WgUpNOLq38fNnplx3
	 CfRHovgea/Z5BrEl+Zg2Rjml5ADUyOXhFxWYh8yo93MuICZopCerWvGlzq6hhixe9A
	 vxc8XZ5+sPmVxdXqVy4zRr5HixDGVwaOYwne4BatzeOJOrdrK3mvy6xSmUC+pPIMUN
	 UPFrB6rR9cVmKvpfK9EGUnW6Z0x5D0rMOUVq4hXWjq1xl8A9Cgav6diJYHR9H4clLi
	 9kaUrYh2ByB+/QmT47Mm46dUvs+/B2ZaOgJSnpqhXvitn2HlMm7E3KpISAJ9DHurX4
	 pqu6tMqrW3lYQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not set mtime/ctime to current time when unlinking for log replay
Date: Mon,  4 Aug 2025 11:49:41 +0100
Message-ID: <eb58e42ddc016bff18f179b4ef4507d6fe37e73d.1754304373.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we are doing an unlink for log replay, we are updating the directory's
mtime and ctime to the current time, and this is incorrect since it should
stay with the mtime and ctime that were set when the directory was logged.

This is the same as when adding a link to an inode during log replay (with
btrfs_add_link()), where we want the mtime and ctime to be the values that
were in place when the inode was logged.

This was found with generic/547 using LOAD_FACTOR=20 and TIME_FACTOR=20,
where due to large log trees we have longer log replay times and fssum
could detect a mismatch of the mtime and ctime of a directory.

Fix this by skipping the mtime and ctime update at __btrfs_unlink_inode()
if we are in log replay context (just like btrfs_add_link()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fcbe3e791026..83e242bf42f3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4192,6 +4192,23 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static void update_time_after_link_or_unlink(struct btrfs_inode *dir)
+{
+	struct timespec64 now;
+
+	/*
+	 * If we are replaying a log tree, we do not want to update the mtime
+	 * and ctime of the parent directory with the current time, since the
+	 * log replay procedure is responsible for setting them to their correct
+	 * values (the ones it had when the fsync was done).
+	 */
+	if (test_bit(BTRFS_FS_LOG_RECOVERING, &dir->root->fs_info->flags))
+		return;
+
+	now = inode_set_ctime_current(&dir->vfs_inode);
+	inode_set_mtime_to_ts(&dir->vfs_inode, now);
+}
+
 /*
  * unlink helper that gets used here in inode.c and in the tree logging
  * recovery code.  It remove a link in a directory with a given name, and
@@ -4292,7 +4309,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
- 	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
+	update_time_after_link_or_unlink(dir);
 
 	return btrfs_update_inode(trans, dir);
 }
@@ -6686,15 +6703,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	btrfs_i_size_write(parent_inode, parent_inode->vfs_inode.i_size +
 			   name->len * 2);
 	inode_inc_iversion(&parent_inode->vfs_inode);
-	/*
-	 * If we are replaying a log tree, we do not want to update the mtime
-	 * and ctime of the parent directory with the current time, since the
-	 * log replay procedure is responsible for setting them to their correct
-	 * values (the ones it had when the fsync was done).
-	 */
-	if (!test_bit(BTRFS_FS_LOG_RECOVERING, &root->fs_info->flags))
-		inode_set_mtime_to_ts(&parent_inode->vfs_inode,
-				      inode_set_ctime_current(&parent_inode->vfs_inode));
+	update_time_after_link_or_unlink(parent_inode);
 
 	ret = btrfs_update_inode(trans, parent_inode);
 	if (ret)
-- 
2.47.2


