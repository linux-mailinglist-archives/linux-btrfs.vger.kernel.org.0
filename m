Return-Path: <linux-btrfs+bounces-15024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6420AEB2BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5339A1893907
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3629346F;
	Fri, 27 Jun 2025 09:19:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970C25FA0E
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015970; cv=none; b=loRE1pl3bF8V70RzQlTqs4WG8P0hXyANWt6akRDOElJ5cVusiUZ46zq66+OyMxx1ktjvi8uugf/OlZp+87tkAupOJHNd5stzwb2tgh2YObJzHNrzLN7IAvAWwaWapfgFMv1m4GRtdqYIM5enMgB+yxz1B94XKkggHl1mba36VGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015970; c=relaxed/simple;
	bh=6EpuEO3WznpugsbIbSWveMSgNXNEVmbNqJWq1pWUTvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZIyE328lwNS1Jy3X01EizNdqT+R0cQb3v+uEnvWck775oxrsYMAi2LtIo1JIlcYTBACPmVOLZcFVAjtbixvcxxUj2XKGRBRl0/IYgsZoVfpPXwNYMIu0lEaBbVyknAvMFcXT9/E+rPt8RGk2XvC153h32q/LvhL8x8+c1wS1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1065360f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015967; x=1751620767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQEIzveT9GzEahHyaqqAw/5fZBHq9CtPM8NYySg0F1Y=;
        b=OAo/9++DOp0wsjPor/KrdhDYVrwBXYjqRF/znxwurJ4SV9JYR1SLZ42nAg2aCZuFNO
         9eQObxgbZeRHpPgbvr/mrQnZK+fm624nDW3ArI/bwkIwOB1gvf7a0FHGIe/EFgcDSNKw
         G3DM6U55MAmHqGueb+V8O6ukK2CIKA0nSpcrTA/jrJ1YnKV1GkHgPWqxrMGD/yZs7+9X
         VBpq6iXTW8PlanZj5z6BaCakfuSQnox/kSMQN/Fktar1XUZS5Uzw/flBfG4InakIXQ15
         iuCd2r8RvxOGgQN3DJDIzwuViz0VnSFhDB7aF6YADbCdybKXtVq60P3u2GLsqqSct7TV
         sVYg==
X-Gm-Message-State: AOJu0YxdfwvbgwO3GSBdZXhaJ1GPBvLO9A38AfZ57RBhfSa2Nk2RTPN1
	JjlDK8vyC+LTFWmezZ3Ul3SKp3PZWNSaueeYp2quuWMiJZyBzuujOEj+Xy9UVw==
X-Gm-Gg: ASbGnctRjbfbeWq/E+4MwoAEduZ7evT77QEjXLrwg4cGV5hf1QXwmEb3m+TeSdAf0Pv
	CCuhxG6fXSrs/0N0dyb90ovdQ1GV4hgyezx+Rky+QFVDa8VIH6+xa7N25m1F/opXSQo9iavAeeI
	TcBV9zDet+MhfyhFdt/txlrfmoYgsKm7a5yMVeblOvEDJlEKQSkUCjFpmxfjVpzpho1mwLHfrHR
	8yPkWQBvMfrEp6i0kFLWGg8c2z2u05BOO8KFMhzqe9y37NLphbvXmpXwExBvHQE7HcWq6UOn9gl
	ah+6MvMdx6tg6VO36op/3BE5G/Z/+YfdbHKzwAB3Vd+5bXBv9Z/7ZjcWmRGUk2YC6Z5+Rdf/yLw
	DHWWHTHOO4JmXQCOLLTVcsVkTAvF7REV2990Jzm4128Keph5T
X-Google-Smtp-Source: AGHT+IEuE7zhVrHuhR2GYfzF2DX6bwW+TQPQe77PAIJuFkF+N8FkZBU+D7nSSz2i9g+38wshRB4H3Q==
X-Received: by 2002:a05:6000:1a8f:b0:3a4:ead4:5ea4 with SMTP id ffacd0b85a97d-3a8f53ab011mr2471225f8f.24.1751015966444;
        Fri, 27 Jun 2025 02:19:26 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f719b2005a9e6e27159b0eb3.dip0.t-ipconnect.de. [2003:f6:f719:b200:5a9e:6e27:159b:eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm2152556f8f.72.2025.06.27.02.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:19:26 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 3/9] btrfs: zoned: get rid of treelog_bg_lock
Date: Fri, 27 Jun 2025 11:19:08 +0200
Message-ID: <20250627091914.100715-4-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627091914.100715-1-jth@kernel.org>
References: <20250627091914.100715-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Lockstat analysis of benchmark workloads shows a very high contention of
the treelog_bg_lock. But the treelog_bg_lock only protects a single
field in 'struct btrfs_fs_info', namely 'u64 treelog_bg'.

