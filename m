Return-Path: <linux-btrfs+bounces-4992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0BF8C5CAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 23:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902B2282D21
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 21:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657AD181D0D;
	Tue, 14 May 2024 21:13:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1D2A1D4;
	Tue, 14 May 2024 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721208; cv=none; b=abT9vLjEQR+2M7pXb4Io0/6GlvNh15QuueDgxfxtilW3/Rc0D5O3YxmHTNg+XfDbpN94reUBTBJvqegTbDZZckLttuA24QHBsadkur8vYeXO4y1H8oorfKZxA2PyyuOPkV6UudDS9cfz9DFdmqBZsUITOnwkDCq07fiZI1bsF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721208; c=relaxed/simple;
	bh=OuhlJZQDRifnKQDwqSTU7er/WFwoQXBxbE0NfsILInY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mF8bzE/l2ER+yA7DdvhrwDd3/DkufhswD66AmdPtZ/ieRT11+tV3G28/47uVd+1LI4tAUIF9XBt/rie8h1C94bxDu116Q6l2xKMZOZqlQVeYSxHeD4CxD3K5wX8OPLvzFkdwhPrdeUz98EvCYIOf1uOnZ8/TrlD7Oi0pvc1IFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f71e4970bso7235073e87.2;
        Tue, 14 May 2024 14:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715721205; x=1716326005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMGciBx6a6W9YMu8j+TGhNBJjOW56w9BCchj3OIvq7g=;
        b=qO2bnSWvVMXS6Y0UbxpB4iTzy1QsyHo7ohyDV0egzNulOIrSnSd2Gtzj0ab6rPSnuV
         tzYDUA4Zj9zZ7LN3sPW3AmNKvqj5LnlHCT/GuFdQ6AnYpKkvY6Hmognkxey4587eZKqq
         ym+w/6RrOzLp2H2kYsqJRV3OT1Vho7JCCkVAEawPfILsbfi3//0IQxeecB7Bi2zzcyW0
         WPnMr8sgzCssiOq1bC/qa7okWcPhJvzxxabctFdLRFklQbGH2hj3t3lCJfmEqfeU2gZJ
         nAGIKLCOdJtR5KGRA1zmrLv8Gfq2TZNJZwEm19q0FzOulsnJDP7JWByjNdc2g3Xwuunn
         jwKA==
X-Forwarded-Encrypted: i=1; AJvYcCWVcIjQCDiMv1ugL5feYkoguNj0KxMpVI03hPQoZupnPPt2yW9i3VdrPdZjw2s4nRlEx0ny8Mkmxvpnzh75mFaw50QrgPmHK3BqGtv22qH04PxQkjdMRXs6F9pHnk3mr37/J/MtbS6lPe0=
X-Gm-Message-State: AOJu0YysJV5UmwBCeyB/+m0I/454S97gmctU5wqLacxIwPV8HBxRnS9L
	dA+GC1bSDWh2TMKFLd17RqB9ZCfPE2iTUYYv7ipxU2Nw8POx/2PI
X-Google-Smtp-Source: AGHT+IHL0KjuKuJX2UNLz3kNqPrubHLYJcjq6K8qgD+M1K9TnnJ7bLJ5/6OQNPwGiY4WbPE9OukMnQ==
X-Received: by 2002:ac2:5dd3:0:b0:518:c610:754f with SMTP id 2adb3069b0e04-5220fc7bf01mr11583842e87.19.1715721204844;
        Tue, 14 May 2024 14:13:24 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a178a9d73sm760229766b.67.2024.05.14.14.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 14:13:24 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 14 May 2024 23:13:21 +0200
Subject: [PATCH 1/2] btrfs: zoned: reserve relocation zone on mount
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-zoned-gc-v1-1-109f1a6c7447@kernel.org>
References: <20240514-zoned-gc-v1-0-109f1a6c7447@kernel.org>
In-Reply-To: <20240514-zoned-gc-v1-0-109f1a6c7447@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reserve one zone as a data relocation target on each mount. If we already
find one empty block group, there's no need to force a chunk allocation,
but we can use this empty data block group as our relocation target.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c |  2 ++
 fs/btrfs/zoned.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  3 +++
 3 files changed, 65 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a91a8056758a..0490f2f45fb1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3558,6 +3558,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 	btrfs_discard_resume(fs_info);
 
+	btrfs_reserve_relocation_zone(fs_info);
+
 	if (fs_info->uuid_root &&
 	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
 	     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4cba80b34387..b752f8c95f40 100644
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


