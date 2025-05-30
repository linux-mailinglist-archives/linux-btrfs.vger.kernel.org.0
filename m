Return-Path: <linux-btrfs+bounces-14310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AD5AC8CEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6967A4F7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6A4225A50;
	Fri, 30 May 2025 11:29:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A96FB9
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604569; cv=none; b=Uu79s6FyufIb+T8gv8i5lbdyrCzjVEA6ZaceBCSFP211JFouU2Y9/b0IxBNcxepr8kVYcWtZceGiwvQxrBp7g0GWlGa5YYZ+DHjVSfLFv2RF+sfI55QQJNvwXG8aDseOAbyWJB6mFBvSReEW4mWHK1hNrSsusbspwEnXX8wf7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604569; c=relaxed/simple;
	bh=ojM+pytbCWmU4lHwN0QKXS/TqaIaggZNUEIZrMJO69o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGakMDWrOwO03RF6OLkg5zYFWwgdO1mBJswDJbOD9VaaJhPafYavRYzgkgfj82/fdHKUwikYsNlq+l6aEOPoqopb6ihoT06HD6Reml0Ym7FTziNUnOKVgn/4S6gtAGx5T5fxqCFBOMXS8HeRzpdn7hDGFAaOv2CHISwei32zpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a375888197so967406f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 04:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748604565; x=1749209365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TR1FuBtmFL81LLolab72cWmLY122pUoW90ji6Vxs7x0=;
        b=iRzFSZOMf454c2sCCAnDwC7MyBZZx+DjJwWrvDjq+zOnQ/741Av43lLYQ1zxAGLkL+
         l93JySUknkmuUkOuyxhidVHWKq3ScVsWAeIlMNudcy2/DGLfQnclrmSJLC1VKv4mylwC
         dyyTtZWPhxyeH7aHXYMsXtJo/HhZpM1hkvbvlv+GmnA8veMBQZ+gK7kTg5Nm9rGOLPhZ
         mWTGT5s0D7fOsyIEeYucXcfbqJU5rOIbhLpHCQYtQdBEBpopUxQha8RXVVwjegnSdiHB
         YPIBgAfIGdHTIHcXlHpwiwQzwyf3XjAcWBpcpaI1Wkbivdmj8c1hugIKnlTuxC0s3DO6
         0dZQ==
X-Gm-Message-State: AOJu0Yz0f9WHuhCB8bfkyhxYPdhxH8xLE+C1G7u/NqnhKPV0M2j5iCOu
	VnbO0n3jFbICc4RpW6sH/ou4OGy7Y1jILP64lsZKxWn/Qycvv0u8CMpMUwZLY+qMq7M=
X-Gm-Gg: ASbGncscq5LoGRxceovurzfvxDWUbCfPU4k2bFc71fnEyt7GnoY0nIXvcIqUuD7jxOi
	wukWRhfObWOXLEo6jjqbWLNPpxMbVwEzZcjIh2L6ZJoJJoz7cwFuUjrgGXijLqmv8vj0lKt848v
	FaVN0LCp0NinQZCRfF0joW4d2Rx+OwlGOZqzED3/Vl4bd4THeFUVW2n52iQnBl9usqLuNN+yl0M
	9zkUVT/j0LqcqLTVHZj8qe8YVc2xmXEVq/NrfeYziodVFhgr6uTqdZ1ydDdwlIRociOAldZOpS+
	WXI97dboIMm5hI8Mke4C3+1uhsMif5qZMXaDQ9d6Tw6wb/uZzPTYinx56lp2RrBK101b3epF7tg
	ADqmObDepGNC1EZsUULGj7iUQQY19GT0jYw==
