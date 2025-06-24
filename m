Return-Path: <linux-btrfs+bounces-14904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0ECAE60F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 11:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA454A3CB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81F27C84B;
	Tue, 24 Jun 2025 09:37:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6B27AC3C
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757844; cv=none; b=T3edQ1v1qkxzRXf0vfcNl70F9lN5fX95rOzz/CzuujDXMG1tpLSnwreLWbL+ZOARr3EZDGT3r+LOGdCDIq41ZSdzkQFpPvUbO/hbDP/cUG2Fbu0SEQJQ0KHAKssqq5rOOfdnfgQlg/zh0cPAUpTMgK8f5FlhZbU1jftYpS64uDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757844; c=relaxed/simple;
	bh=g2BrAMna37TxR11hClsx23veEVoqBN3fcLsN7zVvAbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh7eHxBxplzPGuvtoLdYgyV4mB1/xiKVOm55GUpHqhXUhz4jpOWFR+Ln4dVaNbYxNtbpLY3MfCE8E7qs5Lu8JsxJkdka+FXrTSfbOpqXQlXzGd5PNqSFOcrYiPyahhBe8YzLwbfxwiJM4+yWJXcGItIDvr2Zf/YeEBA6x/LNMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso2272585e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 02:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750757841; x=1751362641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERq8rX2jRk30v15GCAcGhh3EDCmnC1wyftATXJwfIT0=;
        b=WFXyqeNZwjTCHTZ4Nv8+PAYVo5+pEP3kZFBK6Eki7gI1E+/UivWIEGPKupsVyMk0hT
         GekGMNfji4pj51lfBUfZw6sC9Jazmkog8WoYUcKkuJprDRlSLGxldTaW71pQf5q3M55P
         QHLTZAU4Ht9Jsm5XP704pMqfQRcEXa5vG7NaS4kCjLqYOobn0vf1etiRg/ZKmUQVduIt
         4cNajsMuxUMd89HrKTFcjSW+GFoTBjYx0o3LOOzgNKl3HWUJjRD0c3o1KZyckgT0g+RX
         9hUmQq8xEC3yTFIVITiFnFVNS10DfwtAkLzR+5lNAIC9K4Avk0xFFlRQfwm2KH8a9rKe
         zfeQ==
X-Gm-Message-State: AOJu0Ywggy/xmg0p4Zf5yUr4z1VKhtFGwhJSrLkmimbhSFqrvpGZSQ8a
	dSHouP6ihnASs13W2ncC4K38n4xqZHfZI7jv/kcQjuIf359SQgt8s+td9CwPd02+
X-Gm-Gg: ASbGnctxK/mYwdtGLjYWyw+HlB+yxbO8oGvIBwnYulPlRLrMC5+etvI8evLSnEWzzYt
	j2lwizxfUWfUMvyHBy3CdNMoAPQNO9FBkcNJ1euPZu/ZKpvAPjgFAR1K9O+v7PVsT4gBBwAOia6
	HqWwGstrCXguYizbxAXZpoUhiZNusTrPxjlLxrn4237CohXKzp8URco4g03usZhxARz7hn9mCIq
	JM7Q/EzyElxZibwDBC52a5hWLr2QOiRmdjvkwHuDUgjePU12IKUC0bAafi3QUAvrPEanfY7G8fk
	5qMhxecUWevViDok9P3FybsD3+nnlFEvC2cDzSvUasNAjg7RAUb05Cl6SNHuoKGFoje3oubom5A
	7zK62X1aYO4TrqAgDJlF9u3orAFtyHsFlqGsm64obwrL1e/5aBw==
X-Google-Smtp-Source: AGHT+IE+OsTstWS5TDYwi5qgQGN95ux+aaM70mZ7ZL/O9q+Bz9X78bPpHqY6t7lYdq8y23wWS6pkvQ==
X-Received: by 2002:a05:600c:1da0:b0:451:833f:483c with SMTP id 5b1f17b1804b1-453653d4544mr140403055e9.7.1750757840703;
        Tue, 24 Jun 2025 02:37:20 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453769da7f6sm54880745e9.40.2025.06.24.02.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 02:37:20 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/3] btrfs: zoned: get rid of relocation_bg_lock
Date: Tue, 24 Jun 2025 11:37:08 +0200
Message-ID: <20250624093710.18685-2-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624093710.18685-1-jth@kernel.org>
References: <20250624093710.18685-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Lockstat analysis of benchmark workloads shows a very high contention on
relocation_bg_lock. But the lock only protects a single field in
'struct btrfs_fs_info', namely 'u64 data_reloc_bg'.

Use READ_ONCE()/WRITE_ONCE() to access 'btrfs_fs_info::data_reloc_bg'.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c     |  1 -
 fs/btrfs/extent-tree.c | 34 ++++++++++++----------------------
 fs/btrfs/fs.h          |  6 +-----
 fs/btrfs/zoned.c       | 10 ++++------
 4 files changed, 17 insertions(+), 34 deletions(-)

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
index 10f50c725313..80ceca89a9ef 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3842,7 +3842,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	u64 avail;
 	u64 bytenr = block_group->start;
 	u64 log_bytenr;
