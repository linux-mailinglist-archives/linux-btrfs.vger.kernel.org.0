Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5935BA779
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 09:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiIPH3E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 03:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiIPH3C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 03:29:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3CE8E
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 00:29:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29968338D4
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663313340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FBGvKL7p1SfWoIEMtTBqTR17V1fKeAUIzmutqemM5d8=;
        b=QzELixqvmqwvykJ6IMcyucUSjgwefw/j3i75+ClX3WbRSKXZJryF8CD+Vu5EkNATmd2P/h
        yeXFl4XpDdbXCPmBsdWJt0J9qny2gAYeCiTGGfTY+Fn9nYM7Myp4vP9Xz06pS6yl1FwqPz
        8Vsf/PK3dEl/kAaGYu3u2ZRdh7HbohM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DB151332E
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sGTUDLslJGMMKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:28:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs: make inline extent read calculation much simpler
Date:   Fri, 16 Sep 2022 15:28:36 +0800
Message-Id: <67735671d36a3fe83873b2ee2f0baf467a52f7a0.1663312786.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663312786.git.wqu@suse.com>
References: <cover.1663312786.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we calculate inline extent read in a way that inline extent
can start at non-zero offset.

This is consistent with the inode selftest, which puts an inline extent
at file offset 5.

Meanwhile the inline extent creation code will only create inline extent
at file offset 0.

Furthermore with the introduction of tree-checker on file extents, we are
actively rejecting inline extent which starts at non-zero file offset.
And so far we haven't yet seen any report of rejected inline extents at
non-zero file offset.

This all means, the extra calculation to support inline extents at
non-zero file offset is mostly paper weight, and damaging the
readability of the code.

Thus this patch will:

- Add extra ASSERT()s to make sure involved file offset are all 0

- Remove @extent_offset calculation

- Simplify the involved code
  As several variables are now single-use, no need to declare them as
  a variable anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6fde13f62c1d..5df5b0714d40 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6983,41 +6983,43 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		goto insert;
 	} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-		unsigned long ptr;
 		char *map;
-		size_t size;
-		size_t extent_offset;
 		size_t copy_size;
 
 		if (!page)
 			goto out;
 
-		size = btrfs_file_extent_ram_bytes(leaf, item);
-		extent_offset = page_offset(page) + pg_offset - extent_start;
-		copy_size = min_t(u64, PAGE_SIZE - pg_offset,
-				  size - extent_offset);
-		em->start = extent_start + extent_offset;
+		/*
+		 * Inline extent can only exist at file offset 0. This is
+		 * ensured by tree-checker and inline extent creation path.
+		 * Thus all members representing file offsets should be zero.
+		 */
+		ASSERT(page_offset(page) == 0);
+		ASSERT(pg_offset == 0);
+		ASSERT(extent_start == 0);
+		ASSERT(em->start == 0);
+
+		copy_size = min_t(u64, PAGE_SIZE,
+				  btrfs_file_extent_ram_bytes(leaf, item));
+		em->start = extent_start;
 		em->len = ALIGN(copy_size, fs_info->sectorsize);
 		em->orig_block_len = em->len;
 		em->orig_start = em->start;
-		ptr = btrfs_file_extent_inline_start(item) + extent_offset;
 
 		if (!PageUptodate(page)) {
 			if (btrfs_file_extent_compression(leaf, item) !=
 			    BTRFS_COMPRESS_NONE) {
-				ret = uncompress_inline(path, page, pg_offset,
-							extent_offset, item);
+				ret = uncompress_inline(path, page, 0, 0, item);
 				if (ret)
 					goto out;
 			} else {
 				map = kmap_local_page(page);
-				read_extent_buffer(leaf, map + pg_offset, ptr,
-						   copy_size);
-				if (pg_offset + copy_size < PAGE_SIZE) {
-					memset(map + pg_offset + copy_size, 0,
-					       PAGE_SIZE - pg_offset -
-					       copy_size);
-				}
+				read_extent_buffer(leaf, map,
+					btrfs_file_extent_inline_start(item),
+					copy_size);
+				if (copy_size < PAGE_SIZE)
+					memset(map + copy_size, 0,
+					       PAGE_SIZE - copy_size);
 				kunmap_local(map);
 			}
 			flush_dcache_page(page);
-- 
2.37.3

