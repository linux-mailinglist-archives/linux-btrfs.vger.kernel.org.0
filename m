Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB81E4B1EAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 07:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbiBKGqg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 01:46:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345015AbiBKGqf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 01:46:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B615410EA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 22:46:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 75C431F3A8;
        Fri, 11 Feb 2022 06:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644561993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87MaJQaLThuhCMYfLEHMvRW0Uz618vBEFDVi9RcBBew=;
        b=YuMSMXbpyqpISgh/bQarmnRfsqW9f6h3OViX+enNLc6STuXO9hkGGse3EhHz5LIuYrhmyW
        gC6zFKfRRj/vlCQ8W2cPMSq6EQEyyRPMnOjTXThfAzPKV6JhiTXJjUo/HzJLfGOODZOTBu
        T8l+MXYKq/dHzPGCF1CbsNk1avwudTc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 965EF13345;
        Fri, 11 Feb 2022 06:46:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mDvYF0gGBmJSUgAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 11 Feb 2022 06:46:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 1/2] btrfs: defrag: bring back the old file extent search behavior
Date:   Fri, 11 Feb 2022 14:46:12 +0800
Message-Id: <0dd2be27e93e7db12a3b83bdce48448a1f2f692f.1644561774.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644561774.git.wqu@suse.com>
References: <cover.1644561774.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For defrag, we don't really want to use btrfs_get_extent() to iterate
all extent maps of an inode.

The reasons are:

- btrfs_get_extent() can merge extent maps
  And the result em has the higher generation of the two, causing defrag
  to mark unnecessary part of such merged large extent map.

  This in fact can result extra IO for autodefrag in v5.16+ kernels.

  However this patch is not going to completely solve the problem, as
  one can still using read() to trigger extent map reading, and got
  them merged.

  The completely solution for the extent map merging generation problem
  will come as an standalone fix.

- btrfs_get_extent() caches the extent map result
  Normally it's fine, but for defrag the target range may not get
  another read/write for a long long time.
  Such cache would only increase the memory usage.

- btrfs_get_extent() doesn't skip older extent map
  Unlike the old find_new_extent() which uses btrfs_search_forward() to
  skip the older subtree, thus it will pick up unnecessary extent maps.

This patch will fix the regression by introducing defrag_get_extent() to
replace the btrfs_get_extent() call.

This helper will:

- Not cache the file extent we found
  It will search the file extent and manually convert it to em.

- Use btrfs_search_foward() to skip entire ranges which is modified in
  the past

This should reduce the IO for autodefrag.

Reported-by: Filipe Manana <fdmanana@suse.com>
Fixes: 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 160 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 156 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e49f745af942..0e983b782968 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1017,8 +1017,154 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 	return ret;
 }
 
