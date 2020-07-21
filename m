Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8A228206
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgGUOXX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgGUOXX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3895C0619DB
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so16246163qtg.4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=453v9VzQmoK5i/nqibBwzH7YHdJp2eB/54xxH6Xi1B8=;
        b=00foF6MBj4sZ6qcOh4aAyXm6as0STbKJ2WaVX1ia/LdtC1jDPvAAFyK7NG6O5GVh6Q
         XT19iLI1NDapZWCas74RNjklookqFaXyiT33Rz4oamROs8vLGUfuXFxlbTvrvL+1stki
         uEIjktRrXLxsKqZdq9Xn1U9n8n0LTsAYSLMrXjRh47WyOm2tCgK7bDnONJ3N0zAL9bV0
         rO0zzywdGSnAzTOcHkmJdNOa+aDJH3rH7z/jmFO6rHym6ajrFvMtcbpFTJJ9cqLzZuja
         OXvQ1dC4TMw0YsCoNxvdZkNhZ7Y3qaLYzaHn5NzxE04/7/oseFODr1ve/xVlmsdFs46p
         KOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=453v9VzQmoK5i/nqibBwzH7YHdJp2eB/54xxH6Xi1B8=;
        b=ofRDl3SpufQvZFrgKKRBkrNopZ4ip7liielExw4aqQKNBus+15hHk5QsUTfCko9oYr
         KN4HVuSLJptxx16+BTACI46MEgfhfro02nONEubGnc2CJj4F2bbhiE+1rjKIosDhHM8s
         df+vfyLHyGg5hMhT9UzE2MPYslc0XCO1kI9TKLGVyFi7wuvqF0yLiXfJPdYEL2+ePpIa
         JRQOX5S/uiOZJ5M2yh4D5vK/0QF7PRYAsufSvSr7k13PVGZyyQH9YQQF4S4KTQ5fqhDF
         eAFa7i1mYx7LGV4Ig7iEDjLURZCwXrU+lkO4mUgh/3JFa8eQCgIzn7PW0qsDn9xS4AVh
         c6uA==
X-Gm-Message-State: AOAM533mxe6RYhL/NhVHWHgLQYk9KnxTPAU2Yr9xYN9rjxMIvR0XziRH
        SIf3/i/3KQZzAqoOhjv7A91MOPxudosW/A==
X-Google-Smtp-Source: ABdhPJwqINB8neYhRmwVDO6nQsmfR+tgzGAQga9P1CcpxkhBdZuGaowsakcvhfk1criHTeuf3xLJOg==
X-Received: by 2002:ac8:4788:: with SMTP id k8mr30247536qtq.120.1595341401680;
        Tue, 21 Jul 2020 07:23:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 128sm2609527qkk.101.2020.07.21.07.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:23:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/23] btrfs: add a comment explaining the data flush steps
Date:   Tue, 21 Jul 2020 10:22:34 -0400
Message-Id: <20200721142234.2680-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The data flushing steps are not obvious to people other than myself and
Chris.  Write a giant comment explaining the reasoning behind each flush
step for data as well as why it is in that particular order.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 680218a7b0e5..ba2bb47cbb18 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -998,6 +998,53 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	} while (flush_state <= COMMIT_TRANS);
 }
 
+/*
+ * FLUSH_DELALLOC_WAIT:
+ *   Space is free'd from flushing delalloc in one of two ways.
+ *
+ *   1) compression is on and we allocate less space than we reserved.
+ *   2) We are overwriting existing space.
+ *
+ *   For #1 that extra space is reclaimed as soon as the delalloc pages are
+ *   cow'ed, by way of btrfs_add_reserved_bytes() which adds the actual extent
+ *   length to ->bytes_reserved, and subtracts the reserved space from
+ *   ->bytes_may_use.
+ *
+ *   For #2 this is trickier.  Once the ordered extent runs we will drop the
+ *   extent in the range we are overwriting, which creates a delayed ref for
+ *   that freed extent.  This however is not reclaimed until the transaction
+ *   commits, thus the next stages.
+ *
+ * RUN_DELAYED_IPUTS
+ *   If we are freeing inodes, we want to make sure all delayed iputs have
+ *   completed, because they could have been on an inode with i_nlink == 0, and
+ *   thus have been trunated and free'd up space.  But again this space is not
+ *   immediately re-usable, it comes in the form of a delayed ref, which must be
+ *   run and then the transaction must be committed.
+ *
+ * FLUSH_DELAYED_REFS
+ *   The above two cases generate delayed refs that will affect
+ *   ->total_bytes_pinned.  However this counter can be inconsistent with
+ *   reality if there are outstanding delayed refs.  This is because we adjust
+ *   the counter based soley on the current set of delayed refs and disregard
+ *   any on-disk state which might include more refs.  So for example, if we
+ *   have an extent with 2 references, but we only drop 1, we'll see that there
+ *   is a negative delayed ref count for the extent and assume that the space
+ *   will be free'd, and thus increase ->total_bytes_pinned.
+ *
+ *   Running the delayed refs gives us the actual real view of what will be
+ *   freed at the transaction commit time.  This stage will not actually free
+ *   space for us, it just makes sure that may_commit_transaction() has all of
+ *   the information it needs to make the right decision.
+ *
+ * COMMIT_TRANS
+ *   This is where we reclaim all of the pinned space generated by the previous
+ *   two stages.  We will not commit the transaction if we don't think we're
+ *   likely to satisfy our request, which means if our current free space +
+ *   total_bytes_pinned < reservation we will not commit.  This is why the
+ *   previous states are actually important, to make sure we know for sure
+ *   whether committing the transaction will allow us to make progress.
+ */
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
-- 
2.24.1

