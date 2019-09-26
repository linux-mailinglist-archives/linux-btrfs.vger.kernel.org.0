Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D27BF1DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 13:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfIZLj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 07:39:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:47068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfIZLj5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 07:39:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C76FFAE35;
        Thu, 26 Sep 2019 11:39:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Speed up btrfs_file_llseek
Date:   Thu, 26 Sep 2019 14:39:51 +0300
Message-Id: <20190926113953.19569-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926113953.19569-1-nborisov@suse.com>
References: <20190926113953.19569-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Modifying the file position is done on a per-file basis. This renders
holding the inode lock useless and currently holding it makes the
performance of concurrent llseek's abysmal.

Fix this by removing calls to inode_lock. This is correct because
find_desired_extent already includes proper extent locking for the
range it's going to interrogate for finding a DATA/HOLE region. The
other two cases SEEK_END/SEEK_CUR are also safe. The latter is
synchronized by file::f_lock spinlock. SEEK_END is not synchronized
but atomic, but that's OK since there is not guarantee that SEEK_END
will always be at the end of the file in the face of tail modifications. For 
more information on locking requirements see ef3d0fd27e90 ("vfs: do (nearly)
lockless generic_file_llseek")


This change brings ~85% performance improvement when doing a lot of
parallel fseeks. The workload essentially does: 

                    for (d=0; d<num_seek_read; d++)
                      {
                        /* offset %= 16777216; */
                        fseek (f, 256 * d % 16777216, SEEK_SET);
                        fread (buffer, 64, 1, f);
                      }

Without patch:

num workprocesses = 16
num fseek/fread = 8000000
step = 256
fork 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15

real	0m41.412s
user	0m28.777s
sys	2m16.510s

With patch:

num workprocesses = 16
num fseek/fread = 8000000
step = 256
fork 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15

real	0m11.479s
user	0m27.629s
sys	0m18.187s

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 12688ae6e6f2..31111a94251a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3347,13 +3347,14 @@ static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em = NULL;
 	struct extent_state *cached_state = NULL;
+	loff_t i_size = i_size_read(inode);
 	u64 lockstart;
 	u64 lockend;
 	u64 start;
 	u64 len;
 	int ret = 0;
 
-	if (inode->i_size == 0)
+	if (i_size == 0)
 		return -ENXIO;
 
 	/*
@@ -3363,8 +3364,7 @@ static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
 	start = max_t(loff_t, 0, *offset);
 
 	lockstart = round_down(start, fs_info->sectorsize);
-	lockend = round_up(i_size_read(inode),
-			   fs_info->sectorsize);
+	lockend = round_up(i_size, fs_info->sectorsize);
 	if (lockend <= lockstart)
 		lockend = lockstart + fs_info->sectorsize;
 	lockend--;
@@ -3373,7 +3373,7 @@ static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
 	lock_extent_bits(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			 &cached_state);
 
-	while (start < inode->i_size) {
+	while (start < i_size) {
 		em = btrfs_get_extent_fiemap(BTRFS_I(inode), start, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
@@ -3397,10 +3397,10 @@ static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
 	}
 	free_extent_map(em);
 	if (!ret) {
-		if (whence == SEEK_DATA && start >= inode->i_size)
+		if (whence == SEEK_DATA && start >= i_size)
 			ret = -ENXIO;
 		else
-			*offset = min_t(loff_t, start, inode->i_size);
+			*offset = min_t(loff_t, start, i_size);
 	}
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			     &cached_state);
@@ -3412,7 +3412,6 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 	struct inode *inode = file->f_mapping->host;
 	int ret;
 
-	inode_lock(inode);
 	switch (whence) {
 	case SEEK_END:
 	case SEEK_CUR:
@@ -3420,21 +3419,16 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 		goto out;
 	case SEEK_DATA:
 	case SEEK_HOLE:
-		if (offset >= i_size_read(inode)) {
-			inode_unlock(inode);
+		if (offset >= i_size_read(inode))
 			return -ENXIO;
-		}
 
 		ret = find_desired_extent(inode, &offset, whence);
-		if (ret) {
-			inode_unlock(inode);
+		if (ret)
 			return ret;
-		}
 	}
 
 	offset = vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
 out:
-	inode_unlock(inode);
 	return offset;
 }
 
-- 
2.17.1

