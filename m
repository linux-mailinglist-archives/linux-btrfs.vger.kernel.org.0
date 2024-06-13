Return-Path: <linux-btrfs+bounces-5708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B163906AB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 13:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87925B21A0D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06714374D;
	Thu, 13 Jun 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaSGxFO7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8100143739
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276734; cv=none; b=mbGgtQ6PsFRd7QfrH4GlQP+/Sc3DBauktWgm1jS9aogxeEdb1gR7SDDlSRbBD4ssBthTX5jG8YpZhnnJ52okzS6RfX1fot0lJp5Hk/IF2mBIp8CoGBTrnRVrdR2V4kwmkOp7Q7cgS660+mkS1K2viFf+l2WFmLvtJ39fcx5Y/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276734; c=relaxed/simple;
	bh=dzLKR4zub0eA4boKu+dY2wLsSnSn7c972Be6EUf+Hz4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KdQQGusbkxZJ0ppuyh7JFTNE/RSZ/MpVkx/QVx42TbS9xY/yffC8HLfuewhYE3GX+1qPMG7SngHjDSVni3HCehKOseKqckgyCxF/i8P0pTPHThQX//GrGQBOi+ueOaAwvVnqDzOeo7VE8TM9TA07seaV9Pez4HWobPNnVhJ2hhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaSGxFO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1F4C2BBFC
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718276734;
	bh=dzLKR4zub0eA4boKu+dY2wLsSnSn7c972Be6EUf+Hz4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QaSGxFO7QS1og/IDC8vuseztBlUSdJ6TCiSnPlreQ+7Qqfy/iEuOyWnL2zg789LMg
	 oNRPe2bgLUFSCgZhZV2FBbhE/O3HDUVyBGVyZwTU0S7SK3DBa8Da8GDx4qY6Vz/X7Z
	 TNX2kAIMND509M9kZEulUZiUIJuPMrKir06iW1VBBpJIV7l0PWYzZzwzQxfY0vm4rT
	 luQ4R3hLUXT2eZ0SnwgtAVZVjmHoREmiWKjeKCbXYkHWjHAKKgbRDH55mEOhClcYGy
	 nCJSmUXILnhqcEm6sHHQALdrwkOD2f7VZ5XakgWEq7mE8LVc6BjkNFDo/LpZBNVgpG
	 STQlk0rl//oWw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: remove super block argument from btrfs_iget_path()
Date: Thu, 13 Jun 2024 12:05:27 +0100
Message-Id: <d83766bc45314caa6aa4298ad5f67b019badca29.1718276261.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718276261.git.fdmanana@suse.com>
References: <cover.1718276261.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's pointless to pass a super block argument to btrfs_iget_path() because
we always pass a root and from it we can get the super block through:

   root->fs_info->sb

So remove the super block argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h      | 4 ++--
 fs/btrfs/free-space-cache.c | 3 +--
 fs/btrfs/inode.c            | 8 ++++----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 4867b0d76199..b0fe610d5940 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -574,8 +574,8 @@ void btrfs_free_inode(struct inode *inode);
 int btrfs_drop_inode(struct inode *inode);
 int __init btrfs_init_cachep(void);
 void __cold btrfs_destroy_cachep(void);
-struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
-			      struct btrfs_root *root, struct btrfs_path *path);
+struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
+			      struct btrfs_path *path);
 struct inode *btrfs_iget(u64 ino, struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, u64 start, u64 len);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index fcfc1b62e762..9f3a58b74612 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -82,7 +82,6 @@ static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 					       struct btrfs_path *path,
 					       u64 offset)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
 	struct btrfs_key location;
 	struct btrfs_disk_key disk_key;
@@ -116,7 +115,7 @@ static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 	 * sure NOFS is set to keep us from deadlocking.
 	 */
 	nofs_flag = memalloc_nofs_save();
-	inode = btrfs_iget_path(fs_info->sb, location.objectid, root, path);
+	inode = btrfs_iget_path(location.objectid, root, path);
 	btrfs_release_path(path);
 	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(inode))
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6c2654c1e222..43cedb8ff14c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5595,13 +5595,13 @@ static struct inode *btrfs_iget_locked(struct super_block *s, u64 ino,
  * allocator. NULL is also valid but may require an additional allocation
  * later.
  */
-struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
-			      struct btrfs_root *root, struct btrfs_path *path)
+struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
+			      struct btrfs_path *path)
 {
 	struct inode *inode;
 	int ret;
 
-	inode = btrfs_iget_locked(s, ino, root);
+	inode = btrfs_iget_locked(root->fs_info->sb, ino, root);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
@@ -5632,7 +5632,7 @@ struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 
 struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 {
-	return btrfs_iget_path(root->fs_info->sb, ino, root, NULL);
+	return btrfs_iget_path(ino, root, NULL);
 }
 
 static struct inode *new_simple_dir(struct inode *dir,
-- 
2.43.0


