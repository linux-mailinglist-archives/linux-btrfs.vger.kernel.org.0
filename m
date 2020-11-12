Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6F2B03AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 12:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgKLLQ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 06:16:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:48390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgKLLQ0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 06:16:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605179784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xEGwKs4Zqyd852Tm9QvnedCWw8IuU5KXRtXXuIUIWWA=;
        b=lIXIzD6Plyq3dNdLUHOIilsV4eM8ClBguF6Vg7JtisNb2NBi5UR35t7aSeKmb3CRI9j32Y
        R45CIBnN9YQb/y71LrSPo0m1DlcQ7wPt3rXZ5Tc2E8aHZxZpvqb9TyrjhSvSoW1mKWXmav
        TrupUifjZMtmLkqn+NeuP5sJJrvfLXk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62743AB95;
        Thu, 12 Nov 2020 11:16:24 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Simplify setup_nodes_for_search
Date:   Thu, 12 Nov 2020 13:16:22 +0200
Message-Id: <20201112111622.784178-1-nborisov@suse.com>
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
 fs/btrfs/ctree.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 892b467347a3..6c309dfee3f5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2394,52 +2394,38 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 
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

