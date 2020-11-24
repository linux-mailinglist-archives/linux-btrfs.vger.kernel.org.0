Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA92C2BCC
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 16:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389875AbgKXPtg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 10:49:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:58002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389339AbgKXPtg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 10:49:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606232974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JM5bOZuTGI0R1AX75x6mDXJGtIIS2e1kAORq0mhc2AY=;
        b=IAUO/qQIZcA+9vhq5enjTKaONqBHZqODjKUMXvFEwDuGe+KFpcS1QYLgLX5eOTlSf15+le
        RhSPiYDBwHBWVvDOMEajntDu5FC8EgxJrpi8eQ/8ZmI97VxTlGYpgA2xJewAJD6nFucMFa
        9Q1Krct9wCyFL36Vj60mTn+E5TqYINA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF191ACBF;
        Tue, 24 Nov 2020 15:49:34 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: Eliminate err variable from merge_reloc_root
Date:   Tue, 24 Nov 2020 17:49:31 +0200
Message-Id: <20201124154932.3180539-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124154932.3180539-1-nborisov@suse.com>
References: <20201124154932.3180539-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In most cases when an error is returned from a function 'ret' is simply
assigned to 'err'. There is only 1 case where walk_up_reloc_tree can
return a positive value - in this case the code breaks from the loop and
ret is going to get its return value from btrfs_cow_block - either 0 or
negative. This retains the old logic of how 'err' used to be set at
this call site.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/relocation.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c5774a8e6ff7..8fc75db901c8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1630,8 +1630,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	int level;
 	int max_level;
 	int replaced = 0;
-	int ret;
-	int err = 0;
+	int ret = 0;
 	u32 min_reserved;
 
 	path = btrfs_alloc_path();
@@ -1682,13 +1681,11 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	while (1) {
 		ret = btrfs_block_rsv_refill(root, rc->block_rsv, min_reserved,
 					     BTRFS_RESERVE_FLUSH_LIMIT);
-		if (ret) {
-			err = ret;
+		if (ret)
 			goto out;
-		}
 		trans = btrfs_start_transaction(root, 0);
 		if (IS_ERR(trans)) {
-			err = PTR_ERR(trans);
+			ret = PTR_ERR(trans);
 			trans = NULL;
 			goto out;
 		}
@@ -1710,10 +1707,8 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 		max_level = level;
 
 		ret = walk_down_reloc_tree(reloc_root, path, &level);
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			goto out;
-		}
 		if (ret > 0)
 			break;
 
@@ -1724,11 +1719,8 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 			ret = replace_path(trans, rc, root, reloc_root, path,
 					   &next_key, level, max_level);
 		}
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			goto out;
-		}
-
 		if (ret > 0) {
 			level = ret;
 			btrfs_node_key_to_cpu(path->nodes[level], &key,
@@ -1767,12 +1759,10 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 			      BTRFS_NESTING_COW);
 	btrfs_tree_unlock(leaf);
 	free_extent_buffer(leaf);
-	if (ret < 0)
-		err = ret;
 out:
 	btrfs_free_path(path);
 
-	if (err == 0)
+	if (ret == 0)
 		insert_dirty_subvol(trans, rc, root);
 
 	if (trans)
@@ -1783,7 +1773,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	if (replaced && rc->stage == UPDATE_DATA_PTRS)
 		invalidate_extent_cache(root, &key, &next_key);
 
-	return err;
+	return ret;
 }
 
 static noinline_for_stack
-- 
2.25.1

