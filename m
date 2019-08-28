Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45034A05EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 17:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfH1PP2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 11:15:28 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:40515 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfH1PP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 11:15:28 -0400
Received: by mail-qk1-f180.google.com with SMTP id f10so54589qkg.7
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/hYVacxGHKy+AogtVhSIU4dcnh6wnHiTCbBCowTWTdA=;
        b=Ve1l5vv3+yYPJxSd1ls9zYsLo0HvyLtfyPV3ahJ75n1F5jzaKbttFD77yNWjJhm9sP
         BfUL027GWlUMIOt1zmxUmUWjdvBbj8KTOZSvTwVyvDOWot1y/UiRCZb4mRzlDTkNw5/n
         liRs23aB0V7yESV4DXMxMoLoNBaioPaUO2WA5SJG+RmHG5ngVbF7y0GN9JSwHgdQlvN1
         qnMsZGKwttSi41UdPC3RdhaoCeNhP8g5B5eaRmkFezSlAYN939ex+FacPe5lQS1c/ocm
         pSKpoeqyymD0Lg1FeJrgkC2hojEhd/wbr2vV5o5Uo7M7Jd2FCLiESiplPMHgGmS15DLN
         zFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hYVacxGHKy+AogtVhSIU4dcnh6wnHiTCbBCowTWTdA=;
        b=dxqp9G9Ct1orDJkwd3Jy8BiyhFvxm/fPgAdgjb3sln/goyWZiQJM6ljIgkQ/J3TUNi
         BlGh6QAJXihfHZI9xPO6UtyHrCy3Uq+PlzvuqF3nlNdzq0LdxxW+p8i/8atSE31BsK+C
         eCfVqAJsAPfInB6v4TNju0R84GNPAeFHYhBrvBI9VeMFYey3zCVH9AFqaOorHuDvQf74
         lT4s4VPFVFavxAQl/O5e/MlAW3R2fNq+t95O1WKgxqM6w+9rdDR+h+TiWBt61A1Aqrji
         sJrP4FKJc1K1FZKrdmUuPutd8wn8syHj50k7I5tvHesitJq8D30mT24t9IiNRqedxasy
         e8rw==
X-Gm-Message-State: APjAAAUKnprUJKi7yO+hTpaJJKnxVaSyGLa8jB53xwvcn4VSAk7s0wR9
        MVc6XOK9lobQatMYdKWIhiPzCniRkFtmaA==
X-Google-Smtp-Source: APXvYqxSNS8TxMxrC4kP0XMSjY3QybHCYNBr38i2OmCjImVcXWb5gUj3CJD01yRMykg57I6cB83nzg==
X-Received: by 2002:a37:a090:: with SMTP id j138mr4499113qke.83.1567005326126;
        Wed, 28 Aug 2019 08:15:26 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c13sm984997qtg.3.2019.08.28.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 08:15:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v2] btrfs: stop partially refilling tickets when releasing space
Date:   Wed, 28 Aug 2019 11:15:24 -0400
Message-Id: <20190828151524.17706-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-5-josef@toxicpanda.com>
References: <20190822191102.13732-5-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_space_info_add_old_bytes is used when adding the extra space from
an existing reservation back into the space_info to be used by any
waiting tickets.  In order to keep us from overcommitting we check to
make sure that we can still use this space for our reserve ticket, and
if we cannot we'll simply subtract it from space_info->bytes_may_use.

However this is problematic, because it assumes that only changes to
bytes_may_use would affect our ability to make reservations.  Any
changes to bytes_reserved would be missed.  If we were unable to make a
reservation prior because of reserved space, but that reserved space was
free'd due to unlink or truncate and we were allowed to immediately
reclaim that metadata space we would still ENOSPC.

Consider the example where we create a file with a bunch of extents,
using up 2mib of actual space for the new tree blocks.  Then we try to
make a reservation of 2mib but we do not have enough space to make this
reservation.  The iput() occurs in another thread and we remove this
space, and since we did not write the blocks we simply do
space_info->bytes_reserved -= 2mib.  We would never see this because we
do not check our space info used, we just try to re-use the freed
reservations.

To fix this problem, and to greatly simplify the wakeup code, do away
with this partial refilling nonsense.  Use
btrfs_space_info_add_old_bytes to subtract the reservation from
space_info->bytes_may_use, and then check the ticket against the total
used of the space_info the same way we do with the initial reservation
attempt.

This keeps the reservation logic consistent and solves the problem of
early ENOSPC in the case that we free up space in places other than
bytes_may_use and bytes_pinned.  Thanks,

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Simply updated the changelog, what I was describing couldn't actually happen.
  I went back and re-ran tests and added in tracing and realized it was
  bytes_reserved that was changing without telling anybody, not that we were
  removing more of bytes_may_use than expected.  Updated the changelog to
  reflect this as well as hopefully make it clearer the motivation for the
  change.

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

