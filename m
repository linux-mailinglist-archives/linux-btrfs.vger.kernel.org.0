Return-Path: <linux-btrfs+bounces-14905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1065CAE60FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 11:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0B5192004C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 09:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C427E1A1;
	Tue, 24 Jun 2025 09:37:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E727BF89
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757845; cv=none; b=RNOLdpYUUYw/Q9vJPypEIqZgU4vQ4+y8m7mGp0pvNuLCqR+jfutnFFcnt6//vlXpJ7f3UOMBQEO1Rx9/ZFdSF14aFfWIAMh6pqeapORvmb1FrK+FNnECWjVBRuhnC2H2CGc9r/o6JcYlSXC15OrBd7xtebaKPA14bF2xtiwy14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757845; c=relaxed/simple;
	bh=jZ9XVf9uiwhcwwPIgks+a1xZWE7xvtnRK2x8Sv4sAno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRYaKqmRToKIofnJiA7p6ab9GEh/V1xuv3sDsPLOEKMgrqk9SRb0dDRwNVJ6wujlP6fDQeAmVs7aUET7F6X3LopzUM8my2S81N3GvnECO62iEWeEtUT+MMJ55DH2a6wf7P7IF1hnfh3gFnudtB7AWEnA5RdCaTMQqL74/m2/nNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so1506325e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 02:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750757842; x=1751362642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kj1/0wSEFl5KHImxbkz9ZQDIg/G5qq7akwTBKoBYw0M=;
        b=nz8OGsOQso2T/7PFceK61TJWcUvfHeY03QE7QBEhdvb1BozbuERmhXjubR1zXO1IJQ
         Y9Mo2fhXQrpeffnWtlsDiofmAcRxFptqWwlSj+PzjMZRn3xmCXhfmCdEfS2/L0hGy8uX
         /vxoxMFphirnq9bROtpL1vnK2G5MLQsRwPKJ1ze5O1CXXR/7qSS0HVJwjdIx2wrUwSd/
         2THhmKQLvWNaCQwckgDGV10i/MexTKeo4SvAqyyDvLgt0IKVljJam9LQAGQwsx7uEayJ
         7m63x3I/3OQgzlSWDSmcw1ASJj8/uBgKN1WMjq7FW2m6Oaxs+XRb7JHy4lbzh0WVBjlZ
         0kBQ==
X-Gm-Message-State: AOJu0YxaGwrJB899AOTjqo6yKjtRVJXGIcuON5t/rn50gCwOZ+mq/7KU
	FvkBN2sLvoBk69DFXq/Sc7CVi7Iugwg0O+Bho7n5bm03vKB+WOsmcUdIa3zydg4L
X-Gm-Gg: ASbGncswgHsMjrioGS5uYetV68iB9ngdzXbQj+qSUNZfu4yGXgEfa7+aRhZdMR83RgG
	Aiqh9KR81gyRQKcbDEsjbFrb7fdlGPtoagnpLHy4z751aH9+wqw8lU5lEd8XFrm8VHPXfEvVQYI
	GQxIgeirMET7f/OYdx3ZtjZyyNQW2P81n49C3pM2AOXaA4EzYaf3146upq1iWphX780oqcUqX/k
	RkUHV4bjOWryHMqCkTpAzGXlrKM3qVqvsnozYQtkMdJkTuz35mRjSnNqicu240oot/3/A3ZdSxI
	Psj5w2BQbCrR3vsiQXQvD/FGppMqzO3wvia5CtgQ3i93f129+2tHpqh8Ja8TdR59XC10E+q8vzf
	ekDxQmjUUmuP1rpkB8Y3mPQv0StKjpd2yr3MSV6/MmTmrqzch5A==
X-Google-Smtp-Source: AGHT+IFACOv/fVPVkKG8gU28RwgvG+37/YtqWApT+JJDVqQfFs5H4YRO/PPnF90BsvpH5cBfqMUEgg==
X-Received: by 2002:a05:600c:820e:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-4536478ecd2mr160658065e9.0.1750757841732;
        Tue, 24 Jun 2025 02:37:21 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453769da7f6sm54880745e9.40.2025.06.24.02.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 02:37:21 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/3] btrfs: zoned: get rid of treelog_bg_lock
Date: Tue, 24 Jun 2025 11:37:09 +0200
Message-ID: <20250624093710.18685-3-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624093710.18685-1-jth@kernel.org>
References: <20250624093710.18685-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Lockstat analysis of benchmark workloads shows a very high contention on
treelog_bg_lock. But the lock only protects a single field in
'struct btrfs_fs_info', namely 'u64 treelog_bg'.

Use READ_ONCE()/WRITE_ONCE() to access 'btrfs_fs_info::treelog_bg'.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c     |  1 -
 fs/btrfs/extent-tree.c | 49 ++++++++++--------------------------------
 fs/btrfs/fs.h          |  1 -
 fs/btrfs/zoned.c       |  2 +-
 fs/btrfs/zoned.h       |  6 ++----
 5 files changed, 14 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 24896322376d..a54218717cb4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2789,7 +2789,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->defrag_inodes_lock);
 	spin_lock_init(&fs_info->super_lock);
 	spin_lock_init(&fs_info->unused_bgs_lock);
-	spin_lock_init(&fs_info->treelog_bg_lock);
 	spin_lock_init(&fs_info->zone_active_bgs_lock);
 	rwlock_init(&fs_info->tree_mod_log_lock);
 	rwlock_init(&fs_info->global_root_lock);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 80ceca89a9ef..39d3984153a2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3809,22 +3809,6 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	return find_free_extent_unclustered(block_group, ffe_ctl);
 }
 
