Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586795BA77A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 09:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiIPH3I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 03:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIPH3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 03:29:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E185F6C
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 00:29:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA824338C3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663313343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddWz1XqfMb1AfsWZB72d7j3IGGDwzxFfXCj6iWHsAFQ=;
        b=jWsP48TN1LqF/AEFoDPtKQNHNsv2nOR4lyQh6TVMpXromh0afiY5CVLbcZHii6j+ZkP7yU
        6sf69Uek0KZTwd4o7M8ekyYqyNWKYlQuGtN+Z2VroSi6vb1ow86h6mYqcAAU8TcGf51ox/
        8d9KX9bc87edZN5f9+EAeunT+oiTA3I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE5291332E
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eBg+LL4lJGMMKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:29:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs: extract the inline extent read code into its own function
Date:   Fri, 16 Sep 2022 15:28:39 +0800
Message-Id: <839ee8ec62cdf576b2db923d5ff63226ac493c6d.1663312787.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663312786.git.wqu@suse.com>
References: <cover.1663312786.git.wqu@suse.com>
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

Currently we have inline extent read code behind two levels of indent,
just extract them into a new function, read_inline_extent(), to make it
a little easier to read.

Since we're here, also remove @extent_offset and @pg_offset arguments
from uncompress_inline() function, as it's not possible to have inline
extents at non-inline file offset.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 73 +++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27fe46ef5e86..871c65f72822 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6784,7 +6784,6 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 static noinline int uncompress_inline(struct btrfs_path *path,
 				      struct page *page,
-				      size_t pg_offset, u64 extent_offset,
 				      struct btrfs_file_extent_item *item)
 {
 	int ret;
@@ -6795,7 +6794,6 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	unsigned long ptr;
 	int compress_type;
 
-	WARN_ON(pg_offset != 0);
 	compress_type = btrfs_file_extent_compression(leaf, item);
 	max_size = btrfs_file_extent_ram_bytes(leaf, item);
 	inline_size = btrfs_file_extent_inline_item_len(leaf, path->slots[0]);
@@ -6807,8 +6805,8 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	read_extent_buffer(leaf, tmp, ptr, inline_size);
 
 	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
-	ret = btrfs_decompress(compress_type, tmp, page,
-			       extent_offset, inline_size, max_size);
+	ret = btrfs_decompress(compress_type, tmp, page, 0, inline_size,
+			       max_size);
 
 	/*
 	 * decompression code contains a memset to fill in any space between the end
@@ -6818,13 +6816,43 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	 * cover that region here.
 	 */
 
-	if (max_size + pg_offset < PAGE_SIZE)
-		memzero_page(page,  pg_offset + max_size,
-			     PAGE_SIZE - max_size - pg_offset);
+	if (max_size < PAGE_SIZE)
+		memzero_page(page,  max_size, PAGE_SIZE - max_size);
 	kfree(tmp);
 	return ret;
 }
 
+static int read_inline_extent(struct btrfs_inode *inode,
+			      struct btrfs_path *path,
+			      struct page *page)
+{
+	struct btrfs_file_extent_item *fi;
+	void *kaddr;
+	size_t copy_size;
+
+	if (!page || PageUptodate(page))
+		return 0;
+
+	ASSERT(page_offset(page) == 0);
+
+	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_extent_item);
+	if (btrfs_file_extent_compression(path->nodes[0], fi) !=
+	    BTRFS_COMPRESS_NONE)
+		return uncompress_inline(path, page, fi);
+
+	copy_size = min_t(u64, PAGE_SIZE,
+			  btrfs_file_extent_ram_bytes(path->nodes[0], fi));
+	kaddr = kmap_local_page(page);
+	read_extent_buffer(path->nodes[0], kaddr,
+			   btrfs_file_extent_inline_start(fi), copy_size);
+	kunmap_local(kaddr);
+	if (copy_size < PAGE_SIZE)
+		memzero_page(page, copy_size, PAGE_SIZE - copy_size);
+	flush_dcache_page(page);
+	return 0;
+}
+
 /**
  * btrfs_get_extent - Lookup the first extent overlapping a range in a file.
  * @inode:	file to search in
@@ -6983,25 +7011,15 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		goto insert;
 	} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-		char *map;
-		size_t copy_size;
-
-		if (!page)
-			goto out;
-
 		/*
 		 * Inline extent can only exist at file offset 0. This is
 		 * ensured by tree-checker and inline extent creation path.
 		 * Thus all members representing file offsets should be zero.
 		 */
-		ASSERT(page_offset(page) == 0);
 		ASSERT(pg_offset == 0);
 		ASSERT(extent_start == 0);
 		ASSERT(em->start == 0);
 
-		copy_size = min_t(u64, PAGE_SIZE,
-				  btrfs_file_extent_ram_bytes(leaf, item));
-
 		/*
 		 * btrfs_extent_item_to_extent_map() should have properly
 		 * initialized em members already.
@@ -7011,24 +7029,9 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		ASSERT(em->block_start == EXTENT_MAP_INLINE);
 		ASSERT(em->len = fs_info->sectorsize);
 
-		if (!PageUptodate(page)) {
-			if (btrfs_file_extent_compression(leaf, item) !=
-			    BTRFS_COMPRESS_NONE) {
-				ret = uncompress_inline(path, page, 0, 0, item);
-				if (ret)
-					goto out;
-			} else {
-				map = kmap_local_page(page);
-				read_extent_buffer(leaf, map,
-					btrfs_file_extent_inline_start(item),
-					copy_size);
-				if (copy_size < PAGE_SIZE)
-					memset(map + copy_size, 0,
-					       PAGE_SIZE - copy_size);
-				kunmap_local(map);
-			}
-			flush_dcache_page(page);
-		}
+		ret = read_inline_extent(inode, path, page);
+		if (ret < 0)
+			goto out;
 		goto insert;
 	}
 not_found:
-- 
2.37.3

