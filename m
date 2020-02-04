Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85004151E1D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgBDQT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:19:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37231 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBDQT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:19:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so18513849qky.4
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3V8NDRPLi1mh5S/HcCUVZsc8Mf4FJqHg1o4nAIdsc8o=;
        b=MC3fG+g2xjgyo4BKFyVkZFX9ansMqqmwKEjTuPmU6rO0n/x617gvoTj+l7oKWqRKTl
         fPiittVxHzDMRl22G5LuCYNmRGws1dZWfuN7sRvcr3i8hw6yYY4c59ngivv8nZK3T1Yd
         ZM1+0tCRvRsCr6e+O6iQHos4cjN4qPOLuBnmk6l9X/z6/LApF++umSqdwbMwEINL4ZVV
         7sNXhTY6RauZpX4/gcBb7PkaG6kZf6NAjawehvt6LOT2SWxVDzb0zqJaPDpWMHsTnI0F
         hxhytmr3PwzeFal5W1LKXjgE4n6QlisPBd5FIEKVpkmbPvtgx4BHQ9wOf59pjk0UdTtK
         81KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3V8NDRPLi1mh5S/HcCUVZsc8Mf4FJqHg1o4nAIdsc8o=;
        b=NslU4Mn3BQs49yoF1NjzF7C4cnHYMLW0O6dBdnOtzMDxPldYCMIW9IZGlbXNKFZyZi
         28+fzBmOtbcYR1tQ2GcLbF7TaR8Vhqhs0+/E+/Vndy67Cj0kFhlaY8hNXFJIjkkb71aW
         LZsqVQ3dsSrSykdsW4mWBaz0qM1TWdb/QKL++0iwHgDg+wlovBVlw5d9/Qm9FlOoF7pa
         NVkSlcgXX3gS7uRQL3FRlXjDqzLzHrWUT2o+8aMVk+gpCP37+oxk+usTpaxMXaC4p25o
         HFZVGBCipLyPNhUlW/ymDqWV0Kgqv/sH1Iu3tem72/9lWR8gHYUX3sCGNsvI6ACpbKHw
         ssrA==
X-Gm-Message-State: APjAAAVLhXg1augHGp7NyTxJpuaeOOZgGRQDiDLZgCVf1JoFK6mVl2xr
        rbETgRGUgHFUq7p9Hsvc7RlXvo/RbbqzEw==
X-Google-Smtp-Source: APXvYqwtym6mlV1HxJDcLuGbF4n1FjNM/P6sLgW0XkhvqcWBoZ+6E6EtjoFhLzN4weoSEhB5famSWQ==
X-Received: by 2002:a37:b8b:: with SMTP id 133mr29144498qkl.418.1580833195900;
        Tue, 04 Feb 2020 08:19:55 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 141sm5318454qkk.62.2020.02.04.08.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:19:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 01/23] btrfs: change nr to u64 in btrfs_start_delalloc_roots
Date:   Tue,  4 Feb 2020 11:19:29 -0500
Message-Id: <20200204161951.764935-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have btrfs_wait_ordered_roots() which takes a u64 for nr, but
btrfs_start_delalloc_roots() that takes an int for nr, which makes using
them in conjunction, especially for something like (u64)-1, annoying and
inconsistent.  Fix btrfs_start_delalloc_roots() to take a u64 for nr and
adjust start_delalloc_inodes() and it's callers appropriately.

This means we've adjusted start_delalloc_inodes() to take a pointer of
nr since we want to preserve the ability for start-delalloc_inodes() to
return an error, so simply make it do the nr adjusting as necessary.

Part of adjusting the callers to this means changing
btrfs_writeback_inodes_sb_nr() to take a u64 for items.  This may be
confusing because it seems unrelated, but the caller of
btrfs_writeback_inodes_sb_nr() already passes in a u64, it's just the
function variable that needs to be changed.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/inode.c       | 27 +++++++++++----------------
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/space-info.c  |  2 +-
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8a2c1665baad..6afa0885a9bb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2884,7 +2884,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       u32 min_type);
 
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root);
-int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr);
+int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr);
 int btrfs_set_extent_delalloc(struct inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f639dde2a679..6ff08eb3c35d 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -593,7 +593,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	 * flush all outstanding I/O and inode extent mappings before the
 	 * copy operation is declared as being finished
 	 */
-	ret = btrfs_start_delalloc_roots(fs_info, -1);
+	ret = btrfs_start_delalloc_roots(fs_info, U64_MAX);
 	if (ret) {
 		mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
 		return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9320f13778ce..5c6ce78bff1d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9619,7 +9619,8 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
  * some fairly slow code that needs optimization. This walks the list
  * of all the inodes with pending delalloc and forces them to disk.
  */
-static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
+static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr,
+				 bool snapshot)
 {
 	struct btrfs_inode *binode;
 	struct inode *inode;
@@ -9659,9 +9660,11 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
 		list_add_tail(&work->list, &works);
 		btrfs_queue_work(root->fs_info->flush_workers,
 				 &work->work);
-		ret++;
-		if (nr != -1 && ret >= nr)
-			goto out;
+		if (*nr != U64_MAX) {
+			(*nr)--;
+			if (*nr == 0)
+				goto out;
+		}
 		cond_resched();
 		spin_lock(&root->delalloc_lock);
 	}
@@ -9686,18 +9689,15 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	int ret;
+	u64 nr = U64_MAX;
 
 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
 		return -EROFS;
 
-	ret = start_delalloc_inodes(root, -1, true);
-	if (ret > 0)
-		ret = 0;
-	return ret;
+	return start_delalloc_inodes(root, &nr, true);
 }
 
-int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr)
+int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr)
 {
 	struct btrfs_root *root;
 	struct list_head splice;
@@ -9720,15 +9720,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr)
 			       &fs_info->delalloc_roots);
 		spin_unlock(&fs_info->delalloc_root_lock);
 
-		ret = start_delalloc_inodes(root, nr, false);
+		ret = start_delalloc_inodes(root, &nr, false);
 		btrfs_put_root(root);
 		if (ret < 0)
 			goto out;
-
-		if (nr != -1) {
-			nr -= ret;
-			WARN_ON(nr < 0);
-		}
 		spin_lock(&fs_info->delalloc_root_lock);
 	}
 	spin_unlock(&fs_info->delalloc_root_lock);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ecb6b188df15..442c89502f06 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5510,7 +5510,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_SYNC: {
 		int ret;
 
-		ret = btrfs_start_delalloc_roots(fs_info, -1);
+		ret = btrfs_start_delalloc_roots(fs_info, U64_MAX);
 		if (ret)
 			return ret;
 		ret = btrfs_sync_fs(inode->i_sb, 1);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 01297c5b2666..edda1ee0455e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -310,7 +310,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 }
 
 static void btrfs_writeback_inodes_sb_nr(struct btrfs_fs_info *fs_info,
-					 unsigned long nr_pages, int nr_items)
+					 unsigned long nr_pages, u64 nr_items)
 {
 	struct super_block *sb = fs_info->sb;
 
-- 
2.24.1

