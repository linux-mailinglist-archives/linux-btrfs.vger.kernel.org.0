Return-Path: <linux-btrfs+bounces-6316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295EF92B040
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 08:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65C1B22921
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D18145324;
	Tue,  9 Jul 2024 06:32:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583413D516;
	Tue,  9 Jul 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506743; cv=none; b=mYp+LFznGcnYr4ZyhKi17iA7ie3Zcghl9j1Y/ZPDNlGRnfV2thEkRPmElSCqAK+xX/svQntvoZc9OIeexsgkcKCijcf4OCBP14lrT1xB2Sj53Uy1FyFYgF1QPoO4cUuzOX8Mqij222chYQR20uqSCnv95WK5QtVJKI3O/TgdRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506743; c=relaxed/simple;
	bh=wYnjBVzTcF/OzalHx2oAQbF/PY+TIdryRfsI0bE4fL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fnXsJgkBEI2nWb1ZlZPvzKEB0UkN1tbd9cntxEKixIm5YSecvKUTvtPfDz81pQSC2I9VJsB+vAaOm8yHZgbnxaDN2ySrPVo2YRi48trdOftmJJH/bYXPmVD5IURCPHH2A2pxZtE06Xs5+X75sAI2jNOm7iGSagvYteaAs3IxPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso33869985e9.3;
        Mon, 08 Jul 2024 23:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506740; x=1721111540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jqmu7ZRed+yR97RAgoDGzIXlD6UyBcncdYUkhMXLDQ=;
        b=vBwQ8LvNkWDGhWPxevthhh9tSMaHerYtpLZi1FnUr8iJfjiH5qW7LSyxH8CASBQ4fp
         o8pPtaXmKAn2etZZl5wRGavMT8PVN42kNIeYiFITvqPW47sc1TORsdJ6Um8bsEa02LkV
         du8pJDWultq1TK7KidE1DFJLiNG96Nzn5/WQ2HskTC8LgcECp9xkva/YRJc32q54Xpt7
         8aWdcfG6ElyfHMgbjdXeyvW8rM8bYw4mJ3Wm9AM+1ohPFFvevHGHk0AyMq42l7YPRcUd
         mLROr+bTMldNzSyC11TeorvGrEiEILbiStEDBYZmxssm82K5lJItiAwdguWqs8HpreaT
         +nXA==
X-Forwarded-Encrypted: i=1; AJvYcCW0hKnG0BqUrdQDMUb5BSQEbpD2uQe4G0iTYeDidHYhdDVrfptaRTNnmMKmx+0NrtGPCc5qs3W/Hrl60mJctJoSQVj1nrA9qm++HvVG
X-Gm-Message-State: AOJu0Yyj0oMMGjRgfzcJ/YJM5eJYBTiOEc75crfNZjbDUS3ZdpFDYbrf
	Wp0l1E1utSvqXxqWaCMI3lXux4NPrPGZ6BycDhoG3+p8FdP5hgkJ
X-Google-Smtp-Source: AGHT+IEh1OZCe4wjuP8JX1Km7aJ9Mb3qkqLnUxrW+/PGBWeGbsCH3M8narU94xSn/uyvTedu/0L/lQ==
X-Received: by 2002:a05:600c:63d0:b0:426:6e86:f82 with SMTP id 5b1f17b1804b1-426707e36e6mr10145385e9.22.1720506740083;
        Mon, 08 Jul 2024 23:32:20 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm1569239f8f.63.2024.07.08.23.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:32:19 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 09 Jul 2024 08:32:12 +0200
Subject: [PATCH 1/2] btrfs: don't hold dev_replace rwsem over whole of
 btrfs_map_block
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-rst-updates-v1-1-200800dfe0fd@kernel.org>
References: <20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org>
In-Reply-To: <20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3579; i=jth@kernel.org;
 h=from:subject:message-id; bh=C/2veQuXInUAYzzKEwd4xcEWSsj265yrCeC73ehFe4I=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaT13CzMKuWN2cJvevf03EkPBczf6Gx88Ka6N9FtraihR
 +jicovOjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZhIoDHDLyamwvKA4rInAQnt
 9xkYeiVWBBv/e8wttqWeYeotp/PpCgz/s1ZJ3XzNfu3h07atCs1XcsslufTitaq8Yw3CdLJ5/lr
 wAQA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't hold the dev_replace rwsem for the entirety of btrfs_map_block().

It is only needed to protect
a) calls to find_live_mirror() and
b) calling into handle_ops_on_dev_replace().

But there is no need to hold the rwsem for any kind of set_io_stripe()
calls.

So relax taking the dev_replace rwsem to only protect both cases and check
if the device replace status has changed in the meantime, for which we have
to re-do the find_live_mirror() calls.

This fixes a deadlock on raid-stripe-tree where device replace performs a
scrub operation, which in turn calls into btrfs_map_block() to find the
physical location of the block.

Cc: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fcedc43ef291..4209419244a1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6650,14 +6650,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
+again:
 	down_read(&dev_replace->rwsem);
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
-	/*
-	 * Hold the semaphore for read during the whole operation, write is
-	 * requested at commit time but must wait.
-	 */
-	if (!dev_replace_is_ongoing)
-		up_read(&dev_replace->rwsem);
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case BTRFS_BLOCK_GROUP_RAID0:
@@ -6695,6 +6690,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			   "stripe index math went horribly wrong, got stripe_index=%u, num_stripes=%u",
 			   io_geom.stripe_index, map->num_stripes);
 		ret = -EINVAL;
+		up_read(&dev_replace->rwsem);
 		goto out;
 	}
 
@@ -6710,6 +6706,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 */
 		num_alloc_stripes += 2;
 
+	up_read(&dev_replace->rwsem);
+
 	/*
 	 * If this I/O maps to a single device, try to return the device and
 	 * physical block information on the stack instead of allocating an
@@ -6782,6 +6780,18 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		goto out;
 	}
 
+	/*
+	 * Check if something changed the dev_replace state since
+	 * we've checked it for the last time and if redo the whole
+	 * mapping operation.
+	 */
+	down_read(&dev_replace->rwsem);
+	if (dev_replace_is_ongoing !=
+	    btrfs_dev_replace_is_ongoing(dev_replace)) {
+		up_read(&dev_replace->rwsem);
+		goto again;
+	}
+
 	if (op != BTRFS_MAP_READ)
 		io_geom.max_errors = btrfs_chunk_max_errors(map);
 
@@ -6789,6 +6799,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	    op != BTRFS_MAP_READ) {
 		handle_ops_on_dev_replace(bioc, dev_replace, logical, &io_geom);
 	}
+	up_read(&dev_replace->rwsem);
 
 	*bioc_ret = bioc;
 	bioc->num_stripes = io_geom.num_stripes;
@@ -6796,11 +6807,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	bioc->mirror_num = io_geom.mirror_num;
 
 out:
-	if (dev_replace_is_ongoing) {
-		lockdep_assert_held(&dev_replace->rwsem);
-		/* Unlock and let waiting writers proceed */
-		up_read(&dev_replace->rwsem);
-	}
 	btrfs_free_chunk_map(map);
 	return ret;
 }

-- 
2.43.0


