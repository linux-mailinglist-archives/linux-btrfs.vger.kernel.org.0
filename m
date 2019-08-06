Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBE8836DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbfHFQ3E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:29:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36153 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387782AbfHFQ3D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:29:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so85203456qtc.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VKGgH/ZndUHuK6+BE7VdunrhKdpuT0Yp0EFLV5WnNeI=;
        b=MWn5VfSLh3FXZFH1q+ho2nR5kkINA4q8OhSpYgr5wn5LjqVwqS+D6dKoeKmeUq4SL5
         J7PtlCG9S0WLgjHtk9K1zqLAMKw+wn5XEkVhAjwpRGLptrM4paVjTDwxJIByomJHZ5Z0
         MX5g7sXZdV0LdSw2W8Lc+Al3XlcPLc0HnsXHTXCiUy6kSzOQ237Vb6ATThlrKrdAUc5Z
         I54ff3uxpLvT0jfpIIAiSSKHwkdY2qQywZqA0TdVq2k7TB6j6yU6s1zNe2RSsJ6qtkQg
         mhh/Gin9CFMmMYaU15RSWs7zzZRiDk0DgrIacKgQtQlAgFHeRqP4WIAPBhpvTmkS9yZJ
         l2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VKGgH/ZndUHuK6+BE7VdunrhKdpuT0Yp0EFLV5WnNeI=;
        b=T7O/KHkaVmFB4uQvQF4Z5iCmszIkCQAw2zhgoKSV114DNAWp6f+cIiT6ST0LJdqrIh
         zHZfKylSA7POK+vv6zaMc9BM+z2aUsV/gSG23EwrFClGhoPCxCqYaFmoOKGOkj/z5LFl
         p8d2+bZaQd4+Z+gxucuwJnvPQBojNgydNcOJxqMw3+Mjm2vwUcBs9/yJKwahb2MTLoFn
         9Tfm4v0tzJhhIlreVeeIE/ELIvXBNvBlpZFVr6BvA0KJf1VUyvXGpl6wFFP0EI+5nm1C
         K6NqjtD79WyNGykbOTOsX7wVfmF3IrIq2JfgOxw2Yc8K1H42mFqaGpF2+FjgKMEItcZJ
         G3gg==
X-Gm-Message-State: APjAAAXuACj5/uF39RKsbfxaZxR1rs8t1n2cOvfSW3inDQtTE8OTfxql
        4ydMMyC6LvBKyK4h5TqPqkWPGSUr/H8i1w==
X-Google-Smtp-Source: APXvYqyT/Oy12Vrfup95uS+A2+H22l1gCblMGcudHidDhj+jBwJ5Z0pNrjHzY0dcJ2DhJ4sD/+IiHg==
X-Received: by 2002:a0c:818f:: with SMTP id 15mr3750243qvd.162.1565108941629;
        Tue, 06 Aug 2019 09:29:01 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s127sm38183308qkd.107.2019.08.06.09.29.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:29:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 12/15] btrfs: migrate the alloc_profile helpers
Date:   Tue,  6 Aug 2019 12:28:34 -0400
Message-Id: <20190806162837.15840-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These feel more at home in block-group.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 100 +++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |  16 ++++++
 fs/btrfs/ctree.h       |   4 --
 fs/btrfs/extent-tree.c | 115 -----------------------------------------
 4 files changed, 116 insertions(+), 119 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0221c8c6c7d4..330f96134ffb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -15,6 +15,106 @@
 #include "delalloc-space.h"
 #include "math.h"
 
