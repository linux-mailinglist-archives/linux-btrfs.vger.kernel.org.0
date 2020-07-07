Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E792164F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 05:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgGGD7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 23:59:50 -0400
Received: from mail.synology.com ([211.23.38.101]:50320 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726478AbgGGD7u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 23:59:50 -0400
Received: from localhost.localdomain (unknown [10.17.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 401DACE782D5;
        Tue,  7 Jul 2020 11:59:48 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594094388; bh=+159Bbp0cMWw7t/PKZ8gbPP+Pvq1tDBaJGnj+W6YzQ4=;
        h=From:To:Cc:Subject:Date;
        b=NssxO/6/ne4DDPvm2uCFVi/zcmQy3G7CkSaHG4dyu3vXgjd9DwArWNmjhNfdDCGA3
         VTdE7SFHG43JdWjOWAeMT7nMhSw/YJo6AZ3DVvK3Z7mbAZmfMNbLZhZm9Uz6yQfG5w
         fRHZWY4X90w/SBIhXnAVbpoGeN4+zR+6/0+beIbU=
From:   robbieko <robbieko@synology.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH v2] btrfs: speedup mount time with readahead chunk tree
Date:   Tue,  7 Jul 2020 11:59:44 +0800
Message-Id: <20200707035944.15150-1-robbieko@synology.com>
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

It is unreasonable to limit the readahead mechanism to a
range of 64k, so we have removed that limit.

In addition we added reada_maximum_size to customize the
size of the pre-reader, The default is 64k to maintain the
original behavior.

So we fix this by used readahead mechanism, and set readahead
max size to ULLONG_MAX which reads all the leaves after the
key in the node when reading a level 1 node.

I have a test environment as follows:

200TB btrfs volume: used 192TB

Data, single: total=192.00TiB, used=192.00TiB
System, DUP: total=40.00MiB, used=19.91MiB
Metadata, DUP: total=63.00GiB, used=46.46GiB
GlobalReserve, single: total=2.00GiB, used=0.00B

chunk tree level : 2
chunk tree tree:
   nodes: 4
   leaves: 1270
   total: 1274
chunk tree size: 19.9 MB
SYSTEM chunks count : 2 (8MB, 32MB)

btrfs_read_chunk_tree spends the following time:
before: 1.89s
patch: 0.27s
Speed increase of about 85%.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
Changelog:
v2:
- add performance testing
- remove readahead logical bytenr 64k limit
- add reada_maximum_size for customize
---
 fs/btrfs/ctree.c   | 23 +++++++++++------------
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/volumes.c |  2 ++
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3a7648bff42c..dc84f526cd93 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -75,7 +75,14 @@ size_t __const btrfs_get_num_csums(void)
 
 struct btrfs_path *btrfs_alloc_path(void)
 {
-	return kmem_cache_zalloc(btrfs_path_cachep, GFP_NOFS);
+	struct btrfs_path *path;
+
+	path = kmem_cache_zalloc(btrfs_path_cachep, GFP_NOFS);
+
+	if (path)
+		path->reada_maximum_size = 65536;
+
+	return path;
 }
 
 /* this also releases the path */
@@ -2161,12 +2168,10 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 	struct btrfs_disk_key disk_key;
 	u32 nritems;
 	u64 search;
-	u64 target;
 	u64 nread = 0;
 	struct extent_buffer *eb;
 	u32 nr;
 	u32 blocksize;
-	u32 nscan = 0;
 
 	if (level != 1)
 		return;
@@ -2184,8 +2189,6 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 		return;
 	}
 
-	target = search;
-
 	nritems = btrfs_header_nritems(node);
 	nr = slot;
 
@@ -2205,13 +2208,9 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 				break;
 		}
 		search = btrfs_node_blockptr(node, nr);
-		if ((search <= target && target - search <= 65536) ||
-		    (search > target && search - target <= 65536)) {
-			readahead_tree_block(fs_info, search);
-			nread += blocksize;
-		}
-		nscan++;
-		if ((nread > 65536 || nscan > 32))
+		readahead_tree_block(fs_info, search);
+		nread += blocksize;
+		if (nread > path->reada_maximum_size)
 			break;
 	}
 }
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d404cce8ae40..ea88a6473eb8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -360,6 +360,7 @@ struct btrfs_path {
 	/* if there is real range locking, this locks field will change */
 	u8 locks[BTRFS_MAX_LEVEL];
 	u8 reada;
+	u64 reada_maximum_size;
 	/* keep some upper locks as we walk down */
 	u8 lowest_level;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0d6e785bcb98..fc87b2e9e865 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7043,6 +7043,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
+	path->reada = READA_FORWARD;
+	path->reada_maximum_size = ULLONG_MAX;
 
 	/*
 	 * uuid_mutex is needed only if we are mounting a sprout FS
-- 
2.17.1