X-Google-Smtp-Source: AGHT+IHkeEUlBCKqlwUEVHrBJC4JLcSIbi0n2meaFRkaRCAiQA9Zqhi71c3KhnydPTHBnKQeMtpPUg==
X-Received: by 2002:a05:6000:1a8b:b0:3a4:e672:df0e with SMTP id ffacd0b85a97d-3a4f7aa6711mr2081124f8f.40.1748604565339;
        Fri, 30 May 2025 04:29:25 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7057400fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f705:7400:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009745esm4595113f8f.71.2025.05.30.04.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 04:29:24 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: reserve data_reloc block group on mount
Date: Fri, 30 May 2025 13:29:16 +0200
Message-ID: <1c24dcb591bbd2c70b7dcf2a2a8219eea1e06b55.1748604543.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Create a blog group dedicated for data relocation on mount of a zoned
filesystem.

If there is already more than one empty DATA block group on mount, this
one is picked for the data relocation block group, instead of a newly
created one.

This is done to ensure, there is always space for performing garbage
collection and the filesystem is not hitting ENOSPC under heavy overwrite
workloads.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/zoned.c   | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  3 ++
 3 files changed, 88 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3def93016963..b211dc8cdb86 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3562,6 +3562,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
+	btrfs_zoned_reserve_data_reloc_bg(fs_info);
 	btrfs_free_zone_cache(fs_info);
 
 	btrfs_check_active_zone_reservation(fs_info);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 19710634d63f..446f6cee10c2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2443,6 +2444,89 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->relocation_bg_lock);
 }
 
+void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
+	struct btrfs_space_info *space_info;
+	struct btrfs_root *root;
+	struct btrfs_trans_handle *trans = NULL;
+	struct btrfs_block_group *bg;
+	u64 alloc_flags;
+	bool initial = false;
+	int index;
+	int ret;
+
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	if (fs_info->data_reloc_bg)
+		return;
+
+	if (sb_rdonly(fs_info->sb))
+		return;
+
+	space_info = data_sinfo->sub_group[0];
+	ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC);
+	alloc_flags = btrfs_get_alloc_profile(fs_info, space_info->flags);
+	index = btrfs_bg_flags_to_raid_index(alloc_flags);
+
+	list_for_each_entry(bg, &data_sinfo->block_groups[index], list) {
+		btrfs_get_block_group(bg);
+		if (!bg->used) {
+			if (!initial) {
+				initial = true;
+				btrfs_put_block_group(bg);
+				continue;
+			}
+
+			fs_info->data_reloc_bg = bg->start;
+			set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+				&bg->runtime_flags);
+			btrfs_zone_activate(bg);
+
+			btrfs_put_block_group(bg);
+			return;
+		}
+		btrfs_put_block_group(bg);
+	}
+
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
+		root = fs_info->block_group_root;
+	else
+		root = btrfs_extent_root(fs_info, 0);
+
+	trans = btrfs_join_transaction(root);
+	if (IS_ERR(trans))
+		return;
+
+	mutex_lock(&fs_info->chunk_mutex);
+	bg = btrfs_create_chunk(trans, space_info, alloc_flags);
+	if (IS_ERR(bg)) {
+		mutex_unlock(&fs_info->chunk_mutex);
+		ret = PTR_ERR(bg);
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return;
+	}
+
+	ret = btrfs_chunk_alloc_add_chunk_item(trans, bg);
+	if (ret) {
+		mutex_unlock(&fs_info->chunk_mutex);
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return;
+	}
+	mutex_unlock(&fs_info->chunk_mutex);
+
+	btrfs_get_block_group(bg);
+	fs_info->data_reloc_bg = bg->start;
+	set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &bg->runtime_flags);
+	btrfs_zone_activate(bg);
+	btrfs_put_block_group(bg);
+
+	btrfs_end_transaction(trans);
+}
+
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 9672bf4c3335..a91e713809cc 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -88,6 +88,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 				   struct extent_buffer *eb);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
+void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
 bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
@@ -241,6 +242,8 @@ static inline void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 
 static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg) { }
 
+static inline void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_block_group *bg) { }
+
 static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
 
 static inline bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info)
-- 
2.43.0


