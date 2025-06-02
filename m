Return-Path: <linux-btrfs+bounces-14385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A0ACB98A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55177AC1FC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856122A7EA;
	Mon,  2 Jun 2025 16:20:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5322A4EE
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881250; cv=none; b=N+y5REzp/zlwmmwykxzI6mSSsrqCg7IVUii0yHaTO9/OkAFBb9MHo0c39PZqLeKI/oS3Cv3+jz5Jl2rTlpSam60XyeIgN+v5SMGQ1t4auHBrUHQOP08snkhocjzdyBJTPSo/IS0YimGz6B4gdy8F1ogRTJCZx0Zb19/Mm8NbbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881250; c=relaxed/simple;
	bh=Cc4aLVgkzFhyCb82ScAh2wQ+357QJqSa1D9sT7pte+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AyJDShQHmsKYig7vQt2MCzkpw2v/EzvEBAHANbzWE8dbi9BdeNqudQe4kKGW7Ull76XWeyBOs7IcX12lLro4MsZi3xEP0cRuC6MwemXpw5mepGvasngNRx8OVPeo/NozRdxf5O0krxYGPoH3lS0aOz+REc5zcrHrrgwdFiYHIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f89c6e61so1835795f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 09:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748881246; x=1749486046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0W0Y1De58/fPO/OrtJss93BYip5p1NUZf0kCf2pBxeU=;
        b=G+Z/8W3TsQOb3qeb5rGlqyHzimLTDVoVlTTspETjAYQSo/mMmeNoWLbgnTH/Vvkt1O
         mLLu+dduhf/HGqTA3TY6U5mQsigXr1IBC+69QkRHaV9U4+TAvX7gL0M8t8SXyBL7kgbT
         V10pUiJIekDNq9tyVqMf4Jmb8UwazSxa9g0GmCgp2Ir25USkI2ilBvQWD5UFqU/SNUX2
         g27RTVnHou8wFycqVz1dM3uIq43b63CVsJD2rdFbEe7L7obNLAltoK8wFyL58yyHQqwB
         AuGWObOV3arQ0bPwNcLFN/XYU97+3IQfX8TEzpWX5P11NrdNVPmE91KFduANv+iVZLoa
         vgUw==
X-Gm-Message-State: AOJu0YwPvNA/P8Cg9ZerARlqDXioLK+Bz7pgaZgtUhgVybjZIwrpH3CJ
	NbA6LWjOcl5Ahq0kKe75KbQ+j5tvZ+XZikW4Vi8cYTTY5iGGjqV2LyL3qDITkg==
X-Gm-Gg: ASbGncsZnswqIb7lpqtK1DBE9ieC+8QA5UOo/8hhYjhUdYM3hCcvJukxTpNiO15Yteb
	UZ9hjLBMgxXZof/qjHzWawfEeQcOaVhQ8BuzofsGH63axtRZxxwE5FANHvvMG3FWXMNkXB1j4OT
	EnEVbhLartLiXGd2/a6c5odOUZNNVzZUflc+i8JD90QvAvc14f3xH6ZrxZa55O/CqXoKw2vXrFv
	U+J3pvt+ZjLCCt6J/uyX/twB0UhqWLCPBnJcBESxfqTGrnJ38nniSBZwk3qqDVY/+MowAZZY+JG
	qnH1ZjQCeGUBfsOE8xd8PhKCpRnhtYtqSU8P1m0IVUCDQGH/iIkDwQ4afxlAjRfHInDZ9smd+h3
	2EHTza19+AYo37+3/Gofu9zdmMDgx0QibTA==
X-Google-Smtp-Source: AGHT+IHrI26bgITFsawlVc3e6Dl67JHWpz9T/ZY1v7OVPTDmNSEzwOvhejT5aT/YxRtqr/eCxLG5pA==
X-Received: by 2002:a05:6000:230d:b0:3a4:ddd6:427f with SMTP id ffacd0b85a97d-3a4fe3947d1mr7607118f8f.35.1748881246329;
        Mon, 02 Jun 2025 09:20:46 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f734a100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f734:a100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8edc0sm126771515e9.5.2025.06.02.09.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 09:20:45 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3] btrfs: zoned: reserve data_reloc block group on mount
Date: Mon,  2 Jun 2025 18:20:38 +0200
Message-ID: <20250602162038.3840-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Create a block group dedicated for data relocation on mount of a zoned
filesystem.

If there is already more than one empty DATA block group on mount, this
one is picked for the data relocation block group, instead of a newly
created one.

This is done to ensure, there is always space for performing garbage
collection and the filesystem is not hitting ENOSPC under heavy overwrite
workloads.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v2:
- Don't take references
- Use btrfs_chunk_alloc()
- Don't abort the transaction
- Decrease indendation


 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/zoned.c   | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  3 ++
 3 files changed, 75 insertions(+)

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
index 19710634d63f..663cd194522b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2443,6 +2444,76 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->relocation_bg_lock);
 }
 
+void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
+	struct btrfs_space_info *space_info = data_sinfo->sub_group[0];
+	struct btrfs_trans_handle *trans;
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
+	ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC);
+	alloc_flags = btrfs_get_alloc_profile(fs_info, space_info->flags);
+	index = btrfs_bg_flags_to_raid_index(alloc_flags);
+
+	list_for_each_entry(bg, &data_sinfo->block_groups[index], list) {
+		if (bg->used > 0)
+			continue;
+
+		if (!initial) {
+			initial = true;
+			continue;
+		}
+
+		fs_info->data_reloc_bg = bg->start;
+		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			&bg->runtime_flags);
+		btrfs_zone_activate(bg);
+
+		return;
+	}
+
+	trans = btrfs_join_transaction(fs_info->tree_root);
+	if (IS_ERR(trans))
+		return;
+
+	ret = btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
+	if (ret != 1)
+		goto out;
+
+	list_for_each_entry(bg, &space_info->block_groups[index], list) {
+		if (bg->used > 0)
+			continue;
+
+		if (!initial) {
+			initial = true;
+			continue;
+		}
+
+		fs_info->data_reloc_bg = bg->start;
+		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			&bg->runtime_flags);
+		btrfs_zone_activate(bg);
+
+		break;
+	}
+
+out:
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
2.49.0


