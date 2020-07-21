Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB892281ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgGUOWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:22:40 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01662C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:40 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z15so12613783qki.10
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J36cNQ1tXyjMa+mflUWj9ER0c/TvEfxh7nAeu52A0Uc=;
        b=0IRTtqSdFLzHOZYECl/5eduocO6rgrY/nQ0x7I6/Vbcop2MFTXImzZoACjvK1kunVI
         0gCBoEBJ1CTfmR4KX6//4TV4PEarPbxBdAXmYmsSAkgDbALwuSk1tYogf0YTvsIiGRIo
         N8qwDpLhjGlsZqmeHh4nU5cp8vPWo5pox9DWpECQBj8sr6xqJkWQ7Z8obkWzN7jDD04x
         JsbUJ0MbeHiocMUUgXj15G1hB56LWfTq2CNrVhyjeZ03Owfvj+aZ+7d6EMz7z9BLohOd
         bkv2Z8++fDTAyKN4fYxr+qRz80ZEfz6GHbLPMxZe5jSqGkRrtcVs3N2hQs9gJf8XwV2h
         V8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J36cNQ1tXyjMa+mflUWj9ER0c/TvEfxh7nAeu52A0Uc=;
        b=p9W9PSb4dWZb2iXkxFysW35IGONL1L28aXpFGGmcSiXQGg7x45cxd6TJznyJYl+aWL
         1nx/DaVL6PMUuOo4Fk+l8+s7s+oequcji95yWzdvJLCqos2eavgTaBA2Tir6w0juBlbS
         fv3jII4cg1tzIup7LCRv1sdCXJiXNozlD+v9K/vQBGrYJ0Zx3n/GS1pbUBwXIbZW/npk
         3ZRgQ2/gGBgcRwozTY62MG2f6tAlqH587/H+hqOnjRzGx0P5zePa2aH3Qly6N4fZc+4f
         xwM9gu4E0oON3ihYt5ChjQpz7zw9+G0+gsiCeTOW031Zhwo/azOr/HJXvvYxdVPi2hpe
         l51w==
X-Gm-Message-State: AOAM532/8HgX6lveWzYdPTq4ZYM3HCj1NesjJAqW6DSntzQICEG39bsI
        hPHOFfc7u3wODxd4SYY2MGN21eY5anCXfg==
X-Google-Smtp-Source: ABdhPJwEFfjKi1yM1DaQu4iClKg4V2H6aigWdUCBrvbimYQxwTsO//vxoVbL3e+izL9vwYDd0cWBQw==
X-Received: by 2002:ae9:ea13:: with SMTP id f19mr26807113qkg.331.1595341358719;
        Tue, 21 Jul 2020 07:22:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o4sm23467630qtf.92.2020.07.21.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:22:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 01/23] btrfs: change nr to u64 in btrfs_start_delalloc_roots
Date:   Tue, 21 Jul 2020 10:22:12 -0400
Message-Id: <20200721142234.2680-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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
index b70c2024296f..4e882ae15eea 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2956,7 +2956,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       u32 min_type);
 
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root);
-int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr);
+int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr);
 int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index db93909b25e0..769ac3098880 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -630,7 +630,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	 * flush all outstanding I/O and inode extent mappings before the
 	 * copy operation is declared as being finished
 	 */
-	ret = btrfs_start_delalloc_roots(fs_info, -1);
+	ret = btrfs_start_delalloc_roots(fs_info, U64_MAX);
 	if (ret) {
 		mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
 		return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 611b3412fbfd..97bfd50d7923 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9382,7 +9382,8 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
  * some fairly slow code that needs optimization. This walks the list
  * of all the inodes with pending delalloc and forces them to disk.
  */
-static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
+static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr,
+				 bool snapshot)
 {
 	struct btrfs_inode *binode;
 	struct inode *inode;
@@ -9422,9 +9423,11 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
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
@@ -9449,18 +9452,15 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
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
@@ -9483,15 +9483,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr)
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
index bd3511c5ca81..e45520d3cf51 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4883,7 +4883,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_SYNC: {
 		int ret;
 
-		ret = btrfs_start_delalloc_roots(fs_info, -1);
+		ret = btrfs_start_delalloc_roots(fs_info, U64_MAX);
 		if (ret)
 			return ret;
 		ret = btrfs_sync_fs(inode->i_sb, 1);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c7bd3fdd7792..ef6e264746fc 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -477,7 +477,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 }
 
 static void btrfs_writeback_inodes_sb_nr(struct btrfs_fs_info *fs_info,
-					 unsigned long nr_pages, int nr_items)
+					 unsigned long nr_pages, u64 nr_items)
 {
 	struct super_block *sb = fs_info->sb;
 
-- 
2.24.1

