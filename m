Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E622C28B318
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbgJLKze (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 06:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387573AbgJLKze (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 06:55:34 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2CD208FE
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 10:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602500133;
        bh=d95tuZKSLtojl4nkLGC0UXkfyd0iKnO/OVHHTkAMT5o=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=yX0H06SyE4no2nU5+PNNS+x69639ivNtVFUAjjzIiH2kBHiV1/6pwxXKcx8jGoffh
         URS0ZZ0yjh8EwoIyCoJGyliJ2jcP556OAZsbq6qZpAoUCPdWlcEBOuvuReSFO1QpGn
         /w5Ipzzp0ql7KBDPz4nl4R7Nt5fVuanfA4R4o33Y=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: do not start readahead for csum tree when scrubbing non-data block groups
Date:   Mon, 12 Oct 2020 11:55:26 +0100
Message-Id: <fdde80f42dc3e822ab990d28d584175eb0ca222f.1602499588.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602499587.git.fdmanana@suse.com>
References: <cover.1602499587.git.fdmanana@suse.com>
In-Reply-To: <cover.1602499587.git.fdmanana@suse.com>
References: <cover.1602499587.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When scrubbing a stripe of a block group we always start readahead for the
checksums btree and wait for it to complete, however when the blockgroup is
not a data block group (or a mixed block group) it is a waste of time to do
it, since there are no checksums for metadata extents in that btree.

So skip that when the block group does not have the data flag set, saving
some time doing memory allocations, queueing a job in the readahead work
queue, waiting for it to complete and potentially avoiding some IO as well
(when csum tree extents are not in memory already).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/scrub.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cf63f1e27a27..54a4f34d4c1c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3084,17 +3084,21 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	key_end.offset = (u64)-1;
 	reada1 = btrfs_reada_add(root, &key, &key_end);
 
-	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-	key.type = BTRFS_EXTENT_CSUM_KEY;
-	key.offset = logical;
-	key_end.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-	key_end.type = BTRFS_EXTENT_CSUM_KEY;
-	key_end.offset = logic_end;
-	reada2 = btrfs_reada_add(csum_root, &key, &key_end);
+	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
+		key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+		key.type = BTRFS_EXTENT_CSUM_KEY;
+		key.offset = logical;
+		key_end.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+		key_end.type = BTRFS_EXTENT_CSUM_KEY;
+		key_end.offset = logic_end;
+		reada2 = btrfs_reada_add(csum_root, &key, &key_end);
+	} else {
+		reada2 = NULL;
+	}
 
 	if (!IS_ERR(reada1))
 		btrfs_reada_wait(reada1);
-	if (!IS_ERR(reada2))
+	if (!IS_ERR_OR_NULL(reada2))
 		btrfs_reada_wait(reada2);
 
 
-- 
2.28.0

