Return-Path: <linux-btrfs+bounces-11589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991FBA3BD5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30263B87B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CE41E0E11;
	Wed, 19 Feb 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtypfmHo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070431EDA2C
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965435; cv=none; b=OsdCqibuD2DspBuA4l/SSCYv1NZ8wtDYZ6PNm1cJvXhZzZkiaxfjfThCgptVIMp5BaNnASW549pQJHBqPWDFpfUuOyQI90JpTeKnXbUyfxV/Ra81orU9OtZyZEgeCUmyhYSWrg2Tbjmg2nBiPbwCh3MSvjVq0EGjRW+263RL/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965435; c=relaxed/simple;
	bh=hJI7VMR/Lc2dLgc0ARCoL3PyWcBx6mTHUMDxGS/UJ1k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0cWABpQwR0DTBD7pwzI/9RXh5aNxzRjq4jbzVnjWJAc5qLWkxtV9/ji0kUC/lYYoJP1/wBlt9PogPzerdd7D7jV0RDvulrng9Hux59yzMpZbPKjjNNcztPJQzMqPBiHTE2j5CnFNj3/+7iCfKIptO5IXnmJeaxXdyPiY9fd2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtypfmHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C73C4CEE6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965434;
	bh=hJI7VMR/Lc2dLgc0ARCoL3PyWcBx6mTHUMDxGS/UJ1k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FtypfmHop7TTR/eIQaf6wGPwpV/iPBv9Ib3/Yqi8gonj+edyYRHATRFvY32aS9WR5
	 X/wuO3mB3M0yaAIYowc5orpJDWfA2l5sll3Qdr+stBnkUkCh5jN0hxHPLWN6qdtAUC
	 4Kl9VHDXT5XhSvmIAshb/Lp6/CI4WgrjyyTyKXoD3+zcXMJQdtH1mQdEWfZJcKP8Wd
	 yQ0YlLg27uGyiiy3mLXf42pRh78ERmepNPc81LMahiEcQ8uReoCW6FPkN5mOHih22V
	 G5RE4E01oK1SRMP0lVfP3NhjQm8MEQSOu97WRaf4tolrxfuoMf8CxVA/FaGre1WLUP
	 NoA5CCCAWVHIQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 24/26] btrfs: send: keep the current inode's path cached
Date: Wed, 19 Feb 2025 11:43:24 +0000
Message-Id: <6dbeb0b889a40c60b985d5c07ee1e62901ce47aa.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Whenever we need to send a command for the current inode, like sending
writes, xattr updates, truncates, utimes, etc, we compute the inode's
path each time, which implies doing some memory allocations and traversing
the inode hierarchy to extract the name of the inode and each ancestor
directory, and that implies doing lookups in the subvolume tree amongst
other operations.

Most of the time, by far, the current inode's path doesn't change while
we are processing it (like if we need to issue 100 write commands, the
path remains the same and it's pointless to compute it 100 times).

To avoid this keep the current inode's path cached in the send context
and invalidate it or update it whenever it's needed (after unlinks or
renames).

A performance test, and its results, is mentioned in the next patch in
the series (subject: "btrfs: send: avoid path allocation for the current
inode when issuing commands").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 53 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f161e6a695bd..0d0f073a9945 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -177,6 +177,7 @@ struct send_ctx {
 	u64 cur_inode_rdev;
 	u64 cur_inode_last_extent;
 	u64 cur_inode_next_write_offset;
+	struct fs_path cur_inode_path;
 	bool cur_inode_new;
 	bool cur_inode_new_gen;
 	bool cur_inode_deleted;
@@ -433,6 +434,14 @@ static void fs_path_reset(struct fs_path *p)
 	*p->start = 0;
 }
 
+static void init_path(struct fs_path *p)
+{
+	p->reversed = 0;
+	p->buf = p->inline_buf;
+	p->buf_len = FS_PATH_INLINE_SIZE;
+	fs_path_reset(p);
+}
+
 static struct fs_path *fs_path_alloc(void)
 {
 	struct fs_path *p;
@@ -440,10 +449,7 @@ static struct fs_path *fs_path_alloc(void)
 	p = kmalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return NULL;
-	p->reversed = 0;
-	p->buf = p->inline_buf;
-	p->buf_len = FS_PATH_INLINE_SIZE;
-	fs_path_reset(p);
+	init_path(p);
 	return p;
 }
 
