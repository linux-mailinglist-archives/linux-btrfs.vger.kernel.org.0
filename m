Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167A0333856
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhCJJJT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:09:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:34680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231492AbhCJJIs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:08:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615367326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFzUcqMoymWdrtGFPzOKYkfz451nUeU2/0G08f7YHMY=;
        b=auhnWkq99WkgYiIw05k4B4Pn5BxqQxYnSvyoW9S27/3DTRAj7+M2fhw+yt3kKFKdMYcBTu
        rSXmySWcPTds3Bhcn7KqV78jsakgGyijdxA1+ScB/+u8N4vWkeRf9MlxsvXW53hQlWWY6H
        r2gDi5rELjm2AcCf17hoantj1EoH5kc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3275AE1B
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:08:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/15] btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage()
Date:   Wed, 10 Mar 2021 17:08:21 +0800
Message-Id: <20210310090833.105015-4-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210310090833.105015-1-wqu@suse.com>
References: <20210310090833.105015-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_invalidatepage() we re-declare @tree variable as
btrfs_ordered_inode_tree.

Since it's only used to do the spinlock, we can grab it from inode
directly, and remove the unnecessary declaration completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2973cec05505..f99554f0bd48 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8404,15 +8404,11 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
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

