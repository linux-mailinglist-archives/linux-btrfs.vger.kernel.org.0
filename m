Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99ADE836BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbfHFQ2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:28:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44854 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387867AbfHFQ2s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:28:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id d79so63296106qke.11
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dXKM7lygdO0L63dUE3quhK8HKduKDYbyNiQPEGzXIHY=;
        b=M+J0tVQBQEzapC8fSC0wD1K3w0+LxeDEUC0noClf1D9j2WBUKk5/F15XKkYUSfAD++
         6tgj2l0fjrVZi/tCXKSLr8Q+ueBAHi7IJVuUDRFPySQlSHqFzmK/06rs5gHmeygjoJ7F
         2ZT5bFBIiOwNycmJ7UROgIe9kW3tDDlgWifmcOJHPoh5hfu1aiIBcQj5iZuXG+VRAxFR
         84+08dJ73tj41+PZwm0vFBB6IWLVVfzdKuWh6WFbfM2mhqdShrzINUohSbmIkf7AYPpe
         uCjtc1cktKKpzSwRnBEPFNVvoS4sBhHlIDW7lvqn4+xJVCTCzzB/57N2IpCWmW+/x0/d
         ZC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dXKM7lygdO0L63dUE3quhK8HKduKDYbyNiQPEGzXIHY=;
        b=NH4up5/dwM3Jadm9crHaDFXEfC7c7Vko05cs+PTCuFjEKcNW/MZBGI2bNrOW7qVgxF
         pu1i3EaoMPh4GR9F1cvngi0sz3ZwY2GcVWRb2Y239nmcWVS5fhsJZF/ZQoTPczp/x7xY
         qSXhR88knF78X79INmA3ewvIUFmFx1QJ1Wr74dI/PN4UGoQ5i78fC0OJdg/QB6m5GDt3
         dRG725fMFDShdKYuo56MykpZAy1VKn6aF3LC9M6HUox4/S3oKbOYg7r38/k1AVi5nvdy
         ojicFW8bT7SHuQ8PPwlcUDMfnJG3o13wvKAaZ39TwqyFpLYqTnrzVy0M9Ts4NbVG1akJ
         OBZw==
X-Gm-Message-State: APjAAAXAr4Eym7lWR18uIjK4AQcqR+MsIkDqKTqcJMXi1Re6WhWbprLE
        XcZB9q206HgBzeh1J5jqDJMsnmENAbV9pA==
X-Google-Smtp-Source: APXvYqx6rNm4+RYIaLU3Fk4B56QfpmLrFLXlXpJI1bjWZhZxzAIpMEoeMGt6xIxaKNq0EPfzJNyTjQ==
X-Received: by 2002:a37:6844:: with SMTP id d65mr4012187qkc.398.1565108927439;
        Tue, 06 Aug 2019 09:28:47 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z50sm45156004qtz.36.2019.08.06.09.28.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:28:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 04/15] btrfs: export get_alloc_profile
Date:   Tue,  6 Aug 2019 12:28:26 -0400
Message-Id: <20190806162837.15840-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This gets used directly by a bunch of the block group code, export it to
make it easier to move things around.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/extent-tree.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 266c3cb5f3c9..460f2c53e428 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2467,6 +2467,7 @@ static inline u64 btrfs_calc_trunc_metadata_size(struct btrfs_fs_info *fs_info,
 int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
 			      u64 start, u64 num_bytes);
 void btrfs_free_excluded_extents(struct btrfs_block_group_cache *cache);
+u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			   unsigned long count);
 void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d28e736fdef2..791a2c43a1c0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3255,7 +3255,7 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	return extended_to_chunk(flags | allowed);
 }
 
-static u64 get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
+u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
 {
 	unsigned seq;
 	u64 flags;
@@ -3288,23 +3288,23 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 	else
 		flags = BTRFS_BLOCK_GROUP_METADATA;
 
-	ret = get_alloc_profile(fs_info, flags);
+	ret = btrfs_get_alloc_profile(fs_info, flags);
 	return ret;
 }
 
 u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
-	return get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_DATA);
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_DATA);
 }
 
 u64 btrfs_metadata_alloc_profile(struct btrfs_fs_info *fs_info)
 {
-	return get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 }
 
 u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
 {
-	return get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 }
 
 static void force_metadata_allocation(struct btrfs_fs_info *info)
@@ -6950,7 +6950,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 	ret = __btrfs_inc_block_group_ro(cache, 0);
 	if (!ret)
 		goto out;
-	alloc_flags = get_alloc_profile(fs_info, cache->space_info->flags);
+	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
@@ -6970,7 +6970,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 {
-	u64 alloc_flags = get_alloc_profile(trans->fs_info, type);
+	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
 
 	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 }
@@ -7495,7 +7495,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	}
 
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
-		if (!(get_alloc_profile(info, space_info->flags) &
+		if (!(btrfs_get_alloc_profile(info, space_info->flags) &
 		      (BTRFS_BLOCK_GROUP_RAID10 |
 		       BTRFS_BLOCK_GROUP_RAID1_MASK |
 		       BTRFS_BLOCK_GROUP_RAID56_MASK |
-- 
2.21.0

