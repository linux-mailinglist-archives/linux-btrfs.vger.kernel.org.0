Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECBC12EB54
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgABV1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:27:01 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:38319 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgABV1B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:27:01 -0500
Received: by mail-qv1-f47.google.com with SMTP id t6so15523276qvs.5
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QeCvklU/bMVsGIc6OKqOiQPGW+xPwn5hKqXcy6zD/AU=;
        b=kHw2jUGXGeWOM1uwevUOLE8pqu8+DtD318GwYt8aBcqp/5UvDxzWg9lfzy47HresCC
         ubE1vjQHN6/PSMztF7EfMYYFdyAIwZFAy7J2a12Fo/RT3ni6te8xbYfaaU0ai6VEb7nf
         cplCkU/ycAAwUtv24EJkCbhw8uqOaobKqM9aRqSwEjQrd0M85eGHTmA8vF0IXLDIaVSd
         TonUxvHbw8mALrntPIecUsfmgxweqeiGg8oLcwhQrJPhDmLhfu6Cya3MbZhuj9PqYXzc
         v9tpYlAoy8BJ2LocB6MHbNb5yKSLxc236nIn5++K2dBEEYnoY9hqWB6EVSM0rGY1UGGw
         molw==
X-Gm-Message-State: APjAAAUkdHEGoO7sqlNdWBiPuke/3r4QhueJofHwp/HbHt0zkfrAoFfH
        eJhRPWT0HBfp5YcHee/VX4Y=
X-Google-Smtp-Source: APXvYqwVBNZVWb1eMLkHBZ9PJZR6z5D25fkmXrHpnAw32awq9P5D5cmw9d+qFCi8mFx029U3SGeU1g==
X-Received: by 2002:a0c:e14f:: with SMTP id c15mr62932613qvl.169.1578000420055;
        Thu, 02 Jan 2020 13:27:00 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:26:59 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 08/12] btrfs: add async discard header
Date:   Thu,  2 Jan 2020 16:26:42 -0500
Message-Id: <6b051445e34dadaa0ed1cd7a5efdd19eddbae887.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Give a brief overview for how async discard is implemented.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/discard.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index bc6d4344397d..d5a89e3755ed 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -1,4 +1,42 @@
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
+ * incurred by the iops rate limit, the byte rate limit, and the max delay of
+ * BTRFS_DISCARD_MAX_DELAY.
+ *
+ * Note, this only keeps track of block_groups that are explicitly for data.
+ * Mixed block_groups are not supported.
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

