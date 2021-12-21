Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3347B863
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 03:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhLUCeK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 21:34:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45540 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbhLUCeJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 21:34:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90E1B1F3A6
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640054048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OgjG1sv/1myRnF/12b+quhK4mBqR7ZpkkEVAIsbI7gE=;
        b=aYwY6DghnfS16497+puXbeRAXhWWjw1rcQGX7H6cXcIknkSUGrL1dKUGvvWsf5v4cC6lgh
        4zWCflAoPlizGGEvJm8kUwEoVn+dPq4EPhNG77NgUiwOX1D/q4UQg9XS8+RlobD4nO6r7+
        qtGSyeri8MXQkJ6dBsDlvhcXY5AUolI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDF9113BDA
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YA7/KB89wWEOLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/4] btrfs: introduce a helper to locate an extent item
Date:   Tue, 21 Dec 2021 10:33:46 +0800
Message-Id: <20211221023349.27696-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221023349.27696-1-wqu@suse.com>
References: <20211221023349.27696-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new helper, find_first_extent_item(), will locate an extent item
(either EXTENT_ITEM or METADATA_ITEM) which covers the any byte of the
search range.

This helper will later be used to refactor scrub code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f20ad60dcc0e..640f3de38e18 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3172,6 +3172,114 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 	return ret;
 }
 
+/*
+ * Return 0 if the extent item range covers any byte of the range.
+ * Return <0 if the extent item is before @search_start.
+ * Return >0 if the extent item is after @start_start + @search_len.
+ */
+static int compare_extent_item_range(struct btrfs_path *path,
+				     u64 search_start, u64 search_len)
+{
+	struct btrfs_fs_info *fs_info = path->nodes[0]->fs_info;
+	u64 len;
+	struct btrfs_key key;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	ASSERT(key.type == BTRFS_EXTENT_ITEM_KEY ||
+	       key.type == BTRFS_METADATA_ITEM_KEY);
+	if (key.type == BTRFS_METADATA_ITEM_KEY)
+		len = fs_info->nodesize;
+	else
+		len = key.offset;
+
+	if (key.objectid + len <= search_start)
+		return -1;
+	if (key.objectid >= search_start + search_len)
+		return 1;
+	return 0;
+}
+
+/*
+ * Helper to locate one extent item which covers any byte in range
+ * [@search_start, @search_start + @search_length)
+ *
+ * If the path is not initialized, we will initialize the search by doing
+ * a btrfs_search_slot().
+ * If the path is already initialized, we will use the path as the initial
+ * slot, to avoid duplicated btrfs_search_slot() calls.
+ *
+ * NOTE: If an extent item starts before @search_start, we will still
+ * return the extent item. This is for data extent crossing stripe boundary.
+ *
+ * Return 0 if we found such extent item, and @path will point to the
+ * extent item.
+ * Return >0 if no such extent item can be found, and @path will be released.
+ * Return <0 if hit fatal error, and @path will be released.
+ */
+static int find_first_extent_item(struct btrfs_root *extent_root,
+				  struct btrfs_path *path,
+				  u64 search_start, u64 search_len)
+{
+	struct btrfs_fs_info *fs_info = extent_root->fs_info;
+	struct btrfs_key key;
+	int ret;
+
+	/* Continue using the existing path */
+	if (path->nodes[0])
+		goto search_forward;
+
+	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
+		key.type = BTRFS_METADATA_ITEM_KEY;
+	else
+		key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.objectid = search_start;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	ASSERT(ret > 0);
+	/*
+	 * Here we intentionally pass 0 as @min_objectid, as there could be
+	 * an extent item starting before @search_start.
+	 */
+	ret = btrfs_previous_extent_item(extent_root, path, 0);
+	if (ret < 0)
+		return ret;
+	/*
+	 * No matter whether we have found an extent item, the next loop will
+	 * properly do every check on the key.
+	 */
+search_forward:
+	while (true) {
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+		if (key.objectid >= search_start + search_len)
+			break;
+		if (key.type != BTRFS_METADATA_ITEM_KEY &&
+		    key.type != BTRFS_EXTENT_ITEM_KEY)
+			goto next;
+
+		ret = compare_extent_item_range(path, search_start, search_len);
+		if (ret == 0)
+			return ret;
+		if (ret > 0)
+			break;
+next:
+		path->slots[0]++;
+		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+			ret = btrfs_next_leaf(extent_root, path);
+			if (ret) {
+				/* Either no more item or fatal error */
+				btrfs_release_path(path);
+				return ret;
+			}
+		}
+	}
+	btrfs_release_path(path);
+	return 1;
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct btrfs_block_group *bg,
 					   struct map_lookup *map,
-- 
2.34.1

