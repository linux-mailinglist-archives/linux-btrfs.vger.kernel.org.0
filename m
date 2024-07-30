Return-Path: <linux-btrfs+bounces-6869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78A941011
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 12:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7AE1B2B743
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C01A255C;
	Tue, 30 Jul 2024 10:33:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62E1A0AE5;
	Tue, 30 Jul 2024 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335607; cv=none; b=lSsEXma9HXXOj+26bLa7Y5Kzd/l7uFPbP3ywBsg9l5pCt9PvL6XcctHApqhSpie3tN7ZYUYj6wPA4EGfBHfbh3+rIYf4+mG5wRFFDRttLjPJ4KcT9XtWLO5Q6M0k9ebV6696ApVKZUsXO3hkMABQapXZuYB67suPSLuK6FB2U+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335607; c=relaxed/simple;
	bh=V2/wyFM3bPaGJfPQmLX/sluxJRKr7lvIOzPidOT0y/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ft/oVN3J58nBOviqCLbiWbo09yG7zCB3l8iUrIE3gwhJYVGnSz7S9fk7/pAtcTPEGXH6Db+EK4mtrhOx4jDKaIvBMNuWKJb51IRqnREccr+D6i9RPIZ0z6xWHwEPCGGEcxPaMLQ5lRKmOQTiOEooeTj+6GiDDT3hDnoa38C4zU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a975fb47eso622439466b.3;
        Tue, 30 Jul 2024 03:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335604; x=1722940404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LuI4Ztw0QlpRT70UGqlhNtTpM0k62lG+oH/v547owU=;
        b=sRQEWgFDl3c6QBa5jbB6ZocBEzXAdoDaplt3rqnzmI6VbBE7Fe/I8mas6BwFm+Icjg
         XNP45Mlk+U0+CIJOCbZg8Y7hdWXTqfUeqaWzWo3eb4+aNvmWZdA8V49F6CAACxt+1AIP
         wZPdFKHowf6r2+BN51gxZfGUqyKCob+iN2RWg/R9/B8kseoEB6UoNGZWmRPumxjVCNKH
         BaH+4bIfS8u/UYFHpuzalrGn0ezFeifZpwzhY/Y2py/1aQdh1F+oeERjrEaCFG95VWrJ
         VvjyvBrlKCvYW6MfjczSDMHlzBSKV3sH/Z1NpXMV3PgiPrD/gdL1peMun7V0VcbDPGSI
         EQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXidf0BKhIsOJcEQmIzFEf5ctk8vgh/fw1wh9uJTGJGNrbY5MVIhR6sS3KCeSiRnj3rkWDaUp5VTimbL02k8dAgWZs2ggkmoG30xobQ
X-Gm-Message-State: AOJu0Ywj/Um1zc0gNJ4X1JHgPN41bIuHMFKTEy6OlszDVyZHnOv/IyrX
	eVlaJIcUme8o+mEZI1DIStlTbyM2AT2Z1QbFAOwsd0FrOLZGbn7I
X-Google-Smtp-Source: AGHT+IEYJ0VWlY56L8QNbD6O92hAt0RYIujcd+d1NYHdaz9lZuzhMKyHU5MdFp3T+WJ6UxRBvMxwGg==
X-Received: by 2002:a17:906:dc95:b0:a7a:ae85:f245 with SMTP id a640c23a62f3a-a7d400e1eddmr754454566b.38.1722335604423;
        Tue, 30 Jul 2024 03:33:24 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9f60sm622455266b.223.2024.07.30.03.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:33:24 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 30 Jul 2024 12:33:15 +0200
Subject: [PATCH v2 2/5] btrfs: rename btrfs_io_stripe::is_scrub to
 rst_search_commit_root
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-debug-v2-2-38e6607ecba6@kernel.org>
References: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
In-Reply-To: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2799; i=jth@kernel.org;
 h=from:subject:message-id; bh=GLCvjYyujrbk7qMrFGW/JRXoGw+aEQQjKxibIwWDeQ4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaStOFhg/aNZZspC952b5RZLzRPwP+LIcvXo/tr4gOsRp
 TqO1i4xHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjCRUkmGvyIH2rxuVa5OSXY6
 upGz/cbMRVuUxfaYztpXplmTfG1ypRjD/wL+v5Lt9beePmRkDDFO45LU3xT4cHFUx/+3k2ZpijE
 X8AIA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Rename 'btrfs_io_stripe::is_scrub' to 'rst_search_commit_root'. While
'is_scrub' describes the state of the io_stripe (it is a stripe submitted
by scrub) it does not describe the purpose, namely looking at the commit
root when searching RAID stripe-tree entries.

Renaming the stripe to rst_search_commit_root describes this purpose.

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
index 97430918e923..bfb567f602b1 100644
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
index 0f15f5139896..a1f41e8b00cd 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1695,7 +1695,7 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
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


