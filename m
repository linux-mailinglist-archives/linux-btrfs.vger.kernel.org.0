Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86003507D89
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358463AbiDTAXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343907AbiDTAXE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF92C651
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5C3ED1F74E
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pia0aQ9feSExpPGpQyHMitdiJS7pxVk9MsfzU5fk79U=;
        b=D7k2w84th0dtN0y7YPiHsjN8pl/qyltbIZ/RZdze/xv7ROgXmzcnEnGCImzeNF88S+xrjL
        e7KhGzx98+CDro6tXEvaW/cikJuy8UKwgYbsAift7PbirFOFG5XWqCGZY+hZmyIUM7K/Km
        lJ3iYk9gZdBa89vuHdyt+hpSW857l8k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0D4B139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cPloGcJRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 01/10] btrfs-progs: refactor find_free_dev_extent_start() for later expansion
Date:   Wed, 20 Apr 2022 08:19:50 +0800
Message-Id: <8779c7e0adff47f37e41686b6c53112622ea468b.1650413308.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650413308.git.wqu@suse.com>
References: <cover.1650413308.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CURRENT BEHAVIOR]

We iterate through all dev extents, and calcluate the hole immediately.

This is fine, but for the later incoming delayed chunk allocation, it's
pretty hard to handle both dev extents in dev tree and in delayed
chunks.

[REFACTOR]

This patch will split the search into two part:

1. Populate @used_root cache tree
   That tree will record all used device extents

2. Iterate through each cache extent to calculate holes

With such separate loops, we can easily handle multiple dev extents
source, just queue them all into @used_root.

The 2nd part will handle everything well.

Since we're here, also add a comment on why we may want to re-search
after iterating all dev extents.
(Which is for zoned device boundary)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/volumes.c | 88 ++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 37 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 97c09a1a4931..c61fb51c4def 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -653,58 +653,59 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 				      u64 num_bytes, u64 search_start,
 				      u64 *start, u64 *len)
 {
-	struct btrfs_key key;
 	struct btrfs_root *root = device->dev_root;
-	struct btrfs_dev_extent *dev_extent;
-	struct btrfs_path *path;
-	u64 hole_size;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	struct cache_tree used_root;
+	struct cache_extent *pe;
 	u64 max_hole_start;
 	u64 max_hole_size;
-	u64 extent_end;
 	u64 search_end = device->total_bytes;
+	u64 hole_size;
 	int ret;
-	int slot;
-	struct extent_buffer *l;
 	u64 zone_size = 0;
 
+	cache_tree_init(&used_root);
 	if (device->zone_info)
 		zone_size = device->zone_info->zone_size;
 
 	search_start = dev_extent_search_start(device, search_start);
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
+	btrfs_init_path(&path);
+	path.reada = READA_FORWARD;
 
 	max_hole_start = search_start;
 	max_hole_size = 0;
 
-again:
 	if (search_start >= search_end) {
 		ret = -ENOSPC;
 		goto out;
 	}
 
-	path->reada = READA_FORWARD;
-
 	key.objectid = device->devid;
 	key.offset = search_start;
 	key.type = BTRFS_DEV_EXTENT_KEY;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret < 0)
 		goto out;
 	if (ret > 0) {
-		ret = btrfs_previous_item(root, path, key.objectid, key.type);
+		ret = btrfs_previous_item(root, &path, key.objectid, key.type);
 		if (ret < 0)
 			goto out;
 	}
 
+	/*
+	 * Iterate through all the dev extents in the device tree, and add them
+	 * into the used tree
+	 */
 	while (1) {
-		l = path->nodes[0];
-		slot = path->slots[0];
+		struct extent_buffer *l = path.nodes[0];
+		int slot = path.slots[0];
+		struct btrfs_dev_extent *de;
+
 		if (slot >= btrfs_header_nritems(l)) {
-			ret = btrfs_next_leaf(root, path);
+			ret = btrfs_next_leaf(root, &path);
 			if (ret == 0)
 				continue;
 			if (ret < 0)
@@ -723,8 +724,27 @@ again:
 		if (key.type != BTRFS_DEV_EXTENT_KEY)
 			goto next;
 
-		if (key.offset > search_start) {
-			hole_size = key.offset - search_start;
+		/* Got a dev extent item, add it to used_root */
+		de = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
+		ret = add_merge_cache_extent(&used_root, key.offset,
+					     btrfs_dev_extent_length(l, de));
+		if (ret < 0)
+			goto out;
+next:
+		path.slots[0]++;
+		cond_resched();
+	}
+
+again:
+	/*
+	 * Now used_root contains all the dev extents. Iterate through the tree
+	 * to grab holes.
+	 */
+	for (pe = first_cache_extent(&used_root); pe;
+	     pe = next_cache_extent(pe)) {
+		if (pe->start > search_start) {
+
+			hole_size = pe->start - search_start;
 			dev_extent_hole_check(device, &search_start, &hole_size,
 					      num_bytes);
 
@@ -732,7 +752,6 @@ again:
 				max_hole_start = search_start;
 				max_hole_size = hole_size;
 			}
-
 			/*
 			 * If this free space is greater than which we need,
 			 * it must be the max free space that we have found
@@ -747,15 +766,7 @@ again:
 				goto out;
 			}
 		}
-
-		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
-		extent_end = key.offset + btrfs_dev_extent_length(l,
-								  dev_extent);
-		if (extent_end > search_start)
-			search_start = extent_end;
-next:
-		path->slots[0]++;
-		cond_resched();
+		search_start = max(search_start, pe->start + pe->size);
 	}
 
 	/*
@@ -765,15 +776,17 @@ next:
 	 */
 	if (search_end > search_start) {
 		hole_size = search_end - search_start;
+
+		/*
+		 * Our hole crossed zone boundary, need to re-do the search
+		 * from the zone boundary.
+		 */
 		if (dev_extent_hole_check(device, &search_start, &hole_size,
-					  num_bytes)) {
-			btrfs_release_path(path);
+					  num_bytes))
 			goto again;
-		}
-
-		if (hole_size > max_hole_size) {
-			max_hole_start = search_start;
+		if (hole_size > max_hole_start) {
 			max_hole_size = hole_size;
+			max_hole_start = search_start;
 		}
 	}
 
@@ -784,8 +797,9 @@ next:
 		ret = 0;
 
 out:
+	btrfs_release_path(&path);
+	free_extent_cache_tree(&used_root);
 	ASSERT(zone_size == 0 || IS_ALIGNED(max_hole_start, zone_size));
-	btrfs_free_path(path);
 	*start = max_hole_start;
 	if (len)
 		*len = max_hole_size;
-- 
2.35.1

