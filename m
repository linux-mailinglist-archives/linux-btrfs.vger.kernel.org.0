Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1404B2D6536
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 19:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393127AbgLJShj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 13:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390732AbgLJOdT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 09:33:19 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F590C061794
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:32:34 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id a6so3736940qtw.6
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19V6Q04lor/ykK3Ul5TKTJgD0c2wD9P4uuH9D2Jh3FM=;
        b=bqag4eQeYAgAOVIYkA/sOfNAK+oXIr9/JLrfsjTMzTNQCxwa4d0G1pZ7pK3JFQSOOC
         jXgr/M2gy15iLv5nz68iDsLb73DDOOaDU9HQiFU+PnNJAcraxBEBaPE3Bcln7ARRB/kT
         SYTjvO3YBmk3aoGrONSxQb5IQY7V9CAzWmLWG+6frVx/d4tcU7j/9lQZaZrr7HXFtAA1
         q5QOA+xLPddhVaqr5G51Ld97+poD66lNUBaI2trww7J0tKvXPGo9UHRX0Ak3TQRrj4Yb
         Me+NL8gi/ggP9vD+yJrJSVw36fxwopan4ZgnJLuQfWs8sgA4W3r9R3NsbjZPL4Xxb+2w
         Cuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19V6Q04lor/ykK3Ul5TKTJgD0c2wD9P4uuH9D2Jh3FM=;
        b=POKmt3o7yYH2SzzmmCcC02yrKGSYHdecOubcUJ+8orx4nhLxo0nQZ66dJlhX5bOWYt
         fm/8nJ8nlFHkyjmOtrKJLRWMvlnSdw70dzxSgfMNiuAEX57tnlsIqyAvk+i0403Vkz5r
         wBcaNNkQ32agCeVpbsjuZD5cPXvmTNWGdwjd9zOPDUVp02+d1CAoQBpKxi5VpVGNAAXZ
         HMFUwMx1nRWGRGo6JWSNLNBHt9A4SJOfCfezd7CHY8+dXjxRh2sDRe4MVKZpiEm/oeok
         oFmj0EFeMS3nCPzWj29fdvbWVgab8EDnf9ZTK1q9cpPwtFZnc3H1z4DQ/cWpC+91lhG6
         f28Q==
X-Gm-Message-State: AOAM532ACII4nZ6ALtgvOEVEsv/cErj+Rqwto/YG9ucDS1lhL5/tu0vq
        FBN3fGRfCwh3hfwT05463Nef93dzGS0gvt0t
X-Google-Smtp-Source: ABdhPJwMUVJ6va7QKC2avwy1vQoGNX/+fkVmxE5xr/aBT5y23mWkVDT46y8r2GGQF9hr53MlxzOZJA==
X-Received: by 2002:a05:622a:14:: with SMTP id x20mr9551822qtw.58.1607610752817;
        Thu, 10 Dec 2020 06:32:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm3718855qkm.81.2020.12.10.06.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 06:32:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     stable@vger.kernel.org
Subject: [PATCH v2] btrfs: fix possible free space tree corruption with online conversion
Date:   Thu, 10 Dec 2020 09:32:31 -0500
Message-Id: <e5f7fe3ad3a612efeda53f016904aff332db6f8a.1607610739.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running btrfs/011 in a loop I would often ASSERT() while trying to
add a new free space entry that already existed, or get an -EEXIST while
adding a new block to the extent tree, which is another indication of
double allocation.

This occurs because when we do the free space tree population, we create
the new root and then populate the tree and commit the transaction.
The problem is when you create a new root, the root node and commit root
node are the same.  This means that caching a block group before the
transaction is committed can race with other operations modifying the
free space tree, and thus you can get double adds and other sort of
shenanigans.  This is only a problem for the first transaction, once
we've committed the transaction we created the free space tree in we're
OK to use the free space tree to cache block groups.

Fix this by marking the fs_info as unsafe to load the free space tree,
and fall back on the old slow method.  We could be smarter than this,
for example caching the block group while we're populating the free
space tree, but since this is a serious problem I've opted for the
simplest solution.

cc: stable@vger.kernel.org
Fixes: a5ed91828518 ("Btrfs: implement the free space B-tree")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c     | 11 ++++++++++-
 fs/btrfs/ctree.h           |  3 +++
 fs/btrfs/free-space-tree.c | 10 +++++++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 52f2198d44c9..b8bbdd95743e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -673,7 +673,16 @@ static noinline void caching_thread(struct btrfs_work *work)
 		wake_up(&caching_ctl->wait);
 	}
 
-	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+	/*
+	 * If we are in the transaction that populated the free space tree we
+	 * can't actually cache from the free space tree as our commit root and
+	 * real root are the same, so we could change the contents of the blocks
+	 * while caching.  Instead do the slow caching in this case, and after
+	 * the transaction has committed we will be safe.
+	 */
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    !(test_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
+		       &fs_info->flags)))
 		ret = load_free_space_tree(caching_ctl);
 	else
 		ret = load_extent_tree_free(caching_ctl);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3935d297d198..4a60d81da5cb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -562,6 +562,9 @@ enum {
 
 	/* Indicate that we need to cleanup space cache v1 */
 	BTRFS_FS_CLEANUP_SPACE_CACHE_V1,
+
+	/* Indicate that we can't trust the free space tree for caching yet. */
+	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
 };
 
 /*
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index e33a65bd9a0c..a33bca94d133 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1150,6 +1150,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		return PTR_ERR(trans);
 
 	set_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+	set_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
 	free_space_root = btrfs_create_tree(trans,
 					    BTRFS_FREE_SPACE_TREE_OBJECTID);
 	if (IS_ERR(free_space_root)) {
@@ -1171,11 +1172,18 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE);
 	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
 	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+	ret = btrfs_commit_transaction(trans);
 
-	return btrfs_commit_transaction(trans);
+	/*
+	 * Now that we've committed the transaction any reading of our commit
+	 * root will be safe, so we can cache from the free space tree now.
+	 */
+	clear_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
+	return ret;
 
 abort:
 	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
+	clear_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
 	btrfs_abort_transaction(trans, ret);
 	btrfs_end_transaction(trans);
 	return ret;
-- 
2.26.2

