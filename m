Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C576E26B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436954AbfJWWxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44350 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436948AbfJWWxn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id z22so14227033qtq.11
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=M9rErESMg+rw3MqywVWx5gYmWPPXOLSqDbavwxyakQQ=;
        b=nmn7pw2iaWQlTx6txXB69KXQ52vwMA2hREST5JAbdSvsSri/LzfKqxCwaErcceYjZ6
         adNvZnMFHshixTnG4B5HwBIIgyNPm7DUuanyQcWapBbFvQwUi94txDW7dtdEDjnSMrPi
         t5SXUrwAamqNirRYZueJ65BJwLyIUWcK6PCas3jpCA/gkXnCFf4HzDHnUfCwoAB94Jwe
         v3XCapBnucWgM+1EofRPis7/CDpSg35pjFe2Zc/gH7EpxAwnriOzBuFOs9/RVaUZDO2L
         XjZiN+S5NSUjOYKWzRvGl4zFYLpadexVGWh7Q0Phu8XL0/GAXmqKAqWjVSCKehxNzUQb
         7+MA==
X-Gm-Message-State: APjAAAVOab030Q9yN9Q2ujlA0X1myeqAlkqfU7vK0uHhqpjmW5kpoPMS
        Y4uIqNk1iBFLxczayjtTnmk=
X-Google-Smtp-Source: APXvYqzdv8O8NLbkHIBOq0ldNsvZOg4I7WR75O5H2z+aQcoX163TbDRhHy/l88BnbEPBKD4cHp74sg==
X-Received: by 2002:aed:3baf:: with SMTP id r44mr1117197qte.30.1571871222528;
        Wed, 23 Oct 2019 15:53:42 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:41 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 20/22] btrfs: add async discard header
Date:   Wed, 23 Oct 2019 18:53:14 -0400
Message-Id: <d4d6d37217bc6ac580e369c5827d024828589f4d.1571865775.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Give a brief overview for how async discard is implemented.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/discard.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index f95e437d7629..2ff284a8a760 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -1,5 +1,39 @@
 /*
  * Copyright (C) 2019 Facebook.  All rights reserved.
+ *
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
  */
 
 #include <linux/jiffies.h>
-- 
2.17.1

