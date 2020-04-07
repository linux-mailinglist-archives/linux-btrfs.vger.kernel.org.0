Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6694E1A0C18
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgDGKiw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 06:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgDGKiw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Apr 2020 06:38:52 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5949320644
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Apr 2020 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255931;
        bh=a32MkUzo+FvJDWncrER1zh4qr121eGt/s6SVoPHS3Nc=;
        h=From:To:Subject:Date:From;
        b=fvaTKgovf4/iWK8516bitpoV5MPyGO7oLXLkqksL9wicOuOLxAMeIaxDgeYiHB55c
         TYx/yhNGtHJHzvzVzPgNdh/Q8uCR+WxfFpIkqHQhG2xkVFnCdwMR7fIcSNFe82JGTZ
         kFpH0jUyU9ZBoEnO/SrlMy72pyh6UeuVGAffTGvc=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] Btrfs: fix reclaim counter leak of space_info objects
Date:   Tue,  7 Apr 2020 11:38:49 +0100
Message-Id: <20200407103849.28086-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Whenever we add a ticket to a space_info object we increment the object's
reclaim_size counter witht the ticket's bytes, and we decrement it with
the corresponding amount only when we are able to grant the requested
space to the ticket. When we are not able to grant the space to a ticket,
or when the ticket is removed due to a signal (e.g. an application has
received sigterm from the terminal) we never decrement the counter with
the corresponding bytes from the ticket. This leak can result in the
space reclaim code to later do much more work than necessary. So fix it
by decrementing the counter when those two cases happen as well.

Fixes: db161806dc5615 ("btrfs: account ticket size at add/delete time")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c |  1 +
 fs/btrfs/space-info.c  | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 786849fcc319..47f66c6a7d7f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3370,6 +3370,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 			    space_info->bytes_reserved > 0 ||
 			    space_info->bytes_may_use > 0))
 			btrfs_dump_space_info(info, space_info, 0, 0);
+		WARN_ON(space_info->reclaim_size > 0);
 		list_del(&space_info->list);
 		btrfs_sysfs_remove_space_info(space_info);
 	}
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8b0fe053a25d..ff17a4420358 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -361,6 +361,16 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static void remove_ticket(struct btrfs_space_info *space_info,
+			  struct reserve_ticket *ticket)
+{
+	if (!list_empty(&ticket->list)) {
+		list_del_init(&ticket->list);
+		ASSERT(space_info->reclaim_size >= ticket->bytes);
+		space_info->reclaim_size -= ticket->bytes;
+	}
+}
+
 /*
  * This is for space we already have accounted in space_info->bytes_may_use, so
  * basically when we're returning space from block_rsv's.
@@ -388,9 +398,7 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 			btrfs_space_info_update_bytes_may_use(fs_info,
 							      space_info,
 							      ticket->bytes);
-			list_del_init(&ticket->list);
-			ASSERT(space_info->reclaim_size >= ticket->bytes);
-			space_info->reclaim_size -= ticket->bytes;
+			remove_ticket(space_info, ticket);
 			ticket->bytes = 0;
 			space_info->tickets_id++;
 			wake_up(&ticket->wait);
@@ -899,7 +907,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 			btrfs_info(fs_info, "failing ticket with %llu bytes",
 				   ticket->bytes);
 
-		list_del_init(&ticket->list);
+		remove_ticket(space_info, ticket);
 		ticket->error = -ENOSPC;
 		wake_up(&ticket->wait);
 
@@ -1063,7 +1071,7 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 			 * despite getting an error, resulting in a space leak
 			 * (bytes_may_use counter of our space_info).
 			 */
-			list_del_init(&ticket->list);
+			remove_ticket(space_info, ticket);
 			ticket->error = -EINTR;
 			break;
 		}
@@ -1121,7 +1129,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 		 * either the async reclaim job deletes the ticket from the list
 		 * or we delete it ourselves at wait_reserve_ticket().
 		 */
-		list_del_init(&ticket->list);
+		remove_ticket(space_info, ticket);
 		if (!ret)
 			ret = -ENOSPC;
 	}
-- 
2.11.0