Use READ_ONCE()/WRITE_ONCE() to access 'btrfs_fs_info::treelog_bg'.

This is safe in the allocator path, as treelog I/O is only going to block
groups in the treelog sub-space_info and at the moment, there is only one
treelog block group in this space info.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c     |  1 -
 fs/btrfs/extent-tree.c | 45 +++++++++++-------------------------------
 fs/btrfs/fs.h          |  1 -
 fs/btrfs/zoned.c       |  2 +-
 fs/btrfs/zoned.h       |  7 +++----
 5 files changed, 15 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9a13f5b1ed43..35cd38de7727 100644
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
index a9bda68a1883..46358a555f78 100644
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
@@ -3844,7 +3828,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	u64 log_bytenr;
 	u64 data_reloc_bytenr;
 	int ret = 0;
-	bool skip = false;
 
 	ASSERT(btrfs_is_zoned(block_group->fs_info));
 
@@ -3852,13 +3835,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 * Do not allow non-tree-log blocks in the dedicated tree-log block
 	 * group, and vice versa.
 	 */
-	spin_lock(&fs_info->treelog_bg_lock);
-	log_bytenr = fs_info->treelog_bg;
+	log_bytenr = READ_ONCE(fs_info->treelog_bg);
 	if (log_bytenr && ((ffe_ctl->for_treelog && bytenr != log_bytenr) ||
 			   (!ffe_ctl->for_treelog && bytenr == log_bytenr)))
-		skip = true;
-	spin_unlock(&fs_info->treelog_bg_lock);
-	if (skip)
 		return 1;
 
 	/*
@@ -3894,14 +3873,13 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
-	spin_lock(&fs_info->treelog_bg_lock);
 
 	if (ret)
 		goto out;
 
 	ASSERT(!ffe_ctl->for_treelog ||
-	       block_group->start == fs_info->treelog_bg ||
-	       fs_info->treelog_bg == 0);
+	       block_group->start == log_bytenr ||
+	       log_bytenr == 0);
 	ASSERT(!ffe_ctl->for_data_reloc ||
 	       block_group->start == data_reloc_bytenr ||
 	       data_reloc_bytenr == 0);
@@ -3917,7 +3895,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 * Do not allow currently using block group to be tree-log dedicated
 	 * block group.
 	 */
-	if (ffe_ctl->for_treelog && !fs_info->treelog_bg &&
+	if (ffe_ctl->for_treelog && log_bytenr == 0 &&
 	    (block_group->used || block_group->reserved)) {
 		ret = 1;
 		goto out;
@@ -3948,8 +3926,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
-	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
-		fs_info->treelog_bg = block_group->start;
+	if (ffe_ctl->for_treelog && READ_ONCE(fs_info->treelog_bg) == 0)
+		WRITE_ONCE(fs_info->treelog_bg, block_group->start);
 
 	if (ffe_ctl->for_data_reloc) {
 		if (READ_ONCE(fs_info->data_reloc_bg) == 0)
@@ -3987,10 +3965,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 
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
@@ -4293,10 +4270,10 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
 				    struct find_free_extent_ctl *ffe_ctl)
 {
 	if (ffe_ctl->for_treelog) {
-		spin_lock(&fs_info->treelog_bg_lock);
-		if (fs_info->treelog_bg)
-			ffe_ctl->hint_byte = fs_info->treelog_bg;
-		spin_unlock(&fs_info->treelog_bg_lock);
+		u64 treelog_bg = READ_ONCE(fs_info->treelog_bg);
+
+		if (treelog_bg)
+			ffe_ctl->hint_byte = treelog_bg;
 	} else if (ffe_ctl->for_data_reloc) {
 		u64 data_reloc_bg = READ_ONCE(fs_info->data_reloc_bg);
 
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
index 388c277a84d3..c89f846af6dd 100644
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
index 6e11533b8e14..c1b3a5c3a799 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -383,14 +383,13 @@ static inline void btrfs_zoned_meta_io_unlock(struct btrfs_fs_info *fs_info)
 static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
+	u64 treelog_bg = READ_ONCE(fs_info->treelog_bg);
 
 	if (!btrfs_is_zoned(fs_info))
 		return;
 
-	spin_lock(&fs_info->treelog_bg_lock);
-	if (fs_info->treelog_bg == bg->start)
-		fs_info->treelog_bg = 0;
-	spin_unlock(&fs_info->treelog_bg_lock);
+	if (treelog_bg == bg->start)
+		WRITE_ONCE(fs_info->treelog_bg, 0);
 }
 
 static inline void btrfs_zoned_data_reloc_lock(struct btrfs_inode *inode)
-- 
2.49.0


