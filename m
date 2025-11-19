Return-Path: <linux-btrfs+bounces-19149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E5C6ED41
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 14:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E297F2E186
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282835A157;
	Wed, 19 Nov 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1utaJH7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDD35FF4F
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558374; cv=none; b=UeCex4PfUcQAX+WU35aqZr1HstfcerOa38fIdJW4ucq/Iba/dXa0f8sHLHem0SW2t1RV+rMgHjIKJH3z+Grx9KQrVh7TWsTztNboFI7lms3/HcFrpzQ6S2MG9lPpC/v/FYN23n+1xRbNhYqCewGuZw4yVSBNByqx9XeQV4QhZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558374; c=relaxed/simple;
	bh=g/6vFKTDacLf7faNEeBYPy1QOF7W7pEu5pRleI/W/jY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dx3UMGxswS7R8p40bdnxurZetMiIDj1YqNPOGm3Q8vyezlJZzrdUgOhQfLYuvVRA5USQxfQGGs9fiDfe+fdt4d2Vm3LOHTOFJtK8lRajLUDI4cfJmx07zs3rQVDw0SHSKoe3b+8xTIfG4WnK9mxlNq3gYybU/n/7QYYVNL7efSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1utaJH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A563BC4AF09
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763558373;
	bh=g/6vFKTDacLf7faNEeBYPy1QOF7W7pEu5pRleI/W/jY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t1utaJH7pBPKgtUiwEu7/q3tx9CroJnZ1kbSUW2dARmmi2EU6ZqaUeLzosCjEP6er
	 5id5NUVAEeTkw595xQM2f7fyWZWPfozmKJvhNNnfer6Fz+O/ZaSizIUQwM9e4Jt2MH
	 5R71Q2XRfTc0pjJHrjO9jlZmIymZhtHZd+URLMzoFKo4e+GXf23riR+hEnpOTqNC/Z
	 BwNpGUdflxvLKIe+p0yPT2mqRfo2qV9DuEsBnFTjupYP9VEm0Hwnk3bw1DR/2TfWxG
	 oKLwQTbrOfx1wQGmIRvDCuBK5MMEumL3eMZYCe/X9YUxbqTu4cnFO7xJ8lzS4voviP
	 3pwGiuGSxX/Iw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: reduce arguments to btrfs_del_inode_ref_in_log()
Date: Wed, 19 Nov 2025 13:19:08 +0000
Message-ID: <2554a0143124ec3451e0486a8a36d29a6a80e902.1763557872.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763557872.git.fdmanana@suse.com>
References: <cover.1763557872.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing a root and the objectid of the parent directory, just
pass the directory inode, as like that we can extract both the root and
the objectid, reducing the number of arguments by one. It also makes the
function more consistent with other log tree functions in the sense that
we pass the inode and not only its objectid.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c    |  2 +-
 fs/btrfs/tree-log.c | 10 +++++-----
 fs/btrfs/tree-log.h |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 16d416fe536b..8ace17f3eb42 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4358,7 +4358,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	 * operations on the log tree, increasing latency for applications.
 	 */
 	if (!rename_ctx) {
-		btrfs_del_inode_ref_in_log(trans, root, name, inode, dir_ino);
+		btrfs_del_inode_ref_in_log(trans, name, inode, dir);
 		btrfs_del_dir_entries_in_log(trans, name, dir, index);
 	}
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c2e45e64ab6c..42c9327e0c12 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3938,11 +3938,11 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 
 /* see comments for btrfs_del_dir_entries_in_log */
 void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root,
 				const struct fscrypt_str *name,
-				struct btrfs_inode *inode, u64 dirid)
+				struct btrfs_inode *inode,
+				struct btrfs_inode *dir)
 {
-	struct btrfs_root *log;
+	struct btrfs_root *root = dir->root;
 	int ret;
 
 	ret = inode_logged(trans, inode, NULL);
@@ -3957,10 +3957,10 @@ void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 	ASSERT(ret == 0, "join_running_log_trans() ret=%d", ret);
 	if (WARN_ON(ret))
 		return;
-	log = root->log_root;
 	mutex_lock(&inode->log_mutex);
 
-	ret = btrfs_del_inode_ref(trans, log, name, btrfs_ino(inode), dirid, NULL);
+	ret = btrfs_del_inode_ref(trans, root->log_root, name, btrfs_ino(inode),
+				  btrfs_ino(dir), NULL);
 	mutex_unlock(&inode->log_mutex);
 	if (ret < 0 && ret != -ENOENT)
 		btrfs_set_log_full_commit(trans);
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index a0aeec2448c0..41e47fda036d 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -82,9 +82,9 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 				  const struct fscrypt_str *name,
 				  struct btrfs_inode *dir, u64 index);
 void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root,
 				const struct fscrypt_str *name,
-				struct btrfs_inode *inode, u64 dirid);
+				struct btrfs_inode *inode,
+				struct btrfs_inode *dir);
 void btrfs_end_log_trans(struct btrfs_root *root);
 void btrfs_pin_log_trans(struct btrfs_root *root);
 void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
-- 
2.47.2


