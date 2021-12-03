Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A92C467FC9
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383381AbhLCWVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383378AbhLCWVu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:50 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242AC061353
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:25 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 193so4969180qkh.10
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1LwK30TqGgFDmXlbggxhf5z1dOgxczE8yANuERgWp+M=;
        b=gqIbYdy3584b9ck1ZW6ggdWZoy+RnlJcQWQ3CLyj4ZlcrOuN+GHxopUpdMk4dnutaI
         4RE5SsniAT8zHwQAglkOm+2rNx7n1wpeGshRIyCRqh6MXumvA5cF8+SN4//HyCg0GHxv
         s++LM3TKajO3sMofR/kB0Tqmpvl3zTQRPwaQFB8SuRY+ILsT6jtcsGttVDg9W8h4jFFr
         Fh5LzbgKylt2k53m+LQfyquei8kJrbuA8CG75+lVpciCI6GrLeodg8tXEr4rANrMkXvP
         DU79LT0uv1MHBJme7IyjlDr3l1n7E/ySCUW5La1U8goyTzVENjfrmxLGD0dTyk0KWm0v
         dnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LwK30TqGgFDmXlbggxhf5z1dOgxczE8yANuERgWp+M=;
        b=JXQ/qoAyTb9jt67wM49PVAb7aEBH1wKWViQTX0aSMeOQ8OIOL+/Ja+4vhw37tMPHBb
         4e94ogG/JrEW+BpdTdZSyLFAgeefvNUGed0PN4HjZWh47bjWAsoPjvIq6QgVkDBGs1lD
         NpnnbeC0gWklQ4hNcxB76B0Ihnr5wfwnI/BVgO157Py0B4tiLAiYXKML7UNMZmYaTjQY
         wj1ksSpa9I1LVMjS9KULB8y/JB3Fmg5jyuItDxsecS8ys3baSePBaHuSKgXsE8QJgiGv
         IAcY1Sx5gDFuwm5rK5lASlGwPo4ST9eTMgbZI8iTeH32W0POLPOvkOvswYxiZiJL3EFA
         tAdQ==
X-Gm-Message-State: AOAM531A/WQqvKiDNm7paDe7+salZ1iNmnA27tJvWQdJFIdVxO5tLZNV
        vLSa+3SszMElCxuBAGBtZYBdXo2enWz9ow==
X-Google-Smtp-Source: ABdhPJwkHnZfXx0TwNnNRbHWlSb8ZLOx81JCKBZUI5OxMYD/Z+UyWB1l8fYnF1oruDNetQmh/Hz1Xg==
X-Received: by 2002:a05:620a:22d7:: with SMTP id o23mr19779262qki.222.1638569904901;
        Fri, 03 Dec 2021 14:18:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u11sm2772791qko.33.2021.12.03.14.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/18] btrfs: move extent locking outside of btrfs_truncate_inode_items
Date:   Fri,  3 Dec 2021 17:18:05 -0500
Message-Id: <7e0b2245f997b01d45747bc1a68176016402ce9f.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we are locking the extent and dropping the extent cache for
any inodes we truncate, unless they're in the tree log.  We call this
helper from

- truncate
- evict
- tree log
- free space cache truncation

For evict we've already dropped all of the extent cache for this inode
once we've gotten here, and we're the only one accessing this inode, so
this step is unnecessary.

For the tree log code we already skip this part.

Pull this work into the truncate path and the free space cache
truncation path.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 20 +++++++++++++-------
 fs/btrfs/inode-item.c       | 18 ------------------
 fs/btrfs/inode.c            | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 55e1be703a39..28b9c63ba536 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -289,9 +289,11 @@ int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
 
 int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 				    struct btrfs_block_group *block_group,
-				    struct inode *inode)
+				    struct inode *vfs_inode)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
+	struct btrfs_root *root = inode->root;
+	struct extent_state *cached_state = NULL;
 	int ret = 0;
 	bool locked = false;
 
@@ -321,19 +323,23 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 		btrfs_free_path(path);
 	}
 
-	btrfs_i_size_write(BTRFS_I(inode), 0);
-	truncate_pagecache(inode, 0);
+	btrfs_i_size_write(inode, 0);
+	truncate_pagecache(vfs_inode, 0);
+
+	lock_extent_bits(&inode->io_tree, 0, (u64)-1, &cached_state);
+	btrfs_drop_extent_cache(inode, 0, (u64)-1, 0);
 
 	/*
 	 * We skip the throttling logic for free space cache inodes, so we don't
 	 * need to check for -EAGAIN.
 	 */
-	ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
-					 0, BTRFS_EXTENT_DATA_KEY, NULL);
+	ret = btrfs_truncate_inode_items(trans, root, inode, 0,
+					 BTRFS_EXTENT_DATA_KEY, NULL);
+	unlock_extent_cached(&inode->io_tree, 0, (u64)-1, &cached_state);
 	if (ret)
 		goto fail;
 
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	ret = btrfs_update_inode(trans, root, inode);
 
 fail:
 	if (locked)
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 6e4b244ce96c..124f952ab9f2 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -473,8 +473,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	u64 bytes_deleted = 0;
 	bool be_nice = false;
 	bool should_throttle = false;
-	const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
-	struct extent_state *cached_state = NULL;
 
 	BUG_ON(new_size > 0 && min_type != BTRFS_EXTENT_DATA_KEY);
 
@@ -492,20 +490,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	path->reada = READA_BACK;
 
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-		lock_extent_bits(&inode->io_tree, lock_start, (u64)-1,
-				 &cached_state);
-
-		/*
-		 * We want to drop from the next block forward in case this
-		 * new size is not block aligned since we will be keeping the
-		 * last block of the extent just the way it is.
-		 */
-		btrfs_drop_extent_cache(inode, ALIGN(new_size,
-					fs_info->sectorsize),
-					(u64)-1, 0);
-	}
-
 	/*
 	 * This function is also used to drop the items in the log tree before
 	 * we relog the inode, so if root != BTRFS_I(inode)->root, it means
@@ -788,8 +772,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		if (!ret && last_size > new_size)
 			last_size = new_size;
 		btrfs_inode_safe_disk_i_size_write(inode, last_size);
-		unlock_extent_cached(&inode->io_tree, lock_start, (u64)-1,
-				     &cached_state);
 	}
 
 	btrfs_free_path(path);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c29e7c87ff27..da474791da23 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8583,10 +8583,28 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	trans->block_rsv = rsv;
 
 	while (1) {
+		struct extent_state *cached_state = NULL;
+		const u64 new_size = inode->i_size;
+		const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
+
+		lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
+				 &cached_state);
+		/*
+		 * We want to drop from the next block forward in case this
+		 * new size is not block aligned since we will be keeping the
+		 * last block of the extent just the way it is.
+		 */
+		btrfs_drop_extent_cache(BTRFS_I(inode),
+					ALIGN(new_size, fs_info->sectorsize),
+					(u64)-1, 0);
+
 		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
 						 inode->i_size,
 						 BTRFS_EXTENT_DATA_KEY,
 						 &extents_found);
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lock_start,
+				     (u64)-1, &cached_state);
+
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		if (ret != -ENOSPC && ret != -EAGAIN)
 			break;
-- 
2.26.3

