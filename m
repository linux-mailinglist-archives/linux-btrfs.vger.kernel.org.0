Return-Path: <linux-btrfs+bounces-14877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF15AE4B7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 18:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B511177DFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1287029B8F5;
	Mon, 23 Jun 2025 16:56:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241F29B799
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697804; cv=none; b=RqXsxxxuRpPYNi+YXfQKrM3c7N7TOa1+5vWSy6Bua6jlaDZORedAjxPGb44IdzoEZLkVu7Ad4VpuPkYoNutNAvZxMrmS3z2QnWIfEyrS5ESwu4WiajxSbTIXslT15FCTWUAWO+kuR2UeqSPLyztOT+3NqEKalYYbCTLBQtrCOE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697804; c=relaxed/simple;
	bh=CURJHDGYPQTlzr6oSsPpQFvsoEBUHRqH9CJeMO3cxc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7AF/JQSU9QX58PFnDCFJ0ugEsucqptma2A103Rubepw4qj2qsdTq9s+kS6WbMPTpRwk/2Lrfk1n4cDb1u+FYvdKI+L6PapaYPKuXPEjTBZ6CILf+wNQpKjOFeajZkhs4EU0WW2pUDQXaYbvy+T2/x8WLI2Q6bZ0gX1HNLE5sm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso3886810f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 09:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750697801; x=1751302601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb0Mm8x8JaJ+vFn76wBMXI9xWUQfUCQ5bIg3P4k66J4=;
        b=dHH3mapoJ8DVq1TRU2X5uT02DBWF3ygXq4nXRA9WErJEuLOal4djY8sHwqReseFrko
         v0YGr2oWsmfwcoZRAZ1uzq/Fov4IWge4HvJJfYJMBpF3HKGjZWSYX8VUF+bKcFfiGq7B
         xv82RAhhOL5wxcVO6m6d0+zwHCbLYtyJC3/+uUMmrNk2SwkF8W+nUiu5rDMcSiuVpWES
         WjTPETMaZpz1nFyh5n8s4Qv40gLnbSnmtOG6jkVdmb7OL/02kOtNEJxZjWGqENHXsH8I
         RiNK1mceOgfc/hTqcSlIckKSbeuzEQ1QzTcZMezsZRsot1Hkcb+SzFL6rwOHLEnOuj3t
         cThw==
X-Gm-Message-State: AOJu0YxvYm3uvQmIPKPRzgziPdarP7+HTXF5p+HTwZbHLANiJH0jf+LS
	MWqBh4XQVAY1RMSZBudJ9XTlpqE53HMl3VOYdI6fkrThqh+VfwG9eULkxmcUGkzX
X-Gm-Gg: ASbGncuYkZUXasDXTTnSKpeyu6CRO7ya8VhCort86VSOHd84ZK+/I/pULq9R+3fuS72
	u1IGvMB6zsauS/1zLfwwGfgoXNKldkYi4KJ/QUBIAt71rfI7+Rqe+atkPLyEFntnqTbTs7ewL2X
	YPHvhJQfZr45gAEiK5ryZcUvQC3jy/ihWedViLmn8xuTHy8zQDfInOuVfX0SYsVwlzO6CZ1Az3L
	bb1E+qXFh+5hD6qxJqx7cEcuWCxL8FGR/TNVohMUWWl9PlsCP2u+0PanjEX9Lbkco1Ak1voTcat
	9BhUapXnCBBjMcKL7mace4d5Lfx4Q0UxZ/A7P6YWss1t6c2w1RkL6o9gbSYD+P2Hxv2I/onTH7M
	slYwHut4wUn0oOnt2H4gecjGetc+PnXpIuaAIHdfKFGOsa2NAyh49Nd37Qxle
X-Google-Smtp-Source: AGHT+IEnLQ5wIo8mRdPmxw0suE9lQ7dwtSjiPeS+wacAqXLC27AM47Q4sZlMu1AFxs2kwdV8ydkf9w==
X-Received: by 2002:a05:6000:2c12:b0:3a4:deb9:8964 with SMTP id ffacd0b85a97d-3a6d12c2649mr10936828f8f.17.1750697800978;
        Mon, 23 Jun 2025 09:56:40 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d118a1f2sm9713888f8f.83.2025.06.23.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:56:40 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/3] btrfs: zoned: get rid of relocation_bg_lock
Date: Mon, 23 Jun 2025 18:56:27 +0200
Message-ID: <20250623165629.316213-2-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623165629.316213-1-jth@kernel.org>
References: <20250623165629.316213-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Lockstat analysis of benchmark workloads shows a very high contention of
the relocation_bg_lock. But the relocation_bg_lock only protects a single
field in 'struct btrfs_fs_info', namely 'u64 data_reloc_bg'.

Use READ_ONCE()/WRITE_ONCE() to access 'btrfs_fs_info::data_reloc_bg'.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c     |  1 -
 fs/btrfs/extent-tree.c | 28 +++++++++++-----------------
 fs/btrfs/fs.h          |  6 +-----
 fs/btrfs/zoned.c       | 11 +++++------
 4 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ee3cdd7035cc..24896322376d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2791,7 +2791,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->unused_bgs_lock);
 	spin_lock_init(&fs_info->treelog_bg_lock);
 	spin_lock_init(&fs_info->zone_active_bgs_lock);
