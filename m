Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012B04A8F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 19:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfFRR7W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 13:59:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:45084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727616AbfFRR7V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 13:59:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4078AEA1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 17:59:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0655DA871; Tue, 18 Jun 2019 20:00:08 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/6] btrfs: drop default value assignments in enums
Date:   Tue, 18 Jun 2019 20:00:08 +0200
Message-Id: <726fc64e15ad144b58a4494d87d5e72226631d72.1560880630.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560880630.git.dsterba@suse.com>
References: <cover.1560880630.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few more instances whre we don't need to specify the values as long as
they are the same that enum assigns automatically. All of the enums are
in-memory only and nothing relies on the exact values.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 14 +++++++-------
 fs/btrfs/file.c        |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7d26ec1e8608..fa7ff6b81fe0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -46,9 +46,9 @@
  *
  */
 enum {
-	CHUNK_ALLOC_NO_FORCE = 0,
-	CHUNK_ALLOC_LIMITED = 1,
-	CHUNK_ALLOC_FORCE = 2,
+	CHUNK_ALLOC_NO_FORCE,
+	CHUNK_ALLOC_LIMITED,
+	CHUNK_ALLOC_FORCE,
 };
 
 /*
@@ -7302,10 +7302,10 @@ wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
 }
 
 enum btrfs_loop_type {
-	LOOP_CACHING_NOWAIT = 0,
-	LOOP_CACHING_WAIT = 1,
-	LOOP_ALLOC_CHUNK = 2,
-	LOOP_NO_EMPTY_SIZE = 3,
+	LOOP_CACHING_NOWAIT,
+	LOOP_CACHING_WAIT,
+	LOOP_ALLOC_CHUNK,
+	LOOP_NO_EMPTY_SIZE,
 };
 
 static inline void
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5370152ea7e3..3c508d2a85bf 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2791,9 +2791,9 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
 }
 
 enum {
-	RANGE_BOUNDARY_WRITTEN_EXTENT = 0,
-	RANGE_BOUNDARY_PREALLOC_EXTENT = 1,
-	RANGE_BOUNDARY_HOLE = 2,
+	RANGE_BOUNDARY_WRITTEN_EXTENT,
+	RANGE_BOUNDARY_PREALLOC_EXTENT,
+	RANGE_BOUNDARY_HOLE,
 };
 
 static int btrfs_zero_range_check_range_boundary(struct inode *inode,
-- 
2.21.0

