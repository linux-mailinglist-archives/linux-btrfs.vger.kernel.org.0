Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7B31DA04
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 14:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhBQNNl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 08:13:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:56728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhBQNNj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 08:13:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613567572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piKBC0MoUD68JumoPXG63turKYZa/ITCvpk5eQ9EN9Q=;
        b=Igf+Q2wsGPIXq342LFvMOIMx2aHKaoAFMC/9iX+CIkJZatFJ6vUlK1MF4nbk6StPl3/j4Z
        SO4kL93F+XjAALD20ooUtRpaavI0cJ5IEk4l0Z50wQ6wpaXQLj5pBoD8SzEH3NGk3vX4U9
        WmLgdFOC3cC/A3hij0oopLs/0IIAnb0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CFDC5B8F2;
        Wed, 17 Feb 2021 13:12:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/4] btrfs: Make find_desired_extent take btrfs_inode
Date:   Wed, 17 Feb 2021 15:12:48 +0200
Message-Id: <20210217131250.265859-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217131250.265859-1-nborisov@suse.com>
References: <20210217131250.265859-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a4e6fb43e3a7..1e68349c3884 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3492,13 +3492,13 @@ static long btrfs_fallocate(struct file *file, int mode,
 	return ret;
 }
 
-static loff_t find_desired_extent(struct inode *inode, loff_t offset,
+static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
 				  int whence)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_map *em = NULL;
 	struct extent_state *cached_state = NULL;
-	loff_t i_size = inode->i_size;
+	loff_t i_size = inode->vfs_inode.i_size;
 	u64 lockstart;
 	u64 lockend;
 	u64 start;
@@ -3521,11 +3521,10 @@ static loff_t find_desired_extent(struct inode *inode, loff_t offset,
 	lockend--;
 	len = lockend - lockstart + 1;
 
-	lock_extent_bits(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			 &cached_state);
+	lock_extent_bits(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	while (start < i_size) {
-		em = btrfs_get_extent_fiemap(BTRFS_I(inode), start, len);
+		em = btrfs_get_extent_fiemap(inode, start, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			em = NULL;
@@ -3547,7 +3546,7 @@ static loff_t find_desired_extent(struct inode *inode, loff_t offset,
 		cond_resched();
 	}
 	free_extent_map(em);
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+	unlock_extent_cached(&inode->io_tree, lockstart, lockend,
 			     &cached_state);
 	if (ret) {
 		offset = ret;
@@ -3571,7 +3570,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 	case SEEK_DATA:
 	case SEEK_HOLE:
 		btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
-		offset = find_desired_extent(inode, offset, whence);
+		offset = find_desired_extent(BTRFS_I(inode), offset, whence);
 		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		break;
 	}
-- 
2.25.1

