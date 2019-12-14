Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8934D11EF2E
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfLNAXC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:23:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39453 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfLNAXB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:23:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so2323234pfx.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WPnCaWIqSBt/bL2qzdu5zpp7M7qofjjmTjvo3UUStYc=;
        b=Rhj295tQ1TUZZ0qWe34AfLChCqlePP//JDxa21bJ69RhMj2/zwACCciod6PiALg45h
         XvfH1WmyCCqMT9rGbT9o1f9ftP0tOA75nBSATFfdtlySAXIQZmHndQ5y0iUo9N+fvw6H
         jwwmuhvXX//w4xMgbvDWUlEY0IK9afP1apNi5zkfObh3f4y6ktgp8hWrT2c9FxyHcCVO
         hhpYtl072wRlHcM4cr4EDQH+IZiyUlfDLUB3ekZnrYRZ5nA9H2Oh9iIwqwTluJ0FxfNe
         xYjtAiL+q6h5kWOyaz5V0bkEPVi/mI6+2oDcD6H7FfF/q26JoKpJwd7ulv6QFu/K6Daq
         u/bA==
X-Gm-Message-State: APjAAAXaEdws3pdDjnG1xk0iNKxJapPqzXsbyCBAhEYkOI4c3d8dKLkg
        +fgXs+YlG6KWa0Hc9JA622c=
X-Google-Smtp-Source: APXvYqyD2Iaamn+0KpxdctN4fi+NjTm22UukDXiVY9JP7Q9dnwq+3quZzU2cmJD8lmOVzCXWcBBsog==
X-Received: by 2002:a62:7590:: with SMTP id q138mr2452719pfc.241.1576282980980;
        Fri, 13 Dec 2019 16:23:00 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:23:00 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 20/22] btrfs: add async discard header
Date:   Fri, 13 Dec 2019 16:22:29 -0800
Message-Id: <f20276673ca4890aa3246660c89fd3edbc6b4f53.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
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
index fe73814526ef..fe5719797eee 100644
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