+/*
+ * Defrag specific helper to get an extent map.
+ *
+ * Differences between this and btrfs_get_extent() are:
+ * - No extent_map will be added to inode->extent_tree
+ *   To reduce memory usage in the long run.
+ *
+ * - Extra optimization to skip file extents older than @newer_than
+ *   By using btrfs_search_forward() we can skip entire file ranges that
+ *   have extents created in past transactions, because btrfs_search_forward()
+ *   will not visit leaves and nodes with a generation smaller than given
+ *   minimal generation threshold (@newer_than).
+ *
+ * Return valid em if we find a file extent matching the requirement.
+ * Return NULL if we can not find a file extent matching the requirement.
+ *
+ * Return ERR_PTR() for error.
+ */
+static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
+					    u64 start, u64 newer_than)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_file_extent_item *fi;
+	struct btrfs_path path = {};
+	struct extent_map *em;
+	struct btrfs_key key;
+	u64 ino = btrfs_ino(inode);
+	int ret;
+
+	em = alloc_extent_map();
+	if (!em) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	key.objectid = ino;
+	key.type = BTRFS_EXTENT_DATA_KEY;
+	key.offset = start;
+
+	if (newer_than) {
+		ret = btrfs_search_forward(root, &key, &path, newer_than);
+		if (ret < 0)
+			goto err;
+		/* Can't find anything newer */
+		if (ret > 0)
+			goto not_found;
+	} else {
+		ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+		if (ret < 0)
+			goto err;
+	}
+	if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
+		/*
+		 * If btrfs_search_slot() makes path to point beyond nritems,
+		 * we should not have an empty leaf, as this inode must at
+		 * least have its INODE_ITEM.
+		 */
+		ASSERT(btrfs_header_nritems(path.nodes[0]));
+		path.slots[0] = btrfs_header_nritems(path.nodes[0]) - 1;
+	}
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	/* Perfect match, no need to go one slot back */
+	if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY &&
+	    key.offset == start)
+		goto iterate;
+
+	/* We didn't find a perfect match, needs to go one slot back */
+	if (path.slots[0] > 0) {
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
+			path.slots[0]--;
+	}
+
+iterate:
+	/* Iterate through the path to find a file extent covering @start */
+	while (true) {
+		u64 extent_end;
+
+		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
+			goto next;
+
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+
+		/*
+		 * We may go one slot back to INODE_REF/XATTR item, then
+		 * need to go forward until we reach an EXTENT_DATA.
+		 * But we should still has the correct ino as key.objectid.
+		 */
+		if (WARN_ON(key.objectid < ino) || key.type < BTRFS_EXTENT_DATA_KEY)
+			goto next;
+
+		/* It's beyond our target range, definitely not extent found */
+		if (key.objectid > ino || key.type > BTRFS_EXTENT_DATA_KEY)
+			goto not_found;
+
+		/*
+		 *	|	|<- File extent ->|
+		 *	\- start
+		 *
+		 * This means there is a hole between start and key.offset.
+		 */
+		if (key.offset > start) {
+			em->start = start;
+			em->orig_start = start;
+			em->block_start = EXTENT_MAP_HOLE;
+			em->len = key.offset - start;
+			break;
+		}
+
+		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				    struct btrfs_file_extent_item);
+		extent_end = btrfs_file_extent_end(&path);
+
+		/*
+		 *	|<- file extent ->|	|
+		 *				\- start
+		 *
+		 * We haven't reach start, search next slot.
+		 */
+		if (extent_end <= start)
+			goto next;
+
+		/* Now this extent covers @start, convert it to em */
+		btrfs_extent_item_to_extent_map(inode, &path, fi, false, em);
+		break;
+next:
+		ret = btrfs_next_item(root, &path);
+		if (ret < 0)
+			goto err;
+		if (ret > 0)
+			goto not_found;
+	}
+	btrfs_release_path(&path);
+	return em;
+
+not_found:
+	btrfs_release_path(&path);
+	free_extent_map(em);
+	return NULL;
+
+err:
+	btrfs_release_path(&path);
+	free_extent_map(em);
+	return ERR_PTR(ret);
+}
+
 static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
-					       bool locked)
+					       u64 newer_than, bool locked)
 {
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
@@ -1040,7 +1186,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 		/* get the big lock and read metadata off disk */
 		if (!locked)
 			lock_extent_bits(io_tree, start, end, &cached);
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, sectorsize);
+		em = defrag_get_extent(BTRFS_I(inode), start, newer_than);
 		if (!locked)
 			unlock_extent_cached(io_tree, start, end, &cached);
 
@@ -1068,7 +1214,12 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	if (em->start + em->len >= i_size_read(inode))
 		return ret;
 
-	next = defrag_lookup_extent(inode, em->start + em->len, locked);
+	/*
+	 * We want to check if the next extent can be merged with the current
+	 * one, which can be an extent created in a past generation, so we pass
+	 * a minimum generation of 0 to defrag_lookup_extent().
+	 */
+	next = defrag_lookup_extent(inode, em->start + em->len, 0, locked);
 	/* No more em or hole */
 	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
 		goto out;
@@ -1216,7 +1367,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		u64 range_len;
 
 		last_is_target = false;
-		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
+		em = defrag_lookup_extent(&inode->vfs_inode, cur,
+					  ctrl->newer_than, locked);
 		if (!em)
 			break;
 
-- 
2.35.0

