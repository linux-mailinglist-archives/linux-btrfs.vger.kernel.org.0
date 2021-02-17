Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7795D31DA03
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 14:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhBQNNk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 08:13:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:56752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232660AbhBQNNj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 08:13:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613567573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/u1KLvq3raS0AkW9Mh8M2Xx5F7eAZcpuR6UdbWqv9I=;
        b=Adm2IO9G2cUAezE7PfTPZdYgQBQfQw4bkIouDiaGlFkZEDIGIMLhUa8mwi8uLS8xvAO+hn
        1hxaQvP55pWEvvPkVWjCwu9fSsm44RmcaSBLlsp9br4j0AgV8SH1nzWzh+jCjXdPzOxstQ
        n42zN4fU04AoY9Mp+q6oirnC6Xz0/gg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 502B8B8F4;
        Wed, 17 Feb 2021 13:12:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/4] btrfs: Replace opencoded while loop with proper construct
Date:   Wed, 17 Feb 2021 15:12:50 +0200
Message-Id: <20210217131250.265859-5-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217131250.265859-1-nborisov@suse.com>
References: <20210217131250.265859-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_inc_block_group_ro wants to ensure that the current transaction is
not running dirty block groups, if it is it waits and loops again.
That logic is currently implemented using a goto label. Actually using
a proper do {} while() construct doesn't hurt readibility nor does it
introduce excessive nesting and makes the relevant code stand out by
being encompassed in the loop construct. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5064be59dac5..fabd25b76abb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2262,29 +2262,33 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	struct btrfs_trans_handle *trans;
 	u64 alloc_flags;
 	int ret;
+	bool dirty_bg_running;
 
-again:
-	trans = btrfs_join_transaction(fs_info->extent_root);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
+	do {
+		trans = btrfs_join_transaction(fs_info->extent_root);
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
 
-	/*
-	 * we're not allowed to set block groups readonly after the dirty
-	 * block groups cache has started writing.  If it already started,
-	 * back off and let this transaction commit
-	 */
-	mutex_lock(&fs_info->ro_block_group_mutex);
-	if (test_bit(BTRFS_TRANS_DIRTY_BG_RUN, &trans->transaction->flags)) {
-		u64 transid = trans->transid;
+		dirty_bg_running = false;
 
-		mutex_unlock(&fs_info->ro_block_group_mutex);
-		btrfs_end_transaction(trans);
+		/*
+		 * we're not allowed to set block groups readonly after the dirty
+		 * block groups cache has started writing.  If it already started,
+		 * back off and let this transaction commit
+		 */
+		mutex_lock(&fs_info->ro_block_group_mutex);
+		if (test_bit(BTRFS_TRANS_DIRTY_BG_RUN, &trans->transaction->flags)) {
+			u64 transid = trans->transid;
 
-		ret = btrfs_wait_for_commit(fs_info, transid);
-		if (ret)
-			return ret;
-		goto again;
-	}
+			mutex_unlock(&fs_info->ro_block_group_mutex);
+			btrfs_end_transaction(trans);
+
+			ret = btrfs_wait_for_commit(fs_info, transid);
+			if (ret)
+				return ret;
+			dirty_bg_running = true;
+		}
+	} while (dirty_bg_running);
 
 	if (do_chunk_alloc) {
 		/*
-- 
2.25.1

