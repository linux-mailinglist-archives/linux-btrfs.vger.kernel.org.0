Return-Path: <linux-btrfs+bounces-5283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3028CE8A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 18:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199E71C20CA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EE3130487;
	Fri, 24 May 2024 16:29:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435B12EBE6;
	Fri, 24 May 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568163; cv=none; b=S7U1ZyH0Rj7GBQYyisuPXkiuGiBwipgdKgNUur14hc3OdrgT+0Tkh0m+iKeH81aiaecolxO6JWkNBE0iCMQj2NlozVrbX4FfmZ51ETOdRSTjiecz13/cOmr+gCd/xPKarF2ygUPpPUugDS5skcTSEpl8O2i7B8NKuASG/BLHyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568163; c=relaxed/simple;
	bh=VMLurnZnn98fqJLn2dpqVKy2Z+N3Cdv0A0gKRCRLlhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trhKG4ObDvNg1MJtwTN4V+E7K9HX54+7wwaQ/wVoNfKIJP0i3Yf80E892glqlTeurGyaWtYL1wHCDF7T/kdxh6eYNOYqCitTEEKrVW1JPgK8q5X0PDZ9Sf2GzRwNBBKXfwgjXrcf3OWcm5C5w7Wh5m/mHw48MO2iF7/e7XAXJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so21571441fa.0;
        Fri, 24 May 2024 09:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568160; x=1717172960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9MuPC31FQV6hx/sw9sFp9Nt9OEwI9hKsrnaJWs2Q3I=;
        b=hcWsGS5KRbQkQI9KQvTXVpYnhssJntza4XhOam6OjemwkCuJToz2FWpAPNiYURLr27
         CZZdVH7rFGpLItwOgSeuDv/q2nMtaeSWxhZZZ+8pLSiCjFstnImKHG8JiAcXSScmUBwu
         0yOEiskCojS1WOgK5/lBeeKAQj+FTpOg3CG1t8VJqRQDB6zQ1/NNvW8utV3YUzx35y4u
         Knr5/WkzJmZELdrPjy+x+IkkvBFkiCqQt1XMTE+pG3iZiyK/b1BhwQDsJupvYp0Sh93y
         NT+tHQGLANzqm5dNKcPVKxx0A1yuB/At7jqFVh/3RvcuKrmJWeGFmbCgdLKeFuTxPbGT
         Xxlg==
X-Forwarded-Encrypted: i=1; AJvYcCVDqxlJhnxeIoPK3LZxigYQR0U76BQxTbFOMzHfHovaZRfGTKwRMdLEvfGqckXUECbcV2qeqF1hlMlwLi+bCHqTFb6Iob4BDVwS3m73/ItTaXjSEeIpoXBzCVw5wQyAsiiiSTuvhxMpIVc=
X-Gm-Message-State: AOJu0YxsnuKY8WEhpWgM6jh5FEO9hmULylvKm7rcspac1K1OU2SYcW1X
	76wzyOZp9p9bqs6sFfkzotQK05Wx5XV6bT+MRjuVOek59jaiyBg/
X-Google-Smtp-Source: AGHT+IEXkCIwRUtjX9X0IjjLFQtF33vXE/D/y6uqsinQWRvw13BCKQetQ4P3EcfJEOkVTFip7ZlE9A==
X-Received: by 2002:ac2:5442:0:b0:51f:3b4d:b087 with SMTP id 2adb3069b0e04-52967932297mr1876438e87.63.1716568159951;
        Fri, 24 May 2024 09:29:19 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8dcb2sm154137066b.173.2024.05.24.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:29:19 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 24 May 2024 18:29:10 +0200
Subject: [PATCH v5 2/3] btrfs: zoned: reserve relocation block-group on
 mount
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-zoned-gc-v5-2-872907c7cff4@kernel.org>
References: <20240524-zoned-gc-v5-0-872907c7cff4@kernel.org>
In-Reply-To: <20240524-zoned-gc-v5-0-872907c7cff4@kernel.org>
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
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  9 +++++++
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/zoned.c       | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  3 +++
 4 files changed, 82 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9a01bbad45f6..167ded78af89 100644
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
index c52a0063f7db..f4962935efef 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2637,3 +2638,70 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
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
+	if (!fs_info->data_reloc_bg)
+		fs_info->data_reloc_bg = bytenr;
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


