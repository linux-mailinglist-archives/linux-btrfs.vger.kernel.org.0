Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0E99F81
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbfHVTLR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:11:17 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36371 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfHVTLR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:17 -0400
Received: by mail-yw1-f66.google.com with SMTP id m11so2850845ywh.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DFUWkxxV8j4WIwdU4nZnpBxKbZnkig1x1ot7uIbwXlI=;
        b=JhXGPGy2ajDskg3rYTXBan7ubsHQS3FckmC/tt9/h2SkqPKXiOCchphb7Y2dZV8GZC
         MHd0bsj3jtOgNWROWC5N+y7+c1S+eEKJdhewsNEeDHW3bzZHPiS9U/h3/im4GtAGgyn4
         nxEBp4znixL/pAB7Y6IXWzDTu7CwJNf3cwUmNl7REVFPO44vws7RX85s9BstjTDEOwEW
         cmEJX4t5QKhjrHIcpjNj4PMk1ApwShl/Z7hcXESTEZ4WEvk4r3IpsiPNPzN73BAiwrOU
         8d08CG2lvGb7Qb+pXqdXCDVolLAEzi26i3jkvHk3pJkIocQA/VCdxcOqiVjQw4maqO9x
         w2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFUWkxxV8j4WIwdU4nZnpBxKbZnkig1x1ot7uIbwXlI=;
        b=bJi+4ODn3X6sYjDzrhGvzAIsCDm5fp58PkJbwbP2vmUabvH1j0KmYpTccaDqzj2ALj
         7vnJblxJJ+LXZpSeokS5Evb5MMuYO+XHlrzPBnVZam0qBV7xfT6T6rhHqww1bgjkMfw9
         FEQQl1VNxD62PjLOIZrMjizW+tJwbdBXczv63nyHkXB8vJSIEX+3BdAC/r0wO4PADJBu
         rpRumkTclQXB1JKww/LHKtp9z0gXPBuIL8Wz9glxzq5oNGNOdPQIhgiGrWs0zXKg1fv3
         mmz4hWoPJqC2T7B8Rg7fWMZHUipxFfJriZ/GgAsSpSm+dnpT/k36JyfV3OBtilbd+tdo
         yH6w==
X-Gm-Message-State: APjAAAV9Czx68xiIKQd4YJTAS70njeMCxLRLN4a6AcUTLD8uN3qJndHk
        34RDT7qTZ2QcYP88HDPtYnYtpQ==
X-Google-Smtp-Source: APXvYqxs4BUWegopHiRM4atVIZAS7i0zRvWCWcuxSu+Dxz6oUEKEhSgXiIEIxJD5N1t8R/52uoJy7w==
X-Received: by 2002:a0d:d84c:: with SMTP id a73mr648425ywe.97.1566501075917;
        Thu, 22 Aug 2019 12:11:15 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l4sm111529ywa.58.2019.08.22.12.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:11:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 6/9] btrfs: rework wake_all_tickets
Date:   Thu, 22 Aug 2019 15:10:59 -0400
Message-Id: <20190822191102.13732-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-1-josef@toxicpanda.com>
References: <20190822191102.13732-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we no longer partially fill tickets we need to rework
wake_all_tickets to call btrfs_try_to_wakeup_tickets() in order to see
if any subsequent tickets are able to be satisfied.  If our tickets_id
changes we know something happened and we can keep flushing.

Also if we find a ticket that is smaller than the first ticket in our
queue then we want to retry the flushing loop again in case
may_commit_transaction() decides we could satisfy the ticket by
committing the transaction.

Rename this to maybe_fail_all_tickets() while we're at it, to better
reflect what the function is actually doing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c2143ddb7f4a..dd4adfa75a71 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -679,19 +679,46 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
 		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
 }
 
-static bool wake_all_tickets(struct list_head *head)
+static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
+				   struct btrfs_space_info *space_info)
 {
 	struct reserve_ticket *ticket;
+	u64 tickets_id = space_info->tickets_id;
+	u64 first_ticket_bytes = 0;
+
+	while (!list_empty(&space_info->tickets) &&
+	       tickets_id == space_info->tickets_id) {
+		ticket = list_first_entry(&space_info->tickets,
+					  struct reserve_ticket, list);
+
+		/*
+		 * may_commit_transaction will avoid committing the transaction
+		 * if it doesn't feel like the space reclaimed by the commit
+		 * would result in the ticket succeeding.  However if we have a
+		 * smaller ticket in the queue it may be small enough to be
+		 * satisified by committing the transaction, so if any
+		 * subsequent ticket is smaller than the first ticket go ahead
+		 * and send us back for another loop through the enospc flushing
+		 * code.
+		 */
+		if (first_ticket_bytes == 0)
+			first_ticket_bytes = ticket->bytes;
+		else if (first_ticket_bytes > ticket->bytes)
+			return true;
 
-	while (!list_empty(head)) {
-		ticket = list_first_entry(head, struct reserve_ticket, list);
 		list_del_init(&ticket->list);
 		ticket->error = -ENOSPC;
 		wake_up(&ticket->wait);
-		if (ticket->bytes != ticket->orig_bytes)
-			return true;
+
+		/*
+		 * We're just throwing tickets away, so more flushing may not
+		 * trip over btrfs_try_granting_tickets, so we need to call it
+		 * here to see if we can make progress with the next ticket in
+		 * the list.
+		 */
+		btrfs_try_granting_tickets(fs_info, space_info);
 	}
-	return false;
+	return (tickets_id != space_info->tickets_id);
 }
 
 /*
@@ -759,7 +786,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 		if (flush_state > COMMIT_TRANS) {
 			commit_cycles++;
 			if (commit_cycles > 2) {
-				if (wake_all_tickets(&space_info->tickets)) {
+				if (maybe_fail_all_tickets(fs_info, space_info)) {
 					flush_state = FLUSH_DELAYED_ITEMS_NR;
 					commit_cycles--;
 				} else {
-- 
2.21.0