-/*
- * Tree-log block group locking
- * ============================
- *
- * fs_info::treelog_bg_lock protects the fs_info::treelog_bg which
- * indicates the starting address of a block group, which is reserved only
- * for tree-log metadata.
- *
- * Lock nesting
- * ============
- *
- * space_info::lock
- *   block_group::lock
- *     fs_info::treelog_bg_lock
- */
-
 /*
  * Simple allocator for sequential-only block group. It only allows sequential
  * allocation. No need to play with trees. This function also reserves the
@@ -3841,9 +3825,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	u64 num_bytes = ffe_ctl->num_bytes;
 	u64 avail;
 	u64 bytenr = block_group->start;
-	u64 log_bytenr;
 	int ret = 0;
-	bool skip = false;
 
 	ASSERT(btrfs_is_zoned(block_group->fs_info));
 
@@ -3851,13 +3833,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 * Do not allow non-tree-log blocks in the dedicated tree-log block
 	 * group, and vice versa.
 	 */
-	spin_lock(&fs_info->treelog_bg_lock);
-	log_bytenr = fs_info->treelog_bg;
-	if (log_bytenr && ((ffe_ctl->for_treelog && bytenr != log_bytenr) ||
-			   (!ffe_ctl->for_treelog && bytenr == log_bytenr)))
-		skip = true;
-	spin_unlock(&fs_info->treelog_bg_lock);
-	if (skip)
+	if (READ_ONCE(fs_info->treelog_bg) &&
+	    ((ffe_ctl->for_treelog && bytenr != READ_ONCE(fs_info->treelog_bg)) ||
+	     (!ffe_ctl->for_treelog && bytenr == READ_ONCE(fs_info->treelog_bg))))
 		return 1;
 
 	/*
@@ -3892,14 +3870,13 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
-	spin_lock(&fs_info->treelog_bg_lock);
 
 	if (ret)
 		goto out;
 
 	ASSERT(!ffe_ctl->for_treelog ||
-	       block_group->start == fs_info->treelog_bg ||
-	       fs_info->treelog_bg == 0);
+	       block_group->start == READ_ONCE(fs_info->treelog_bg) ||
+	       READ_ONCE(fs_info->treelog_bg) == 0);
 	ASSERT(!ffe_ctl->for_data_reloc ||
 	       block_group->start == READ_ONCE(fs_info->data_reloc_bg) ||
 	       READ_ONCE(fs_info->data_reloc_bg) == 0);
@@ -3915,7 +3892,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 * Do not allow currently using block group to be tree-log dedicated
 	 * block group.
 	 */
-	if (ffe_ctl->for_treelog && !fs_info->treelog_bg &&
+	if (ffe_ctl->for_treelog && READ_ONCE(fs_info->treelog_bg) == 0 &&
 	    (block_group->used || block_group->reserved)) {
 		ret = 1;
 		goto out;
@@ -3946,8 +3923,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
-	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
-		fs_info->treelog_bg = block_group->start;
+	if (ffe_ctl->for_treelog && READ_ONCE(fs_info->treelog_bg) == 0)
+		WRITE_ONCE(fs_info->treelog_bg, block_group->start);
 
 	if (ffe_ctl->for_data_reloc) {
 		if (READ_ONCE(fs_info->data_reloc_bg) == 0)
@@ -3985,10 +3962,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 
 out:
 	if (ret && ffe_ctl->for_treelog)
-		fs_info->treelog_bg = 0;
+		WRITE_ONCE(fs_info->treelog_bg, 0);
 	if (ret && ffe_ctl->for_data_reloc)
 		WRITE_ONCE(fs_info->data_reloc_bg, 0);
-	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
@@ -4290,11 +4266,8 @@ static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
 static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
 				    struct find_free_extent_ctl *ffe_ctl)
 {
-	if (ffe_ctl->for_treelog) {
-		spin_lock(&fs_info->treelog_bg_lock);
-		if (fs_info->treelog_bg)
-			ffe_ctl->hint_byte = fs_info->treelog_bg;
-		spin_unlock(&fs_info->treelog_bg_lock);
+	if (ffe_ctl->for_treelog && READ_ONCE(fs_info->treelog_bg)) {
+			ffe_ctl->hint_byte = READ_ONCE(fs_info->treelog_bg);
 	} else if (ffe_ctl->for_data_reloc &&
 		   READ_ONCE(fs_info->data_reloc_bg)) {
 			ffe_ctl->hint_byte = READ_ONCE(fs_info->data_reloc_bg);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 570f4b85096c..a388af40a251 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -846,7 +846,6 @@ struct btrfs_fs_info {
 	u64 max_zone_append_size;
 
 	struct mutex zoned_meta_io_lock;
-	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
 
 	/* Start of the dedicated data relocation block group */
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 421afdb6eb39..98f483def77d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1948,7 +1948,7 @@ static bool check_bg_is_active(struct btrfs_eb_write_context *ctx,
 	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
 		return true;
 
-	if (fs_info->treelog_bg == block_group->start) {
+	if (READ_ONCE(fs_info->treelog_bg) == block_group->start) {
 		if (!btrfs_zone_activate(block_group)) {
 			int ret_fin = btrfs_zone_finish_one_bg(fs_info);
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 6e11533b8e14..f71026b6c100 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -387,10 +387,8 @@ static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
 	if (!btrfs_is_zoned(fs_info))
 		return;
 
-	spin_lock(&fs_info->treelog_bg_lock);
-	if (fs_info->treelog_bg == bg->start)
-		fs_info->treelog_bg = 0;
-	spin_unlock(&fs_info->treelog_bg_lock);
+	if (READ_ONCE(fs_info->treelog_bg) == bg->start)
+		WRITE_ONCE(fs_info->treelog_bg, 0);
 }
 
 static inline void btrfs_zoned_data_reloc_lock(struct btrfs_inode *inode)
-- 
2.49.0


