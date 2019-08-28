Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752DBA05D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 17:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfH1PMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 11:12:50 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:38799 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfH1PMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 11:12:50 -0400
Received: by mail-qt1-f174.google.com with SMTP id q64so3397965qtd.5
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=87F5fHiaVTc4Asp26UQYSoKOoF6GTJH/fHz0XYTGP8k=;
        b=ijPVs9OV09zqmTuB0vxktflHXOR/VOseQJIHAPfm6auBh3elKJ6Cs1QcI6VNOHH3hd
         ukDQXsQUzxZslWU4XcylStH5Y/IeXuxv0n8AUb3Vgu3Ea3D8rAR3eh1BO2/qDOrSudLG
         C1Xs8IWEJsjbGbaXrgzVmYIlxpwUkn+l7niQguy77jnFNhUJCg7JZYIZ636JqkGwyNqr
         d2uZWmP0uiltsdwUpv9PwBd7Dk82C14sCbrpPkBgsAWv8HR4k+K9hsogoSLIX6q2tEGv
         RyGtCrhZyGXLqxIaEJzMqFs93P/g8TCDAGF0X3Z1yxzbhSHcODmJRoiEZOiHN+/HseQC
         /bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=87F5fHiaVTc4Asp26UQYSoKOoF6GTJH/fHz0XYTGP8k=;
        b=kW+xR370+728lZSgnw40nIl4ZmN7IBeJXndmE0nAXsOTMM5bI+k0yYOSzQz+LaygTS
         SqsLTwbWgQutBT6jEEAuj76jf0QrKHnzotqsQG/SbLNpGn0Ymg5yemWmfdOEd/BK8Rm8
         iFGzcePCBshKIevpRglcbl/Scm6uwlQrkomO81sDJlem7Z+60Pz3sdE1yEg8KHLVR5P3
         cEBZIjG+9Fwd8Po2nBGu8DdDnLDLLLt9jwEGsLiM0MYduP85lz8j8j5dclgTyYxe73Lw
         1+SQz1ziSbraV/LRJjJ3+hqTvluM/BAPpwqDX00egMHS9IlR5JAhoSRQux25Q9dLGwtd
         R7OA==
X-Gm-Message-State: APjAAAWf28NIzOmEHOsSC+Bu5Cd52EmrGNsPFoDcWt5HCxUkZOJWnlxn
        vCPl7nTuuwnSAZ8xyN8B5w4szw==
X-Google-Smtp-Source: APXvYqxrdWBN0jlsR8cEptm+IKxI2GZpNOEXetKeyrP7X2RX6oMO+kPdLsF/fNQbxCGHyz7pPysGMA==
X-Received: by 2002:ac8:41d1:: with SMTP id o17mr4718371qtm.383.1567005169382;
        Wed, 28 Aug 2019 08:12:49 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u16sm1362815qkj.107.2019.08.28.08.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 08:12:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH][v2] btrfs: rework wake_all_tickets
Date:   Wed, 28 Aug 2019 11:12:47 -0400
Message-Id: <20190828151247.17512-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-7-josef@toxicpanda.com>
References: <20190822191102.13732-7-josef@toxicpanda.com>
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
v1->v2:
- added a comment for maybe_fail_all_tickets

 fs/btrfs/space-info.c | 56 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c2143ddb7f4a..b2bb9d0bd44e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -679,19 +679,61 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
 		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
 }
 
-static bool wake_all_tickets(struct list_head *head)
+/*
+ * maybe_fail_all_tickets - we've exhausted our flushing, start failing tickets
+ * @fs_info - fs_info for this fs
+ * @space_info - the space info we were flushing
+ *
+ * We call this when we've exhausted our flushing ability and haven't made
+ * progress in satisfying tickets.  The reservation code handles tickets in
+ * order, so if there is a large ticket first and then smaller ones we could
+ * very well satisfy the smaller tickets.  This will attempt to wake up any
+ * tickets in the list to catch this case.
+ *
+ * This function returns true if it was able to make progress by clearing out
+ * other tickets, or if it stumbles across a ticket that was smaller than the
+ * first ticket.
+ */
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
@@ -759,7 +801,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
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

