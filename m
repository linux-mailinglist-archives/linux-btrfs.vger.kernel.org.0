Return-Path: <linux-btrfs+bounces-15023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DDEAEB2AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C593BF011
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31EC298CA6;
	Fri, 27 Jun 2025 09:19:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C22989A7
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015969; cv=none; b=P8firQJQkUNeOo6uGBOw0gyqJkTfJhPAAIizNO7fu1cZLkKdn2zDHxThB3+uKY5k2eoueRYo9vN2WTNwPevYejlZE0OdkG4zYzNmzc01Bh+8fk4tzeKvrYzv79PP7nz4rWIwKWxDJ7KhVFvLboDzB7WY3j2yagUVXPJQzA+iF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015969; c=relaxed/simple;
	bh=FsmjBLYLoG8uwznZoXgFFfMiNQHE+5LDMelV0h+w+s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsNJ6dakm3nGblsCNwD16mM2WthbqVf90PBWgwKgpxnnNXT3MMqDsSVVrlCEkMPdJIvXUnn7TcMq4U1Ej4Bmyr8ox7V1j2Ebvi+hKT9A8oB0+zT0LJNizN74Z1D6oXqexfD2cTAgv7BtO9dyVDkc05fsMGh4DjVr7qd81muUbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so10381235e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015966; x=1751620766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lukUz9BAsZi+HK/jffJCacr8A+S55LWP0hlQe8vZ048=;
        b=CL2Gh6dUlz6ym4zfEaQMt3qhpTrr5s7nbihpMn/eHZDAIJ79XtWV6RVmD1BJdJiMVr
         R/DPKBHe/Tj4LB3/4Tj//Q0bnU1gkvsWqhPhLtFpL8jC3xiirbnT0nO2kBYKooyXUbmq
         Bdxy77ruX+sUyPulXpw98XhgYe2BjxJCtdgtMw/8eUPnfqrposyRJS8ez5z76Wn6X0ox
         hs9+8mtHDmZSg4VK8K3C7VMFM0WMQGBUdX8Xi35SMliELGov7zrtgYIYmAjLFJVExM6a
         X5zO4QTBSZcbvec8b38NehOabUtnfbUriecvAcQB5LH7J8AQHbZBhrSomtWjc0jGzsfL
         HAuQ==
X-Gm-Message-State: AOJu0YxBpGc5gWDdHwlxdygWlHFZTdndv4IHdOHOqI1SsYhJjFjCaeSL
	hnfvfsPKgYqITA6qsVcVS6maZYLdgemC7LJ45vVf59Npn5p+6Xh8YflhPPDEzg==
X-Gm-Gg: ASbGncvVRXhlhbRLtbeOzHt93B7QgRZrNvwz7H7/kgpoc3pndkQadKO2OK1NDIQMb7J
	fiePkvBMGCTexftHsj2+qCFUCokoWpHMWvqUm2VEO32HWn/gr5NsF24R6eGZTBZiGHOHA7DVjqU
	9y6D454c9OpbEr/Vk/AzeOEMdLpv7PqyBOqHC6a6TX0Vcy6/swkjHO0ACQnXb4mJAThFKPB59s5
	UU0KunnbOP1SO0wE5FbCT7mjymMFoQRuVogSPyToF51LDRM8yV6uE4Vlt4tET3Rzqk6GHVTWuf9
	sr1DV0SU1XznEgH50KMBpNDOBTKcFvVmFu11FOetyzC0QicgRbJkh5E8ipvdZH3mB7tpiNhowSW
	paVt37wPMJg6rAXQebpyvWksSTKmDHXrGRfVkT5B4qtW7dG//OZbUeD8KBLM=
X-Google-Smtp-Source: AGHT+IEcGbFtluHsAv4VAUzML5XOQBXxLPM6R2vlMKZTzI4bQSbl0O2iUW9Vic9RNQS61ChJPHfHvA==
X-Received: by 2002:a05:600c:1c10:b0:453:8a62:df34 with SMTP id 5b1f17b1804b1-4538ee7deb4mr22786425e9.21.1751015965257;
        Fri, 27 Jun 2025 02:19:25 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f719b2005a9e6e27159b0eb3.dip0.t-ipconnect.de. [2003:f6:f719:b200:5a9e:6e27:159b:eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm2152556f8f.72.2025.06.27.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:19:24 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 2/9] btrfs: zoned: get rid of relocation_bg_lock
Date: Fri, 27 Jun 2025 11:19:07 +0200
Message-ID: <20250627091914.100715-3-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627091914.100715-1-jth@kernel.org>
References: <20250627091914.100715-1-jth@kernel.org>
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

This is safe in the allocator path, as relocation I/O is only going to
block groups in the relocation sub-space_info and at the moment, there is
only one relocation block group in this space info.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c     |  1 -
 fs/btrfs/extent-tree.c | 28 +++++++++++-----------------
 fs/btrfs/fs.h          |  6 +-----
 fs/btrfs/zoned.c       | 11 +++++------
 4 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6ac5be02dce7..9a13f5b1ed43 100644
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
index 0d5d6db72b62..388c277a84d3 100644
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