+/*
+ * returns target flags in extended format or 0 if restripe for this
+ * chunk_type is not in progress
+ *
+ * should be called with balance_lock held
+ */
+u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
+{
+	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
+	u64 target = 0;
+
+	if (!bctl)
+		return 0;
+
+	if (flags & BTRFS_BLOCK_GROUP_DATA &&
+	    bctl->data.flags & BTRFS_BALANCE_ARGS_CONVERT) {
+		target = BTRFS_BLOCK_GROUP_DATA | bctl->data.target;
+	} else if (flags & BTRFS_BLOCK_GROUP_SYSTEM &&
+		   bctl->sys.flags & BTRFS_BALANCE_ARGS_CONVERT) {
+		target = BTRFS_BLOCK_GROUP_SYSTEM | bctl->sys.target;
+	} else if (flags & BTRFS_BLOCK_GROUP_METADATA &&
+		   bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) {
+		target = BTRFS_BLOCK_GROUP_METADATA | bctl->meta.target;
+	}
+
+	return target;
+}
+
+/*
+ * @flags: available profiles in extended format (see ctree.h)
+ *
+ * Returns reduced profile in chunk format.  If profile changing is in
+ * progress (either running or paused) picks the target profile (if it's
+ * already available), otherwise falls back to plain reducing.
+ */
+static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
+{
+	u64 num_devices = fs_info->fs_devices->rw_devices;
+	u64 target;
+	u64 raid_type;
+	u64 allowed = 0;
+
+	/*
+	 * see if restripe for this chunk_type is in progress, if so
+	 * try to reduce to the target profile
+	 */
+	spin_lock(&fs_info->balance_lock);
+	target = btrfs_get_restripe_target(fs_info, flags);
+	if (target) {
+		/* pick target profile only if it's already available */
+		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
+			spin_unlock(&fs_info->balance_lock);
+			return extended_to_chunk(target);
+		}
+	}
+	spin_unlock(&fs_info->balance_lock);
+
+	/* First, mask out the RAID levels which aren't possible */
+	for (raid_type = 0; raid_type < BTRFS_NR_RAID_TYPES; raid_type++) {
+		if (num_devices >= btrfs_raid_array[raid_type].devs_min)
+			allowed |= btrfs_raid_array[raid_type].bg_flag;
+	}
+	allowed &= flags;
+
+	if (allowed & BTRFS_BLOCK_GROUP_RAID6)
+		allowed = BTRFS_BLOCK_GROUP_RAID6;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
+		allowed = BTRFS_BLOCK_GROUP_RAID5;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
+		allowed = BTRFS_BLOCK_GROUP_RAID10;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
+		allowed = BTRFS_BLOCK_GROUP_RAID1;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
+		allowed = BTRFS_BLOCK_GROUP_RAID0;
+
+	flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
+
+	return extended_to_chunk(flags | allowed);
+}
+
+u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
+{
+	unsigned seq;
+	u64 flags;
+
+	do {
+		flags = orig_flags;
+		seq = read_seqbegin(&fs_info->profiles_lock);
+
+		if (flags & BTRFS_BLOCK_GROUP_DATA)
+			flags |= fs_info->avail_data_alloc_bits;
+		else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
+			flags |= fs_info->avail_system_alloc_bits;
+		else if (flags & BTRFS_BLOCK_GROUP_METADATA)
+			flags |= fs_info->avail_metadata_alloc_bits;
+	} while (read_seqretry(&fs_info->profiles_lock, seq));
+
+	return btrfs_reduce_alloc_profile(fs_info, flags);
+}
+
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
 {
 	atomic_inc(&cache->count);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 4b8ac8e9323c..ab5434ddd7f4 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -223,6 +223,22 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 		      enum btrfs_chunk_alloc_enum force);
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
 void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
+u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
+
+static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
+{
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_DATA);
+}
+
+static inline u64 btrfs_metadata_alloc_profile(struct btrfs_fs_info *fs_info)
+{
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+}
+
+static inline u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
+{
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
+}
 
 static inline int btrfs_block_group_cache_done(
 		struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index db56a1c81843..fab6e9792d23 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2467,7 +2467,6 @@ static inline u64 btrfs_calc_trunc_metadata_size(struct btrfs_fs_info *fs_info,
 int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
 			      u64 start, u64 num_bytes);
 void btrfs_free_excluded_extents(struct btrfs_block_group_cache *cache);
-u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			   unsigned long count);
 void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
@@ -2526,9 +2525,6 @@ int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
 void btrfs_get_block_group_trimming(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *cache);
-u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info);
-u64 btrfs_metadata_alloc_profile(struct btrfs_fs_info *fs_info);
-u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 
 enum btrfs_reserve_flush_enum {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a218f2187ebe..40e4f2ce4952 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2545,106 +2545,6 @@ int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
 	return readonly;
 }
 