-	spin_lock_init(&fs_info->relocation_bg_lock);
 	rwlock_init(&fs_info->tree_mod_log_lock);
 	rwlock_init(&fs_info->global_root_lock);
 	mutex_init(&fs_info->unused_bg_unpin_mutex);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 10f50c725313..a9bda68a1883 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3865,14 +3865,10 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 * Do not allow non-relocation blocks in the dedicated relocation block
 	 * group, and vice versa.
 	 */
-	spin_lock(&fs_info->relocation_bg_lock);
-	data_reloc_bytenr = fs_info->data_reloc_bg;
+	data_reloc_bytenr = READ_ONCE(fs_info->data_reloc_bg);
 	if (data_reloc_bytenr &&
 	    ((ffe_ctl->for_data_reloc && bytenr != data_reloc_bytenr) ||
 	     (!ffe_ctl->for_data_reloc && bytenr == data_reloc_bytenr)))
-		skip = true;
-	spin_unlock(&fs_info->relocation_bg_lock);
-	if (skip)
 		return 1;
 
 	/* Check RO and no space case before trying to activate it */
@@ -3899,7 +3895,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	spin_lock(&fs_info->treelog_bg_lock);
-	spin_lock(&fs_info->relocation_bg_lock);
 
 	if (ret)
 		goto out;
@@ -3908,8 +3903,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	       block_group->start == fs_info->treelog_bg ||
 	       fs_info->treelog_bg == 0);
 	ASSERT(!ffe_ctl->for_data_reloc ||
-	       block_group->start == fs_info->data_reloc_bg ||
-	       fs_info->data_reloc_bg == 0);
+	       block_group->start == data_reloc_bytenr ||
+	       data_reloc_bytenr == 0);
 
 	if (block_group->ro ||
 	    (!ffe_ctl->for_data_reloc &&
@@ -3932,7 +3927,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 * Do not allow currently used block group to be the data relocation
 	 * dedicated block group.
 	 */
-	if (ffe_ctl->for_data_reloc && !fs_info->data_reloc_bg &&
+	if (ffe_ctl->for_data_reloc && data_reloc_bytenr == 0 &&
 	    (block_group->used || block_group->reserved)) {
 		ret = 1;
 		goto out;
@@ -3957,8 +3952,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		fs_info->treelog_bg = block_group->start;
 
 	if (ffe_ctl->for_data_reloc) {
-		if (!fs_info->data_reloc_bg)
-			fs_info->data_reloc_bg = block_group->start;
+		if (READ_ONCE(fs_info->data_reloc_bg) == 0)
+			WRITE_ONCE(fs_info->data_reloc_bg, block_group->start);
 		/*
 		 * Do not allow allocations from this block group, unless it is
 		 * for data relocation. Compared to increasing the ->ro, setting
@@ -3994,8 +3989,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (ret && ffe_ctl->for_treelog)
 		fs_info->treelog_bg = 0;
 	if (ret && ffe_ctl->for_data_reloc)
-		fs_info->data_reloc_bg = 0;
-	spin_unlock(&fs_info->relocation_bg_lock);
+		WRITE_ONCE(fs_info->data_reloc_bg, 0);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
@@ -4304,10 +4298,10 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
 			ffe_ctl->hint_byte = fs_info->treelog_bg;
 		spin_unlock(&fs_info->treelog_bg_lock);
 	} else if (ffe_ctl->for_data_reloc) {
-		spin_lock(&fs_info->relocation_bg_lock);
-		if (fs_info->data_reloc_bg)
-			ffe_ctl->hint_byte = fs_info->data_reloc_bg;
-		spin_unlock(&fs_info->relocation_bg_lock);
+		u64 data_reloc_bg = READ_ONCE(fs_info->data_reloc_bg);
+
+		if (data_reloc_bg)
+			ffe_ctl->hint_byte = data_reloc_bg;
 	} else if (ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA) {
 		struct btrfs_block_group *block_group;
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b239e4b8421c..570f4b85096c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -849,11 +849,7 @@ struct btrfs_fs_info {
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
 
-	/*
-	 * Start of the dedicated data relocation block group, protected by
-	 * relocation_bg_lock.
-	 */
-	spinlock_t relocation_bg_lock;
+	/* Start of the dedicated data relocation block group */
 	u64 data_reloc_bg;
 	struct mutex zoned_data_reloc_io_lock;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a4a309050b67..f58bd85ddf5a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2495,11 +2495,10 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
+	u64 data_reloc_bg = READ_ONCE(fs_info->data_reloc_bg);
 
-	spin_lock(&fs_info->relocation_bg_lock);
-	if (fs_info->data_reloc_bg == bg->start)
-		fs_info->data_reloc_bg = 0;
-	spin_unlock(&fs_info->relocation_bg_lock);
+	if (data_reloc_bg == bg->start)
+		WRITE_ONCE(fs_info->data_reloc_bg, 0);
 }
 
 void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
@@ -2518,7 +2517,7 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 	if (!btrfs_is_zoned(fs_info))
 		return;
 
-	if (fs_info->data_reloc_bg)
+	if (READ_ONCE(fs_info->data_reloc_bg))
 		return;
 
 	if (sb_rdonly(fs_info->sb))
@@ -2539,7 +2538,7 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 			continue;
 		}
 
-		fs_info->data_reloc_bg = bg->start;
+		WRITE_ONCE(fs_info->data_reloc_bg, bg->start);
 		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &bg->runtime_flags);
 		btrfs_zone_activate(bg);
 
-- 
2.49.0


