Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B742B1673
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 08:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMH3n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 02:29:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:52374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgKMH3n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 02:29:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605252581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tRq07XwlDc66UYAB/bNK8E8QsWJtcluLKWN0uYImD64=;
        b=C4e/BA7zatBuvNYQOI+zFUBtro1Af2b65p8zZhfjMzGTnpcjuRMkr2m6FqC2p/P/j+zLrR
        eSdV0T8Nd0oP2Ti8WfoW1jgpsm0SPfDk9a6ak6BuPuK19k2SxGocvmofbTHMozb+9dFFJY
        zQa0On3IopjkhZS/YIgd9oIkxrvtfus=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC6F8ABD1;
        Fri, 13 Nov 2020 07:29:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: Simplify setup_nodes_for_search
Date:   Fri, 13 Nov 2020 09:29:40 +0200
Message-Id: <20201113072940.479655-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is needlessly convoluted. Fix that by:

* Removing redundant sret variable definition in both if arms.

* Replace the again/done labels with direct return statements, the
function is short enough and doesn't do anything special upon exit.

* Remove BUG_ON on split_node returning a positive number - it can't
  happen as split_node returns either 0 or a negative error code.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V2:
- Initialize ret to 0 by default in case we don't hit any of the branch conditions
and simply exit.

 fs/btrfs/ctree.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 892b467347a3..5de33cd85cac 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2390,56 +2390,42 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 		       int *write_lock_level)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	int ret;
+	int ret = 0;

 	if ((p->search_for_split || ins_len > 0) && btrfs_header_nritems(b) >=
 	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 3) {
-		int sret;

 		if (*write_lock_level < level + 1) {
 			*write_lock_level = level + 1;
 			btrfs_release_path(p);
-			goto again;
+			return -EAGAIN;
 		}

 		reada_for_balance(p, level);
-		sret = split_node(trans, root, p, level);
+		ret = split_node(trans, root, p, level);

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

 		reada_for_balance(p, level);
-		sret = balance_level(trans, root, p, level);
+		ret = balance_level(trans, root, p, level);
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
-	return 0;
-
-again:
-	ret = -EAGAIN;
-done:
 	return ret;
 }

--
2.25.1

