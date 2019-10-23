Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A636AE26B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436949AbfJWWxr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42607 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436953AbfJWWxo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:44 -0400
Received: by mail-qk1-f193.google.com with SMTP id m4so4565200qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cf3syB5TxnowiiB5Ffw9wa8pxofRulUCkNKiRoMRhMU=;
        b=n+dUKPG3PCa5Vv9Mwke8sCTl5lw+Rgbgj14ViuGi7rNU8DIUrVNhjFZrmjcqEjKlxl
         lB2tOKhpdUoibtMt9pS1miVv1df/zrDjRA3PWgADraTpQKc8PSwDi36spFVBs3pcjrOV
         5HoB0QOSHgjdw1NhfzIhXB+aHRA0RUC6B7t+batkhbaqPubW30F4FjJwMnGpmUjuO6Bn
         5IYeY3oGbhett/rEwOFZWMNLKQQ81u3r4kI5DT/32sF3KCxLxoSUa/10YoDk49M50kig
         c6F/3tGJBukFkLCvvqNsIm6QzhkhZoJg+OFZwZK+pmawYPQXbYGlXoGRxlAk1RbAsJNA
         7/iw==
X-Gm-Message-State: APjAAAXWoYDl1ckSwMOHOWKZahI3gbJG3E32yW3JtCblvZQhwFKAOGN4
        5glDgHMQDaWAiMByn8lGVz8=
X-Google-Smtp-Source: APXvYqzvptG9rpifZjVN12C9mv7V63MPU5z1+v+5xUU/qTfojBzSAwMZDNrD286ujAu7di11MgO+CA==
X-Received: by 2002:a37:4fd1:: with SMTP id d200mr11119292qkb.413.1571871223657;
        Wed, 23 Oct 2019 15:53:43 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:42 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 21/22] btrfs: increase the metadata allowance for the free_space_cache
Date:   Wed, 23 Oct 2019 18:53:15 -0400
Message-Id: <0ee7de7dbc9dc043903e8da7c8d09df74ce03e09.1571865775.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, there is no way for the free space cache to recover from
being serviced by purely bitmaps because the extent threshold is set to
0 in recalculate_thresholds() when we surpass the metadata allowance.

This adds a recovery mechanism by keeping large extents out of the
bitmaps and increases the metadata upper bound to 64KB. The recovery
mechanism bypasses this upper bound, thus making it a soft upper bound.
But, with the bypass being 1MB or greater, it shouldn't add unbounded
overhead.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 29d3e21ba7fd..4a769003414c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -24,7 +24,8 @@
 #include "discard.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
-#define MAX_CACHE_BYTES_PER_GIG	SZ_32K
+#define MAX_CACHE_BYTES_PER_GIG	SZ_64K
+#define FORCE_EXTENT_THRESHOLD	SZ_1M
 
 struct btrfs_trim_range {
 	u64 start;
@@ -1691,26 +1692,17 @@ static void recalculate_thresholds(struct btrfs_free_space_ctl *ctl)
 	ASSERT(ctl->total_bitmaps <= max_bitmaps);
 
 	/*
-	 * The goal is to keep the total amount of memory used per 1gb of space
-	 * at or below 32k, so we need to adjust how much memory we allow to be
-	 * used by extent based free space tracking
+	 * We are trying to keep the total amount of memory used per 1gb of
+	 * space to be MAX_CACHE_BYTES_PER_GIG.  However, with a reclamation
+	 * mechanism of pulling extents >= FORCE_EXTENT_THRESHOLD out of
+	 * bitmaps, we may end up using more memory than this.
 	 */
 	if (size < SZ_1G)
 		max_bytes = MAX_CACHE_BYTES_PER_GIG;
 	else
 		max_bytes = MAX_CACHE_BYTES_PER_GIG * div_u64(size, SZ_1G);
 
-	/*
-	 * we want to account for 1 more bitmap than what we have so we can make
-	 * sure we don't go over our overall goal of MAX_CACHE_BYTES_PER_GIG as
-	 * we add more bitmaps.
-	 */
-	bitmap_bytes = (ctl->total_bitmaps + 1) * ctl->unit;
-
-	if (bitmap_bytes >= max_bytes) {
-		ctl->extents_thresh = 0;
-		return;
-	}
+	bitmap_bytes = ctl->total_bitmaps * ctl->unit;
 
 	/*
 	 * we want the extent entry threshold to always be at most 1/2 the max
@@ -2096,6 +2088,10 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
 		forced = true;
 #endif
 
+	/* This is a way to reclaim large regions from the bitmaps. */
+	if (!forced && info->bytes >= FORCE_EXTENT_THRESHOLD)
+		return false;
+
 	/*
 	 * If we are below the extents threshold then we can add this as an
 	 * extent, and don't have to deal with the bitmap
-- 
2.17.1

