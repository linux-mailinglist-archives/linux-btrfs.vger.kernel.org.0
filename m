Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2811762D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLITqe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34113 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfLITqc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id x17so964213pln.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WPnCaWIqSBt/bL2qzdu5zpp7M7qofjjmTjvo3UUStYc=;
        b=a65+3f7Ffcu9dgcVbjCGx/uYar03DESyPmzH1jMSbMOZAiCSCBhfOUtjuMTzTs76nc
         4LM3GKxFYuYYA9ThNKkUMAxldEiaadQ6vtn34FCO1Y1sVB34p94ykAUHQUUo60HFSDRt
         tix3DgxS/lerH2VZhg6IvC14aEEubt7GAnOb+59weMx3MsveEqb0MymY1svMnqMYpkFS
         ZsWK80Y6X2WiK311gLSzSRuEMsPhZp6bYdC9Wm/aZybMLzV8eO9atNsdQpnjsIehk9u8
         gxFNhgezQ8Pva4VAMOj1q38KuUIWzzDS85wzMDRjmtvd1oFOllk24tyYxBdswD2JKbtp
         JNbg==
X-Gm-Message-State: APjAAAVv0IHgLW1xkXF3TwCPzjrCa0linKE+iBu9pcGKsddWGXj+MECc
        kBRAnXv5PXkMVboMnuUKaFM=
X-Google-Smtp-Source: APXvYqxD3nr7YMBF9iNcILLwZJmVens1sqLBfGT9UW+ILZDnr6hmT9ix6KMU0KgQz1lfl0VpxQeOaQ==
X-Received: by 2002:a17:902:a9c7:: with SMTP id b7mr10074105plr.23.1575920791921;
        Mon, 09 Dec 2019 11:46:31 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:31 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 20/22] btrfs: add async discard header
Date:   Mon,  9 Dec 2019 11:46:05 -0800
Message-Id: <4010415d184b5a5e47ec5ab4fc215d3ef9532488.1575919746.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
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

