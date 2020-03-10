Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E876817F28B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 10:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCJJAi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 05:00:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:55656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgCJJAi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 05:00:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D1552AE79;
        Tue, 10 Mar 2020 09:00:36 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Optimise space flushing machinery
Date:   Tue, 10 Mar 2020 11:00:35 +0200
Message-Id: <20200310090035.16676-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of iterating all pending tickets on the normal/priority list to
sum their total size the cost can be amortized across ticket addition/
removal. This turns O(n) + O(m) (where n is the size of the normal list
and m of the priority list) into O(1). This will mostly have effect in workloads
that experience heavy flushing.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/space-info.c | 13 ++++++++-----
 fs/btrfs/space-info.h |  4 ++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9cb511d8cd9d..316a724dc990 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -389,6 +389,8 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 							      space_info,
 							      ticket->bytes);
 			list_del_init(&ticket->list);
+			ASSERT(space_info->reclaim_size >= ticket->bytes);
+			space_info->reclaim_size -= ticket->bytes;
 			ticket->bytes = 0;
 			space_info->tickets_id++;
 			wake_up(&ticket->wait);
@@ -784,16 +786,15 @@ static inline u64
 btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 				 struct btrfs_space_info *space_info)
 {
-	struct reserve_ticket *ticket;
 	u64 used;
 	u64 avail;
 	u64 expected;
 	u64 to_reclaim = 0;

-	list_for_each_entry(ticket, &space_info->tickets, list)
-		to_reclaim += ticket->bytes;
-	list_for_each_entry(ticket, &space_info->priority_tickets, list)
-		to_reclaim += ticket->bytes;
+	lockdep_assert_held(&space_info->lock);
+
+	if (space_info->reclaim_size)
+		return space_info->reclaim_size;

 	avail = calc_available_free_space(fs_info, space_info,
 					  BTRFS_RESERVE_FLUSH_ALL);
@@ -1192,8 +1193,10 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	 * the list and we will do our own flushing further down.
 	 */
 	if (ret && flush != BTRFS_RESERVE_NO_FLUSH) {
+		ASSERT(space_info->reclaim_size >= 0);
 		ticket.bytes = orig_bytes;
 		ticket.error = 0;
+		space_info->reclaim_size += ticket.bytes;
 		init_waitqueue_head(&ticket.wait);
 		if (flush == BTRFS_RESERVE_FLUSH_ALL) {
 			list_add_tail(&ticket.list, &space_info->tickets);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 24514cd2c6c1..0e68a6dd2a79 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -54,6 +54,10 @@ struct btrfs_space_info {
 	struct list_head ro_bgs;
 	struct list_head priority_tickets;
 	struct list_head tickets;
+
+	u64 reclaim_size; /* Size of space that needs to be reclaimed in order
+			     to satisfy pending tickets */
+
 	/*
 	 * tickets_id just indicates the next ticket will be handled, so note
 	 * it's not stored per ticket.
--
2.17.1

