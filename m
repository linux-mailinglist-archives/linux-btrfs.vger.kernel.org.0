Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD0325A0E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgIAVkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 17:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgIAVkq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 17:40:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C16C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 14:40:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w16so3943qkj.7
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ecVV5EltMj5QywktaFMyO1s0bSwOJgCHsvKDSvHr1aA=;
        b=J7xzAlKlBa5TA2dMBG6V7ftkbXSy/+AvYnCKqHO9BG/6GfvXMNFQNGfDX4Jq6Wq8jE
         lj6tfNXQPgEuAi7mN2o3tmBqTARqhBn/fGveGRloh1gQhemY7pdnkPzzbYYFVurpGoYJ
         pVPfDO7XSENLHL17G7v8gKmzHb+WZl6RWuXGVg5+/y84cALIP+U/OybiAvk2EkNSZVX+
         KOL6J6Evy6cxq3yxfvd9COEMLYn6SJKY/EQe29+gmPX01lb6VwPJ3MMLCSdJIWAElceB
         syp61xuRHEnfdHFwha3n/p0lvMXjixOxu9th2HyiiYEHC1zl9wiAq20qGiBN6tUSdq99
         0PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecVV5EltMj5QywktaFMyO1s0bSwOJgCHsvKDSvHr1aA=;
        b=slfRYWOlo9AQxPzdhbYRYFJuEmXT7Kg7Io57+v+iLfbq2CavsY+3FN8J/9RBD7fnZn
         ryqpvBfv4MgVflO/z6gVyU2kwP5PbfweDZyAUZphPs/wcwEY3DDNQvTKW/6U3Xd5miun
         0D47L1hO5GPX/82IA6r8jyvvQe0S0UfeHzh+F6QfBc8X7izLUXlJjAqZ9xnIEeTr0AUj
         tOfk+8G8kfDt484VIJ5aG0IQNphfDSZBOw5q0vrL3v9VJW/adQD30gn805OgGVDlYPAF
         Ox+GgVnCocKMYNwETIb/jrvzuBCmQGVdd/xHdBhoLChZQxSBuU1g85nyiajoXDT5w/a0
         s01A==
X-Gm-Message-State: AOAM5307RrqkHLDU+coLAOzMsOvFWzTC8Ckb+T5vlaFU1pqZOozCtRBZ
        uW/0d/m5lraVK/U4Ebeex3UKoPwoeL4tJpvw
X-Google-Smtp-Source: ABdhPJzlx4hycu/Zs3JuxqVN8culpAR7ISC2FNc4+IA6/DvOTvkp+0r3T4M1M4JVpTN1dV8aEMIAjw==
X-Received: by 2002:a37:a143:: with SMTP id k64mr4073662qke.266.1598996444834;
        Tue, 01 Sep 2020 14:40:44 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v42sm3211945qth.35.2020.09.01.14.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 14:40:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/4] btrfs: kill the rcu protection for fs_info->space_info
