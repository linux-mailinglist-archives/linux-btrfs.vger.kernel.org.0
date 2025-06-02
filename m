Return-Path: <linux-btrfs+bounces-14359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC4FACA90E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 07:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C952189C5AD
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 05:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FAF1865FA;
	Mon,  2 Jun 2025 05:43:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7752C3242
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 05:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748843006; cv=none; b=MenY6jI5ZxVFKDQ6Xaau4SDRO5erOh7YnkXPztM+lSzAhA4pZSZXUDcWyxMEgUPct23/TWnlvgcffCCNvfl2qbpdnXgOO/H1vGkh9schiZZvzUQrxyr+0yUQR/dTd4z0eC2tPsMimoKaykzc29cMzUgiURUxMJqNLJdnL2LWSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748843006; c=relaxed/simple;
	bh=1FFaBPcHxXEQTLJ2C6D2WNkdNYqh47xliVhMEearWME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARuhCsO+jGI9kD0o6GtGyYGrmd8aNv749JFqQA9RdJ139oIyoKK2NVn31xwXEPJmgaiHzDllinf6W0n8p9gOYdkRTEZa9dwJtnll/vU4ySGgAc9wUH2+N+n85CNnZ4ZGu2wsrDcPuYs5b0/9TBp352sMVzU/Syp7UUSGyFihnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0ac853894so3770837f8f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Jun 2025 22:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748843002; x=1749447802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VK5ABjtyTEYvFaMc4PaNvxvS09L+85+fi3NJvmEd5rA=;
        b=FbxNiolXiqnVibyxv2vvz+0naxiJZSP0IiOxc9bZvkjcR612ghkUm6dLxjreq1ySkc
         84sPhaZ2QcumB/rV6ic7Aq2exVFUb6exm1m4roy1qoQtW4ICWsJfo/qGwc1KxIuflH0J
         N4KDKGatKJ0i9YAZl5i1kQndhM6KbxKESex0AzMBVph0/OCVJkKMgr33lKD8X9W/uHHD
         DiEd8NZ1WTrEdhJA/v2DoQw/6Mo0mDxeWpyl0NFESoOyEfNQdIaMUibiuzN+fA0Ak7mT
         QPV4JWi7KcmCr5nMSmTX1NeAmj5TK/JFslekPV+I9K6qjr5/45nwsa3GlDiVXWACFvsS
         BMzQ==
X-Gm-Message-State: AOJu0Ywcph0SdZ98R2PXxSEZjTsrllvLzLi7dfKvmKscE+yhim8YeHKr
	60AFBjdG3/O6Dl3Z5CTo7j4UsehRy1/jjiD3xwzhavdUCadwGbwg3sBDPWl6nA==
X-Gm-Gg: ASbGncueCbDnF1urD9NrgGzEtruBWkiXSZ1xg+LD56OC1+YDrQhMqQJ2Y3g3r1qFJ+r
	Cmn83ckPluSEMxuPbcUp8nv0I9DbOmckGijsFyZ00s8/t2HslWm+SBwb4lkbIAxPyzhNMkDrS6I
	m6ZNc1bVVMsCjvUL0Aez/KF8nU2Wr6pYjK9V0SwZYKidAfm2ZZJpR3OB1KHAJB9Oim5D0nkxw8F
	bp0d9HcJczyAusLhp9z9cXliMIbr48hTrsJOiNQrwDQtv6vdRZyE1JT3leXPGubI69dVoba9/se
	SQH6OVlHzuPVyrAMnmoak46zAN+FWrFcWGxaUdT5Fyc3DWDZd/E2h/eeoh3hmmLvE4F9jBeq1bF
	bONy/eykv0AmTvjU0f7+sO8vvNFuX4sKEHS1dof/QcEat
X-Google-Smtp-Source: AGHT+IGbNc6pMF3ES+otE2F4NCD9RB3bFwh8vg96u1Z492eL1p5webhioKLOI+PFokt11g6osL8Qcg==
X-Received: by 2002:a05:6000:310f:b0:3a4:f744:e01b with SMTP id ffacd0b85a97d-3a4fe395603mr4765343f8f.39.1748843002214;
        Sun, 01 Jun 2025 22:43:22 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f734a100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f734:a100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b887sm13898832f8f.18.2025.06.01.22.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 22:43:21 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: zoned: reserve data_reloc block group on mount
Date: Mon,  2 Jun 2025 07:43:12 +0200
Message-ID: <6133ab918b19507738e4fa08be23b73be0d8d84e.1748842937.git.johannes.thumshirn@wdc.com>
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
Changes to v1:
- Fix build error with CONFIG_BLK_DEV_ZONED=n

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
index 9672bf4c3335..6e11533b8e14 100644
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
 
+static inline void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info) { }
+
 static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
 
 static inline bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info)
-- 
2.43.0


