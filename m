Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731D2423222
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbhJEUhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhJEUh1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:37:27 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD14C061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:35:36 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f130so291918qke.6
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ackAR3Yma9SnxRIBQx4MUm2XQRUK2eWBSsU/PWnLD9E=;
        b=owlf2QyG+ZUP4pzeOEu8dKvqEnM6QwV1OdK1hjSkHD2MB+KzhalEHwmtoEpwh0xxMP
         GPvToi3V/S+NKokJLCqLBaPpPQvNZsx8ezEVXawFcVq24mTO1tA8eZagHh0QKi07sGvx
         Z0EOnXr6vLpqSg2u4O9KfbWN7RwfnZaAv7aMg9DwpTz+yP18ZiQLQr2Vd+AaA7KWjD1n
         1MBNHOUfV8YJTqEvQqOFaaNtWjWCR4tzD6fWeCZKVRJEfpJamLBd/BTZYxmh52gOQSFS
         hcjjOPet/hOwZoZzLTm8038SElxsgirthdULVQH7YytiRLH5iqN5dpgyMrmVPFRRDDw/
         vn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ackAR3Yma9SnxRIBQx4MUm2XQRUK2eWBSsU/PWnLD9E=;
        b=lhpN3tL1H/db4cpMxK+WcmvVOJcULeA1Bpj1DB/0NxLnXQgPEwdN+t2DIE5LX3G5JR
         E9kUwMOc3WDHCs4nq32yJe5W5ArW1KMtCcY8Rbii+IEdmIHz2XPHCMh4XKNDDqGHhiO1
         SsPw66lL0oVjhiiqobntRzUreDdB9xj/ydjnWw4oXmDLgLluUbygUbKvAcaQXwQbnjUe
         H/53jkAtrstdZZrLo+aogUtk3MZtb7tK/jqmNAReVV7aIEjbPJM/4o3lUsasKiSJtFvo
         IevkBZmB/B7wiBpWevWe73TCdS00AJVJlto/Zm2CiMqM+7C60fJVerl+DLgY6d7tPhJr
         akFg==
X-Gm-Message-State: AOAM533hH+d+dut/IiSLCEvHViQWUk32l65TMMvERjTqoiuaTHnx1/yH
        FBdBWEe0ctiVYlshT8/YpngsWD3BB39ZYQ==
X-Google-Smtp-Source: ABdhPJzpyqQtNOoNKzyTtWP/vvVPtwgQVzbCdfqHnzf1bfLFJiBiU27owWizNxZ3rWNa8oP4ZJuMXw==
X-Received: by 2002:a37:ae81:: with SMTP id x123mr17122313qke.498.1633466135481;
        Tue, 05 Oct 2021 13:35:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h8sm9803348qkk.11.2021.10.05.13.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:35:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 4/5] btrfs: do not infinite loop in data reclaim if we aborted
Date:   Tue,  5 Oct 2021 16:35:26 -0400
Message-Id: <105b3762cf4f8dfe4a2d97b17f2632a82612a1ee.1633465964.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633465964.git.josef@toxicpanda.com>
References: <cover.1633465964.git.josef@toxicpanda.com>
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
index aa5be0b24987..d018bc1203f7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -885,6 +885,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 {
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
+	const bool aborted = BTRFS_FS_ERROR(fs_info);
 
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
+		if (BTRFS_FS_ERROR(fs_info))
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
+			if (BTRFS_FS_ERROR(fs_info))
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

