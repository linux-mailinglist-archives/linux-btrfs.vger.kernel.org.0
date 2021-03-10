Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ABF333853
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhCJJJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:09:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:34636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232536AbhCJJIp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:08:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615367324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/x2j7tJnKMd/biipz8bOY9VEFgXErGUHF0dX3BYXGo=;
        b=uXngKrzJHA1bg+U4tGSQcJBHHUe++mGCZ9nN38tg+9iugWk//E6xPItuG+gyOZiNd6uRm+
        0KhTy5KKOcKkq3Q/bQtta5EXUz+BXLUs6t/wI7p1PG8DsCxZKDNR6mWxPCAtWcmSwQGsYZ
        1i1pPKVjF6YL58UDvmNw55g4cCUzh/U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7B87AE1B
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:08:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/15] btrfs: use min() to replace open-code in btrfs_invalidatepage()
Date:   Wed, 10 Mar 2021 17:08:20 +0800
Message-Id: <20210310090833.105015-3-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210310090833.105015-1-wqu@suse.com>
References: <20210310090833.105015-1-wqu@suse.com>
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
index 52dc5f52ea58..2973cec05505 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8405,15 +8405,13 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
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

