Return-Path: <linux-btrfs+bounces-1718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A423B83AFAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3528B2B771
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60651128389;
	Wed, 24 Jan 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="a6aBxN46"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9881AA5
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116799; cv=none; b=c850YmrL5Ebl9vklb496OmglXn6+CEDH4tPBwUdcos6M284H83rJtzoU5Fyr9jfrur8LRBwghlWo82wraa+MJ1dfJ2BHqUHr1ZpvVNtASvLnE1a0isxzVoVSho++ZqcPT7No2cstmjaRUREqjiGcwLB4lxQb1R70kJfgJTK6dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116799; c=relaxed/simple;
	bh=ccxk9A0lLAH7hM0Kq5d4bG+71N269qXfLCbaeZdL+vQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csR3o6niv0kUqTvFSvoTY7KkZb0dduVyMQaFFDiNow51zdgcyOHOpwA0XTmtq0N35MTkeL5DtWa75zoHr0Kpd8F4eOXG+39MXViazkPMad24r7bLyTVOPMK4QOffStbHWkXVuBRTporj7kis4kf5lEJktbFRCuTPioGGESwEonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=a6aBxN46; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ff7ec8772dso49935237b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116797; x=1706721597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzwurHsIxfPSp3qChyTj7+rJwRjra1JtBmEgFeG7iEQ=;
        b=a6aBxN46qEbdvhcgiwp0EuANZ8wICstPvOR5Mfx3cLW+uVGKqUfRsC2VzZTjEJ3RvJ
         APduYkzMGjS9Q9AJAWlbxpka3dwWKjjwcFjt9AtiH7KMJZr52wQaGLEB4Ua1EzZkLHOn
         prWtyp6bPS+4/vHfavXrD/QG/T7iQDDTHuTAHH9Hsv27FXRKTvbYgdAtEg7nUQhxmezk
         Av48WGV5wcC6Wzh5Sr7cf1IkNOAKkUcZVlGJ96pI+glo2hnF/cLQydJ+JNPQTXRHfQ+r
         Tacbgm3F3C0EzYfOsqYS/eQUmCTcTUp+0AL1vT5vq+OxD/9RS6nXn9ePamr7Y88zhWLf
         YWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116797; x=1706721597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzwurHsIxfPSp3qChyTj7+rJwRjra1JtBmEgFeG7iEQ=;
        b=vtlNMYchIUnG+hDXQz/Ny7uUcoMbRtPt3mkewlzCmCXXsFgSTl8HFMXjprvgyMQNIb
         ru3y6mY6Px3aToLT95dZ9E988yvj9tJo2R65tIq4dAojUP23iZybLFx4o73HTM9fksrU
         TejrcH+Dl59HhfSI5IR7R6xLVFvtxkZBaB1HRU7ZrsL3nzZV0twsZU59Itd19MNE086w
         FFUlRQP97hFsbN4gA8hpHiKk36y3O8k/u1XUt/ChC667RHpnHPjh48m8T10NOf4dmkC8
         7ArjC3uMt5dK/1LpY/bz+S10jCSpwqCNjk11JW/3Lzd3cion7VDYPUI3ferq+gSneTEG
         MM8g==
X-Gm-Message-State: AOJu0Yw+Tj9126m0mmVaTh6Y1pZz77gZ+Z0NtSF2k5v/FutcUj4FrHt0
	Z407DNmvIsb4JEl9aGcE19KeqX03Ac7/ogm7mjiTA7zkS196OTGshhrgjuTCkEtuBwgDyAJXuZw
	Y
X-Google-Smtp-Source: AGHT+IHDXgfJ4fWPssh/BfzA/yK692bNzi2Go+ZkJ6sRjvWySvZD+/VuPH06r3rYV5x+lgrx0YMBRg==
X-Received: by 2002:a0d:d90c:0:b0:5fb:cffb:9609 with SMTP id b12-20020a0dd90c000000b005fbcffb9609mr1094471ywe.6.1706116796964;
        Wed, 24 Jan 2024 09:19:56 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id gt19-20020a05690c451300b005ff7a3cc04dsm60323ywb.129.2024.01.24.09.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:56 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 36/52] btrfs: add orig_logical to btrfs_bio
Date: Wed, 24 Jan 2024 12:18:58 -0500
Message-ID: <dd9c0885524c54598664ce0acf6fad749792337c.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When checksumming the encrypted bio on writes we need to know which
logical address this checksum is for.  At the point where we get the
encrypted bio the bi_sector is the physical location on the target disk,
so we need to save the original logical offset in the btrfs_bio.  Then
we can use this when csum'ing the bio instead of the
bio->iter.bi_sector.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c       | 10 ++++++++++
 fs/btrfs/bio.h       |  3 +++
 fs/btrfs/file-item.c |  2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index fc5c56a9d25f..cb998048edce 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -96,6 +96,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	if (bbio_has_ordered_extent(bbio)) {
 		refcount_inc(&orig_bbio->ordered->refs);
 		bbio->ordered = orig_bbio->ordered;
+		bbio->orig_logical = orig_bbio->orig_logical;
+		orig_bbio->orig_logical += map_length;
 	}
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
@@ -678,6 +680,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		goto fail;
 	}
 
+	/*
+	 * For fscrypt writes we will get the encrypted bio after we've remapped
+	 * our bio to the physical disk location, so we need to save the
+	 * original bytenr so we know what we're checksumming.
+	 */
+	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
+		bbio->orig_logical = logical;
+
 	map_length = min(map_length, length);
 	if (use_append)
 		map_length = min(map_length, fs_info->max_zone_append_size);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index bbaed317161a..a5c5371e99e2 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -54,11 +54,14 @@ struct btrfs_bio {
 		 * - pointer to the checksums for this bio
 		 * - original physical address from the allocator
 		 *   (for zone append only)
+		 * - original logical address, used for checksumming fscrypt
+		 *   bios.
 		 */
 		struct {
 			struct btrfs_ordered_extent *ordered;
 			struct btrfs_ordered_sum *sums;
 			u64 orig_physical;
+			u64 orig_logical;
 		};
 
 		/* For metadata reads: parentness verification. */
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 6264cb837dcf..a7e545e7461f 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -756,7 +756,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio)
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
-	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	sums->logical = bbio->orig_logical;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
-- 
2.43.0


