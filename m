Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF63B3489EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 08:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCYHPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 03:15:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:36436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhCYHPG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 03:15:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616656505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xUvs9P8i27Mo5iLh6QK8nM3lgEZqPP99kmN2UWHl8XE=;
        b=j77BGx767ocCL4MgKIrQFffbFPgP2Rb7gM81+7bDHfNLgDxNAxR4cI8/Z9GHym3U1eue6Q
        GPJpDeupG73gX9vG6tSsHX/XGMgM6IeSHpmM9Ea5hG/Z4mlKfMII6+o6OOCVSt7Fk2ZAB6
        sWYtaHGbkWjQaWXZnysVrTCR33z79zI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 572C6AD71;
        Thu, 25 Mar 2021 07:15:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 03/13] btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage()
Date:   Thu, 25 Mar 2021 15:14:35 +0800
Message-Id: <20210325071445.90896-4-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
References: <20210325071445.90896-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_invalidatepage() we re-declare @tree variable as
btrfs_ordered_inode_tree.

Since it's only used to do the spinlock, we can grab it from inode
directly, and remove the unnecessary declaration completely.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ab42d1d0c1f2..d777f67d366b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8409,15 +8409,11 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		 * for the finish_ordered_io
 		 */
 		if (TestClearPagePrivate2(page)) {
-			struct btrfs_ordered_inode_tree *tree;
-
-			tree = &inode->ordered_tree;
-
-			spin_lock_irq(&tree->lock);
+			spin_lock_irq(&inode->ordered_tree.lock);
 			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
 			ordered->truncated_len = min(ordered->truncated_len,
 					start - ordered->file_offset);
-			spin_unlock_irq(&tree->lock);
+			spin_unlock_irq(&inode->ordered_tree.lock);
 
 			if (btrfs_dec_test_ordered_pending(inode, &ordered,
 							   start,
-- 
2.30.1

