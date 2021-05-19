Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9850A389474
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355550AbhESRMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 13:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355490AbhESRMa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 13:12:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874D6C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 10:11:09 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v8so13474713qkv.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ncJHzBVU5TzNJ5ihpuFDeSv5N839gzzPKrEqFLZqZc=;
        b=eY19TQ6yifVX0qo4q+y4eLV96SHTI/i3wrnOYOCFpchoUmm4m0tWt6sjby9L0kMqtq
         ebE4PJq31peUHsm+yM6XkDI6njV3I3Nmk/6U7PixwWBxBvLNZ+Jof4H9uS6MCKQ24QW6
         /xlihGkKcaco4wRWZ386k0RlhkQ3l0tIwAuoxL7aKi9fdBJIfjgVZA8ynfnUgB+3DW1H
         p1jhUXarOms7B4BPJ7Phf7OBBdYtjKyk8qVUAdsS80untpr3IMoTytckzvU2k2y6TOc/
         rYwDXKXcv6992bGwjE6fOlSTcMh6fZr+eG7rRIKL5bRQNEY6r/OvzyoUMx+KXjd2X9fl
         hR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ncJHzBVU5TzNJ5ihpuFDeSv5N839gzzPKrEqFLZqZc=;
        b=ZJWHabis0zoeLdA3miyYMBhaUx9XpbROZgNiW3Zl99ycc2kToVjaf02d/YOzhUfUKM
         n0kcUMpHU88OmrYTd5lI7wQ3tBgEGLAgP+g6hfEhp2YA4gS+WgTSFkZSm6yEqxAEuqjT
         SeeaPwVK8qmWPkYVIpBxS6d1WFqtA0WwbRZMj6y4xbHU+N3eQ1PQ7pL5qR6hlOjndyLC
         p5SlcYhdDwDAlKl/+SJ9wuYr/OfOJaF3cZoio8ftYAVcnJFaNV1NBgwNEdGNY8gExSkK
         ga3eHj7jiDFZ0KGgZxAbPH8meYPcdilnybr9GyzkjjfXwimzeCtb59GO6FOMQt8XoRng
         sdwA==
X-Gm-Message-State: AOAM531rjDW1ckS06UAAF8jjT/Iku89B4ZehWhftzeAL3sY8s0wIAz7+
        hJnYHkLOuHicSa/DFV57YrZjHLkkQZ/tAA==
X-Google-Smtp-Source: ABdhPJxl7bBrKnvgPADBMXRAr46trG2L6p2PXalZvEVhu/UmQXX+BuJsnoV3u/A9VM+0WJ9lRx1wsg==
X-Received: by 2002:a37:45c3:: with SMTP id s186mr382339qka.318.1621444268131;
        Wed, 19 May 2021 10:11:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b4sm18302qti.43.2021.05.19.10.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 10:11:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3] btrfs: do not infinite loop in data reclaim if we aborted
Date:   Wed, 19 May 2021 13:11:06 -0400
Message-Id: <dadfaef8dc4bd12e96759701d6da8bab1c3cb0a5.1621444159.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Fix this by checking to see if we have BTRFS_FS_STATE_TRANS_ABORTED in
either of the reclaim loops, and if so fail the tickets and bail.  In
addition to this, fix maybe_fail_all_tickets() to not try to grant
tickets if we've aborted, simply fail everything.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v2->v3:
- const bool aborted as per Johannes' comments.
- consolidate the error handling into a label as per Johannes' comments.

v1->v2:
- The original fix would bail, but we'd hang because tickets wouldn't be worken
  up properly, fix the error case to fail all pending tickets.
- The original fix also didn't include the normal reclaim loop, which has a
  similar problem in that it only fails if ->full is set.
- Make maybe_fail_all_tickets() actually fail all tickets if we've aborted.
  This is just nice to have, there's no problem per-se but it makes it less
  likely that we'll allow tickets to be granted if there was a little bit of
  available space.

 fs/btrfs/space-info.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 42d0fa2092d4..12faee050639 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -941,6 +941,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
 	u64 first_ticket_bytes = 0;
+	const bool aborted = test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
+				      &fs_info->fs_state);
 
 	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
@@ -952,7 +954,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
 
-		if (ticket->steal &&
+		if (!aborted && ticket->steal &&
 		    steal_from_global_rsv(fs_info, space_info, ticket))
 			return true;
 
@@ -968,15 +970,18 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
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
@@ -985,7 +990,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		 * here to see if we can make progress with the next ticket in
 		 * the list.
 		 */
-		btrfs_try_granting_tickets(fs_info, space_info);
+		if (!aborted)
+			btrfs_try_granting_tickets(fs_info, space_info);
 	}
 	return (tickets_id != space_info->tickets_id);
 }
@@ -1253,6 +1259,11 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 			spin_unlock(&space_info->lock);
 			return;
 		}
+
+		/* Something happened, fail everything and bail. */
+		if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
+			     &fs_info->fs_state))
+			goto aborted_fs;
 		last_tickets_id = space_info->tickets_id;
 		spin_unlock(&space_info->lock);
 	}
@@ -1283,9 +1294,20 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 			} else {
 				flush_state = 0;
 			}
+
+			/* Something happened, fail everything and bail. */
+			if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
+				     &fs_info->fs_state))
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

