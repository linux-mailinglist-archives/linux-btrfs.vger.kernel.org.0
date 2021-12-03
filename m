Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D54467FCE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383390AbhLCWV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383382AbhLCWV5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:57 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912B4C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:32 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a2so4816930qtx.11
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=75beZCfjU1J2T2g2eJHqUp1T8G+zWOWlLw5fTK6HPCA=;
        b=if9Z6r7nPG6J+eFUa53I9QU48QcK4xuestDirPS4Yy+O+VT7CRa4rjd9VWOktmzfVX
         rZPh/RznqVol1Wmro4dE+SzArOyjRiLR+62kkgA3Lrah8H+dzzqCrKvibEk5fi5DNlrR
         72hbQmF8/1AiCsrBNbrtPIDc71Ufajk1G2s73lR5tFcOqqzYRhbYLzEDd5BRpeuVmnAx
         qvVnNMwv4HAFxMXiU/Jc2HmRZ8qIshQwQgdYqxyz5WoPm7qDkM80+8uHDnn8/nxeXgai
         /GoCaEzRuScOzG4mjXO8kRo/zrQBueBTGMk71EzJiNnKsbVQskAGx9or97MmDhosygcB
         e19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75beZCfjU1J2T2g2eJHqUp1T8G+zWOWlLw5fTK6HPCA=;
        b=bbBC4qftAb9r998NEMODMP31xbUG2hIA2F7EiqI25OenPdowaE5tKb2e7OQ+oFkkIw
         tnTZOzirN0mCyFafSA58iN1U9yMLwupq3fOQ5I1LJStXnc9LjyJwQJPE/ROMObQO2V/h
         Cmuaun3Ok5khtEJlpQkXhwNArQUU82Rh3ZdrdfAQa4TdImv3nOMJUrCdVLugqD13MkSq
         DlW/kE0CiajcABjEdIEfJ/gGRVUHqXWWd+8zYwXrFXc3VRmT3kYBLJSFGjMtp+EdSDtN
         EiCazyP92/Iy0x8UbyUDA1brJUOq7FNzSGg4TPZJtZHj0jy1Os7dsDorVs3vbHsZ1I7C
         n77w==
X-Gm-Message-State: AOAM531JYqeBq82gjG1fH+VLBp9VPvG/9QaaqMdvRvMvgLU7zatYn+I1
        4uWohxu6JtW3vZXpoTMw4IC8Oknb++qdHw==
X-Google-Smtp-Source: ABdhPJyJfpo7YU94ehqTGdtL7c/kWdKLvkJ0NwDO1uFpBNSHRggNk2Gy9q34kwf+g4gr5A2UbqH17A==
X-Received: by 2002:a05:622a:54c:: with SMTP id m12mr11721106qtx.280.1638569911422;
        Fri, 03 Dec 2021 14:18:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s126sm2724710qkf.7.2021.12.03.14.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/18] btrfs: only update i_size in truncate paths that care
Date:   Fri,  3 Dec 2021 17:18:10 -0500
Message-Id: <cf4101bbbb10b6cada23185632742ce535d04cba.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We currently will update the i_size of the inode as we truncate it down,
however we skip this if we're calling btrfs_truncate_inode_items from
the tree log code.  However we also don't care about this in the case of
evict.  Instead keep track of this value in the btrfs_truncate_control
and then have btrfs_truncate() and the free space cache truncate path
both do the i_size update themselves.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c |  3 +++
 fs/btrfs/inode-item.c       | 17 ++++++++---------
 fs/btrfs/inode-item.h       |  3 +++
 fs/btrfs/inode.c            |  4 ++++
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index a05dd3d29695..fd469beb0985 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -338,6 +338,9 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	 * need to check for -EAGAIN.
 	 */
 	ret = btrfs_truncate_inode_items(trans, root, inode, &control);
+
+	btrfs_inode_safe_disk_i_size_write(inode, control.last_size);
+
 	unlock_extent_cached(&inode->io_tree, 0, (u64)-1, &cached_state);
 	if (ret)
 		goto fail;
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index fa172c760fe2..15dc5352d08a 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -452,7 +452,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	u64 extent_num_bytes = 0;
 	u64 extent_offset = 0;
 	u64 item_end = 0;
-	u64 last_size = new_size;
 	u32 found_type = (u8)-1;
 	int del_item;
 	int pending_del_nr = 0;
@@ -466,6 +465,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 	BUG_ON(new_size > 0 && control->min_type != BTRFS_EXTENT_DATA_KEY);
 
+	control->last_size = new_size;
+
 	/*
 	 * For shareable roots we want to back off from time to time, this turns
 	 * out to be subvolume roots, reloc roots, and data reloc roots.
@@ -649,9 +650,9 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		}
 
 		if (del_item)
-			last_size = found_key.offset;
+			control->last_size = found_key.offset;
 		else
-			last_size = new_size;
+			control->last_size = new_size;
 		if (del_item) {
 			if (!pending_del_nr) {
 				/* no pending yet, add ourselves */
@@ -744,12 +745,10 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			ret = err;
 		}
 	}
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-		ASSERT(last_size >= new_size);
-		if (!ret && last_size > new_size)
-			last_size = new_size;
-		btrfs_inode_safe_disk_i_size_write(inode, last_size);
-	}
+
+	ASSERT(control->last_size  >= new_size);
+	if (!ret && control->last_size > new_size)
+		control->last_size = new_size;
 
 	btrfs_free_path(path);
 	return ret;
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 47c3fec579f8..21adab1df4e5 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -16,6 +16,9 @@ struct btrfs_truncate_control {
 	/* OUT: the number of extents truncated. */
 	u64 extents_found;
 
+	/* OUT: the last size we truncated this inode to. */
+	u64 last_size;
+
 	/*
 	 * IN: minimum key type to remove.  All key types with this type are
 	 * removed only if their offset >= new_size.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6600c474b2e8..23b47c7bce0f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8620,6 +8620,10 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 
 		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
 						 &control);
+
+		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode),
+						   control.last_size);
+
 		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lock_start,
 				     (u64)-1, &cached_state);
 
-- 
2.26.3

