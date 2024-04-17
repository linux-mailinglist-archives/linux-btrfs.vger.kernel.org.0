Return-Path: <linux-btrfs+bounces-4349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6BA8A835C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FC51F22752
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ADF13D24E;
	Wed, 17 Apr 2024 12:47:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EEA132803
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358028; cv=none; b=tU/2E7Uao73RbLkKIp7L4Z9EeAJf4cDpHZAkz845ysFYiiSDOQyGOxuyPkOPanjaMEjanif4Wu/PMKpyLNHiSaFLI7XVX/YBDuTHZdRgO/5rAZyGvKpjHexj4ynZLoMIu3tG9ms+Po6DEgbVyRYxhAFmDzIX7XCNJGWoAWJA5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358028; c=relaxed/simple;
	bh=63Rf7sQyOUgbp8P7eu5GjFcwwc/u+n4kMU2joxr+bVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c23GjWdib3NBxWJuLZC9AoVyYW8Ztz/Oa6cZK9OeEUI9c6cPVk1Rv47+yooIcdbUejdyH6KnMmGtC3EeP/JafFO8pbFCZzR8qyvEc4Xqo0VWc4jk2ivkFrVcX1w1RWJVhH5c5C2pChkFSIlBKBCaQ2BjXjCKXnh/xywwQ/1vdo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-418ce99e7dfso1200825e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 05:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713358025; x=1713962825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+Xvr33uMUZQ09SjBY1aOLhwhBrTSzbbif/c3xO50x4=;
        b=b07omZgNhtq8tJhCcovVS8DKVDUIz36YTmZpswYv1N86pY52UuYLorfQ7UApzUw9Tt
         mydBqfkgVhENu1U8LD2SUDh8tUPEubyMSBn9loZmu6z6+WwbVTv0SEF/Bpd12HI5XHff
         mt9M5Dt5e4ST5WSfsucWJuMWOnbN+pXQ52yZQIGDTty8jQvNcoC7i8MByT2AZzmCi9ul
         e8qe8uGk4b0NQ0PfY6i856piESHrdGJJa0iwgb1KySz4uGB01CfmNiy2stLuxkvGlpFh
         trXGvfMqAzaMz3/cVSNbSpAZZLoMBMD0ENbCZ52EA1+HSPrT3jWEUZv2QNTlcUce9+Zl
         RNmg==
X-Gm-Message-State: AOJu0YzsYJupaLytyuHUTq9WKpIH7n060dEqHsROwwKB0bOVfUkswKOa
	IDhVc1pfT6FdT1XBNgjuKDVeZf8G8xYAv5PIa0jx98Qm+sf+P9H3w2RBoA==
X-Google-Smtp-Source: AGHT+IFdqJ9u/us/a7/+oyVqqxwCGDBWQcRMTFcyA2+u8dqW4ZWEp1YhxdfiuMLp7rjjTASiiQk0Gg==
X-Received: by 2002:a05:600c:1907:b0:418:2636:3152 with SMTP id j7-20020a05600c190700b0041826363152mr10780632wmq.6.1713358024966;
        Wed, 17 Apr 2024 05:47:04 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id k29-20020a05600c1c9d00b00418948a5eb0sm2714688wms.32.2024.04.17.05.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:47:04 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Boris Burkov <boris@bur.io>,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: reserve relocation zone on mount
Date: Wed, 17 Apr 2024 14:46:48 +0200
Message-Id: <1480374e3f65371d4b857fb45a3fd9f6a5fa4a25.1713357984.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reserve one zone as a data relocation target on each mount. If we already
find one empty block group, there's no need to force a chunk allocation,
but we can use this empty data block group as our relocation target.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c |  2 ++
 fs/btrfs/zoned.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  3 +++
 3 files changed, 65 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c2dc88f909b0..680ea8924333 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3559,6 +3559,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 	btrfs_discard_resume(fs_info);
 
+	btrfs_reserve_relocation_zone(fs_info);
+
 	if (fs_info->uuid_root &&
 	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
 	     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d51faf7f4162..1d44c268da96 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2634,3 +2635,62 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 }
+
+static u64 find_empty_block_group(struct btrfs_space_info *sinfo, u64 flags)
+{
+	struct btrfs_block_group *bg;
+
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
+			if (bg->flags != flags)
+				continue;
+			if (bg->used == 0)
+				return bg->start;
+		}
+	}
+
+	return 0;
+}
+
+void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_space_info *sinfo = fs_info->data_sinfo;
+	struct btrfs_trans_handle *trans;
+	u64 flags = btrfs_get_alloc_profile(fs_info, sinfo->flags);
+	u64 bytenr = 0;
+
+	lockdep_assert_not_held(&fs_info->relocation_bg_lock);
+
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	bytenr = find_empty_block_group(sinfo, flags);
+	if (!bytenr) {
+		int ret;
+
+		trans = btrfs_join_transaction(tree_root);
+		if (IS_ERR(trans))
+			return;
+
+		ret = btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);
+		btrfs_end_transaction(trans);
+
+		if (!ret) {
+			struct btrfs_block_group *bg;
+
+			bytenr = find_empty_block_group(sinfo, flags);
+			if (!bytenr)
+				goto out;
+			bg = btrfs_lookup_block_group(fs_info, bytenr);
+			ASSERT(bg);
+
+			if (!btrfs_zone_activate(bg))
+				bytenr = 0;
+			btrfs_put_block_group(bg);
+		}
+	}
+
+out:
+	fs_info->data_reloc_bg = bytenr;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 77c4321e331f..048ffada4549 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -97,6 +97,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
 int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info, bool do_finish);
 void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
+void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -271,6 +272,8 @@ static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 
 static inline void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info) { }
 
+static inline void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.35.3


