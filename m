Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD071F93F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgFOJww (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 05:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgFOJwv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 05:52:51 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9A702068E
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jun 2020 09:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592214771;
        bh=YfpQThCi9rSIuVP96dsApV7xqAHMemWRscXSmvISKss=;
        h=From:To:Subject:Date:From;
        b=tMVJLAj/2DhlF2BrxiomaJ1r9ReO4f9kmfaJ0Mqfq9bwEpMTguiy2qdsBGHOaS8Pb
         5E+JCWthm1CjDqw1q3n3EGbbHkEzRBq8bvHEFzIaEKCJemrQOKbvpicQ+sdn6oJmfm
         0r6PSZ62szN0pLdAtwtF9wRihdjD4wtwIdPdecmA=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] Btrfs: remove no longer used trans_list member of struct btrfs_ordered_extent
Date:   Mon, 15 Jun 2020 10:36:58 +0100
Message-Id: <20200615093658.287160-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The 'trans_list' member of an ordered extent was used to keep track of the
ordered extents for which a transaction commit had to wait. These were
ordered extents that were started and logged by an fsync. However we don't
do that anymore and before we stopped doing it we changed the approach to
wait for the ordered extents in commit 161c3549b45aee ("Btrfs: change how
we wait for pending ordered extents"), which stopped using that list and
therefore the 'trans_list' member is not used anymore since that commit.
So just remove it since it's doing nothing and making each ordered extent
structure waste memory (2 pointers).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 2 --
 fs/btrfs/ordered-data.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 73d5352c401b..350e5da001f0 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -197,7 +197,6 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 	INIT_LIST_HEAD(&entry->root_extent_list);
 	INIT_LIST_HEAD(&entry->work_list);
 	init_completion(&entry->completion);
-	INIT_LIST_HEAD(&entry->trans_list);
 
 	trace_btrfs_ordered_extent_add(inode, entry);
 
@@ -428,7 +427,6 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 	trace_btrfs_ordered_extent_put(entry->inode, entry);
 
 	if (refcount_dec_and_test(&entry->refs)) {
-		ASSERT(list_empty(&entry->trans_list));
 		ASSERT(list_empty(&entry->root_extent_list));
 		ASSERT(RB_EMPTY_NODE(&entry->rb_node));
 		if (entry->inode)
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 35e81b80bd5d..8c6b31babcda 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -101,9 +101,6 @@ struct btrfs_ordered_extent {
 	/* list of checksums for insertion when the extent io is done */
 	struct list_head list;
 
-	/* If the transaction needs to wait on this ordered extent */
-	struct list_head trans_list;
-
 	/* used to wait for the BTRFS_ORDERED_COMPLETE bit */
 	wait_queue_head_t wait;
 
-- 
2.26.2

