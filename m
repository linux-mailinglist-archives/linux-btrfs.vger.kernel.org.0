Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FCE2DCBCB
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 05:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgLQE6g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 23:58:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgLQE6g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 23:58:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608181069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqUH/zW/pYgc5y8gvC47cOLC+rhn4Ea3Y+Ct+jCG47I=;
        b=AsbrdhrFrakw4cquU0TDBS1tfHBdc5lyNcD8LZsvJ1Qo9pmnP62ThmsJcuNZkQOFsXOFp+
        XJ9pM4cApXgY2usAM0g/0drlfAEq/frlkN5VYaNSk//1uC52xpWoHOfeybp+OS2VAgLrZ9
        4MIEnwklfxZBZlyE0t7h+CVQQjDl+dk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8C37ACC6
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 04:57:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: inode: use min() to replace open-code in btrfs_invalidatepage()
Date:   Thu, 17 Dec 2020 12:57:34 +0800
Message-Id: <20201217045737.48100-2-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217045737.48100-1-wqu@suse.com>
References: <20201217045737.48100-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_invalidatepage() we introduce a temporary variable, new_len, to
update ordered->truncated_len.

But we can use min() to replace it completely and no need for the
variable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index af3439b21bc4..dced71bccaac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8219,15 +8219,13 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		 */
 		if (TestClearPagePrivate2(page)) {
 			struct btrfs_ordered_inode_tree *tree;
-			u64 new_len;
 
 			tree = &inode->ordered_tree;
 
 			spin_lock_irq(&tree->lock);
 			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
-			new_len = start - ordered->file_offset;
-			if (new_len < ordered->truncated_len)
-				ordered->truncated_len = new_len;
+			ordered->truncated_len = min(ordered->truncated_len,
+					start - ordered->file_offset);
 			spin_unlock_irq(&tree->lock);
 
 			ASSERT(end - start + 1 < U32_MAX);
-- 
2.29.2