-/*
- * returns target flags in extended format or 0 if restripe for this
- * chunk_type is not in progress
- *
- * should be called with balance_lock held
- */
-u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
-{
-	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
-	u64 target = 0;
-
-	if (!bctl)
-		return 0;
-
-	if (flags & BTRFS_BLOCK_GROUP_DATA &&
-	    bctl->data.flags & BTRFS_BALANCE_ARGS_CONVERT) {
-		target = BTRFS_BLOCK_GROUP_DATA | bctl->data.target;
-	} else if (flags & BTRFS_BLOCK_GROUP_SYSTEM &&
-		   bctl->sys.flags & BTRFS_BALANCE_ARGS_CONVERT) {
-		target = BTRFS_BLOCK_GROUP_SYSTEM | bctl->sys.target;
-	} else if (flags & BTRFS_BLOCK_GROUP_METADATA &&
-		   bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) {
-		target = BTRFS_BLOCK_GROUP_METADATA | bctl->meta.target;
-	}
-
-	return target;
-}
-
-/*
- * @flags: available profiles in extended format (see ctree.h)
- *
- * Returns reduced profile in chunk format.  If profile changing is in
- * progress (either running or paused) picks the target profile (if it's
- * already available), otherwise falls back to plain reducing.
- */
-static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
-{
-	u64 num_devices = fs_info->fs_devices->rw_devices;
-	u64 target;
-	u64 raid_type;
-	u64 allowed = 0;
-
-	/*
-	 * see if restripe for this chunk_type is in progress, if so
-	 * try to reduce to the target profile
-	 */
-	spin_lock(&fs_info->balance_lock);
-	target = btrfs_get_restripe_target(fs_info, flags);
-	if (target) {
-		/* pick target profile only if it's already available */
-		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
-			spin_unlock(&fs_info->balance_lock);
-			return extended_to_chunk(target);
-		}
-	}
-	spin_unlock(&fs_info->balance_lock);
-
-	/* First, mask out the RAID levels which aren't possible */
-	for (raid_type = 0; raid_type < BTRFS_NR_RAID_TYPES; raid_type++) {
-		if (num_devices >= btrfs_raid_array[raid_type].devs_min)
-			allowed |= btrfs_raid_array[raid_type].bg_flag;
-	}
-	allowed &= flags;
-
-	if (allowed & BTRFS_BLOCK_GROUP_RAID6)
-		allowed = BTRFS_BLOCK_GROUP_RAID6;
-	else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
-		allowed = BTRFS_BLOCK_GROUP_RAID5;
-	else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
-		allowed = BTRFS_BLOCK_GROUP_RAID10;
-	else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
-		allowed = BTRFS_BLOCK_GROUP_RAID1;
-	else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
-		allowed = BTRFS_BLOCK_GROUP_RAID0;
-
-	flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
-
-	return extended_to_chunk(flags | allowed);
-}
-
-u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
-{
-	unsigned seq;
-	u64 flags;
-
-	do {
-		flags = orig_flags;
-		seq = read_seqbegin(&fs_info->profiles_lock);
-
-		if (flags & BTRFS_BLOCK_GROUP_DATA)
-			flags |= fs_info->avail_data_alloc_bits;
-		else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
-			flags |= fs_info->avail_system_alloc_bits;
-		else if (flags & BTRFS_BLOCK_GROUP_METADATA)
-			flags |= fs_info->avail_metadata_alloc_bits;
-	} while (read_seqretry(&fs_info->profiles_lock, seq));
-
-	return btrfs_reduce_alloc_profile(fs_info, flags);
-}
-
 static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -2662,21 +2562,6 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 	return ret;
 }
 
-u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
-{
-	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_DATA);
-}
-
-u64 btrfs_metadata_alloc_profile(struct btrfs_fs_info *fs_info)
-{
-	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_METADATA);
-}
-
-u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
-{
-	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
-}
-
 static u64 first_logical_byte(struct btrfs_fs_info *fs_info, u64 search_start)
 {
 	struct btrfs_block_group_cache *cache;
-- 
2.21.0

