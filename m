Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5EA2970FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373788AbgJWN6X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372968AbgJWN6W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:58:22 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575E3C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:21 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id s17so699307qvr.11
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z497L4gT5Xjgc2QE6kY0Ag3tjw4Ujb5y7t6fOXrVYxY=;
        b=jKehH3Fj6oK0/j/EkTg4vWafiOiSeJHO9ToiL9L0UQunhBqCk6f7bWZfsX8Qi27xye
         fJrnugje//Zs5IaFOgLtVNZQgrsErWKi+BzulTRCvjvCYDxiZgOC6NbhbLaaWVP8YScc
         DL+ST7BzUCz+l+cTMze1IoIHY73TV/uAq/33/A/rKqN4Yt2Ai6q5NmRn3PwlAjZ12tye
         k43EJ5FiKYUEyN35NRWAbkbrHaMJ/O42OGWun7cCdvuiF7jLwKM6nEA+gZTjM97hdVVG
         c3ezPpTJ63M41nKXDMb6Y/ijmjO0eM4JOCQei88C4tFqOUz/r+mN3aSZwV9w/3lbLACS
         NUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z497L4gT5Xjgc2QE6kY0Ag3tjw4Ujb5y7t6fOXrVYxY=;
        b=O6+0xj3agzZWo2RQ4lwifyXVLX3x2PmfwNoUARvBKvEB9sB+P2Vhz9OeFrA5sFahG9
         Z/ON5my0EntJAtAEjBGLhHCO476cO0mMlV6suuV8EzXeN87QOz39U++7ymGNakTxT4Tt
         4R+T9P4CoKbQhEUhzJLvSMKxG3zDytCzWDc56YKBpVm492BFbRMWQEPF1cj5SZBm9iRH
         MoOTE6h5xxkj3wBbFI1Zj8Di8OmahjJKgg9FcccZu/6Fc0iXrvJskvU1KuQ6o49iQlFA
         LW3siUJQq5BpujsLjbJZ8EJusN0BFvHVwpC1HWx+NGP9CUhMivMhA9+HH9+NQgzqGlvx
         KB2g==
X-Gm-Message-State: AOAM533B0YYdwKhaKkOsGvG0nT4nSfsgp/5WeZx0ylFGAjfa20rGcLsH
        AbmmhxIeqT0BngN3DSYUKc8bkz+M9o+tS91L
X-Google-Smtp-Source: ABdhPJzq2eDGCBfPObAFXnOm8NkYKjzygl6IEISW7644NMv7yWkalxQK3TxSoB8i8zbRLDA2mDHJNA==
X-Received: by 2002:a0c:f38b:: with SMTP id i11mr2271254qvk.41.1603461500080;
        Fri, 23 Oct 2020 06:58:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 19sm760237qki.33.2020.10.23.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:58:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: cleanup btrfs_discard_update_discardable usage
Date:   Fri, 23 Oct 2020 09:58:07 -0400
Message-Id: <afb3c72b04191707f96001bc3698e14b4d3400a8.1603460665.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603460665.git.josef@toxicpanda.com>
References: <cover.1603460665.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This passes in the block_group and the free_space_ctl, but we can get
this from the block group itself.  Part of this is because we call it
from __load_free_space_cache, which can be called for the inode cache as
well.  Move that call into the block group specific load section, wrap
it in the right lock that we need, and fix up the arguments to only take
the block group.  Add a lockdep_assert as well for good measure to make
sure we don't mess up the locking again.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/discard.c          |  7 ++++---
 fs/btrfs/discard.h          |  3 +--
 fs/btrfs/free-space-cache.c | 14 ++++++++------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 741c7e19c32f..5a88b584276f 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -563,15 +563,14 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 /**
  * btrfs_discard_update_discardable - propagate discard counters
  * @block_group: block_group of interest
- * @ctl: free_space_ctl of @block_group
  *
  * This propagates deltas of counters up to the discard_ctl.  It maintains a
  * current counter and a previous counter passing the delta up to the global
  * stat.  Then the current counter value becomes the previous counter value.
  */
-void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
-				      struct btrfs_free_space_ctl *ctl)
+void btrfs_discard_update_discardable(struct btrfs_block_group *block_group)
 {
+	struct btrfs_free_space_ctl *ctl;
 	struct btrfs_discard_ctl *discard_ctl;
 	s32 extents_delta;
 	s64 bytes_delta;
@@ -581,8 +580,10 @@ void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
 	    !btrfs_is_block_group_data_only(block_group))
 		return;
 
+	ctl = block_group->free_space_ctl;
 	discard_ctl = &block_group->fs_info->discard_ctl;
 
+	lockdep_assert_held(&ctl->tree_lock);
 	extents_delta = ctl->discardable_extents[BTRFS_STAT_CURR] -
 			ctl->discardable_extents[BTRFS_STAT_PREV];
 	if (extents_delta) {
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 353228d62f5a..57b9202f427f 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -28,8 +28,7 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
 
 /* Update operations */
 void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
-void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
-				      struct btrfs_free_space_ctl *ctl);
+void btrfs_discard_update_discardable(struct btrfs_block_group *block_group);
 
 /* Setup/cleanup operations */
 void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 5ea36a06e514..0787339c7b93 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -828,7 +828,6 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 	merge_space_tree(ctl);
 	ret = 1;
 out:
-	btrfs_discard_update_discardable(ctl->private, ctl);
 	io_ctl_free(&io_ctl);
 	return ret;
 free_cache:
@@ -929,6 +928,9 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 			   block_group->start);
 	}
 
+	spin_lock(&ctl->tree_lock);
+	btrfs_discard_update_discardable(block_group);
+	spin_unlock(&ctl->tree_lock);
 	iput(inode);
 	return ret;
 }
@@ -2508,7 +2510,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	if (ret)
 		kmem_cache_free(btrfs_free_space_cachep, info);
 out:
-	btrfs_discard_update_discardable(block_group, ctl);
+	btrfs_discard_update_discardable(block_group);
 	spin_unlock(&ctl->tree_lock);
 
 	if (ret) {
@@ -2643,7 +2645,7 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 		goto again;
 	}
 out_lock:
-	btrfs_discard_update_discardable(block_group, ctl);
+	btrfs_discard_update_discardable(block_group);
 	spin_unlock(&ctl->tree_lock);
 out:
 	return ret;
@@ -2779,7 +2781,7 @@ void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl)
 	spin_lock(&ctl->tree_lock);
 	__btrfs_remove_free_space_cache_locked(ctl);
 	if (ctl->private)
-		btrfs_discard_update_discardable(ctl->private, ctl);
+		btrfs_discard_update_discardable(ctl->private);
 	spin_unlock(&ctl->tree_lock);
 }
 
@@ -2801,7 +2803,7 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group)
 		cond_resched_lock(&ctl->tree_lock);
 	}
 	__btrfs_remove_free_space_cache_locked(ctl);
-	btrfs_discard_update_discardable(block_group, ctl);
+	btrfs_discard_update_discardable(block_group);
 	spin_unlock(&ctl->tree_lock);
 
 }
@@ -2885,7 +2887,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 			link_free_space(ctl, entry);
 	}
 out:
-	btrfs_discard_update_discardable(block_group, ctl);
+	btrfs_discard_update_discardable(block_group);
 	spin_unlock(&ctl->tree_lock);
 
 	if (align_gap_len)
-- 
2.26.2

