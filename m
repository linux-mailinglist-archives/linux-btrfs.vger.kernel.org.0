Return-Path: <linux-btrfs+bounces-7682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5646F96534A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 01:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B471C210CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3891BAEF4;
	Thu, 29 Aug 2024 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vP2Wb/1C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250C1BAEDF
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972983; cv=none; b=sFf0f1MIozMFp2POJgibIno8fDYboDQWG8Sd3pw1T/NA8Tne3ZdOIohu2S4HHqSpFByyFg3qqAkXd58yWgrlKB2+uFKu2ImssIg06jT5pdxPrAsXEvNT7I6vsVXsjSz1Jwq8cwp0kc1T68I+k44dYmE1Pv1xycr8kyewNXUB9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972983; c=relaxed/simple;
	bh=mhBGRbbOKQGSN0BG4fKmo7CAsOCzQwIWrZDlmD67YeU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dFeUJeWBTkCgU0UGzFizs34nbsN6g9dwFqQj2lTQMpxC08Xk7961K+A2lsxvEKzu6FWpDXN/f5rdyk1DoXLA/vrSiHJGpUp3ISGOc0OLyBs2Lwut1BNYHbCVCaqaxWIKiHXhgHdsy+Yms8XaLyAEAaHKlxh52Jxj0RybGt5Z+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vP2Wb/1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ABCC4CEC5
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 23:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724972982;
	bh=mhBGRbbOKQGSN0BG4fKmo7CAsOCzQwIWrZDlmD67YeU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vP2Wb/1Co/Oyl+rkQevlA3SAfTr5wjYa8ZoXgksfq41jWhOekQTsDtwXNBBH4dqZH
	 DsN4LjSYDx8tNhZdvvYpA6XK3LoYTqKNAoI9bX1WzjiFcdZ60GthnOG3Hk38chGpVG
	 85WlgQZhXnqeJsP5zy57rh9kvZpwhPHAHoMpchGw6XBeLLdbQStFw4gz3rYaV6cWnX
	 6MGKlhdO2j8pMlH6Z/tLZt2RpDEtvykIzBbqlG6DzWFX4Z/U7IXAnZ0sPZFe+wJT8Z
	 P16A4qf9e6+F1T/0sb/Hp4dRy9iIfVsBEhgNjpp+Q/8lwPnydjOGEHx+hwrf2XqUn1
	 rMyVxOkSzgu1w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: add and use helper to verify the calling task has locked the inode
Date: Fri, 30 Aug 2024 00:09:37 +0100
Message-Id: <bc7d8296881e91d679ab2c297e2869899d71a321.1724972507.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724972506.git.fdmanana@suse.com>
References: <cover.1724972506.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a few places that check if we have the inode locked by doing:

    ASSERT(inode_is_locked(vfs_inode));

This actually proved to be useful several times as if assertions are
enabled (and by default they are in many distros) it immediately triggers
a crash which is impossible for users to miss.

However that doesn't check if the lock is held by the calling task, so
the check passes if some other task locked the inode.

Using one of the lockdep functions to check the lock is held, like
lockdep_assert_held() for example, does check that the calling task
holds the lock, and if that's not the case it produces a warning and
stack trace in dmesg. However, despite the misleading "assert" in the
name of the lockdep helpers, it does not trigger a crash/BUG_ON(), just
a warning and splat in dmesg, which is easy to get unnoticed by users
who may have lockdep enabled.

So add a helper that does the ASSERT() and calls lockdep_assert_held()
immediately after and use it every where we check the inode is locked.
Like this if the lock is held by some other task we get the warning
in dmesg which is caught by fstests, very helpful during development,
and may also be ocassionaly noticed by users with lockdep enabled.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h  | 8 ++++++++
 fs/btrfs/file.c         | 2 +-
 fs/btrfs/ordered-data.c | 2 +-
 fs/btrfs/tree-log.c     | 2 +-
 fs/btrfs/verity.c       | 6 +++---
 fs/btrfs/xattr.c        | 2 +-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 2d7f8da54d8a..90e72031c724 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -505,6 +505,14 @@ static inline bool btrfs_inode_can_compress(const struct btrfs_inode *inode)
 	return true;
 }
 
+static inline void btrfs_assert_inode_locked(struct btrfs_inode *inode)
+{
+	/* Immediately trigger a crash if the inode is not locked. */
+	ASSERT(inode_is_locked(&inode->vfs_inode));
+	/* Trigger a splat in dmesg if this task is not holding the lock. */
+	lockdep_assert_held(&inode->vfs_inode.i_rwsem);
+}
+
 /* Array of bytes with variable length, hexadecimal format 0x1234 */
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c7a7234998aa..c5e36f58eb07 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1617,7 +1617,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (current->journal_info == BTRFS_TRANS_DIO_WRITE_STUB) {
 		skip_ilock = true;
 		current->journal_info = NULL;
-		lockdep_assert_held(&inode->vfs_inode.i_rwsem);
+		btrfs_assert_inode_locked(inode);
 	}
 
 	trace_btrfs_sync_file(file, datasync);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index eb9b32ffbc0c..2104d60c2161 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1015,7 +1015,7 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 {
 	struct rb_node *n;
 
-	ASSERT(inode_is_locked(&inode->vfs_inode));
+	btrfs_assert_inode_locked(inode);
 
 	spin_lock_irq(&inode->ordered_tree_lock);
 	for (n = rb_first(&inode->ordered_tree); n; n = rb_next(n)) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f0cf8ce26f01..e2ed2a791f8f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2877,7 +2877,7 @@ void btrfs_release_log_ctx_extents(struct btrfs_log_ctx *ctx)
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_ordered_extent *tmp;
 
-	ASSERT(inode_is_locked(&ctx->inode->vfs_inode));
+	btrfs_assert_inode_locked(ctx->inode);
 
 	list_for_each_entry_safe(ordered, tmp, &ctx->ordered_extents, log_list) {
 		list_del_init(&ordered->log_list);
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 4042dd6437ae..af4e7b70b4a7 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -460,7 +460,7 @@ static int rollback_verity(struct btrfs_inode *inode)
 	struct btrfs_root *root = inode->root;
 	int ret;
 
-	ASSERT(inode_is_locked(&inode->vfs_inode));
+	btrfs_assert_inode_locked(inode);
 	truncate_inode_pages(inode->vfs_inode.i_mapping, inode->vfs_inode.i_size);
 	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags);
 	ret = btrfs_drop_verity_items(inode);
@@ -585,7 +585,7 @@ static int btrfs_begin_enable_verity(struct file *filp)
 	struct btrfs_trans_handle *trans;
 	int ret;
 
-	ASSERT(inode_is_locked(file_inode(filp)));
+	btrfs_assert_inode_locked(inode);
 
 	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags))
 		return -EBUSY;
@@ -633,7 +633,7 @@ static int btrfs_end_enable_verity(struct file *filp, const void *desc,
 	int ret = 0;
 	int rollback_ret;
 
-	ASSERT(inode_is_locked(file_inode(filp)));
+	btrfs_assert_inode_locked(inode);
 
 	if (desc == NULL)
 		goto rollback;
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 738c7bb8ea7c..ce464cd8e0ac 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -120,7 +120,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 	 * locks the inode's i_mutex before calling setxattr or removexattr.
 	 */
 	if (flags & XATTR_REPLACE) {
-		ASSERT(inode_is_locked(inode));
+		btrfs_assert_inode_locked(BTRFS_I(inode));
 		di = btrfs_lookup_xattr(NULL, root, path,
 				btrfs_ino(BTRFS_I(inode)), name, name_len, 0);
 		if (!di)
-- 
2.43.0


