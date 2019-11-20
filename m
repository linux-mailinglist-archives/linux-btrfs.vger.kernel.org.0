Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7B104627
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKTVvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44210 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKTVvx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id m16so1221629qki.11
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vMyc/H/5XWfNQgnL4eY4+5UHuR56u7xaGi9Q/p+TpsU=;
        b=AMISJ1TasI+vqx+x1f7To8KOeYvKP/TMhLx+j1NbQ4sUHgmFpywy3mgIO8Sg44wl43
         DDga0FaAWo11ZW4NOkd8doNSpr1l/OznllakmEhkD85Ffa8eWVl0h3RbjDQ+AQb6rdla
         flgYWAkoOCvgFy3J6C5rJEjm6r/3kDrz88iifLgjvVac2G/VYyNy3WT5PukH8ZY+XjCR
         aJfPvk0sLGkVViWKxFDRLd37zRa3j1L3AdOSsSgYAuTn5rrZArnILY7dftWbvWQn+uHQ
         tSULqWHJr786XKgNeJaB+T/rLBySqwk4IP818mt98hIzRam520gMvzD2ygEc0S+wCH3F
         2pFA==
X-Gm-Message-State: APjAAAUhY/Wo3XZeDFVObp57GxxSRsrWg7MnSKEiDluwSJbSD0ZQitya
        1u2jW+Hr1A/FhMTmOyZ9F1s=
X-Google-Smtp-Source: APXvYqyG3VkqWh6rPuCmwisYvn8LcgScr0TM/CVlW7drgHj8LUeGp0LPE8liJEVpx4TmU1L8Mrxetg==
X-Received: by 2002:a05:620a:1283:: with SMTP id w3mr4278865qki.431.1574286712245;
        Wed, 20 Nov 2019 13:51:52 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:51 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 21/22] btrfs: increase the metadata allowance for the free_space_cache
Date:   Wed, 20 Nov 2019 16:51:20 -0500
Message-Id: <5af33480e4bb610851fb4b7d47fccf74c683d148.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
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
index b35394118d87..c4d4a7fbbd77 100644
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
@@ -1695,26 +1696,17 @@ static void recalculate_thresholds(struct btrfs_free_space_ctl *ctl)
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
@@ -2100,6 +2092,10 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
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