Date:   Tue,  1 Sep 2020 17:40:37 -0400
Message-Id: <a88fca8411a0b1f5bc25926a4489b07af0f65ffa.1598996236.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1598996236.git.josef@toxicpanda.com>
References: <cover.1598996236.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have this thing wrapped in an rcu lock, but it's really not needed.
We create all the space_info's on mount, and we destroy them on unmount.
The list never changes and we're protected from messing with it by the
normal mount/umount path, so kill the RCU stuff around it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 16 ++--------------
 fs/btrfs/ioctl.c       | 10 ++--------
 fs/btrfs/space-info.c  | 14 ++++----------
 fs/btrfs/super.c       |  5 +----
 4 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 01e8ba1da1d3..a3b27204371c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2031,8 +2031,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		btrfs_release_path(path);
 	}
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(space_info, &info->space_info, list) {
+	list_for_each_entry(space_info, &info->space_info, list) {
 		if (!(btrfs_get_alloc_profile(info, space_info->flags) &
 		      (BTRFS_BLOCK_GROUP_RAID10 |
 		       BTRFS_BLOCK_GROUP_RAID1_MASK |
@@ -2052,7 +2051,6 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 				list)
 			inc_block_group_ro(cache, 1);
 	}
-	rcu_read_unlock();
 
 	btrfs_init_global_block_rsv(info);
 	ret = check_chunk_block_group_mappings(info);
@@ -3007,12 +3005,10 @@ static void force_metadata_allocation(struct btrfs_fs_info *info)
 	struct list_head *head = &info->space_info;
 	struct btrfs_space_info *found;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(found, head, list) {
+	list_for_each_entry(found, head, list) {
 		if (found->flags & BTRFS_BLOCK_GROUP_METADATA)
 			found->force_alloc = CHUNK_ALLOC_FORCE;
 	}
-	rcu_read_unlock();
 }
 
 static int should_alloc_chunk(struct btrfs_fs_info *fs_info,
@@ -3343,14 +3339,6 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	}
 	spin_unlock(&info->block_group_cache_lock);
 
-	/*
-	 * Now that all the block groups are freed, go through and free all the
-	 * space_info structs.  This is only called during the final stages of
-	 * unmount, and so we know nobody is using them.  We call
-	 * synchronize_rcu() once before we start, just to be on the safe side.
-	 */
-	synchronize_rcu();
-
 	btrfs_release_global_block_rsv(info);
 
 	while (!list_empty(&info->space_info)) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a5f466d23139..3a7a34cf6c22 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3461,15 +3461,12 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 		struct btrfs_space_info *tmp;
 
 		info = NULL;
-		rcu_read_lock();
-		list_for_each_entry_rcu(tmp, &fs_info->space_info,
-					list) {
+		list_for_each_entry(tmp, &fs_info->space_info, list) {
 			if (tmp->flags == types[i]) {
 				info = tmp;
 				break;
 			}
 		}
-		rcu_read_unlock();
 
 		if (!info)
 			continue;
@@ -3517,15 +3514,12 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 			break;
 
 		info = NULL;
-		rcu_read_lock();
-		list_for_each_entry_rcu(tmp, &fs_info->space_info,
-					list) {
+		list_for_each_entry(tmp, &fs_info->space_info, list) {
 			if (tmp->flags == types[i]) {
 				info = tmp;
 				break;
 			}
 		}
-		rcu_read_unlock();
 
 		if (!info)
 			continue;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b733718f45d3..837615702c94 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -175,10 +175,8 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
 	struct list_head *head = &info->space_info;
 	struct btrfs_space_info *found;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(found, head, list)
+	list_for_each_entry(found, head, list)
 		found->full = 0;
-	rcu_read_unlock();
 }
 
 static int create_space_info(struct btrfs_fs_info *info, u64 flags)
@@ -213,7 +211,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	if (ret)
 		return ret;
 
-	list_add_rcu(&space_info->list, &info->space_info);
+	list_add(&space_info->list, &info->space_info);
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
 		info->data_sinfo = space_info;
 
@@ -290,14 +288,10 @@ struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 
 	flags &= BTRFS_BLOCK_GROUP_TYPE_MASK;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(found, head, list) {
-		if (found->flags & flags) {
-			rcu_read_unlock();
+	list_for_each_entry(found, head, list) {
+		if (found->flags & flags)
 			return found;
-		}
 	}
-	rcu_read_unlock();
 	return NULL;
 }
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3ebe7240c63d..8840a4fa81eb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2164,8 +2164,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 thresh = 0;
 	int mixed = 0;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(found, &fs_info->space_info, list) {
+	list_for_each_entry(found, &fs_info->space_info, list) {
 		if (found->flags & BTRFS_BLOCK_GROUP_DATA) {
 			int i;
 
@@ -2194,8 +2193,6 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		total_used += found->disk_used;
 	}
 
-	rcu_read_unlock();
-
 	buf->f_blocks = div_u64(btrfs_super_total_bytes(disk_super), factor);
 	buf->f_blocks >>= bits;
 	buf->f_bfree = buf->f_blocks - (div_u64(total_used, factor) >> bits);
-- 
2.26.2

