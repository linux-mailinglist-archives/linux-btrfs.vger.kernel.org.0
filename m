Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EFD11762E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLITqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:35 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34748 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfLITqd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:33 -0500
Received: by mail-pj1-f67.google.com with SMTP id j11so5204329pjs.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MqX4YrE1Mit8QmVppoCrUPY+0r38mzKs9y2W2gE8I/k=;
        b=ohxqp51JznL353aGuJLHNymIYeBf7F5zoIJ77grV9ASo60/cYtrZzGOw7zgx+rMXlt
         C3O1BwY7p271gWuGhcqQs/3xb+kO6VTA/xBg0ju/8Pz77g3w/C3y6YW1rQ8W9RDvD4h4
         ojZcPte68jZ2vhHYi3phyUXFekn3bd2flR08wTni9BuhWmCCnX4isqHVVnRzrxuCQ1Ci
         j0GQB4nsm3rXvgLllxhrJPMGeUYLZ1/LKwYyrGBnd77jjkEq4I7es1BAgQ/GSk+3FZUk
         HtGAd+BQkBulSbJoQs4dmHL8kz6/2gUX+Q0uMtVDCCxlkrxW0s7BNYgdUEJmJGVZ/Tna
         aXxw==
X-Gm-Message-State: APjAAAUA2yZ9dB2ukBMSqOArx7IbWIyMRh0HaH6ZWT66BVAXoufV4T8y
        N2JOsCezmUzYuWdyQyUbNxQ=
X-Google-Smtp-Source: APXvYqzsUEmFZh6caRIFah3XpnkiQDeCwgfSvBvk7xhN6fKrMqJM7atcMo5Hoi4JkRqeCMKSQNKxBA==
X-Received: by 2002:a17:902:7784:: with SMTP id o4mr30923554pll.176.1575920792922;
        Mon, 09 Dec 2019 11:46:32 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:32 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 21/22] btrfs: increase the metadata allowance for the free_space_cache
Date:   Mon,  9 Dec 2019 11:46:06 -0800
Message-Id: <2f96529bfb5a4a3b8e8f9012c1ca2a16f6f000d0.1575919746.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
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
index 612726a91e98..6a313946a8da 100644
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

