Return-Path: <linux-btrfs+bounces-5651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC039039B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 13:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A30283534
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C85817B408;
	Tue, 11 Jun 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2sJjHIf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96C0179957
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104227; cv=none; b=TksCpEgsl7dnGpj/TvDAxCnas8Yk1u593pSrtgxqAuX+jXtumPAYWQxtfp3ZCg50cbhTbK8pk5SSQtaX02sP6cHO/XK97hDNkporLfBRKWnFLJRzCQgy5d1BClEz4jC5f4gSYMTJTLZqNEa7KUha3Hd80+GhEu/9IPcLjOPlW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104227; c=relaxed/simple;
	bh=8xJU2d0Sk89Pf6tbW6sVZew4XvtkZ2Qjq5rMW4UHPqk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Lcpunu4vZDo5xBl4tPrz6cHyFPjfIOEknwK8mvCH1WB5Rm66hz97agBI4ObeQpbuSJNoV4Dvg1N5adzR+zARd8FZtR1nAy2KqB5U0six2qPmp3rN4k/cnPhFGSwdIXH/HjfGZWeEHUzvrxJqy0wEizPEac+2FyPxHSH5XfbZAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2sJjHIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6B8C2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718104227;
	bh=8xJU2d0Sk89Pf6tbW6sVZew4XvtkZ2Qjq5rMW4UHPqk=;
	h=From:To:Subject:Date:From;
	b=N2sJjHIfSFPkoh4sgNAZZoDenVQgLRk64z8xqRDi8TRO6uKIDI8oO2wvdHnfwnQqb
	 b5h6WGn89FVvljVpUQkwTxVRAdIetpQvo+Z+TaQ0btWkhZL0A//eHzmACJ0zc+wJv/
	 r511oZYLER+ea3lw+St2e+4Zyzr4HJ1d99bdanWN9qjj7aGwazGszMs9INzaQtdcPB
	 qz0KRI63sYGcD7BSuVEywaE9JVBUEhrApgb6KgrAl2mEc0Rq+ZwuAEfdNwa/RlDf6s
	 zMsXwEd8LOxla0dIgHq7AArZY+zco2w7OucxKd785Z1Np1u4hkjnqrjFWeNG7m4wDl
	 OyncIa60EhTrQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid transaction commit on any fsync after subvolume creation
Date: Tue, 11 Jun 2024 12:10:24 +0100
Message-Id: <65a8b2e10dc470b52858865906f36c80b77ce010.1718104115.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

As of commit 1b53e51a4a8f ("btrfs: don't commit transaction for every
subvol create") we started to make any fsync after creating a subvolume
to fallback to a transaction commit if the fsync is performed in the
same transaction that was used to create the subvolume. This happens
with the following at ioctl.c:create_subvol():

  $ cat fs/btrfs/ioctl.c
  (...)
      /* Tree log can't currently deal with an inode which is a new root. */
      btrfs_set_log_full_commit(trans);
  (...)

Note that the comment is misleading as the problem is not that fsync can
not deal with the root inode of a new root, but that we can not log any
inode that belongs to a root that was not yet persisted because that would
make log replay fail since the root doesn't exist at log replay time.

The above simply makes any fsync fallback to a full transaction commit if
it happens in the same transaction used to create the subvolume - even if
it's an inode that belongs to any other subvolume. This is a brute force
solution and it doesn't necessarily improve performance for every workload
out there - it just moves a full transaction commit from one place, the
subvolume creation, to another - an fsync for any inode.

Just improve on this by making the fallback to a transacton commit only
for an fsync against an inode of the new subvolume, or for the directory
that contains the dentry that points to the new subvolume (in case anyone
attempts to fsync the directory in the same transaction).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c    |  4 ++--
 fs/btrfs/tree-log.c | 27 +++++++++++++++++++++++++++
 fs/btrfs/tree-log.h |  2 ++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d00d49338ecb..1dca986943f0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -662,8 +662,6 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	qgroup_reserved = 0;
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
-	/* Tree log can't currently deal with an inode which is a new root. */
-	btrfs_set_log_full_commit(trans);
 
 	ret = btrfs_qgroup_inherit(trans, 0, objectid, btrfs_root_id(root), inherit);
 	if (ret)
@@ -764,6 +762,8 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		goto out;
 	}
 
+	btrfs_record_new_subvolume(trans, BTRFS_I(dir));
+
 	d_instantiate_new(dentry, new_inode_args.inode);
 	new_inode_args.inode = NULL;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d3142d55875a..cf384f32d5fe 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7065,6 +7065,15 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 		goto end_no_trans;
 	}
 
+	/*
+	 * If we're logging an inode from a subvolume created in the current
+	 * transaction we must force a commit since the root is not persisted.
+	 */
+	if (btrfs_root_generation(&root->root_item) == trans->transid) {
+		ret = BTRFS_LOG_FORCE_COMMIT;
+		goto end_no_trans;
+	}
+
 	/*
 	 * Skip already logged inodes or inodes corresponding to tmpfiles
 	 * (since logging them is pointless, a link count of 0 means they
@@ -7445,6 +7454,24 @@ void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
 	mutex_unlock(&dir->log_mutex);
 }
 
+/*
+ * Call this when creating a subvolume in a directory.
+ * Because we don't commit a transaction when creating a subvolume, we can't
+ * allow the directory pointing to the subvolume to be logged with an entry that
+ * points to an unpersisted root if we are still in the transaction used to
+ * create the subvolume, so make any attempt to log the directory to result in a
+ * full log sync.
+ * Also we don't need to worry with renames, since btrfs_rename() marks the log
+ * for full commit when renaming a subvolume.
+ */
+void btrfs_record_new_subvolume(struct btrfs_trans_handle *trans,
+				struct btrfs_inode *dir)
+{
+	mutex_lock(&dir->log_mutex);
+	dir->last_unlink_trans = trans->transid;
+	mutex_unlock(&dir->log_mutex);
+}
+
 /*
  * Update the log after adding a new name for an inode.
  *
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index fa0a689259b1..ec99975a0fff 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -94,6 +94,8 @@ void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
 			     bool for_rename);
 void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
 				   struct btrfs_inode *dir);
+void btrfs_record_new_subvolume(struct btrfs_trans_handle *trans,
+				struct btrfs_inode *dir);
 void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 			struct dentry *old_dentry, struct btrfs_inode *old_dir,
 			u64 old_dir_index, struct dentry *parent);
-- 
2.43.0


