Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF66F5FE954
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJNHRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 03:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJNHRf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 03:17:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3985EC6955
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 00:17:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 922461F385
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665731852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hug+dIeeUptzXKXWLSCXA+hEhBZuU+xQN6yNLCsNJKM=;
        b=Q6SLxZ/ojHiGPh1YbLVj9ie/N6WnuNYwlFtVj0D+VsbFOyAY9DXiM/7G7U+KWAVQ8g8wt+
        riSN41a9hMluU6wN+1xsdctHZ1PmRE4D5uVG1Q6fsE5MewrQ2cw2dR/yMYrwK2I69Nl7UE
        IVch8+1L3jyQAYJU3+LbyIpNdxWdOSQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4A2B13451
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uD7PJQsNSWOsUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/5] btrfs: refactor btrfs_lookup_csums_range()
Date:   Fri, 14 Oct 2022 15:17:09 +0800
Message-Id: <a4da5db6aecaae841cfb498676d517f8df56bdab.1665730948.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665730948.git.wqu@suse.com>
References: <cover.1665730948.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The refactor involves the following parts:

- Introduce bytes_to_csum_size() and csum_size_to_bytes() helpers
  As we have quite some open-coded calculation, some of them are even
  split into two assignments just to fit 80 chars limit.

- Remove the @csum_size parameter from max_ordered_sum_bytes()
  Csum size can be fetched from @fs_info.
  And we will use the csum_size_to_bytes() helper anyway.

- Add a comment explaining how we had the first search result

- Use newly introduced helpers to cleanup btrfs_lookup_csums_range()

- Move variables declaration to the minimal scope

- Never mix number of sectors with bytes
  There are several locations doing things like:

 			size = min_t(size_t, csum_end - start,
				     max_ordered_sum_bytes(fs_info));
			...
			size >>= fs_info->sectorsize_bits

  Or

			offset = (start - key.offset) >> fs_info->sectorsize_bits;
			offset *= csum_size;

  Make sure those variables can only represent BYTES inside the
  function, by using the above bytes_to_csum_size() helpers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 69 ++++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 6bb9fa961a6a..8d9c4488d86a 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -121,12 +121,26 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 				start + len - 1, EXTENT_DIRTY, NULL);
 }
 
-static inline u32 max_ordered_sum_bytes(struct btrfs_fs_info *fs_info,
-					u16 csum_size)
+static size_t bytes_to_csum_size(struct btrfs_fs_info *fs_info, u32 bytes)
 {
-	u32 ncsums = (PAGE_SIZE - sizeof(struct btrfs_ordered_sum)) / csum_size;
+	ASSERT(IS_ALIGNED(bytes, fs_info->sectorsize));
 
-	return ncsums * fs_info->sectorsize;
+	return (bytes >> fs_info->sectorsize_bits) * fs_info->csum_size;
+}
+
+static size_t csum_size_to_bytes(struct btrfs_fs_info *fs_info, u32 csum_size)
+{
+	ASSERT(IS_ALIGNED(csum_size, fs_info->csum_size));
+
+	return (csum_size / fs_info->csum_size) << fs_info->sectorsize_bits;
+}
+
+static inline u32 max_ordered_sum_bytes(struct btrfs_fs_info *fs_info)
+{
+	int max_csum_size = round_down(PAGE_SIZE - sizeof(struct btrfs_ordered_sum),
+				       fs_info->csum_size);
+
+	return csum_size_to_bytes(fs_info, max_csum_size);
 }
 
 /*
@@ -135,9 +149,8 @@ static inline u32 max_ordered_sum_bytes(struct btrfs_fs_info *fs_info,
  */
 static int btrfs_ordered_sum_size(struct btrfs_fs_info *fs_info, unsigned long bytes)
 {
-	int num_sectors = (int)DIV_ROUND_UP(bytes, fs_info->sectorsize);
-
-	return sizeof(struct btrfs_ordered_sum) + num_sectors * fs_info->csum_size;
+	return sizeof(struct btrfs_ordered_sum) +
+	       bytes_to_csum_size(fs_info, bytes);
 }
 
 int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
@@ -521,11 +534,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_csum_item *item;
 	LIST_HEAD(tmplist);
-	unsigned long offset;
 	int ret;
-	size_t size;
-	u64 csum_end;
-	const u32 csum_size = fs_info->csum_size;
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(end + 1, fs_info->sectorsize));
@@ -551,16 +560,33 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 	if (ret > 0 && path->slots[0] > 0) {
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0] - 1);
+
+		/*
+		 * There are two cases we can hit here for the previous
+		 * csum item.
+		 *
+		 *		|<- search range ->|
+		 *	|<- csum item ->|
+		 *
+		 * Or
+		 *				|<- search range ->|
+		 *	|<- csum item ->|
+		 *
+		 * Check if the previous csum item covers the leading part
+		 * of the search range.
+		 * If so we have to start from previous csum item.
+		 */
 		if (key.objectid == BTRFS_EXTENT_CSUM_OBJECTID &&
 		    key.type == BTRFS_EXTENT_CSUM_KEY) {
-			offset = (start - key.offset) >> fs_info->sectorsize_bits;
-			if (offset * csum_size <
+			if (bytes_to_csum_size(fs_info, start - key.offset) <
 			    btrfs_item_size(leaf, path->slots[0] - 1))
 				path->slots[0]--;
 		}
 	}
 
 	while (start <= end) {
+		u64 csum_end;
+
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
@@ -580,8 +606,8 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 		if (key.offset > start)
 			start = key.offset;
 
-		size = btrfs_item_size(leaf, path->slots[0]);
-		csum_end = key.offset + (size / csum_size) * fs_info->sectorsize;
+		csum_end = key.offset + csum_size_to_bytes(fs_info,
+					btrfs_item_size(leaf, path->slots[0]));
 		if (csum_end <= start) {
 			path->slots[0]++;
 			continue;
@@ -591,8 +617,11 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				      struct btrfs_csum_item);
 		while (start < csum_end) {
+			unsigned long offset;
+			size_t size;
+
 			size = min_t(size_t, csum_end - start,
-				     max_ordered_sum_bytes(fs_info, csum_size));
+				     max_ordered_sum_bytes(fs_info));
 			sums = kzalloc(btrfs_ordered_sum_size(fs_info, size),
 				       GFP_NOFS);
 			if (!sums) {
@@ -603,16 +632,14 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			sums->bytenr = start;
 			sums->len = (int)size;
 
-			offset = (start - key.offset) >> fs_info->sectorsize_bits;
-			offset *= csum_size;
-			size >>= fs_info->sectorsize_bits;
+			offset = bytes_to_csum_size(fs_info, start - key.offset);
 
 			read_extent_buffer(path->nodes[0],
 					   sums->sums,
 					   ((unsigned long)item) + offset,
-					   csum_size * size);
+					   bytes_to_csum_size(fs_info, size));
 
-			start += fs_info->sectorsize * size;
+			start += size;
 			list_add_tail(&sums->list, &tmplist);
 		}
 		path->slots[0]++;
-- 
2.37.3

