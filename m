Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0498A210825
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 11:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgGAJac (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 05:30:32 -0400
Received: from mail.synology.com ([211.23.38.101]:41244 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbgGAJac (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 05:30:32 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jul 2020 05:30:30 EDT
Received: from localhost.localdomain (unknown [10.17.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 22797CE78031;
        Wed,  1 Jul 2020 17:25:02 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1593595502; bh=vmaLzrgyXsA/w7RySgTkfZcXycOo9zcOG7ic0XlP7Rk=;
        h=From:To:Cc:Subject:Date;
        b=q9oIf2mkYJjrChhJVmEYYu2lkwIsJeGav0EByfPgGb62Zg8Rqh6dr+m7ncc/S49NC
         8kKQU4/Y0SYZ6EiGJrrN1nJ6Adn6wOzbxyti9xmHZg6DY6vQm4ZK8IFcJa41q2DAVN
         3TwrXM389v5SgWGo3/zjWIJAIWuzjrouMYiskxjw=
From:   robbieko <robbieko@synology.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Robbie Ko <robbieko@synology.com>
Subject: [PATCH] btrfs: speedup mount time with force readahead chunk tree
Date:   Wed,  1 Jul 2020 17:24:49 +0800
Message-Id: <20200701092449.19545-1-robbieko@synology.com>
X-Mailer: git-send-email 2.17.1
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

When mounting, we always need to read the whole chunk tree,
when there are too many chunk items, most of the time is
spent on btrfs_read_chunk_tree, because we only read one
leaf at a time.

We fix this by adding a new readahead mode READA_FORWARD_FORCE,
which reads all the leaves after the key in the node when
reading a level 1 node.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/ctree.c   | 7 +++++--
 fs/btrfs/ctree.h   | 2 +-
 fs/btrfs/volumes.c | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3a7648bff42c..abb9108e2d7d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2194,7 +2194,7 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 			if (nr == 0)
 				break;
 			nr--;
-		} else if (path->reada == READA_FORWARD) {
+		} else if (path->reada == READA_FORWARD || path->reada == READA_FORWARD_FORCE) {
 			nr++;
 			if (nr >= nritems)
 				break;
@@ -2205,12 +2205,15 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 				break;
 		}
 		search = btrfs_node_blockptr(node, nr);
-		if ((search <= target && target - search <= 65536) ||
+		if ((path->reada == READA_FORWARD_FORCE) ||
+		    (search <= target && target - search <= 65536) ||
 		    (search > target && search - target <= 65536)) {
 			readahead_tree_block(fs_info, search);
 			nread += blocksize;
 		}
 		nscan++;
+		if (path->reada == READA_FORWARD_FORCE)
+			continue;
 		if ((nread > 65536 || nscan > 32))
 			break;
 	}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d404cce8ae40..808bcbdc9530 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -353,7 +353,7 @@ struct btrfs_node {
  * The slots array records the index of the item or block pointer
  * used while walking the tree.
  */
-enum { READA_NONE, READA_BACK, READA_FORWARD };
+enum { READA_NONE, READA_BACK, READA_FORWARD, READA_FORWARD_FORCE };
 struct btrfs_path {
 	struct extent_buffer *nodes[BTRFS_MAX_LEVEL];
 	int slots[BTRFS_MAX_LEVEL];
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0d6e785bcb98..78fd65abff69 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7043,6 +7043,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
+	path->reada = READA_FORWARD_FORCE;
 
 	/*
 	 * uuid_mutex is needed only if we are mounting a sprout FS
-- 
2.17.1

