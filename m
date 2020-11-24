Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF722C2BCD
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 16:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389877AbgKXPth (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 10:49:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:58022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389441AbgKXPtg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 10:49:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606232975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHhZKRb2Mat8A/SmR3oOgyCvYICMxzOcS9KCaiQsV00=;
        b=qXipuEENUUu9zC4mdnv4uIGXRE93KlGS9nplb64EBTjGC2+AKs645tTrwM293DByDIIVoh
        2cN3pWKq7cFXpeyZUDrFfYlbBAM+qjFcSlmEB1zCMJh8D3RfF5W1qRerC2KCY71yzzFpkV
        8O2/Sdll6XMZPBANrDkpJcsttEEH1QE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B2F5ACC2;
        Tue, 24 Nov 2020 15:49:35 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: Remove err variable from do_relocation
Date:   Tue, 24 Nov 2020 17:49:32 +0200
Message-Id: <20201124154932.3180539-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124154932.3180539-1-nborisov@suse.com>
References: <20201124154932.3180539-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It simply gets assigned to 'ret' in case of errors. The flow of the
while loop is not changed by this commit since the few call sites
that 'goto next' will simply break from the loop.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/relocation.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8fc75db901c8..6e7e5fe2e277 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2181,8 +2181,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	u32 blocksize;
 	u64 bytenr;
 	int slot;
-	int ret;
-	int err = 0;
+	int ret = 0;
 
 	BUG_ON(lowest && node->eb);
 
@@ -2200,10 +2199,8 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 		if (upper->eb && !upper->locked) {
 			if (!lowest) {
 				ret = btrfs_bin_search(upper->eb, key, &slot);
-				if (ret < 0) {
-					err = ret;
+				if (ret < 0)
 					goto next;
-				}
 				BUG_ON(ret);
 				bytenr = btrfs_node_blockptr(upper->eb, slot);
 				if (node->eb->start == bytenr)
@@ -2215,10 +2212,8 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 		if (!upper->eb) {
 			ret = btrfs_search_slot(trans, root, key, path, 0, 1);
 			if (ret) {
-				if (ret < 0)
-					err = ret;
-				else
-					err = -ENOENT;
+				if (ret > 0)
+					ret = -ENOENT;
 
 				btrfs_release_path(path);
 				break;
@@ -2238,10 +2233,8 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_release_path(path);
 		} else {
 			ret = btrfs_bin_search(upper->eb, key, &slot);
-			if (ret < 0) {
-				err = ret;
+			if (ret < 0)
 				goto next;
-			}
 			BUG_ON(ret);
 		}
 
@@ -2252,7 +2245,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 		"lowest leaf/node mismatch: bytenr %llu node->bytenr %llu slot %d upper %llu",
 					  bytenr, node->bytenr, slot,
 					  upper->eb->start);
-				err = -EIO;
+				ret = -EIO;
 				goto next;
 			}
 		} else {
@@ -2263,7 +2256,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 		blocksize = root->fs_info->nodesize;
 		eb = btrfs_read_node_slot(upper->eb, slot);
 		if (IS_ERR(eb)) {
-			err = PTR_ERR(eb);
+			ret = PTR_ERR(eb);
 			goto next;
 		}
 		btrfs_tree_lock(eb);
@@ -2273,10 +2266,8 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 					      slot, &eb, BTRFS_NESTING_COW);
 			btrfs_tree_unlock(eb);
 			free_extent_buffer(eb);
-			if (ret < 0) {
-				err = ret;
+			if (ret < 0)
 				goto next;
-			}
 			BUG_ON(node->eb != eb);
 		} else {
 			btrfs_set_node_blockptr(upper->eb, slot,
@@ -2302,19 +2293,19 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_backref_drop_node_buffer(upper);
 		else
 			btrfs_backref_unlock_node_buffer(upper);
-		if (err)
+		if (ret)
 			break;
 	}
 
-	if (!err && node->pending) {
+	if (!ret && node->pending) {
 		btrfs_backref_drop_node_buffer(node);
 		list_move_tail(&node->list, &rc->backref_cache.changed);
 		node->pending = 0;
 	}
 
 	path->lowest_level = 0;
-	BUG_ON(err == -ENOSPC);
-	return err;
+	BUG_ON(ret == -ENOSPC);
+	return ret;
 }
 
 static int link_to_upper(struct btrfs_trans_handle *trans,
-- 
2.25.1

