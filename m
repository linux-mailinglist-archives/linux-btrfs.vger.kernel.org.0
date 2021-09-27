Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F36419DCE
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhI0SHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 14:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbhI0SHC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 14:07:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E2C061714
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:24 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c7so38009725qka.2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f2R/OkwismCzwR3LRjxYhNy8immU4DsVoIq2J6589Yc=;
        b=qcneTljw/fdM8OWaAfHnnxtf84yQvXV/A9xHrCQgZQEuDGCyOIOVpajTwdUy6qPl+U
         2/sETXfFsH/SvHgEn7G3Smfa2rs1hpxa4Z8DSyU/6iwWJEZFae/x/FAd4rXZq9l3b6Cf
         EwXPXvJAV+MnxMkEfv099Uqp2uDEvwddxMrXaOigg3mwIE+L6W0dOrd9LkGbbF9e6L33
         wdcW13A8OaxE9bo/ysU1tVhdzjr6D4CZ6V0r1Rp/6/7dSFHeCbESyB9rZU6WnkU7bu6o
         9QzPIWXJDvdM3IbkiQuVPFYMZ7LmFPyEU1LGbHEGT84CKohI82A7scqjspxiW2aGWkM4
         PxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2R/OkwismCzwR3LRjxYhNy8immU4DsVoIq2J6589Yc=;
        b=JIjwvK+RLaeCSNiDfhi2BiVNRLI4P0DQS/BuPIDOyQipoKHM8ciVPgaAlJulvXZqYH
         d8Qg48Gg8wHW+4+58QflszzGIPUo0qKh8Xe0naQhcWgjHlKPQXd6ej2NrJHF1oumv2GM
         u0xPpOkdFLRDGrJm3a172/KHEJfqAmJvgKgoqMxmH+sPLGpZWozJMm3aFnELyttk5l1R
         ksFkhT98pfejJFsWerWskeOiU0BinpFx2gcDNvg7xLcUC4USEsvhhuT3PTiFab7jyn0H
         hZjXFW8IiKg31W4ty1SCas3puKlVjoTKUAD2jwXGTITjJOIiN5KDUr7nMVnPnjL5w5Pg
         gsrw==
X-Gm-Message-State: AOAM533oamv0bRWAGLAGk8H2K7GrvphzSkZua5bqMp4Mp+EOxAZR3MFX
        7hgMZt7o0gvrksu289edtHb2HfUqdSCa0A==
X-Google-Smtp-Source: ABdhPJyYygJYvM3SzKEywZ01gvpcgfrliO5H1vfZuZTYgRIXS2SbHm3+nT2MgmvHfPdNSjKXgX8foA==
X-Received: by 2002:a05:620a:5ae:: with SMTP id q14mr1345426qkq.246.1632765922945;
        Mon, 27 Sep 2021 11:05:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y11sm11860298qtm.27.2021.09.27.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:05:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 4/5] btrfs: do not infinite loop in data reclaim if we aborted
Date:   Mon, 27 Sep 2021 14:05:13 -0400
Message-Id: <03b2f64b3acc918b67c2fef6d4bfce70ab12ce3b.1632765815.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1632765815.git.josef@toxicpanda.com>
References: <cover.1632765815.git.josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index aa5be0b24987..63423f9729c5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -885,6 +885,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 {
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
+	const bool aborted = btrfs_has_fs_error(fs_info);
 
 	trace_btrfs_fail_all_tickets(fs_info, space_info);
 
@@ -898,16 +899,19 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
 
-		if (ticket->steal &&
+		if (!aborted && ticket->steal &&
 		    steal_from_global_rsv(fs_info, space_info, ticket))
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
@@ -916,7 +920,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		 * here to see if we can make progress with the next ticket in
 		 * the list.
 		 */
-		btrfs_try_granting_tickets(fs_info, space_info);
+		if (!aborted)
+			btrfs_try_granting_tickets(fs_info, space_info);
 	}
 	return (tickets_id != space_info->tickets_id);
 }
@@ -1172,6 +1177,10 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
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
@@ -1202,9 +1211,19 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
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

