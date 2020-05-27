Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16F71E3EB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgE0KLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:11:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgE0KLM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:11:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00EABAE28;
        Wed, 27 May 2020 10:11:13 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Simplify setup_nodes_for_search
Date:   Wed, 27 May 2020 13:11:09 +0300
Message-Id: <20200527101109.7492-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is needlessly convoluted. Fix that by:

* Removing redundant sret variable definition in both if arms
* Replace the again/done labels with direct return statements, the
function is short enough and doesn't do anything special upon exit.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 72a3389d2d87..bd1d54e6b4cc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2436,55 +2436,46 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,

 	if ((p->search_for_split || ins_len > 0) && btrfs_header_nritems(b) >=
 	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 3) {
-		int sret;

 		if (*write_lock_level < level + 1) {
 			*write_lock_level = level + 1;
 			btrfs_release_path(p);
-			goto again;
+			return -EAGAIN;
 		}

 		btrfs_set_path_blocking(p);
 		reada_for_balance(fs_info, p, level);
-		sret = split_node(trans, root, p, level);
+		ret = split_node(trans, root, p, level);
+
+		BUG_ON(ret > 0);
+		if (ret)
+			return ret;

-		BUG_ON(sret > 0);
-		if (sret) {
-			ret = sret;
-			goto done;
-		}
 		b = p->nodes[level];
 	} else if (ins_len < 0 && btrfs_header_nritems(b) <
 		   BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 2) {
-		int sret;

 		if (*write_lock_level < level + 1) {
 			*write_lock_level = level + 1;
 			btrfs_release_path(p);
-			goto again;
+			return -EAGAIN;
 		}

 		btrfs_set_path_blocking(p);
 		reada_for_balance(fs_info, p, level);
-		sret = balance_level(trans, root, p, level);
+		ret = balance_level(trans, root, p, level);
+
+		if (ret)
+			return ret;

-		if (sret) {
-			ret = sret;
-			goto done;
-		}
 		b = p->nodes[level];
 		if (!b) {
 			btrfs_release_path(p);
-			goto again;
+			return -EAGAIN;
 		}
 		BUG_ON(btrfs_header_nritems(b) == 1);
 	}
 	return 0;
-
-again:
-	ret = -EAGAIN;
-done:
-	return ret;
 }

 int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *path,
--
2.17.1

