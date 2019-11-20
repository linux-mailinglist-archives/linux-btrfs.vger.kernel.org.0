Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33196104626
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKTVvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:52 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:32943 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKTVvw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:52 -0500
Received: by mail-qv1-f67.google.com with SMTP id x14so585562qvu.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CRpJ3FkZbTWBWP7F9lzw4C3yR8Uyi/Fn6W2RxVoe8BQ=;
        b=OCnK9Mw4uq8zC2rJ8MB86f7laouZnDTp+JdyW73B40ZaidyHFVwuX7okTnzXQvJnTs
         aP6ueXi5Rvwll5JNlrUDO0+j3NCShHD9OLsLUNowGC0Srk61Xbo1T0fMq2eZd3cnE+Ps
         y5Bnfp+Q9IhSAiY9+hjVTCUdIUfivfzIrtf35XYwUO70RGSCjK6xcTxDr9YGScmtPCct
         PA1zLT5OdxdYMaQxV5MPHQSTPvgWbSWcPn53sSvL73lAiqqT9FW18i0ZYYmQUTb7P/g9
         tT0PsYYMF45ZUie1SKB6aeeiOmbVQ3Rh0tt4x+s9JrappKPPi9Th+6IoujyEtzJCFlM+
         9TVA==
X-Gm-Message-State: APjAAAVl4+Ipr4EDKfcxDHRGXHN9KQ0+ZzqOGN1OwHSDMiUn7pLe82aw
        d5xmnqLMgOT0KfPQTXI2GCw=
X-Google-Smtp-Source: APXvYqyZFmg6K3WuOik1MqgnrGP9M2WiB7/DcJWe0kOfTddWtsBw5PYiGfZ6vHSRDMnkb4SZrbFTqg==
X-Received: by 2002:a0c:fe69:: with SMTP id b9mr4852201qvv.206.1574286711014;
        Wed, 20 Nov 2019 13:51:51 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:50 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 20/22] btrfs: add async discard header
Date:   Wed, 20 Nov 2019 16:51:19 -0500
Message-Id: <723469c79c037e12de0c06e8a1ea36fbc3ee562a.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Give a brief overview for how async discard is implemented.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/discard.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 83618dd1a5b0..98032b5d341b 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -1,4 +1,39 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * This contains the logic to handle async discard.
+ *
+ * Async discard manages trimming of free space outside of transaction commit.
+ * Discarding is done by managing the block_groups on a LRU list based on free
+ * space recency.  Two passes are used to first prioritize discarding extents
+ * and then allow for trimming in the bitmap the best opportunity to coalesce.
+ * The block_groups are maintained on multiple lists to allow for multiple
+ * passes with different discard filter requirements.  A delayed work item is
+ * used to manage discarding with timeout determined by a max of the delay
+ * incurred by the iops rate limit, byte rate limit, and the timeout of max
+ * delay of BTRFS_DISCARD_MAX_DELAY.
+ *
+ * The first list is special to manage discarding of fully free block groups.
+ * This is necessary because we issue a final trim for a full free block group
+ * after forgetting it.  When a block group becomes unused, instead of directly
+ * being added to the unused_bgs list, we add it to this first list.  Then
+ * from there, if it becomes fully discarded, we place it onto the unused_bgs
+ * list.
+ *
+ * The in-memory free space cache serves as the backing state for discard.
+ * Consequently this means there is no persistence.  We opt to load all the
+ * block groups in as not discarded, so the mount case degenerates to the
+ * crashing case.
+ *
+ * As the free space cache uses bitmaps, there exists a tradeoff between
+ * ease/efficiency for find_free_extent() and the accuracy of discard state.
+ * Here we opt to let untrimmed regions merge with everything while only letting
+ * trimmed regions merge with other trimmed regions.  This can cause
+ * overtrimming, but the coalescing benefit seems to be worth it.  Additionally,
+ * bitmap state is tracked as a whole.  If we're able to fully trim a bitmap,
+ * the trimmed flag is set on the bitmap.  Otherwise, if an allocation comes in,
+ * this resets the state and we will retry trimming the whole bitmap.  This is a
+ * tradeoff between discard state accuracy and the cost of accounting.
+ */
 
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
-- 
2.17.1

