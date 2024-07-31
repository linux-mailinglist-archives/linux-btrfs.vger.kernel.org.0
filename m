Return-Path: <linux-btrfs+bounces-6924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC2C943747
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 22:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3915B1F22C9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A377F16CD16;
	Wed, 31 Jul 2024 20:43:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC361684A7;
	Wed, 31 Jul 2024 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458609; cv=none; b=kFJL0RObDVyu7j0U//OHzSCJJh88SkVApUFKKaE+7OH0L27P5H4TvLgqzeh1acQVZ6PI4VVa4xqIY4NCyUO0Sde/YJM5KcEg0xL+MDhrpbvKTE9S1FlG5oFgjDZsrVA2Q9+tBAhYaZUkLztb6ar2z9djR/I++4aNbg+ht2mI1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458609; c=relaxed/simple;
	bh=7TbeDsKXJvGad5Ts6keLBQjavxJq1zeKUjYg/JJnKCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ug2sdeR0kWa9i7zxeBYzpheiq6shLY6eGN2uXpkhTTH39po0u2O6OACREglt0l6QSc47mdLdtQEx+ZxQILkAVqteJjO7TJbP3AVRW9LBOHIGU3mdAm2uwiUZ1WF5x1yKNEYbPdOGP7a2059fZXlJoZfrLmbox6RXKQk7uO4rArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so717369166b.1;
        Wed, 31 Jul 2024 13:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458606; x=1723063406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT7oFTQ6Sowbdm+xO/cDuLRyJLq8hSrrkBPbaTkA1sw=;
        b=sAEkHZQEJQxvLC2Xnguj/Y788T0aRkpnc8JzuD6KKRz33uz2jh5gpVCjPJJZd0W2sg
         K7tlKbasXKL94Owqji8YCfO3vgzM+b7G9+xguO83mH/X+jxzZLv6MX51dP8TYMimAihL
         fMACXgzD0462ZnzbmynjP0VppwxNsSRG0EyALhseNuUjD1gKrKMts1+sKvCQpbXXK/ql
         MfMWrUKK2zLflqgHp2G/TcmIPUAOAlbw9QIOPL3/nDhBZIaResKLw/hrOX3bv4wY7X0U
         xh1GUFjQsQxgnkbAFFVtJCTF4Pgvc9ClbgBFSxibzAKFEO6lwykPo6LJFd/rYzLS7FCp
         QMQA==
X-Forwarded-Encrypted: i=1; AJvYcCVbi146WATKN0NkhsvT80g38jSni7Nysun6NQfiH7iWsTfqwmTH4Txl428SeEWBHvXgyAVZIyrQn23cjdaE+qWi+9LSPHy7YI/Nl/Dd
X-Gm-Message-State: AOJu0Yx3UbY0m+GetQTtTkpwMi3RYXTWJ2ui4NXl491HDdJgPKdogc1c
	ZRMEMABqR6rWUAuVCkoBg6dubJu64Xs5pnBjmsQBjyaL5l65eFcDC5I6eA==
X-Google-Smtp-Source: AGHT+IEnQmfLkPGszSqIjOVisoimKTIcDY8APejDKb0Kng18XAPyL4uv9Tvt90G6s13an3c4b6MhCg==
X-Received: by 2002:a17:907:160d:b0:a77:dcda:1fe1 with SMTP id a640c23a62f3a-a7daf53a34cmr19519566b.25.1722458605409;
        Wed, 31 Jul 2024 13:43:25 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4dec6sm807454366b.61.2024.07.31.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:43:25 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 31 Jul 2024 22:43:04 +0200
Subject: [PATCH v3 2/5] btrfs: rename btrfs_io_stripe::is_scrub to
 rst_search_commit_root
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-debug-v3-2-f9b7ed479b10@kernel.org>
References: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
In-Reply-To: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2887; i=jth@kernel.org;
 h=from:subject:message-id; bh=7mQ8HznYTYuuf96GOY5iEqVDono4DkJl7eM5YKDGOx4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaStWvhyukQoo0mFTzvH1LYLLDpL3u06amTcbpjKasmZM
 2nye2HNjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZjIfnmGv7Jb2cItPiczzzg0
 8RJvzCqnW1IpEzvYl5mJSJ1tlv2/WJWR4drVefMmq0ZKfmed77bf7uWd7S0+K4/N8PTxqNs71+J
 MKzsA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Rename 'btrfs_io_stripe::is_scrub' to 'rst_search_commit_root'. While
'is_scrub' describes the state of the io_stripe (it is a stripe submitted
by scrub) it does not describe the purpose, namely looking at the commit
root when searching RAID stripe-tree entries.

Renaming the stripe to rst_search_commit_root describes this purpose.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c              | 2 +-
 fs/btrfs/raid-stripe-tree.c | 4 ++--
 fs/btrfs/scrub.c            | 2 +-
 fs/btrfs/volumes.h          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index f04d93109960..dfb32f7d3fc2 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -679,7 +679,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	blk_status_t ret;
 	int error;
 
-	smap.is_scrub = !bbio->inode;
+	smap.rst_search_commit_root = !bbio->inode;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index c1c74f310e8b..28a545367be7 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -210,7 +210,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	if (!path)
 		return -ENOMEM;
 
-	if (stripe->is_scrub) {
+	if (stripe->rst_search_commit_root) {
 		path->skip_locking = 1;
 		path->search_commit_root = 1;
 	}
@@ -283,7 +283,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 out:
 	if (ret > 0)
 		ret = -ENOENT;
-	if (ret && ret != -EIO && !stripe->is_scrub) {
+	if (ret && ret != -EIO && !stripe->rst_search_commit_root) {
 		btrfs_err(fs_info,
 		"cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
 			  logical, logical + *length, stripe->dev->devid,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0de9162ff481..b3afa6365823 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1694,7 +1694,7 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					    (i << fs_info->sectorsize_bits);
 			int err;
 
-			io_stripe.is_scrub = true;
+			io_stripe.rst_search_commit_root = true;
 			stripe_len = (nr_sectors - i) << fs_info->sectorsize_bits;
 			/*
 			 * For RST cases, we need to manually split the bbio to
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c947187539dd..03d2d60afe0c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -444,7 +444,7 @@ struct btrfs_io_stripe {
 	/* Block mapping. */
 	u64 physical;
 	u64 length;
-	bool is_scrub;
+	bool rst_search_commit_root;
 	/* For the endio handler. */
 	struct btrfs_io_context *bioc;
 };

-- 
2.43.0


