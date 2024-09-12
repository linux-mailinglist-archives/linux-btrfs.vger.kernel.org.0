Return-Path: <linux-btrfs+bounces-7974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11181976C34
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4323C1C23EC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14061B12F1;
	Thu, 12 Sep 2024 14:33:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA991A0BF6;
	Thu, 12 Sep 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151607; cv=none; b=CjiCScVKwnzNVF5VA3rLnKGIHyGJ6AgNXG14CLzSdOUQDszS25YtDXRG/j2tP5YTxdo4CQc9doJn+H0JXEWJ5f7dsHqHmRLNjvV+we60Lrn79CJC7yNCqnZVJzTNpcoUTLyqeu5IcRUAoQoihUaBRxd51wlkkC6BFp8+xl9PHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151607; c=relaxed/simple;
	bh=jPsonDFH1h+vW6R5YJGOdFGCoIX/eAwcER281EI4LZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wl/+GMWyKhKFVkosFvnGF5OM/lGF5qOXDhFvFrCYob5EW0eSQmep7eAUdYrKp8eeaepNPCd6ZKfLjj3guakZUI2AQxiqkt+wMVWr9oeoVYJFfqzC31S/TddR08UaG5IsSFkyQNuvqDR6s1k+kbrMnuO1tC2v8jjAbf/5S7dUkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cae102702so8759475e9.0;
        Thu, 12 Sep 2024 07:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151604; x=1726756404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GMZ7G7HX+tO1yGwljy1JRhPKEI2IDSYYGNH9iv2OtE=;
        b=VPoM1H8RC2lbG10pAaiZplwl5ZN6XZLaeDMhqBXHjh0hv2NB2+QEM1CE/ZNn4LjI4K
         QpeqI0afwPP3nT15NxNkR33OtFRsGnShMFo1QGL5yra0hvdjVAfwaZTiFTj4EwN9xh1J
         h3Wr9jdHPBAS0FpneQdIAGnpn/ivlcAzoQtwAkZy2HhCfOrAXO1gbzT8JV4xos6VjTsK
         NT2P9V5DQcRBfhiV7FTZhY8xtRu+8Xbd10urKQnWf1i6JYtYYHkjfXApq5nfdcLU8DWY
         hrRnToDRGumcd1TjjwtG+7d+zZ9Q2S4rGc4y3PttUng4oK7XyjsNFfieLt4PLl4Za1GD
         dCdA==
X-Forwarded-Encrypted: i=1; AJvYcCW9rEwmuVxlJXERQdNlCfUlbex/0kd6iIsDbpE5WMskL9J6rUM0wgpiNHYRWtMCQJEU9bfoZitIOTQYbjcv@vger.kernel.org, AJvYcCXY6nCUCrWQ+YUetj0sgqhtkxDPTOW9KIZn/UxLXfaadjmEcUFWxOhbMPsLijzeoVIcwEGuRClf9ZXpXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzie2L4Jrw9t81H4sEogPJQKHP4uk9GcDg88u+4tsxIKmQuT9Q
	sBIIzB0YvDmpX11eT8gKK8nDauk1yZT3dhfa57ypMOd/lCgehZOF
X-Google-Smtp-Source: AGHT+IH60ABF5LIYqfDKYcwEt2gLD1wp4Y3iP5FYyLzwSpcfyEYl1lbFI+h9KHw5LDn8L/GP9CXzWw==
X-Received: by 2002:adf:fd47:0:b0:378:7f65:e13a with SMTP id ffacd0b85a97d-378c2cd3a33mr1724900f8f.2.1726151603205;
        Thu, 12 Sep 2024 07:33:23 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7178100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f717:8100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a340sm14556911f8f.24.2024.09.12.07.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:33:22 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenru <wqu@suse.com>
Subject: [PATCH] btrfs: scrub: skip PREALLOC extents on RAID stripe-tree
Date: Thu, 12 Sep 2024 16:33:11 +0200
Message-ID: <20240912143312.14442-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When scrubbing a RAID stripe-tree based filesystem with preallocated
extents, the btrfs_map_block() called by
scrub_submit_extent_sector_read() will return ENOENT, because there is
no RAID stripe-tree entry for preallocated extents. This then causes
the sector to be marked as a sector with an I/O error.

To prevent this false alert don't mark secotors for that
btrfs_map_block() returned an ENOENT as I/O errors but skip them.

This results for example in errors in fstests' btrfs/060 .. btrfs/074
which all perform fsstress and scrub operations. Whit this fix, these
errors are gone and the tests pass again.

Cc: Qu Wenru <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3a3427428074..b195c41676e3 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1657,7 +1657,7 @@ static u32 stripe_length(const struct scrub_stripe *stripe)
 }
 
 static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
-					    struct scrub_stripe *stripe)
+					   struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
@@ -1703,10 +1703,21 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 			err = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
 					      &stripe_len, &bioc, &io_stripe, &mirror);
 			btrfs_put_bioc(bioc);
-			if (err < 0) {
+			if (err < 0 && err != -ENOENT) {
 				set_bit(i, &stripe->io_error_bitmap);
 				set_bit(i, &stripe->error_bitmap);
 				continue;
+			} else if (err == -ENOENT) {
+				/*
+				 * btrfs_map_block() returns -ENOENT if it can't
+				 * find the logical  address in the RAID stripe
+				 * tree. This can happens on PREALLOC  extents.
+				 * As we know the extent tree  has an extent
+				 * recorded there, we can be sure this is a
+				 * PREALLOC  extent, so skip this sector and
+				 * continue to the next.
+				 */
+				continue;
 			}
 
 			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
-- 
2.43.0


