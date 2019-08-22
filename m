Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9EF99F7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391542AbfHVTLO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:11:14 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:34545 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfHVTLN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:13 -0400
Received: by mail-yw1-f49.google.com with SMTP id n126so2854499ywf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1TohfY64odoKuSpukVPpVWeT8cyz97ORIcTqA6NHK4M=;
        b=npXwjyySxH5tXY6phD6V92l80v/ZdllLL2sO25zQCX2Rl4QdzwssusizaddTOD3YT9
         3ie8OFju7/1MsoAVEY/qVI9PJx0M+Puse9IkuhnvvPfMZNRpI/KSRlDo2BgTFIs4u7yU
         s4RudqxGThFp2m6QsWQWFaFD87e3etYDm15vZcoJkAVxL2WdUiY3zMPtZTbqR8c9Qoff
         938rPoXsgSfuH74MdcwA227hoNbzYOejqijql7GRCVfiNXjTFu3GmWCmuneVquwRIPqe
         2EEPupKQHkFmP+eclYfCchA9bVWvtAJ4qQHlNSHkh0rs1rEyPduYL0zgMiN582chkPVe
         WhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TohfY64odoKuSpukVPpVWeT8cyz97ORIcTqA6NHK4M=;
        b=Eg26oZA/mszbFW4rbpKd+y7yzjFr8fezBx1/JevNlK/KGUuLPeQfjFyKusvDZ6SozB
         1NHNDEr0Y1kiCsXdpfjmGufMSceq05UFFQovSNQUDjl5adRbDx5536IpWl+eE+qttent
         69qYRuJ/Knb12hI+njqJmJNe71L/u69loxIgrojcpVDh+tJzyToK9RwcloXYIs/AfEl9
         cYbaDxkFMM/PL5H+0QMbEP301D0/vsG5OLRsma6PlKzDPoPTrvzXR5MEtoUK6yC20V5Y
         xwJgS6W7Z9PyZMV60Tdog9G8OeQwWCLQ3tcXFZ2QCey2KzSGZs9WCS/gtDS+kjDC4SRQ
         4ZsQ==
X-Gm-Message-State: APjAAAU3tz8dF3aJOdFdBQtKGX+uHforzpHduzUakRkWDRUSSK7+Fj9z
        kLnSY48diTC1/6dZdxMSO/TxRA==
X-Google-Smtp-Source: APXvYqzmtZvSTkDZQBB2kcA3VL/E9w69syEd1QXyQ5FxDNrNn0RMGE4XyG08r94AYjRXOlI4hT1qyQ==
X-Received: by 2002:a81:b308:: with SMTP id r8mr646481ywh.45.1566501072481;
        Thu, 22 Aug 2019 12:11:12 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m40sm100187ywh.2.2019.08.22.12.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:11:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs: rework btrfs_space_info_add_old_bytes
Date:   Thu, 22 Aug 2019 15:10:57 -0400
Message-Id: <20190822191102.13732-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-1-josef@toxicpanda.com>
References: <20190822191102.13732-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If there are pending tickets and we are overcommitted we will simply
return free'd reservations to space_info->bytes_may_use if we cannot
overcommit any more.  This is problematic because we assume any free
space would have been added to the tickets, and so if we go from an
overcommitted state to not overcommitted we could have plenty of space
in our space_info but be unable to make progress on our tickets because
we only refill tickets from previous reservations.

Consider the following example.  We were allowed to overcommit to
space_info->total_bytes + 2mib.  Now we've allocated all of our chunks
and are no longer allowed to overcommit those extra 2mib.  Assume there
is a 3mib reservation we are now freeing.  Because we can no longer
overcommit we do not partially refill the ticket with the 3mib, instead
we subtract it from space_info->bytes_may_use.  Now the total reserved
space is 1mib less than total_bytes, meaning we have 1mib of space we
could reserve.  Now assume that our ticket is 2mib, and we only have
1mib of space to reclaim, so we have a partial refilling to 1mib.  We
keep trying to flush and eventually give up and ENOSPC the ticket, when
there was the remaining 1mib left in the space_info for usage.

Instead of doing this partial filling of tickets dance we need to simply
add our space to the space_info, and then do the normal check to see if
we can satisfy the whole reservation.  If we can then we wake up the
ticket and carry on.  This solves the above problem and makes it much
more straightforward to understand how the tickets are satisfied.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a0a36d5768e1..357fe7548e07 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -233,52 +233,41 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info,
 				    u64 num_bytes)
 {
-	struct reserve_ticket *ticket;
 	struct list_head *head;
-	u64 used;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
-	bool check_overcommit = false;
 
 	spin_lock(&space_info->lock);
 	head = &space_info->priority_tickets;
+	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
 
-	/*
-	 * If we are over our limit then we need to check and see if we can
-	 * overcommit, and if we can't then we just need to free up our space
-	 * and not satisfy any requests.
-	 */
-	used = btrfs_space_info_used(space_info, true);
-	if (used - num_bytes >= space_info->total_bytes)
-		check_overcommit = true;
 again:
-	while (!list_empty(head) && num_bytes) {
-		ticket = list_first_entry(head, struct reserve_ticket,
-					  list);
-		/*
-		 * We use 0 bytes because this space is already reserved, so
-		 * adding the ticket space would be a double count.
-		 */
-		if (check_overcommit &&
-		    !can_overcommit(fs_info, space_info, 0, flush, false))
-			break;
-		if (num_bytes >= ticket->bytes) {
+	while (!list_empty(head)) {
+		struct reserve_ticket *ticket;
+		u64 used = btrfs_space_info_used(space_info, true);
+
+		ticket = list_first_entry(head, struct reserve_ticket, list);
+
+		/* Check and see if our ticket can be satisified now. */
+		if ((used + ticket->bytes <= space_info->total_bytes) ||
+		    can_overcommit(fs_info, space_info, ticket->bytes, flush,
+				   false)) {
+			btrfs_space_info_update_bytes_may_use(fs_info,
+							      space_info,
+							      ticket->bytes);
 			list_del_init(&ticket->list);
-			num_bytes -= ticket->bytes;
 			ticket->bytes = 0;
 			space_info->tickets_id++;
 			wake_up(&ticket->wait);
 		} else {
-			ticket->bytes -= num_bytes;
-			num_bytes = 0;
+			break;
 		}
 	}
 
-	if (num_bytes && head == &space_info->priority_tickets) {
+	if (head == &space_info->priority_tickets) {
 		head = &space_info->tickets;
 		flush = BTRFS_RESERVE_FLUSH_ALL;
 		goto again;
 	}
-	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
 	spin_unlock(&space_info->lock);
 }
 
-- 
2.21.0

