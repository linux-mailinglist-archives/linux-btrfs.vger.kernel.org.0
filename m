Return-Path: <linux-btrfs+bounces-5163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E58CB0DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 16:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FA9281A77
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AEF143730;
	Tue, 21 May 2024 14:58:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309557EEED;
	Tue, 21 May 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303495; cv=none; b=bEsnWudu55Lve0KjRYny2RfSQaJjnILTULXLQcj2UzClfU+hXGrc3xT1MsxMDm/aw6zGIG7gVZv+UzWQFHdBa1xC6ApDvNKnVCSnR1VNYQPLSrpkCma2HwincYAsbEhsHslavmEgjpxw4n04m+NWaJH09O0GxgcLpLaUDR1FAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303495; c=relaxed/simple;
	bh=ZYZrYeeOyuNeFDHEE7azERnUzieU53RjMkeioN/xwPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6YMDEJtKCuxHhoDED6rEXXAdahBh3pkXpjWk/ajhzzTPRbu9QoFOdv7MSl7RVekLzU985neJPckGbLtz6mF0+MQkM9KPzNeCmT2IocA6BN17h31PnkoJIMcmGylCLH+zKgO8yIIGVUKycyYQXnn7/1cxdz12fmvHqrV3Ob4JY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so8934810a12.3;
        Tue, 21 May 2024 07:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303491; x=1716908291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jDM3n2hrEdNut5AaYCXkXUfuBArSh9fWKGJh+DYbeU=;
        b=D5fhdVOILdv3PV1OsDX9BsT8rhw30Dbq2U8kTcKvAbtoi5R9FBAfd+S9Ny3pzq/5cr
         AbhHlDmo3hykCmrSaPOR8iw4Ma2wmVlq2Bej3B+jwayqKDy7PHuYkYnu9Cfqtzl3X5zo
         inS87qvtD+mTK+6RXkINy8d8nvAjdrz5e4kJhbhpkuZScygej5rrv+o8kYfkBGUj06cZ
         o3gITS4f7bx9p1EkkCTzlwHCvvR41mt8thKs7fGopHGV8m1ECRkXtylmna4PnY9n7izN
         Y1fAWM7IEYWlVQ1e7UbpmU0LUHd/wURTjOubBeJUHMwn4V81Uv5TsmtgJmdrozq1sUJe
         oxYA==
X-Forwarded-Encrypted: i=1; AJvYcCVtDhOVJ+GT8qlgsqvtewPqDxEgNJWEzMlQfn4QWVm9Ay4cFVGYQGS7XgcgTaqsg2yT6Nig7n7q9OE3fYutsoMtGz+IvYr1VDPcV2V4txewDIU1TxNpH4P177ZY1Fxbjpt1pVJdx5OlfZE=
X-Gm-Message-State: AOJu0YxgIXK57x6Ly/hdOMbNZDqez6MVj5neY8uNu1MmCXcUrEONdj9q
	7We6MehpshpdRvkgyTLMPL+krvJXeVyYTg2o9kroDSLCUseft/ho2ne/XcYS
X-Google-Smtp-Source: AGHT+IE+BoEGdFNLF9XCeZ9VsBRDaEJMWy66xC5oQjnYENIF8dgrwCuX88TmYKdykmEOjsqrkC3ZJQ==
X-Received: by 2002:a50:d745:0:b0:56e:3774:749b with SMTP id 4fb4d7f45d1cf-5734d6dfeedmr18653240a12.42.1716303491367;
        Tue, 21 May 2024 07:58:11 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f709b700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f709:b700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f6b8b9d7sm8912502a12.82.2024.05.21.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:58:10 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 21 May 2024 16:58:07 +0200
Subject: [PATCH v3 1/2] btrfs: zoned: reserve relocation block-group on
 mount
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-zoned-gc-v3-1-7db9742454c7@kernel.org>
References: <20240521-zoned-gc-v3-0-7db9742454c7@kernel.org>
In-Reply-To: <20240521-zoned-gc-v3-0-7db9742454c7@kernel.org>
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
 fs/btrfs/zoned.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  3 +++
 3 files changed, 70 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a91a8056758a..19e7b4a59a9e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3558,6 +3558,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 	btrfs_discard_resume(fs_info);
 
+	btrfs_reserve_relocation_bg(fs_info);
+
 	if (fs_info->uuid_root &&
 	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
 	     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4cba80b34387..9404cb32256f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2634,3 +2635,67 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
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
+	spin_lock(&fs_info->relocation_bg_lock);
+	fs_info->data_reloc_bg = bytenr;
+	spin_unlock(&fs_info->relocation_bg_lock);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 77c4321e331f..b9935222bf7a 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -97,6 +97,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
 int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info, bool do_finish);
 void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
+void btrfs_reserve_relocation_bg(struct btrfs_fs_info *fs_info);
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
2.43.0


