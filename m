Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95638B2FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 17:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243863AbhETPXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243776AbhETPXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 11:23:03 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3CDC0613ED
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 08:21:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f8so13030204qth.6
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z5x2PBP8GslGnHYMVuxISwfjtHrDVj4X+uAxS0SdbbU=;
        b=ZkpiepV/xiS7xvVdFI1wH9yoCmPRYwYKbM60iDh106tvqnTGY+SArA+VWxyfb7xrsS
         c8VC6Ff9RMNH47ocVBddF4m8GdKfd0eqelfU4KYHtMBCPRWPobJiidUvz0eI5+P0fej+
         PTsBlcXyTH8SyriNfOIAk09CXimSnQ3wBK81SFibF0LGoLZ8QLtYtkrkJtqU3+i56OP6
         +598Rl4vc9DgWGiKsddPBQU0q/3KG3VmthHZU6haBBHv7n1fXEscDaxyF2Bew8aLUVj0
         3JljHzNBQcjUkzvrs/jZ+GAKqNt4pKaSvDEbow52PkdmxpcysUl0l03SZZekaId+rh1b
         jmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5x2PBP8GslGnHYMVuxISwfjtHrDVj4X+uAxS0SdbbU=;
        b=tng4BpKqlfolsNVWeiaMlYvhIDBvjp4ku9TIfEBHrjPwtjLQ9iiS5cqW1aiBW2/8Vt
         M6gR8DAH8xNlOYMh2oOzEpKx7CPtE1AZE+u4VSH+k/DorEq5CWlaXiK7jr2BmQu2sq0P
         214s/hVTcIYH6f7PRWammkGzSKu82CAsL0BAfPvpTvn63ps6FgqzUtJri0QYnBCLJQJW
         TtKum+wMNJFr/reQcSitJCQMbn6HfXUMYyYt1XKy9YNom0/BJrC90a/CbJvaPtettST3
         w/48z0KxDUKGq9CyHejVh1BvWrTeYP0QxPFgNRdIfIhc71lMLWQtaz3jVc1dFLVRexY1
         9cnw==
X-Gm-Message-State: AOAM531jCw239y0XpCuPm7UFl3VkJs8pv+e3tvp8+OSL4zgbhQZfKFeo
        N/dwRbdk4Q/qJVQJEhAu2P9k7s8lBefd7Q==
X-Google-Smtp-Source: ABdhPJwUpXdlBoWeEcUB7+iXx0+NnRQWBfT0fXil0tpNWJdD9msB3aWfYBAPgcMXhy3glBu+IQa0JQ==
X-Received: by 2002:ac8:5483:: with SMTP id h3mr856614qtq.205.1621524100572;
        Thu, 20 May 2021 08:21:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x27sm2211824qkj.133.2021.05.20.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:21:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: do not infinite loop in data reclaim if we aborted
Date:   Thu, 20 May 2021 11:21:33 -0400
Message-Id: <303817cba3a99d35aa5bb490110cda5b6b50f68f.1621523846.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1621523846.git.josef@toxicpanda.com>
References: <cover.1621523846.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Error injection stressing uncovered a busy loop in our data reclaim
loop.  There are two cases here, one where we loop creating block groups
until space_info->full is set, or in the main loop we will skip erroring
out any tickets if space_info->full == 0.  Unfortunately if we aborted
the transaction then we will never allocate chunks or reclaim any space
and thus never get ->full, and you'll see stack traces like this

watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/u4:4:139]
CPU: 0 PID: 139 Comm: kworker/u4:4 Tainted: G        W         5.13.0-rc1+ #328
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Workqueue: events_unbound btrfs_async_reclaim_data_space
RIP: 0010:btrfs_join_transaction+0x12/0x20
RSP: 0018:ffffb2b780b77de0 EFLAGS: 00000246
RAX: ffffb2b781863d58 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000801 RSI: ffff987952b57400 RDI: ffff987940aa3000
RBP: ffff987954d55000 R08: 0000000000000001 R09: ffff98795539e8f0
R10: 000000000000000f R11: 000000000000000f R12: ffffffffffffffff
R13: ffff987952b574c8 R14: ffff987952b57400 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff9879bbc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0703da4000 CR3: 0000000113398004 CR4: 0000000000370ef0
Call Trace:
 flush_space+0x4a8/0x660
 btrfs_async_reclaim_data_space+0x55/0x130
 process_one_work+0x1e9/0x380
 worker_thread+0x53/0x3e0
 ? process_one_work+0x380/0x380
 kthread+0x118/0x140
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x1f/0x30

Fix this by checking to see if we have a btrfs fs error in either of the
reclaim loops, and if so fail the tickets and bail.  In addition to
this, fix maybe_fail_all_tickets() to not try to grant tickets if we've
aborted, simply fail everything.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 42d0fa2092d4..077e54cdc29f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -941,6 +941,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
 	u64 first_ticket_bytes = 0;
+	const bool aborted = btrfs_has_fs_error(fs_info);
 
 	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
@@ -952,7 +953,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
 
-		if (ticket->steal &&
+		if (!aborted && ticket->steal &&
 		    steal_from_global_rsv(fs_info, space_info, ticket))
 			return true;
 
@@ -968,15 +969,18 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		 */
 		if (first_ticket_bytes == 0)
 			first_ticket_bytes = ticket->bytes;
-		else if (first_ticket_bytes > ticket->bytes)
+		else if (!aborted && first_ticket_bytes > ticket->bytes)
 			return true;
 
-		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
+		if (!aborted && btrfs_test_opt(fs_info, ENOSPC_DEBUG))
 			btrfs_info(fs_info, "failing ticket with %llu bytes",
 				   ticket->bytes);
 
 		remove_ticket(space_info, ticket);
-		ticket->error = -ENOSPC;
+		if (aborted)
+			ticket->error = -EIO;
+		else
+			ticket->error = -ENOSPC;
 		wake_up(&ticket->wait);
 
 		/*
@@ -985,7 +989,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		 * here to see if we can make progress with the next ticket in
 		 * the list.
 		 */
-		btrfs_try_granting_tickets(fs_info, space_info);
+		if (!aborted)
+			btrfs_try_granting_tickets(fs_info, space_info);
 	}
 	return (tickets_id != space_info->tickets_id);
 }
@@ -1253,6 +1258,10 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 			spin_unlock(&space_info->lock);
 			return;
 		}
+
+		/* Something happened, fail everything and bail. */
+		if (btrfs_has_fs_error(fs_info))
+			goto aborted_fs;
 		last_tickets_id = space_info->tickets_id;
 		spin_unlock(&space_info->lock);
 	}
@@ -1283,9 +1292,19 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 			} else {
 				flush_state = 0;
 			}
+
+			/* Something happened, fail everything and bail. */
+			if (btrfs_has_fs_error(fs_info))
+				goto aborted_fs;
+
 		}
 		spin_unlock(&space_info->lock);
 	}
+	return;
+aborted_fs:
+	maybe_fail_all_tickets(fs_info, space_info);
+	space_info->flush = 0;
+	spin_unlock(&space_info->lock);
 }
 
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
-- 
2.26.3

