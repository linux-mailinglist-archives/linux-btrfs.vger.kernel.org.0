Return-Path: <linux-btrfs+bounces-3728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C58900E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27661F24D33
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC812A171;
	Thu, 28 Mar 2024 13:56:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6B82870;
	Thu, 28 Mar 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634200; cv=none; b=BKhVRgifCrB34Hpo8Nqdn7OlrESrBxjsWuJlYDyrCACQDqq09aNRHqmMdtBW6Z7s0nP5TAIL3sZxy5Rei2ue/VO9mHAvYCK2oLC6CnJKzmVX6iE4bI8g6zznXOm5e40ui2i3Mv3wFTRNIR9D3DBvt5dnQs99CaabJqA35E0bWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634200; c=relaxed/simple;
	bh=c7dItLgZT16BA6Jt8KKVS0vd5eORsAQQuDacIeUM3Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6JCLbRbUGeptqGll/mdsL9Gu7IxcE2Ow3lnW0TNB17nrWHs86plsZFEtfhOe7oYOE5CDUq0Ts14QAe6KPpDcFD7GNgpgKhoXtT4xGttnHDzdNk3LwfPZc52r+m0RHXtURD5HIqSKB834Q+UZ1htRqLwjC+t66yDMuESRxAkCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d6ee81bc87so8667471fa.1;
        Thu, 28 Mar 2024 06:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634197; x=1712238997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ssfp/lixYbBkrYRjJlTEMZijmNwH/IwS9QAvKzM8Pn4=;
        b=TGwGpJTJg1WtWGqB2AUZgJEKxJ2BY1jV95f4ac4LkDtUW5GxemqpI4w51eAp6JK53S
         q6/92SztlHgQ+FlFLKJdFPBCmrHVWtpoXybUgq3PK7DOjYg3kT+HriPn2TIY1kpYhSVw
         xA4pXSkv8g7QPjwXVyqOYNKwbAErDU1PYbwY8+WQYZzAaFGTWkzU4GFnRToC8OyHZUBw
         PuYTz2JEn0+wKLBaSloemyCN3MCVQUuXbzPZEZVNyypzZQEG2f4rWUVzq5Dxdfevpzsl
         UhLe5Zc6sx8i4gO5Yco7W34wMMeNlwFhordclXyBbP2bjHufeu4Mw1Jwt0iF+g30R1G2
         8xTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYjSTlQ/xPfZbXbnnX29dzabhnHGYm0yvijwx4MT575hFg6U8TgnQT82X2x6rUaYlS3zv+UmnFy3Cl5K2hGudsWhy7x/VxIbPKwbTv
X-Gm-Message-State: AOJu0YyGPNlpD5aHI9+qMRNHcFbpUv4YKEJsE/o3H6llpFIOi8pw/3ro
	L76RyjU4ZjFVE2K/PHbJAWrtHEMINtaqRYtvpCaiel9wBH/XcgdO
X-Google-Smtp-Source: AGHT+IFYMes0gsgwMJr3G9wsetCcIQ2nNDAOp/Zvq14gKWTiu2yO4h4EbThCQFd6atMW+XNzEos+ww==
X-Received: by 2002:a05:651c:a08:b0:2d6:f556:d8e8 with SMTP id k8-20020a05651c0a0800b002d6f556d8e8mr2952131ljq.2.1711634196736;
        Thu, 28 Mar 2024 06:56:36 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b004148a5e3188sm5519570wms.25.2024.03.28.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:56:36 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 28 Mar 2024 14:56:32 +0100
Subject: [PATCH RFC PATCH 2/3] btrfs: zoned: reserve relocation zone on
 mount
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-hans-v1-2-4cd558959407@kernel.org>
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
In-Reply-To: <20240328-hans-v1-0-4cd558959407@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans Holmberg <Hans.Holmberg@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 hch@lst.de, Damien LeMoal <dlemoal@kernel.org>, Boris Burkov <boris@bur.io>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reserve one zone as a data relocation target on each mount. If we already
find one empty block group, there's no need to force a chunk allocation,
but we can use this empty data block group as our relocation target.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c |  2 ++
 fs/btrfs/zoned.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  3 +++
 3 files changed, 51 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5a35c2c0bbc9..83b56f109d29 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3550,6 +3550,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 	btrfs_discard_resume(fs_info);
 
+	btrfs_reserve_relocation_zone(fs_info);
+
 	if (fs_info->uuid_root &&
 	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
 	     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d51faf7f4162..fb8707f4cab5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2634,3 +2635,48 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 }
+
+static u64 find_empty_block_group(struct btrfs_space_info *sinfo)
+{
+	struct btrfs_block_group *bg;
+
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
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
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	bytenr = find_empty_block_group(sinfo);
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
+		if (!ret)
+			bytenr = find_empty_block_group(sinfo);
+	}
+
+	spin_lock(&fs_info->relocation_bg_lock);
+	fs_info->data_reloc_bg = bytenr;
+	spin_unlock(&fs_info->relocation_bg_lock);
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


