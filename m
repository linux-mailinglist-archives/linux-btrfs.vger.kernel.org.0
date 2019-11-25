Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE58109472
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKYTrc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:32 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46109 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfKYTrb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:31 -0500
Received: by mail-qv1-f65.google.com with SMTP id w11so6253229qvu.13
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/55shlXn5U81maiE2JbP9Y20nOk8gQoXsZiv9oaLK/M=;
        b=SVwFlHB8vKFBu3FetWD3yOgU1IwQKnAKr5+t439B7hV5X4PVvwfWSAonNb/D5BkqK6
         G2GgDiMcRNp4Il78PItU4dwc+NJQBqNAb26cSIKGVu0FwB3JGSIfI5DvJ5pY146VescF
         u9Nd8mGAmcmXwoJUJkXEJKP3V7STie+MYJizdyH1G1Zwx9MPRJaKC00S2bsgyEDvtUse
         8zwKqMTmuOo95pAfBEkeT0l6iyR3iXE67Vaw7oSz4iA8wmRgz21dMDGMRl/AmmeW2SuC
         YEWdAlkwOrsAPk1lkHP7YhkUsfiaiwyZ/Yojnk6oF2X1EtAXXRvwo/mnRsF2to6//xjh
         Soow==
X-Gm-Message-State: APjAAAWoDQSJewAuWa85YoYR9yvCa0Ws1xkaI3O6Xz6KRH6jQMoPX92k
        2SkD/dh2B+wVwsv6xrJZ2mw=
X-Google-Smtp-Source: APXvYqyMfWFn6uhxCuDQYS07cgLAKOYyCc74u2UDZak2XYN4dMPzI9ghW02vy+mfk/MPz6BF73pLgg==
X-Received: by 2002:ad4:462d:: with SMTP id x13mr29356075qvv.105.1574711250651;
        Mon, 25 Nov 2019 11:47:30 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:29 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 21/22] btrfs: increase the metadata allowance for the free_space_cache
Date:   Mon, 25 Nov 2019 14:47:01 -0500
Message-Id: <894355ca977324aec8587d16625ed5ce10b23e55.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
index 1b887c0d7508..15667095c50d 100644
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

