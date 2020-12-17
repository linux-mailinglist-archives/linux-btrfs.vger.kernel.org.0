Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4D2DCBCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 05:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgLQE6r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 23:58:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:56174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgLQE6j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 23:58:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608181073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IekTWYruOn21zTR5jK2p6e6srdpXJV0F7f3mPjM7Tw8=;
        b=odE9RHr5HlKcRPvvAMKeLAhNg8KzNS3tI2Nxsm4QsPpbKVsOXeGQycaM/iWbJrFHIedRoG
        MHh9sK5yUj50l89JyzChUIKlJdSIAZVRu7KkIh7oTPaKDoAtRMrzWqrfXWh1FcMmZlDMqu
        fJzd3InvFK0XyJpzui8YPeEUfppwxJ8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1828DACF1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 04:57:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: inode: remove variable shadowing in btrfs_invalidatepage()
Date:   Thu, 17 Dec 2020 12:57:35 +0800
Message-Id: <20201217045737.48100-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217045737.48100-1-wqu@suse.com>
References: <20201217045737.48100-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_invalidatepage() we re-declare @tree variable as
btrfs_ordered_inode_tree.

Remove such variable shadowing which can be very confusing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dced71bccaac..b4d36d138008 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8169,6 +8169,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_ordered_inode_tree *ordered_tree = &inode->ordered_tree;
 	struct extent_io_tree *tree = &inode->io_tree;
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
@@ -8218,15 +8219,11 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		 * for the finish_ordered_io
 		 */
 		if (TestClearPagePrivate2(page)) {
-			struct btrfs_ordered_inode_tree *tree;
-
-			tree = &inode->ordered_tree;
-
-			spin_lock_irq(&tree->lock);
+			spin_lock_irq(&ordered_tree->lock);
 			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
 			ordered->truncated_len = min(ordered->truncated_len,
 					start - ordered->file_offset);
-			spin_unlock_irq(&tree->lock);
+			spin_unlock_irq(&ordered_tree->lock);
 
 			ASSERT(end - start + 1 < U32_MAX);
 			if (btrfs_dec_test_ordered_pending(inode, &ordered,
-- 
2.29.2

