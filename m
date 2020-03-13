Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC57184FC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 20:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCMT6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 15:58:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40409 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMT6W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 15:58:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id j2so1857888qkl.7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oN6urh+euZXFbmkMe/AxoC9DyqLDdQfUXUXBpMt2aP0=;
        b=fpm4XqGvq1RqWfnmeFvGuIZWBp7PKDrbsijuxlPuDHLApgFzAURVkox8U9KcBORGn8
         5wd93MinKIpgLkLH+Q7FlZYtbNQvJvJHsDoPpSKWdA3hw2PSKCJLvNnnXBNxM/Amcm2Y
         GagQKtvfKhB5MOwBnu2Xq8fBwx682IGKsyKRGwrnxWP51G1ux7ZbdFUbXldOAp8WPx3X
         hs94KGp8IrQU7x3Z1mLIn739L/q3K3nH5uJIR+gzMispccACZ9hWTAJrQpiYy2WUZGvF
         T8tP+wG4Q6c7lBPhfdCAvfZmp1KXVoWDFwkpevEHjTCZaEJy5QuMfGgF8e0D1H2vYqyg
         QjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oN6urh+euZXFbmkMe/AxoC9DyqLDdQfUXUXBpMt2aP0=;
        b=fFTi1xoboVx85X3xHwqHHp3FCT4tGpVd0EF6IkwqGwgpciMbnPLcQAK+mbXCP/0Xux
         izmQznP7Q+OKkFKQB3e07oc8Jyfoti+DnKE3PiFcmp9JZHqMLD4rFTHep+GNiozjFcq0
         +M4SUKEjx0VnjmlLaqSrE/c6qk9KanxyzoPWv3i1hHeGpOSliKbYwMG0ZJU7jtbFd6na
         gDQjNV4UDmHLddteI3+0tye5h3aIH3W/JvSQFzbbREzMcrZKWryZrtoU40X2flIPkiuE
         vwON808Y7WXi8OmZFN0XMDiitajCTBOQ3I17Wu5xQlV+hrXfUNpf0pZUDgI6rwlmVocG
         sp/Q==
X-Gm-Message-State: ANhLgQ1ZaHCaTkXQsuKoKS6Vi7FVBeJ1kYO3ct11Dn5q/Me1169PdFgW
        ADmNzxTmLRI4B9bmWj+mMPsfqy2wwitSIQ==
X-Google-Smtp-Source: ADFU+vuowRsmy68PrJHnPI87tWbrdrgjiIiM2Jpusuh98wpseIqgkCtA+8Z+iZ/b44Ps6+lCqG4fcQ==
X-Received: by 2002:a37:ad07:: with SMTP id f7mr14212189qkm.316.1584129498849;
        Fri, 13 Mar 2020 12:58:18 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h20sm2093418qka.78.2020.03.13.12.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:58:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: only check priority tickets for priority flushing
Date:   Fri, 13 Mar 2020 15:58:08 -0400
Message-Id: <20200313195809.141753-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195809.141753-1-josef@toxicpanda.com>
References: <20200313195809.141753-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In debugging a generic/320 failure on ppc64, Nikolay noticed that
sometimes we'd ENOSPC out with plenty of space to reclaim if we had
committed the transaction.  He further discovered that this was because
there was a priority ticket that was small enough to fit in the free
space currently in the space_info.

Consider the following scenario.  There is no more space to reclaim in
the fs without committing the transaction.  Assume there's 1mib of space
free in the space info, but there are pending normal tickets with 2mib
reservations.

Now a priority ticket comes in with a .5mib reservation.  Because we
have normal tickets pending we add ourselves to the priority list,
despite the fact that we could satisfy this reservation.

The flushing machinery now gets to the point where it wants to commit
the transaction, but because there's a .5mib ticket on the priority list
and we have 1mib of free space we assume the ticket will be granted
soon, so we bail without committing the transaction.

Meanwhile the priority flushing does not commit the transaction, and
eventually fails with an ENOSPC.  Then all other tickets are failed with
ENOSPC because we were never able to actually commit the transaction.

The fix for this is we should have simply granted the priority flusher
his reservation, because there was space to make the reservation.
Priority flushers by definition take priority, so they are allowed to
make their reservations before any previous normal tickets.  By not
adding this priority ticket to the list the normal flushing mechanisms
will then commit the transaction and everything will continue normally.

We still need to serialize ourselves with other priority tickets, so if
there are any tickets on the priority list then we need to add ourselves
to that list in order to maintain the serialization between priority
tickets.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 784a7ca4f9cb..235dee4a23d3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1278,6 +1278,17 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+/*
+ * This returns true if this flush state will go through the ordinary flushing
+ * code.
+ */
+static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
+{
+	return (flush == BTRFS_RESERVE_FLUSH_DATA) ||
+		(flush == BTRFS_RESERVE_FLUSH_ALL) ||
+		(flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
+}
+
 /**
  * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
  * @root - the root we're allocating for
@@ -1313,8 +1324,17 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	spin_lock(&space_info->lock);
 	ret = -ENOSPC;
 	used = btrfs_space_info_used(space_info, true);
-	pending_tickets = !list_empty(&space_info->tickets) ||
-		!list_empty(&space_info->priority_tickets);
+
+	/*
+	 * We don't want NO_FLUSH allocations to jump everybody, they can
+	 * generally handle ENOSPC in a different way, so treat them the same as
+	 * normal flushers when it comes to skipping pending tickets.
+	 */
+	if (is_normal_flushing(flush) || (flush == BTRFS_RESERVE_NO_FLUSH))
+		pending_tickets = !list_empty(&space_info->tickets) ||
+			!list_empty(&space_info->priority_tickets);
+	else
+		pending_tickets = !list_empty(&space_info->priority_tickets);
 
 	/*
 	 * Carry on if we have enough space (short-circuit) OR call
@@ -1340,9 +1360,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ticket.error = 0;
 		init_waitqueue_head(&ticket.wait);
 		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
-		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
-		    flush == BTRFS_RESERVE_FLUSH_DATA ||
-		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
+		if (is_normal_flushing(flush)) {
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
 				space_info->flush = 1;
-- 
2.24.1

