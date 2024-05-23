Return-Path: <linux-btrfs+bounces-5251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D688CD6F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB8A283786
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 15:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F4A17C66;
	Thu, 23 May 2024 15:22:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3C12E78;
	Thu, 23 May 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477728; cv=none; b=GBMIoyZechWu+M1v2+OfaEbXSgctZ3j3/59JQhFyC1X3RcznbfMfSfF/4y/qBTE5hxf+qdDIXOmh95wRAj4gN2L1wftpFvuXrjoU7bYw8YzkbgfG5ZFc4HmHXQX5pdUKULCoN3SBdwr42zCURxYw4Mzq0WX8x8bZAXA8ucH5COQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477728; c=relaxed/simple;
	bh=W/tRG65sx37Ehqh1vHSLzBBL2Woz1kNROlopvJY18mA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLtm7F1JXMUW0bSvSP0jM3i1BDyS2k3x4Ei5lfSqW1lFSLicS1Qe7mp6nUrHv+y0agQqVdNi+UMzHCV9q34hhkMZ7F19PvkfKWUbTyraULZyo0+dD2GYhkqQsHLh2hkIFjCkUFYsDa4iXT3LJOFiySkgaeCuIyEgCE3Dr4Ykwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so63898641fa.0;
        Thu, 23 May 2024 08:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716477725; x=1717082525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFl3w2xldhE4Ibif4+CzC1kQyMZWWwVIT5sl01nHyf0=;
        b=Pj+6h5QW2aT/MGPgbD8z8G03hhe2wlnqeTPsleAHvUA0wapIDi/WPAuA0BR6Bry4zT
         qyCy25mDZhoULP0mTVAKcK51yxi5IBNQ56vCYPf+i9Xe7H9xGKj/DM3g3+NKjXjMl8EQ
         Fv0jXUICx8w6waJiOQDnf8qaDHDPLJcGyYlGOa65KN7vJN6GTbzhhc89p7jazOFXYc5m
         YR0TZoXe7StpevNQDubT+Se5iGHfh2AGgwpbr60Nnh2SK20rNsPHSIh9hkwrKERt56H8
         PQXKs9a8OGU0jzhcjl94/Oq8Qt8b8DW0stYErAxjn2atY8Rjip04ILWXxaI9CTUTyn3a
         PScw==
X-Forwarded-Encrypted: i=1; AJvYcCUQxZ01u+/WkbIOWF0Hoae3hU6S28RKtzIyXGouoZLWhEzc1mQjSYlhvXXhJmLmzpROTQQJh1bqmAsXOccGkZl48TAYY1CckmT4KRoiTKF2VrL5isIpc27odLTBHLn3pv0CyhGAGQyT678=
X-Gm-Message-State: AOJu0YzHHa0Dr0H4Eu620S5doBytKkU8b6Bv71Wachw1oy56RqMQUHie
	dbhyfjT++i6Cqs3k62wnSv/pdU/cweOmr1acGAlbEXbyV2/Dbcn0
X-Google-Smtp-Source: AGHT+IFXC7jzD337+t0BDF3sLwyHybY7t5571nxZbePH7iSI1lO3KF8/rLSL6D0dGLhE424a1hrBrA==
X-Received: by 2002:a2e:8756:0:b0:2df:a177:58e3 with SMTP id 38308e7fff4ca-2e9494bd33dmr32227511fa.13.1716477724516;
        Thu, 23 May 2024 08:22:04 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f709b700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f709:b700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421010ba0f6sm27536015e9.47.2024.05.23.08.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:22:04 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 23 May 2024 17:21:58 +0200
Subject: [PATCH v4 1/2] btrfs: zoned: reserve relocation block-group on
 mount
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-zoned-gc-v4-1-23ed9f61afa0@kernel.org>
References: <20240523-zoned-gc-v4-0-23ed9f61afa0@kernel.org>
In-Reply-To: <20240523-zoned-gc-v4-0-23ed9f61afa0@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reserve one zone as a data relocation target on each mount. If we already
find one empty block group, there's no need to force a chunk allocation,
but we can use this empty data block group as our relocation target.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 17 +++++++++++++
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/zoned.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  3 +++
 4 files changed, 89 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9910bae89966..1195f6721c90 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1500,6 +1500,15 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			btrfs_put_block_group(block_group);
 			continue;
 		}
+
+		spin_lock(&fs_info->relocation_bg_lock);
+		if (block_group->start == fs_info->data_reloc_bg) {
+			btrfs_put_block_group(block_group);
+			spin_unlock(&fs_info->relocation_bg_lock);
+			continue;
+		}
+		spin_unlock(&fs_info->relocation_bg_lock);
+
 		spin_unlock(&fs_info->unused_bgs_lock);
 
 		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
@@ -1835,6 +1844,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				      bg_list);
 		list_del_init(&bg->bg_list);
 
+		spin_lock(&fs_info->relocation_bg_lock);
+		if (bg->start == fs_info->data_reloc_bg) {
+			btrfs_put_block_group(bg);
+			spin_unlock(&fs_info->relocation_bg_lock);
+			continue;
+		}
+		spin_unlock(&fs_info->relocation_bg_lock);
+
 		space_info = bg->space_info;
 		spin_unlock(&fs_info->unused_bgs_lock);
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 78d3966232ae..16bb52bcb69e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3547,6 +3547,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 	btrfs_discard_resume(fs_info);
 
+	btrfs_reserve_relocation_bg(fs_info);
+
 	if (fs_info->uuid_root &&
 	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
 	     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c52a0063f7db..d291cf4f565e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2637,3 +2638,69 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
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
+void btrfs_reserve_relocation_bg(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_space_info *sinfo = fs_info->data_sinfo;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_block_group *bg;
+	u64 flags = btrfs_get_alloc_profile(fs_info, sinfo->flags);
+	u64 bytenr = 0;
+
+	lockdep_assert_not_held(&fs_info->relocation_bg_lock);
+
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	if (fs_info->data_reloc_bg)
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
+		if (ret)
+			return;
+
+		bytenr = find_empty_block_group(sinfo, flags);
+		if (!bytenr)
+			return;
+
+	}
+
+	bg = btrfs_lookup_block_group(fs_info, bytenr);
+	if (!bg)
+		return;
+
+	if (!btrfs_zone_activate(bg))
+		bytenr = 0;
+
+	btrfs_put_block_group(bg);
+
+	spin_lock(&fs_info->relocation_bg_lock);
+	fs_info->data_reloc_bg = bytenr;
+	spin_unlock(&fs_info->relocation_bg_lock);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index ff605beb84ef..56c1c19d52bc 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -95,6 +95,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
 int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info, bool do_finish);
 void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
+void btrfs_reserve_relocation_bg(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 
 static inline int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
@@ -264,6 +265,8 @@ static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 
 static inline void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info) { }
 
+static inline void btrfs_reserve_relocation_bg(struct btrfs_fs_info *fs_info) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)

-- 
2.43.0


