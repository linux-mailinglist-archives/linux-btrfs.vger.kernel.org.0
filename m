Return-Path: <linux-btrfs+bounces-14878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831C8AE4B7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 18:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C64177DFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4329C353;
	Mon, 23 Jun 2025 16:56:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49DA28A1E0
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697805; cv=none; b=lD5ut9iTTkmYSBeYJzrkY7zpumNUeCYgodTVDY5WOfWsmUCvHh2zRRfCWJJLtNL35OdJ+6GAnaLAUsUQCAgL8xggF5pp4bpq3KE0sKyh6C3e+xi8uQNUWhZVwKGjqA5bb4Ofhu0+5k5kWab5gclBRN5kJb/ZSB73irFh6xPub2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697805; c=relaxed/simple;
	bh=iR2WQICM+K5o5sDyPMxB9UlhiJ/B2r+vn8WNIBUDQoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNiSk46fM/FgjNaFKPwmFv8j5K9GsGjMP4PVIgxHfgpekF15RpXwEUcv2QhKQUmp5Y5vfdrKIU5f3FALIHm2VzH/hnFUyNOLXighTxdGHUXIECY5JPfYkQAy7Jkw8juOmeBR17dJ/Babsovcj3UWjwIeWX0AdIbng0uUd3LiFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cfb79177so22654685e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 09:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750697802; x=1751302602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7/SBQK+5z41yWYKOYbK/5096kE4S/8bRmTQxALlogI=;
        b=ScUnTzkdbYVly3RStOiojrizEOJcsfZFL0Krr17AFGOZ6wWeccjME2vvA02WDbeIG5
         uHKINM2TsVmbdNqYfDcBH31EYWRpGLXjNv3wtrApIsECuOZkee03Tk8EiMBaKFH1TPv1
         H+AYrEMRsVe+mASeTnCc4T3UkZDU3lE7qYbh2rtPNFNK7na60UhUVMt4rcJ7H6rJWwr+
         tu1WWrbI/bYLJXjrb3g7Rn3lFaUXEEgvbE67lK+JVTZjb2djvsLaDz9WxeCRISP56yQp
         ch/vDnFl18mATYt/tb0TaJfQAeyVTdRlvD1WYhIlAQgs0t85xp4BlxyxuJ4HnTGIDwrc
         wmkA==
X-Gm-Message-State: AOJu0Yx5t5UJ09GFKoSRlfrrAhLwfvusNPafOdqTXc3qESW4FlsrnH3t
	zIiWbEI/4zbCfVQEoJxlmdzjt9z0J1EUfHx8ndE0OcaG9HfXM1ZlOO8Ml/bknfQI
X-Gm-Gg: ASbGncsaaflGD/qJ0LKg1NlwkuPYvfoZtCPLTHTD+tFzoj4JXzc9mFMvYf9/qWdLc4h
	xStPvp5/lyL3un9FaUdyvSh8u7lGYhkHQp14028+7A8EHdIw7g2JoBGcB+glJPnpui5dQ3tPFmP
	QBaYT1I0oIipSk60cVAiQY/6ZCzduUwftMSGjKuzSdGqkcTZ05X/g0/6ymytETca8czpv7XXTLE
	WifFMQeCsEJCKyeGppD6vtnVcEdgdEMT8fV7tV9XA24871or8YmrgUMS9BtzV/sgkBG+OpC7V0Z
	RHDOW9UrZoA8jny43HglRQUYsq7PSr3RZy5DfptXmVhddbNAIAr5RNFF1OWmSlRaJP7pliynB7K
	g4kCzeIoRoaiM2jWBIlZTW/jkJbHxL+wEIrttMTjhdZtJQ6W8JA==
X-Google-Smtp-Source: AGHT+IH8FOv92aVDYIc69UDGkW+4Dl2EIJS8zKMBvCQxvzzqUkhsRyFBrXDvRcow/R+zIYIGgyQU4w==
X-Received: by 2002:a05:6000:2008:b0:3a5:8cf0:fc0f with SMTP id ffacd0b85a97d-3a6d12a0ef6mr9639898f8f.19.1750697801817;
        Mon, 23 Jun 2025 09:56:41 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d118a1f2sm9713888f8f.83.2025.06.23.09.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:56:41 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/3] btrfs: zoned: get rid of treelog_bg_lock
Date: Mon, 23 Jun 2025 18:56:28 +0200
Message-ID: <20250623165629.316213-3-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623165629.316213-1-jth@kernel.org>
References: <20250623165629.316213-1-jth@kernel.org>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c     |  1 -
 fs/btrfs/extent-tree.c | 45 +++++++++++-------------------------------
 fs/btrfs/fs.h          |  1 -
 fs/btrfs/zoned.c       |  2 +-
 fs/btrfs/zoned.h       |  7 +++----
 5 files changed, 15 insertions(+), 41 deletions(-)

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
index f58bd85ddf5a..d58bffb84b05 100644
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


