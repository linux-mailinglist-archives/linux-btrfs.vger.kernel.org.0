Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726183489EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 08:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCYHPl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 03:15:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhCYHPD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 03:15:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616656502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJAJuD2KnA5Fro1NUKeTnGFpPR1E7bek9lPhw+Glyok=;
        b=InO8+8RUcaOsY5WU5wuFGMsbsEeoyV53zjz3lABIiSsJ8SyayUHNAMxo32+v7fx3KDEMOq
        6i4PqQm332cKoO/bPgxJPpP1GrLxAyguIZ3pTPlKwXzECiBqUKKOpQfvFY2zcAKhn6b/Dh
        YG1PMiN9PdfzfBZgmgYLma7+Toeh3JU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B422FAA55;
        Thu, 25 Mar 2021 07:15:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 02/13] btrfs: use min() to replace open-code in btrfs_invalidatepage()
Date:   Thu, 25 Mar 2021 15:14:34 +0800
Message-Id: <20210325071445.90896-3-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
References: <20210325071445.90896-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_invalidatepage() we introduce a temporary variable, new_len, to
update ordered->truncated_len.

But we can use min() to replace it completely and no need for the
variable.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 288c7ce63a32..ab42d1d0c1f2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8410,15 +8410,13 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
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
 
 			if (btrfs_dec_test_ordered_pending(inode, &ordered,
-- 
2.30.1

