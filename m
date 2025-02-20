Return-Path: <linux-btrfs+bounces-11663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955AFA3D7CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA8317A404
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA1A1F5434;
	Thu, 20 Feb 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN8C0cVP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7884E1F239B
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049516; cv=none; b=YyUZJFrezkpN1cQNRWFwxGfQumLewHUP0Vm6yb1EIJDNzFiUZbbP0kn4YAhvuGcfEZc1Qy4jp+VTGtrx83Vm1Uszjz0TtarGp/TkQ19rn3PYyTJqNBf/fOF5U/5HDZGAfA8oIzKVVts+Q/TOKcCB7To0TzJVD1qEyxW/zLA1/kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049516; c=relaxed/simple;
	bh=fP2IJ341pVtho47G7OeVJ+kISspNOnjKAdj7w1n0ZOI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nEBmOKIs/NrY4V7l8Rtb410EODp61PxfNEdA73Ex9GMjXVQCc9aG8nZgcBcO/7iRfFd7a+ymqgIJ1uFPGRPVWo/jXzoqAaBOKb+puqKH5M24ddpIqgazKDYTumFInPjIgkQF2NeHJSpYrFhSvPUL9UNbOsSG1Bw06nydg+uWICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN8C0cVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3DBC4CEE4
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049516;
	bh=fP2IJ341pVtho47G7OeVJ+kISspNOnjKAdj7w1n0ZOI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AN8C0cVPAHsl7DBsgASC5IKTO00S05rvU7MdggvpoUav63gR0m36Q7W71z2ppLDfq
	 e3BDCOGP2l8gWqCAaH7whOsStQVH0EBzCaVa/YB+yP1sHnmsH6jN8EjN+8YhliMtAI
	 pRY3h1pnVpV3MrZ3SNbRmyTTpmSY1GOfJXz97pMourb3xC7jMv1rBqUDa3uz4aV+YZ
	 n9WCPBCRqbeekTyUqpZVml5tE514dyXC/vA2uEEiIUrSbqT1J9iFbZ8Y8e+doYx8fG
	 izq4imf3d36tN9eP4wlG9ablaW4EVztg3p5iQvjAVzpWow3BrYhJmOcZfKkF46G9z8
	 JR+CmYUwyaQ5w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 28/30] btrfs: send: keep the current inode's path cached
Date: Thu, 20 Feb 2025 11:04:41 +0000
Message-Id: <eddd57e278ca4a7ab54052e46e6d88f7c8a8f451.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
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
index 0c496270e10f..e811c9237e9e 100644
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
@@ -2415,6 +2429,14 @@ static int get_cur_path(struct send_ctx *sctx, u64 ino, u64 gen,
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
@@ -2466,8 +2488,12 @@ static int get_cur_path(struct send_ctx *sctx, u64 ino, u64 gen,
 
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
 
@@ -3077,6 +3103,11 @@ static int orphanize_inode(struct send_ctx *sctx, u64 ino, u64 gen,
 		goto out;
 
 	ret = send_rename(sctx, path, orphan);
+	if (ret < 0)
+		goto out;
+
+	if (ino == sctx->cur_ino && gen == sctx->cur_inode_gen)
+		ret = fs_path_copy(&sctx->cur_inode_path, orphan);
 
 out:
 	fs_path_free(orphan);
@@ -4139,6 +4170,10 @@ static int rename_current_inode(struct send_ctx *sctx,
 	if (ret < 0)
 		return ret;
 
+	ret = fs_path_copy(&sctx->cur_inode_path, new_path);
+	if (ret < 0)
+		return ret;
+
 	return fs_path_copy(current_path, new_path);
 }
 
@@ -4332,6 +4367,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				if (ret > 0) {
 					orphanized_ancestor = true;
 					fs_path_reset(valid_path);
+					fs_path_reset(&sctx->cur_inode_path);
 					ret = get_cur_path(sctx, sctx->cur_ino,
 							   sctx->cur_inode_gen,
 							   valid_path);
@@ -4531,6 +4567,8 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				ret = send_unlink(sctx, cur->full_path);
 				if (ret < 0)
 					goto out;
+				if (is_current_inode_path(sctx, cur->full_path))
+					fs_path_reset(&sctx->cur_inode_path);
 			}
 			ret = dup_ref(cur, &check_dirs);
 			if (ret < 0)
@@ -6851,6 +6889,7 @@ static int changed_inode(struct send_ctx *sctx,
 	sctx->cur_inode_last_extent = (u64)-1;
 	sctx->cur_inode_next_write_offset = 0;
 	sctx->ignore_cur_inode = false;
+	fs_path_reset(&sctx->cur_inode_path);
 
 	/*
 	 * Set send_progress to current inode. This will tell all get_cur_xxx
@@ -8126,6 +8165,7 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 		goto out;
 	}
 
+	init_path(&sctx->cur_inode_path);
 	INIT_LIST_HEAD(&sctx->new_refs);
 	INIT_LIST_HEAD(&sctx->deleted_refs);
 
@@ -8402,6 +8442,9 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 		btrfs_lru_cache_clear(&sctx->dir_created_cache);
 		btrfs_lru_cache_clear(&sctx->dir_utimes_cache);
 
+		if (sctx->cur_inode_path.buf != sctx->cur_inode_path.inline_buf)
+			kfree(sctx->cur_inode_path.buf);
+
 		kfree(sctx);
 	}
 
-- 
2.45.2


