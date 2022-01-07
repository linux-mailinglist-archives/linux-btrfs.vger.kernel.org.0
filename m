Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6648707B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 03:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344753AbiAGCev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 21:34:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42458 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiAGCeu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 21:34:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85D081F3A2
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 02:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641522889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR8V0tbCZu0fPTkMgTYJKU/aVeHOZy+7NuDIaN6FG3A=;
        b=A6LOW3RijEPLbwJ9B65306y7/Z/RrE/kVjcsJ8/bCVOsuaPake985u6LqOhzMKWQfkGjS2
        vzuL2kwaqXrcpQ6xA0jlFLpJ2XEx4k4vEc2Qg0G2RW45wlK5ZB2ien4nruqVEbVp3CXQFE
        R+1YDLyCNzjNbujJC5npHh+m19SSbC4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD7BC13C9D
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 02:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qOe+Kcim12FTUgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jan 2022 02:34:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: introduce a helper to locate an extent item
Date:   Fri,  7 Jan 2022 10:34:27 +0800
Message-Id: <20220107023430.28288-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107023430.28288-1-wqu@suse.com>
References: <20220107023430.28288-1-wqu@suse.com>
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
index 2e9a322773f2..ee179eb2ea17 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2882,6 +2882,114 @@ static void scrub_parity_put(struct scrub_parity *sparity)
 	scrub_parity_check_and_repair(sparity);
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
 static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 						  struct map_lookup *map,
 						  struct btrfs_device *sdev,
-- 
2.34.1

