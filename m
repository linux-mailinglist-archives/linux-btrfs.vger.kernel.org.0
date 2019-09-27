Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446B2C035E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 12:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfI0KXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 06:23:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfI0KXZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 06:23:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FDB6B052;
        Fri, 27 Sep 2019 10:23:23 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 3/3] btrfs: Return offset from find_desired_extent
Date:   Fri, 27 Sep 2019 13:23:18 +0300
Message-Id: <20190927102318.12830-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927102318.12830-1-nborisov@suse.com>
References: <20190927102318.12830-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of using an input pointer parameter as the return value and have
an int as the return type of find_desired_extent, rework the function
to directly return the found offset. Doing that the 'ret' variable in
btrfs_llseek_file can be removed. Additional (subjective) benefit is
that btrfs' llseek function now resemebles those of the other major
filesystems.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index cda1882f5cb5..cb6f7ac8cd15 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3342,7 +3342,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 	return ret;
 }
 
-static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
+static loff_t find_desired_extent(struct inode *inode, loff_t offset,
+				  int whence)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em = NULL;
@@ -3354,14 +3355,14 @@ static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
 	u64 len;
 	int ret = 0;
 
-	if (i_size == 0 || *offset >= i_size)
+	if (i_size == 0 || offset >= i_size)
 		return -ENXIO;
 
 	/*
-	 * *offset can be negative, in this case we start finding DATA/HOLE from
+	 * offset can be negative, in this case we start finding DATA/HOLE from
 	 * the very start of the file.
 	 */
-	start = max_t(loff_t, 0, *offset);
+	start = max_t(loff_t, 0, offset);
 
 	lockstart = round_down(start, fs_info->sectorsize);
 	lockend = round_up(i_size, fs_info->sectorsize);
@@ -3396,21 +3397,23 @@ static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
 		cond_resched();
 	}
 	free_extent_map(em);
-	if (!ret) {
+	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			     &cached_state);
+	if (ret) {
+		offset = ret;
+	} else {
 		if (whence == SEEK_DATA && start >= i_size)
-			ret = -ENXIO;
+			offset = -ENXIO;
 		else
-			*offset = min_t(loff_t, start, i_size);
+			offset = min_t(loff_t, start, i_size);
 	}
-	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			     &cached_state);
-	return ret;
+
+	return offset;
 }
 
 static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	int ret;
 
 	switch (whence) {
 	default:
@@ -3418,13 +3421,14 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 	case SEEK_DATA:
 	case SEEK_HOLE:
 		inode_lock_shared(inode);
-		ret = find_desired_extent(inode, &offset, whence);
+		offset = find_desired_extent(inode, offset, whence);
 		inode_unlock_shared(inode);
-
-		if (ret)
-			return ret;
+		break;
 	}
 
+	if (offset < 0)
+		return offset;
+
 	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
 }
 
-- 
2.17.1

