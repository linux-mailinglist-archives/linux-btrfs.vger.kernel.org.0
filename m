Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7D2970F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373672AbgJWN6T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372968AbgJWN6T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:58:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD75C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:17 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h140so1173079qke.7
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Kqs/2jDVnYDl7xnn7knteRj+EJd55upv0d1bMNO3H8I=;
        b=DFuVu0hVKe7SUvrwABRD6Q2KGtE+ds84gBjF9Yq4dpZpuJRHfa3YGlibGAvR0nCLSY
         HKSd0ojKZ26MMzZHl/9ZSUD9LblEf4csUkXYN7vojyMFRy7r2+omJCIzWiklY91sc1Aa
         z9q+8kUvq3a381DmFbekwje3SNA0q+cCFOEQIxce+LS8XOePN8ewck5+17nPq4SRP/lv
         GC/gI9wiFwtvZKkt7kZdQ3yeVMS2ODnw4z0Ii6P0s1v27wldzMqBXD/AvAOvLMVkWN8d
         upRKZpe9XIPYl5RfxDvrsxtItHv0tl6cEFMrDgYAJQYRBiaovDtAXmtYvtSayypj97se
         i+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kqs/2jDVnYDl7xnn7knteRj+EJd55upv0d1bMNO3H8I=;
        b=tiiRgT8B8kdsQeNU98e30XS0kUcbZ752OsRBV71wla0QAbEgh5ucFV4elDz8tyYdrA
         YUoM6u9RYZ/tNU33yjeTM4Rq2Xrud9ClVOr1lV+OnFwjTiOhxjmLXkPIxyCHH7bW04/3
         /ZWDJ6enf/9u1rbuqh7Cuhx/r4sIgReQjtgiRhFKlgLVfy+MM2XAZlUYO1qtBSRt0JhB
         9D04KzHnM0vSXbFxt7zPsY6Mz3kMA2AK+IGAKQY0fa1/cpiy6Jh0XL1bKyxs1XxE3Oza
         IKW42wMd05aJVw4Or6ewU7KLRXVCVz59UDSiHmGGYTEk0oajgtyya6t2WR67V5DXupY6
         5Jxw==
X-Gm-Message-State: AOAM531pE8wvwue7cOQ17WrI8ykzv6cWoIQQomdmmDfO3mbdUwrAjvk6
        nC5jgE5GrwQkM2tlE2znIDJY3UhXfe+GTMC5
X-Google-Smtp-Source: ABdhPJz/iDK0/Rja3XdFYCmMR6h25iB5/4OS5EOGJVyFwBtXJ/8OZAnzSwn/o5DINnWO+inGIuzouw==
X-Received: by 2002:ae9:eb97:: with SMTP id b145mr2420075qkg.60.1603461496468;
        Fri, 23 Oct 2020 06:58:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w40sm915120qtj.48.2020.10.23.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:58:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs: update last_byte_to_unpin in switch_commit_roots
Date:   Fri, 23 Oct 2020 09:58:05 -0400
Message-Id: <f31bb86619489274227cae2184283f96a3b7bf36.1603460665.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603460665.git.josef@toxicpanda.com>
References: <cover.1603460665.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While writing an explanation for the need of the commit_root_sem for
btrfs_prepare_extent_commit, I realized we have a slight hole that could
result in leaked space if we have to do the old style caching.  Consider
the following scenario

 commit root
 +----+----+----+----+----+----+----+
 |\\\\|    |\\\\|\\\\|    |\\\\|\\\\|
 +----+----+----+----+----+----+----+
 0    1    2    3    4    5    6    7

 new commit root
 +----+----+----+----+----+----+----+
 |    |    |    |\\\\|    |    |\\\\|
 +----+----+----+----+----+----+----+
 0    1    2    3    4    5    6    7

Prior to this patch, we run btrfs_prepare_extent_commit, which updates
the last_byte_to_unpin, and then we subsequently run
switch_commit_roots.  In this example lets assume that
caching_ctl->progress == 1 at btrfs_prepare_extent_commit() time, which
means that cache->last_byte_to_unpin == 1.  Then we go and do the
switch_commit_roots(), but in the meantime the caching thread has made
some more progress, because we drop the commit_root_sem and re-acquired
it.  Now caching_ctl->progress == 3.  We swap out the commit root and
carry on to unpin.

