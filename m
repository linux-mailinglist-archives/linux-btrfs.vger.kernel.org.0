Return-Path: <linux-btrfs+bounces-14399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7EACC010
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 08:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B58166A70
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 06:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE91F63D9;
	Tue,  3 Jun 2025 06:14:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4223774
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931253; cv=none; b=J3OK0rWZ3dI9FS+mvVwfI9rQuU1MivOHVIJCt40DOwIRk4Oiy/ZBfvALbGCEzKiB8KCWytDCNtcXX5apAp4I4kxzLYHydV9Wuno3ny8vt2fb5ssijVNHGTYylcOFgfHeKf9QH7sCt9pBu5fg4NWiVc89kTUqsw4l6S983C+6fsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931253; c=relaxed/simple;
	bh=eO9pSk8RswpIaChZmyi/2xhBcTwm8eTLG5mLM2dGsgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxhvNNoFFu4usifM3rwGfYNda+TMfhzZtZNfWx6zlQzhxjKgBAGN2rycpbb2WLTf6IBFCRPag9SKkr70UBW21QLMhFWTxcG3LmGhbED8j0PTpCfeZxloa1M+5l1/UTo/Mdmpie6jdg0jl590Ldvh2BqyBpNlnUvN/RbWgTBg/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a36748920cso5875834f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 23:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748931249; x=1749536049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NB+jVq7WeDiNa8ZtSG0IVtpvQLVqxUcrNHyJgHg2BfY=;
        b=famc8NW4pOakPrz4LSh217UIxA//iBcOOis4STwnpKkL9kh0oE/ZZiMLN+wDhqxDSL
         KPkcYIenLsSYDxIBSFviDy3D/XVNjQy2qfLIA1l9xynnKtjhpgWaR2c5rsy8l5G5KNyS
         p7I5BrLnfLs79hxt3kCho7h2+eOsWvH9X9gUg/bWWh7n7sN2MDnwI6WfZBrMBCajRyIC
         oCUp+L5n0H4OSHQ6DPGzhHHXNcFzSF7WeNhw7ztM6k8rzRD9qIKNU4JhfOA+dkMGuURK
         HkZzGeghsF1yeqnMN7pHmNVr7cZYRe/pkVaH12TMLNBoSO/Tfsqk2znixFwyE1jm9ZzN
         zo2A==
X-Gm-Message-State: AOJu0Yz2do7ZJQ9QnPQi8u6tDvfSeIfmJwfevfgr6Z4MpV1ueU69nQup
	5vc9rp+sN99/t6E1q7TWLys9c17zG24BO/c+c+thyp19QsjUDRy80akLBiFjEg==
X-Gm-Gg: ASbGncuW6n+klbO6WEAQRI9uhmXHXNfVsW9BWpf0ideJ1rQPm5dXdhA30VQLSKup44g
	B5usiDDU9EBMRMVzeQNADMcK5c1blayFttYHGbbk+fb7gLQTaDs96CkkhLFR5Ys8VleIVcGAkVu
	EE9uFng/wuBGXukDkOGSHCa7HCV4DSxdFkcMp2ydEBfZ55RexDR3m4zza/pJHlCDRoofDcTL8Ms
	ODKJeKcWM1OCuGyyOkIz0mvRfhJFp+mtGxkgf34dmuC0C+QPaKFlXfwNhkNnG21XtGu0mC+lW1x
	r1LVdvsz5MKJ9zB48gWHfHa3QopFELDCieFsIyR6Fcqd/PORBBRUfnaIWC07vKkdJaRyqVcY7JF
	iIOSkdUPgVgjUw/4kx48fbV6/eQAcoeTu4hkdEq0=
X-Google-Smtp-Source: AGHT+IE9oCJsGnmY9T+E4yxEvdtzmF+NJJLCpWjuNEKwjGiDOHhNLyWaalWt29xuZEd6qRK0/hjfYw==
X-Received: by 2002:a05:6000:2407:b0:3a4:d924:e65e with SMTP id ffacd0b85a97d-3a4f89df89bmr12431241f8f.59.1748931249105;
        Mon, 02 Jun 2025 23:14:09 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451df07ac73sm48674175e9.9.2025.06.02.23.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 23:14:08 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4] btrfs: zoned: reserve data_reloc block group on mount
Date: Tue,  3 Jun 2025 08:14:01 +0200
Message-ID: <20250603061401.217412-1-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
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
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
Changes to v3:
- Use jump label to only have search loop once (Filipe)

 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/zoned.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  3 +++
 3 files changed, 65 insertions(+)

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
index 19710634d63f..a31aa129cb0f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2443,6 +2444,66 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->relocation_bg_lock);
 }
 
+void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
+	struct btrfs_space_info *space_info = data_sinfo->sub_group[0];
+	struct btrfs_trans_handle *trans;
+	struct btrfs_block_group *bg;
+	struct list_head *bg_list;
+	u64 alloc_flags;
+	bool initial = false;
+	bool did_chunk_alloc = false;
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
+	bg_list = &data_sinfo->block_groups[index];
+again:
+	list_for_each_entry(bg, bg_list, list) {
+		if (bg->used > 0)
+			continue;
+
+		if (!initial) {
+			initial = true;
+			continue;
+		}
+
+		fs_info->data_reloc_bg = bg->start;
+		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &bg->runtime_flags);
+		btrfs_zone_activate(bg);
+
+		return;
+	}
+
+	if (did_chunk_alloc)
+		return;
+
+	trans = btrfs_join_transaction(fs_info->tree_root);
+	if (IS_ERR(trans))
+		return;
+
+	ret = btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
+	btrfs_end_transaction(trans);
+	if (ret == 1) {
+		did_chunk_alloc = true;
+		bg_list = &space_info->block_groups[index];
+		goto again;
+	}
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


