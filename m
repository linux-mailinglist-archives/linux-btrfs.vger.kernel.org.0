Return-Path: <linux-btrfs+bounces-14446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7AACDA32
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 10:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF5D3A382F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB60280318;
	Wed,  4 Jun 2025 08:46:42 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109B1DE884
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026801; cv=none; b=SDnV+Nyh7FZn602z95aeQZxzj5jmJrNuTKSqu5ot353S6UrNiqyCsi15VNJ71y0Jv17hbfhyYu+tBAjRNLNoI5oJNs4Rm3HeRCFtqm7CSkmDlcJ/T+50gsZGzEfzFhu2OmlDbB0k6Gzs69AUJnNmNz6OdPvqQID7nXpjSISf6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026801; c=relaxed/simple;
	bh=/3+Tn+GWduZA+n6xaFDrNrvvJ+0oIQOI2EHT6/diSm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQ73I0zCkX8LhgLAhz7ZuXAWexQl7bNzDQXlL4GraNTuZEU39jVaG/Qoqz8Y2pW8/DRXIy9b3iWUkwlhCk5wK1HZL1X7YG+RcOXZpQkc0bCkCoRcfo2TmKerVcOQucikzD9KjoifMkf3aAU8LVLTy8vi5Q8Y5tHsK93fT2wMw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cea01b9cso26404945e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jun 2025 01:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749026798; x=1749631598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDUjbaEAtU29HIzFKl3m+CsFvWPiPLjaWt4XwzVcxU4=;
        b=FHPgm0tbk71nvjC34fQaEfGfgOXueSGGkLFZHIufoHZCNUE706By0/JBifKADDJ9we
         Dns2QZ8uK9DEDIp4AimM1X8BXT0iomJlZkW8pm34Obma0c5GSRzEXVaUK9CLQpAY4TXX
         KU5NLPp2lUjqwyXB4bb1D9S2+ZnvR5YaUtdXSbwW2xpjimQ5uNqSHlLyv592nZyk/reV
         IrQpQ33e5JVwXGkjGUqGZ/X3w7urLY4EdiPns7Ks6i2Y1hLQRe8ZeRmyQUv4vt/ttm8H
         pfd7gC44KyQd1FtIspaYZDI/+xQkC4IdzD0gUtXYbjmLWVf6EmRV6i+QZ50bHC9rEAPg
         5y4w==
X-Gm-Message-State: AOJu0YxY3j9jU9zM84u/8D0dZ3pb67oyvCzsKWdMbnaTvZZNxLoxSunM
	RI/NL0FxAAsdzbWjqg4p1TkJJlBZFhuRXso7feKLorvZs/ntX+G3gE5uLctZ1A==
X-Gm-Gg: ASbGncsJ5nWStP6vcgPYoZ9Bh4ZTCyR2tG+lv5qVeKKmbHGLPUGHRh18RfLK+eukhkz
	191FvZKiHg+xl6IIp0nvHO6ERwoa3S1vsqppLZP/6Z1rHdhCQS2WTz8UurDEE3wYf9Di6lLI5Zt
	iDjXPV99sf6DCRPpUoQkyI1QfDpqvYMHF8lTrIuHHTLzK1ZG8FSmwILnrQsEGbvtcckkymLOv2y
	FUG2AmnWSSiw788+/wmLBH7yVZ5rzZcFAkEjAOt7xVQyuS3gG5ecI8i64E3PEbeu/fajCQY991I
	VfFXmC3X+x/UgRPA7nk284MahXWCPa6GZ/m9iBULvsEJBOYbuPUdjS3V5X7AUqiYxoQDDTKGVOb
	xvtcLB4iiQSeP2iQo/CL7mofeaMFb4pAYwkupl7hJjy0fwehTkQ==
X-Google-Smtp-Source: AGHT+IEWOEpLPRfrTXqEpPihqzbXASwMmuILwJfMPMzd2sJTSKiI/n1GwZ53YqC37mrsxAdGWZdyag==
X-Received: by 2002:a05:600c:3b0f:b0:450:cd25:e68f with SMTP id 5b1f17b1804b1-451f0b270a2mr14132555e9.27.1749026797804;
        Wed, 04 Jun 2025 01:46:37 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe2b35dsm20809507f8f.0.2025.06.04.01.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:46:37 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5] btrfs: zoned: reserve data_reloc block group on mount
Date: Wed,  4 Jun 2025 10:46:30 +0200
Message-ID: <20250604084630.346863-1-jth@kernel.org>
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
---
Changes to v4:
- Use btrfs_commit_transaction() instead of btrfs_end_transaction

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
index 19710634d63f..4e122d6c19c0 100644
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
+	btrfs_commit_transaction(trans);
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