In the unpin code we have last_byte_to_unpin == 1, so we unpin [0,1),
but do not unpin [2,3).  However because caching_ctl->progress == 3 we
do not see the newly free'd section of [2,3), and thus do not add it to
our free space cache.  This results in us missing a chunk of free space
in memory.

Fix this by making sure the ->last_byte_to_unpin is set at the same time
that we swap the commit roots, this ensures that we will always be
consistent.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/extent-tree.c | 25 -------------------------
 fs/btrfs/transaction.c | 41 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8a83bce3225c..41c76db65c8e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2592,7 +2592,6 @@ int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 len, int delalloc);
 int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start,
 			      u64 len);
-void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info);
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a98f484a2fc1..ee7bceace8b3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2730,31 +2730,6 @@ btrfs_inc_block_group_reservations(struct btrfs_block_group *bg)
 	atomic_inc(&bg->reservations);
 }
 
-void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_caching_control *next;
-	struct btrfs_caching_control *caching_ctl;
-	struct btrfs_block_group *cache;
-
-	down_write(&fs_info->commit_root_sem);
-
-	list_for_each_entry_safe(caching_ctl, next,
-				 &fs_info->caching_block_groups, list) {
-		cache = caching_ctl->block_group;
-		if (btrfs_block_group_done(cache)) {
-			cache->last_byte_to_unpin = (u64)-1;
-			list_del_init(&caching_ctl->list);
-			btrfs_put_caching_control(caching_ctl);
-		} else {
-			cache->last_byte_to_unpin = caching_ctl->progress;
-		}
-	}
-
-	up_write(&fs_info->commit_root_sem);
-
-	btrfs_update_global_block_rsv(fs_info);
-}
-
 /*
  * Returns the free cluster for the given space info and sets empty_cluster to
  * what it should be based on the mount options.
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 52ada47aff50..9ef6cba1eb59 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -155,6 +155,7 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 	struct btrfs_transaction *cur_trans = trans->transaction;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root, *tmp;
+	struct btrfs_caching_control *caching_ctl, *next;
 
 	down_write(&fs_info->commit_root_sem);
 	list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
@@ -180,6 +181,44 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 		spin_lock(&cur_trans->dropped_roots_lock);
 	}
 	spin_unlock(&cur_trans->dropped_roots_lock);
+
+	/*
+	 * We have to update the last_byte_to_unpin under the commit_root_sem,
+	 * at the same time we swap out the commit roots.
+	 *
+	 * This is because we must have a real view of the last spot the caching
+	 * kthreads were while caching.  Consider the following views of the
+	 * extent tree for a block group
+	 *
+	 * commit root
+	 * +----+----+----+----+----+----+----+
+	 * |\\\\|    |\\\\|\\\\|    |\\\\|\\\\|
+	 * +----+----+----+----+----+----+----+
+	 * 0    1    2    3    4    5    6    7
+	 *
+	 * new commit root
+	 * +----+----+----+----+----+----+----+
+	 * |    |    |    |\\\\|    |    |\\\\|
+	 * +----+----+----+----+----+----+----+
+	 * 0    1    2    3    4    5    6    7
+	 *
+	 * If the cache_ctl->progress was at 3, then we are only allowed to
+	 * unpin [0,1) and [2,3], because the caching thread has already
+	 * processed those extents.  We are not allowed to unpin [5,6), because
+	 * the caching thread will re-start it's search from 3, and thus find
+	 * the hole from [4,6) to add to the free space cache.
+	 */
+	list_for_each_entry_safe(caching_ctl, next,
+				 &fs_info->caching_block_groups, list) {
+		struct btrfs_block_group *cache = caching_ctl->block_group;
+		if (btrfs_block_group_done(cache)) {
+			cache->last_byte_to_unpin = (u64)-1;
+			list_del_init(&caching_ctl->list);
+			btrfs_put_caching_control(caching_ctl);
+		} else {
+			cache->last_byte_to_unpin = caching_ctl->progress;
+		}
+	}
 	up_write(&fs_info->commit_root_sem);
 }
 
@@ -2293,8 +2332,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		goto unlock_tree_log;
 	}
 
-	btrfs_prepare_extent_commit(fs_info);
-
 	cur_trans = fs_info->running_transaction;
 
 	btrfs_set_root_node(&fs_info->tree_root->root_item,
-- 
2.26.2