-	u64 data_reloc_bytenr;
 	int ret = 0;
 	bool skip = false;
 
@@ -3865,14 +3864,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 * Do not allow non-relocation blocks in the dedicated relocation block
 	 * group, and vice versa.
 	 */
-	spin_lock(&fs_info->relocation_bg_lock);
-	data_reloc_bytenr = fs_info->data_reloc_bg;
-	if (data_reloc_bytenr &&
-	    ((ffe_ctl->for_data_reloc && bytenr != data_reloc_bytenr) ||
-	     (!ffe_ctl->for_data_reloc && bytenr == data_reloc_bytenr)))
-		skip = true;
-	spin_unlock(&fs_info->relocation_bg_lock);
-	if (skip)
+	if (READ_ONCE(fs_info->data_reloc_bg) &&
+	    ((ffe_ctl->for_data_reloc && bytenr != READ_ONCE(fs_info->data_reloc_bg)) ||
+	     (!ffe_ctl->for_data_reloc && bytenr == READ_ONCE(fs_info->data_reloc_bg))))
 		return 1;
 
 	/* Check RO and no space case before trying to activate it */
@@ -3899,7 +3893,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	spin_lock(&fs_info->treelog_bg_lock);
-	spin_lock(&fs_info->relocation_bg_lock);
 
 	if (ret)
 		goto out;
@@ -3908,8 +3901,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	       block_group->start == fs_info->treelog_bg ||
 	       fs_info->treelog_bg == 0);
 	ASSERT(!ffe_ctl->for_data_reloc ||
-	       block_group->start == fs_info->data_reloc_bg ||
-	       fs_info->data_reloc_bg == 0);
+	       block_group->start == READ_ONCE(fs_info->data_reloc_bg) ||
+	       READ_ONCE(fs_info->data_reloc_bg) == 0);
 
 	if (block_group->ro ||
 	    (!ffe_ctl->for_data_reloc &&
@@ -3932,7 +3925,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 * Do not allow currently used block group to be the data relocation
 	 * dedicated block group.
 	 */
-	if (ffe_ctl->for_data_reloc && !fs_info->data_reloc_bg &&
+	if (ffe_ctl->for_data_reloc && READ_ONCE(fs_info->data_reloc_bg) == 0 &&
 	    (block_group->used || block_group->reserved)) {
 		ret = 1;
 		goto out;
@@ -3957,8 +3950,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		fs_info->treelog_bg = block_group->start;
 
 	if (ffe_ctl->for_data_reloc) {
-		if (!fs_info->data_reloc_bg)
-			fs_info->data_reloc_bg = block_group->start;
+		if (READ_ONCE(fs_info->data_reloc_bg) == 0)
+			WRITE_ONCE(fs_info->data_reloc_bg, block_group->start);
 		/*
 		 * Do not allow allocations from this block group, unless it is
 		 * for data relocation. Compared to increasing the ->ro, setting
@@ -3994,8 +3987,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (ret && ffe_ctl->for_treelog)
 		fs_info->treelog_bg = 0;
 	if (ret && ffe_ctl->for_data_reloc)
-		fs_info->data_reloc_bg = 0;
-	spin_unlock(&fs_info->relocation_bg_lock);
+		WRITE_ONCE(fs_info->data_reloc_bg, 0);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
@@ -4303,11 +4295,9 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
 		if (fs_info->treelog_bg)
 			ffe_ctl->hint_byte = fs_info->treelog_bg;
 		spin_unlock(&fs_info->treelog_bg_lock);
-	} else if (ffe_ctl->for_data_reloc) {
-		spin_lock(&fs_info->relocation_bg_lock);
-		if (fs_info->data_reloc_bg)
-			ffe_ctl->hint_byte = fs_info->data_reloc_bg;
-		spin_unlock(&fs_info->relocation_bg_lock);
+	} else if (ffe_ctl->for_data_reloc &&
+		   READ_ONCE(fs_info->data_reloc_bg)) {
+			ffe_ctl->hint_byte = READ_ONCE(fs_info->data_reloc_bg);
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
index bd987c90a05c..421afdb6eb39 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2496,10 +2496,8 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
-	spin_lock(&fs_info->relocation_bg_lock);
-	if (fs_info->data_reloc_bg == bg->start)
-		fs_info->data_reloc_bg = 0;
-	spin_unlock(&fs_info->relocation_bg_lock);
+	if (READ_ONCE(fs_info->data_reloc_bg) == bg->start)
+		WRITE_ONCE(fs_info->data_reloc_bg, 0);
 }
 
 void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
@@ -2518,7 +2516,7 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 	if (!btrfs_is_zoned(fs_info))
 		return;
 
-	if (fs_info->data_reloc_bg)
+	if (READ_ONCE(fs_info->data_reloc_bg))
 		return;
 
 	if (sb_rdonly(fs_info->sb))
@@ -2539,7 +2537,7 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 			continue;
 		}
 
-		fs_info->data_reloc_bg = bg->start;
+		WRITE_ONCE(fs_info->data_reloc_bg, bg->start);
 		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &bg->runtime_flags);
 		btrfs_zone_activate(bg);
 
-- 
2.49.0