@@ -609,6 +615,14 @@ static void fs_path_unreverse(struct fs_path *p)
 	p->reversed = 0;
 }
 
+static inline bool is_current_inode_path(const struct send_ctx *sctx,
+					 const struct fs_path *path)
+{
+	const struct fs_path *cur = &sctx->cur_inode_path;
+
+	return (strncmp(path->start, cur->start, fs_path_len(cur)) == 0);
+}
+
 static struct btrfs_path *alloc_path_for_send(void)
 {
 	struct btrfs_path *path;
@@ -2419,6 +2433,14 @@ static int get_cur_path(struct send_ctx *sctx, u64 ino, u64 gen,
 	u64 parent_inode = 0;
 	u64 parent_gen = 0;
 	int stop = 0;
+	const bool is_cur_inode = (ino == sctx->cur_ino && gen == sctx->cur_inode_gen);
+
+	if (is_cur_inode && fs_path_len(&sctx->cur_inode_path) > 0) {
+		if (dest != &sctx->cur_inode_path)
+			return fs_path_copy(dest, &sctx->cur_inode_path);
+
+		return 0;
+	}
 
 	name = fs_path_alloc();
 	if (!name) {
@@ -2470,8 +2492,12 @@ static int get_cur_path(struct send_ctx *sctx, u64 ino, u64 gen,
 
 out:
 	fs_path_free(name);
-	if (!ret)
+	if (!ret) {
 		fs_path_unreverse(dest);
+		if (is_cur_inode && dest != &sctx->cur_inode_path)
+			ret = fs_path_copy(&sctx->cur_inode_path, dest);
+	}
+
 	return ret;
 }
 
@@ -3081,6 +3107,11 @@ static int orphanize_inode(struct send_ctx *sctx, u64 ino, u64 gen,
 		goto out;
 
 	ret = send_rename(sctx, path, orphan);
+	if (ret < 0)
+		goto out;
+
+	if (ino == sctx->cur_ino && gen == sctx->cur_inode_gen)
+		ret = fs_path_copy(&sctx->cur_inode_path, orphan);
 
 out:
 	fs_path_free(orphan);
@@ -4143,6 +4174,10 @@ static int rename_current_inode(struct send_ctx *sctx,
 	if (ret < 0)
 		return ret;
 
+	ret = fs_path_copy(&sctx->cur_inode_path, new_path);
+	if (ret < 0)
+		return ret;
+
 	return fs_path_copy(current_path, new_path);
 }
 
@@ -4336,6 +4371,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				if (ret > 0) {
 					orphanized_ancestor = true;
 					fs_path_reset(valid_path);
+					fs_path_reset(&sctx->cur_inode_path);
 					ret = get_cur_path(sctx, sctx->cur_ino,
 							   sctx->cur_inode_gen,
 							   valid_path);
@@ -4535,6 +4571,8 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				ret = send_unlink(sctx, cur->full_path);
 				if (ret < 0)
 					goto out;
+				if (is_current_inode_path(sctx, cur->full_path))
+					fs_path_reset(&sctx->cur_inode_path);
 			}
 			ret = dup_ref(cur, &check_dirs);
 			if (ret < 0)
@@ -6855,6 +6893,7 @@ static int changed_inode(struct send_ctx *sctx,
 	sctx->cur_inode_last_extent = (u64)-1;
 	sctx->cur_inode_next_write_offset = 0;
 	sctx->ignore_cur_inode = false;
+	fs_path_reset(&sctx->cur_inode_path);
 
 	/*
 	 * Set send_progress to current inode. This will tell all get_cur_xxx
@@ -8130,6 +8169,7 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 		goto out;
 	}
 
+	init_path(&sctx->cur_inode_path);
 	INIT_LIST_HEAD(&sctx->new_refs);
 	INIT_LIST_HEAD(&sctx->deleted_refs);
 
@@ -8406,6 +8446,9 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 		btrfs_lru_cache_clear(&sctx->dir_created_cache);
 		btrfs_lru_cache_clear(&sctx->dir_utimes_cache);
 
+		if (sctx->cur_inode_path.buf != sctx->cur_inode_path.inline_buf)
+			kfree(sctx->cur_inode_path.buf);
+
 		kfree(sctx);
 	}
 
-- 
2.45.2


