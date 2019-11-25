Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF4109474
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfKYTrf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:35 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34645 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfKYTrc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:32 -0500
Received: by mail-qv1-f68.google.com with SMTP id n12so6290122qvt.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vkcIRBFOsluZbYg6A84SaZ/77cib1TDE+4UeF7XKKAc=;
        b=IsKbUFvpQeCTTnHVOZO0Y+lSBKrw9JlVLEuSjlvN1ZjkEhvvjD/je+MELICU4gcnHY
         q+42J/P2dK3W4KJpXJSUB3E+Z7Ak2qAqo6Tga5kuw0wNPt9E0eibXvhAm9/wKfxiG8FY
         PXVPE/hiWB1xeOJG6DO0Bro5W9PgwNYNrDJjl8AjCKMu4jlm+Kkpan/G7ct9FgydPIFo
         uMC2suVYI+F4yFXRC/lglThlj15U3nW+Dc3zr4TlueQVCUZf1LxjjMN1RDf0qL1i9XM4
         HAOFp9cXUUGx8caSiiwJduYeo5XApUSdw/sWU75wJKSD9Gpau25aw1SSU6j04BDst0Ku
         3ryw==
X-Gm-Message-State: APjAAAXpFm3CLL77GZ3+dIG0RI9fQe+6VyO0RmVugJbPW7hx735PZhSW
        ypE/T4WnMzRCzoyNMgp+lC0=
X-Google-Smtp-Source: APXvYqyjwwKeyIe3B8OHsbEqX2mZ5ftvKGOx49iWqqrG8JJ0vDAwJyttVXEDGDID7vzlIj+gfaJsQQ==
X-Received: by 2002:ad4:55ce:: with SMTP id bt14mr28532711qvb.131.1574711249535;
        Mon, 25 Nov 2019 11:47:29 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:28 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 20/22] btrfs: add async discard header
Date:   Mon, 25 Nov 2019 14:47:00 -0500
Message-Id: <c409aa7d47090134f2e2db5089c5fee1747c26dd.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
index 7ab4a93fc3b7..66b7855449df 100644
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

