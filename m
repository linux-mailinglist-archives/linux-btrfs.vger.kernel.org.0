Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3483892E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 17:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346806AbhESPqk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbhESPqj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 11:46:39 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B132AC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 08:45:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id v8so13187147qkv.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKFsjkcL0AqtvI8tFD1v35rr0+/4ldCSI2fDjNsCUk8=;
        b=d8Xniry5VDUoNJNp8wMb699z1jGxbiE18X+iamUX0SpzkMMgJ5QDrMQpjxY1mlQe7t
         9VN7DNRivC4v65YtVBlLHYHmghM4Wp0Poq2prJQX70k2FAUvmCvSk6kOh49TKH7Pt+lG
         e3MuO/WXTef4eB/U8DB3fxbih7RDOuzMkEP1oLOzZIu2v+PpM//dIA/fMAv5ZzyelU86
         WvtTORaAK5qDLyVGKpQuzBXasoW4viGqlAfc2oeqkmtTM7NnIoGi2uFii+i9hrDJ/WGR
         ukSEn9JwIlZAvV7gzb9w2UfZ3nuxWmI/6yHxjcSB3UzUZfkd6rG7G7/i27gq0HPEU2A5
         WTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKFsjkcL0AqtvI8tFD1v35rr0+/4ldCSI2fDjNsCUk8=;
        b=ZpRdhSbMU6mliDw16R0sCv8BMqLiL1c/InDmu2RIuEDaP0ZYGrwCI18XUq+Qmsp6FE
         RxqsP9LEBdiWqara3M1vaWF/ThO4MklA+N1I2nXU+UY3LjexO9vxCFxiiJl8zTYzOHsh
         X/OEELyme2Ku6PmrTTQI86g5ExXL0cHX8ejRJqVYJiqvEzPSjTMnGE0lBpzLxIZz+ARZ
         Uy589mEv4ivfy2ypibiZv+/WRPtJhIqcIdujdUpm5kWGToMCKceRPbHTpIRh6Y3PlBio
         pR3vJwwZKZWTUql5Xl296WfdoZ+sytZOtP2J6Aks1KChx0gyjuOg4zpvAVRfWdqOcMun
         ctFw==
X-Gm-Message-State: AOAM530PXFeuby6rT5tVK35aoRuooDPE1aGOtZsaPZMkWgb50GfBCKNW
        PNEMojWX86Qk4WQGDFpgRlvDcJT/gty65A==
X-Google-Smtp-Source: ABdhPJzf8pYtTGIcEHN+oiDTCX5kExBDwWRH6mVLbxPuWEqhY/484CEywDaUfLSDbXTPrzGFtmtFoQ==
X-Received: by 2002:a37:de13:: with SMTP id h19mr12529878qkj.346.1621439118294;
        Wed, 19 May 2021 08:45:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v8sm26137qkg.102.2021.05.19.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:45:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2] btrfs: do not infinite loop in data reclaim if we aborted
Date:   Wed, 19 May 2021 11:45:16 -0400
Message-Id: <33a744a9768b0a46b8993c1fc39bacebb43579a9.1621438991.git.josef@toxicpanda.com>
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
v1->v2:
- The original fix would bail, but we'd hang because tickets wouldn't be worken
  up properly, fix the error case to fail all pending tickets.
- The original fix also didn't include the normal reclaim loop, which has a
  similar problem in that it only fails if ->full is set.
- Make maybe_fail_all_tickets() actually fail all tickets if we've aborted.
  This is just nice to have, there's no problem per-se but it makes it less
  likely that we'll allow tickets to be granted if there was a little bit of
  available space.

 fs/btrfs/space-info.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 42d0fa2092d4..0d36d684d552 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -941,6 +941,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
 	u64 first_ticket_bytes = 0;
+	bool aborted = test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
+				&fs_info->fs_state);
 
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
@@ -1253,6 +1259,15 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 			spin_unlock(&space_info->lock);
 			return;
 		}
+
+		/* Something happened, fail everything and bail. */
+		if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
+			     &fs_info->fs_state)) {
+			maybe_fail_all_tickets(fs_info, space_info);
+			space_info->flush = 0;
+			spin_unlock(&space_info->lock);
+			return;
+		}
 		last_tickets_id = space_info->tickets_id;
 		spin_unlock(&space_info->lock);
 	}
@@ -1283,6 +1298,16 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 			} else {
 				flush_state = 0;
 			}
+
+			/* Something happened, fail everything and bail. */
+			if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
+				     &fs_info->fs_state)) {
+				maybe_fail_all_tickets(fs_info, space_info);
+				space_info->flush = 0;
+				spin_unlock(&space_info->lock);
+				return;
+			}
+
 		}
 		spin_unlock(&space_info->lock);
 	}
-- 
2.26.3

