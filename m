Return-Path: <linux-btrfs+bounces-5023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6778C6C4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF9A284A13
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF47215ADA4;
	Wed, 15 May 2024 18:43:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329C2E622;
	Wed, 15 May 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715798594; cv=none; b=MwaJj5oc41ntdoRi/Gl7IQj7+4TDX6wkfoawKLOitMa5gmwp8kHUFWo6JVC0yLovHyVpXu5bZ9u9NrH0gcmbqC9mEMUYVgL0G2S11GI6VL7I8+mid5lG+gPQ+TNOaQCJsgJpCbY4GJ8mHaWzHhbwlc8SE/sUXYyWZkSVYU8T7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715798594; c=relaxed/simple;
	bh=OuhlJZQDRifnKQDwqSTU7er/WFwoQXBxbE0NfsILInY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Akzp5HdOPhhkVWden3Y90YANgHXpvqOTN9FbnZdNKwoXditntJATp4kA05hMWg+XuDneVWw+mDrx7qxHdGayMg5Uiz6FTLYxxlsC4zP3AlpZhHVj2tUqyavGe2Gbjf9204Ynz4g008fo8TaaYEXogfBopdF6Us1hlanOLkwazGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f60817e34so8102007e87.2;
        Wed, 15 May 2024 11:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715798590; x=1716403390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMGciBx6a6W9YMu8j+TGhNBJjOW56w9BCchj3OIvq7g=;
        b=gM6xx+necCeuCUPYtvBTbKaGUTcqCS7l2RGc3OlsbNlLgmNl8os4LJtWpAn9VBq/eZ
         3rdVGxaPORFV9R+oqrDDc1mVcPnghOXq3QDDU/heF9DqlrFjE7SNM+LEVg3t1A4KWNJw
         ODrvkIstbs833uoRA+oLHXueW7h0kMhIAz6bgf/qeOq9SkiR1fdMyfmiSymuMVOU/xE4
         bZraGd1YCVi8FR0+Iwb98yHdhm0jSsSlENijD+1NcynDFeaaxo1p/2h7AWJ4x7E4ifqt
         Loa4kv84o8UrY4AUwXpgSAVKsGnFuySZDwvvQ+s3STUXO+RG3PdDgBaHgnnN20d/3blW
         zh1A==
X-Forwarded-Encrypted: i=1; AJvYcCVtNRIT8xSqmWTcxWZb1WXiBucpy62GkeVqfZXTN+uTQsJjjnF1h7RqLqj3RxyQCc72YP8n8uVaFVtBQBkT6d5IlciVrBRtfQ4zUAbxLOIAJfaHvvWC7KgDx3U3QMaxGII+cpHAQz3hljQ=
X-Gm-Message-State: AOJu0Yyd0eyDim12w7g2qOUDyp1H7XHH7RUvcXuljriBcP3VufWVHw4H
	MDhjzgoMowV4mXQ5vyetJRAHxm1LanuWWu/rjp9HKBKlLbSeoZnr
X-Google-Smtp-Source: AGHT+IH+/qaSgbaekVKIF46e8xhO+/31+Q1RMkHBBqa3Zazk8205UskMDE0tY2IYBXD79aYCSSainw==
X-Received: by 2002:a05:6512:b16:b0:51e:f52c:34eb with SMTP id 2adb3069b0e04-5220fe78cdfmr13415857e87.51.1715798590365;
        Wed, 15 May 2024 11:43:10 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f4a6280csm1724340a12.52.2024.05.15.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 11:43:10 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 15 May 2024 20:43:06 +0200
Subject: [PATCH v2 1/2] btrfs: zoned: reserve relocation zone on mount
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-zoned-gc-v2-1-20c7cb9763cd@kernel.org>
References: <20240515-zoned-gc-v2-0-20c7cb9763cd@kernel.org>
In-Reply-To: <20240515-zoned-gc-v2-0-20c7cb9763cd@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
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


