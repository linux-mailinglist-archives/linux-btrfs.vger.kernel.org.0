Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF3A14F4C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgAaWgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45392 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgAaWgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so8186081qkl.12
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vg21yZU611ABgBg8hmJ4dMx7Bqb2oKc4eL/3Bbeki1I=;
        b=LqyrVQGsGxPAMjP+EwEp2aRfHKOUu1bPGngSVS4FthqgJwmJyiZHP8POqsz4ENQe7J
         12EIeL8rwmSQr9alMBeUAgQqhk5EW9AXfWJqMleYGwWiHM1hWEQCJwlkAaNLnXwQ+pnS
         hBWxYSF9MGdQzDbDr/3NyH0kuvvJRSS550PhYmLhanKifksOwZcjK2Q/K2Yf/R5QhF+B
         q/SCHw4mB1bopAk31H/X2OxkByWuuoDtm7L2y7cMOllZII2ScR9lwsuuqFa0U39EvwWM
         2/jytzvZO7okJWph92H34yPaa76VJSxe4sMxvVBS547zvAQ03TLtsusW+vs7IPpevXk0
         qGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vg21yZU611ABgBg8hmJ4dMx7Bqb2oKc4eL/3Bbeki1I=;
        b=mG21hYnsBQfDNwWRza6qTej+URo1drPTwTgF2yKq3yD+eE9XpwX1URZvsdhzhOC9cY
         sdj6sKNLxsNalqS5NoWUNo6mJJksRur7xOHMqVcOiupTF+C0F3Ol7erayijhJSS2cf2A
         z0Qg0k68JKLYpZTd8BgofXdDXqwKx/zG4kf6lsIuh2xG+pf6AdQxlrK7AEzMYyLidPTM
         4IvspG7G/Xp4weFgBq8qYAK/UP43GVpiIS6UEk9o4e7xJh3s17mADPUfOJAoENzDpoZj
         abn12dGOZpdouA66EIBZTjoLeiv/XBPUc8k48bMYpU9mFRe4smCpuBDHk4TH+FrVqXZu
         fMIg==
X-Gm-Message-State: APjAAAVPmK+KY/l70cFz5ga0fvIu5xQOkMwUfe0tqC4HTdrh5p0vAcM8
        wUNleyhKFRFkWrQTswq8mEYpJl8uYBj8zg==
X-Google-Smtp-Source: APXvYqxnwFUmA4BKT1G/sEppybvdIgD3iYzDoJyu264gIuSN5A8ja5rK3fix0O2DrpuKx/RpXwNgdg==
X-Received: by 2002:a05:620a:1269:: with SMTP id b9mr13289213qkl.312.1580510178585;
        Fri, 31 Jan 2020 14:36:18 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o17sm5586031qtq.93.2020.01.31.14.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/23] btrfs: change nr to u64 in btrfs_start_delalloc_roots
Date:   Fri, 31 Jan 2020 17:35:51 -0500
Message-Id: <20200131223613.490779-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
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

