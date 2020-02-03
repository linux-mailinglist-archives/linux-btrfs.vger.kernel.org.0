Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E1915114A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBCUt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:49:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40869 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCUt6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:49:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so12584902qto.7
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vg21yZU611ABgBg8hmJ4dMx7Bqb2oKc4eL/3Bbeki1I=;
        b=aLO6I91ZDBpA/wdVE47o1n2dHS4MICSUbQc5z/7AJKoxdt6FkeMdl6UQQZ1F1PuDBo
         bxKOUJXulD1G8YMCcQu9Z3lKJfUqgONaQmi48qFzwiEdLwVf6UuAMq0WB9vxnn7YQFBJ
         qn39pdWAe6m8gBI+P2flMxzjtsc+wjy4i3FPhNX1OygEnIAVW/Hdgk48wwztHK9jxr/0
         bOQeDOu0l570lzLQ9eIj8f4lgWrFyzwz3DXUmuzYD6fjjMdLIHVrKpiOTbO8BXdK43Bc
         wjz0K1LVEsjG1ctcetsllA8JlhFFo2l63d1RAa6NKL8o1vsEYC6eL3IG0MteHUUyTjMg
         JLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vg21yZU611ABgBg8hmJ4dMx7Bqb2oKc4eL/3Bbeki1I=;
        b=Ba3pUi99tnAWOAUqhX+hSTf5+N2ckHEH4G0vTvuKlRbZSoNdK+OimrG03YNgCZmCeW
         1NXvVpqfFLm2hmtDzcMps0dSoCfYCS29MHQVymD2mWydJOaP0B5LPjPn+OJHWwn6YP8t
         mhTOMb+maGCWll6IyShX/ovnmvou+i+zhxBJ8VFPV7/oFMrxzO7u5UM3aot+0IGmLeM1
         32Vjh+0kQjiXTucvi2SwwmMuxnh0YJt4P7VPJ3taXhhR8RCfH3oXJkm3dw9Ef6fy/PlI
         UecG0MgEERVWs3yxN9ChUlMrTtgP3kOZC2yMUcZX8WTSntlCwFSqzsb1XRg6mdXXI7LC
         FHeQ==
X-Gm-Message-State: APjAAAXK/oU1XC7XTahdJAEUBjCl0f3YkUoB0+bbapnOVoz4MMSZhygT
        E7pQ+eN98fPDKZ0DB66YjI/8xnQ1r/+wfg==
X-Google-Smtp-Source: APXvYqzQdLt74bZpR/QszTiU7O1BYu09SXT0jvUx/VBoSoM7Q4GuNldyomx1VQdfH4jA9xy9gDAsdA==
X-Received: by 2002:ac8:f02:: with SMTP id e2mr24184738qtk.216.1580762995542;
        Mon, 03 Feb 2020 12:49:55 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 135sm10064940qkl.68.2020.02.03.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:49:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/24] btrfs: change nr to u64 in btrfs_start_delalloc_roots
Date:   Mon,  3 Feb 2020 15:49:28 -0500
Message-Id: <20200203204951.517751-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
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

