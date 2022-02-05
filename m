Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D234AA7EF
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 10:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356005AbiBEJjF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 04:39:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46234 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiBEJjE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 04:39:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 76ECB210E8;
        Sat,  5 Feb 2022 09:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644053943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=poRR94Ae9dMjQlGsCuhx+5GECiXSJBhx9pdR0IekFf0=;
        b=ao2WvlHws+14HPnUWnBxDGQHf/Zgym/4UPL3OqNPCtddQTc1zHS0Hc+Ad9gRXp+Ky/uFpj
        JpiQdWrCkc1FT19Y2lPFSn3KQJgCv45CHmrox0RAy//fpcPigBjAf89f8d0e19H2xCinDg
        V8H3ogno+11RGlw29bJrIUXHkBDPVlQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9669C13305;
        Sat,  5 Feb 2022 09:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dzN6F7ZF/mF+AgAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 05 Feb 2022 09:39:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: defrag: bring back the old file extent search behavior
Date:   Sat,  5 Feb 2022 17:38:45 +0800
Message-Id: <8cc7928a2097f4d06833c960a33bb5ef0a419337.1644051421.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For defrag, we don't really want to use btrfs_get_extent() to iterate
all extent maps of an inode.

The reasons are:

- btrfs_get_extent() can merge extent maps
  And the result em has the higher generation of the two, causing defrag
  to mark unnecessary part of such merged large extent map.

  This in fact results extra IO for autodefrag in v5.16+ kernels.

- btrfs_get_extent() caches the extent map result
  Normally it's fine, but for defrag the target inode may not get
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

- Use btrfs_search_foward() to skip older extents

This should reduce the IO for autodefrag.

Reported-by: Filipe Manana <fdmanana@suse.com>
Fixes: 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 134 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 130 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0b417d7cefa8..133e3e2e2e79 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1017,8 +1017,128 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
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
+ *   By using btrfs_search_forward() we can skip any older tree blocks
+ *   which doesn't meet @newer_than requirement.
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
+	struct extent_map *em = NULL;
+	struct btrfs_key key;
+	int ret;
+
+	em = alloc_extent_map();
+	if (!em) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	key.objectid = btrfs_ino(inode);
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
+		/* No direct hit, needs to go one slot back */
+		if (ret > 0) {
+			/* */
+			if (btrfs_header_nritems(path.nodes[0]) == 0)
+				goto not_found;
+			path.slots[0]--;
+		}
+	}
+
+	/* Iterate through the path to find a file extent covering @start */
+	while (true) {
+		u64 extent_end;
+
+		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
+			goto next;
+
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.objectid != btrfs_ino(inode))
+			goto not_found;
+		if (key.type != BTRFS_EXTENT_DATA_KEY)
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
@@ -1040,7 +1160,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 		/* get the big lock and read metadata off disk */
 		if (!locked)
 			lock_extent_bits(io_tree, start, end, &cached);
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, sectorsize);
+		em = defrag_get_extent(BTRFS_I(inode), start, newer_than);
 		if (!locked)
 			unlock_extent_cached(io_tree, start, end, &cached);
 
@@ -1068,7 +1188,12 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	if (em->start + em->len >= i_size_read(inode))
 		return ret;
 
-	next = defrag_lookup_extent(inode, em->start + em->len, locked);
+	/*
+	 * We may have a single range written and it can only be merged with
+	 * older extents, thus here we pass 0 as @newer_than to get all mergeable
+	 * extent for it.
+	 */
+	next = defrag_lookup_extent(inode, em->start + em->len, 0, locked);
 	/* No more em or hole */
 	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
 		goto out;
@@ -1214,7 +1339,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		u64 range_len;
 
 		last_is_target = false;
-		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
+		em = defrag_lookup_extent(&inode->vfs_inode, cur,
+					  ctrl->newer_than, locked);
 		if (!em)
 			break;
 
-- 
2.35.0

