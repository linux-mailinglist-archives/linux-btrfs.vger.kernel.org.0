Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F0A205BB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 21:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbgFWTYI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 15:24:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:44166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733220AbgFWTYI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 15:24:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0861EAB98;
        Tue, 23 Jun 2020 19:24:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6A7F7DA79B; Tue, 23 Jun 2020 21:23:55 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove unused btrfs_root::defrag_trans_start
Date:   Tue, 23 Jun 2020 21:23:54 +0200
Message-Id: <20200623192354.29423-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Last touched in 2013 by commit de78b51a2852 ("btrfs: remove cache only
arguments from defrag path") that was the only code that used the value.
Now it's only set but never used for anything, so we can remove it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h       | 1 -
 fs/btrfs/disk-io.c     | 4 ----
 fs/btrfs/tree-defrag.c | 5 ++---
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d8301bf240e0..297c51d3c74b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1075,7 +1075,6 @@ struct btrfs_root {
 
 	u64 highest_objectid;
 
-	u64 defrag_trans_start;
 	struct btrfs_key defrag_progress;
 	struct btrfs_key defrag_max;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c70d47b8090a..3aa3ae99710e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1141,10 +1141,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	memset(&root->root_key, 0, sizeof(root->root_key));
 	memset(&root->root_item, 0, sizeof(root->root_item));
 	memset(&root->defrag_progress, 0, sizeof(root->defrag_progress));
-	if (!dummy)
-		root->defrag_trans_start = fs_info->generation;
-	else
-		root->defrag_trans_start = 0;
 	root->root_key.objectid = objectid;
 	root->anon_dev = 0;
 
diff --git a/fs/btrfs/tree-defrag.c b/fs/btrfs/tree-defrag.c
index 16c3a6d2586d..d3f28b8f4ff9 100644
--- a/fs/btrfs/tree-defrag.c
+++ b/fs/btrfs/tree-defrag.c
@@ -133,10 +133,9 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 		ret = 0;
 	}
 done:
-	if (ret != -EAGAIN) {
+	if (ret != -EAGAIN)
 		memset(&root->defrag_progress, 0,
 		       sizeof(root->defrag_progress));
-		root->defrag_trans_start = trans->transid;
-	}
+
 	return ret;
 }
-- 
2.25.0

