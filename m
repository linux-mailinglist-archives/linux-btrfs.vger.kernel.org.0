Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4785BA77C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 09:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIPH3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 03:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIPH3E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 03:29:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF42A5F5B
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 00:29:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 809852000F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663313342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Mbyr2QQhGDVzFqw6/0aTs3wKCDoddFBmL2ZmelXJlI=;
        b=iAQ5t62zF3psY9nvopLjnxyTNvNfmIe64HmNCT4yynetJi4UUcrIa4UpbqL/iI3DB230z6
        oCP6PA8ZY6i0XV3qiZ2uNv7++EW+KLnchxhyZGB67PcTMZuVpPyCjdTniYfQP0NEuwEOxa
        EG7sfRF9XMSakbxa1rnvRvcv3iyzDio=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C33501332E
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uNClIb0lJGMMKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:29:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs: remove the @new_inline argument from btrfs_extent_item_to_extent_map()
Date:   Fri, 16 Sep 2022 15:28:38 +0800
Message-Id: <1fe3dbde7486c233db8e39c38ff689a1325b8a67.1663312787.git.wqu@suse.com>
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

The argument @new_inline changes the following members of extent_map:

- em->compress_type
- EXTENT_FLAG_COMPRESSED of em->flags

However neither members makes a difference for inline extents:

- Inline extent read never use above em members

  As inside btrfs_get_extent() we directly use the file extent item to
  do the read.

- Inline extents are never to be split

  Thus code really needs em->compress_type or that flag will never be
  executed on inlined extents.
  (btrfs_drop_extent_cache() would be one example)

- Fiemap no longer relies on extent maps

  Recent fiemap optimization makes fiemap to search subvolume tree
  directly, without using any extent map at all.

  Thus those members make no difference for inline extents any more.

Furthermore such exception without much explanation is really a source
of confusion.

Thus this patch will completely remove the argument, and always set the
involved members, unifying the behavior.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h     | 1 -
 fs/btrfs/file-item.c | 6 ++----
 fs/btrfs/inode.c     | 2 +-
 fs/btrfs/ioctl.c     | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8b7b7a212da0..7deec2977d28 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3356,7 +3356,6 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
-				     const bool new_inline,
 				     struct extent_map *em);
 int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 					u64 len);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 45949261c699..ba4624b541f5 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1196,7 +1196,6 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
-				     const bool new_inline,
 				     struct extent_map *em)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -1248,10 +1247,9 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		 */
 		em->orig_start = EXTENT_MAP_HOLE;
 		em->block_len = (u64)-1;
-		if (!new_inline && compress_type != BTRFS_COMPRESS_NONE) {
+		em->compress_type = compress_type;
+		if (compress_type != BTRFS_COMPRESS_NONE)
 			set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
-			em->compress_type = compress_type;
-		}
 	} else {
 		btrfs_err(fs_info,
 			  "unknown file extent item type %d, inode %llu, offset %llu, "
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 41562d9d2113..27fe46ef5e86 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6977,7 +6977,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto insert;
 	}
 
-	btrfs_extent_item_to_extent_map(inode, path, item, !page, em);
+	btrfs_extent_item_to_extent_map(inode, path, item, em);
 
 	if (extent_type == BTRFS_FILE_EXTENT_REG ||
 	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d5dd8bed1488..ebcb2d31eb16 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1159,7 +1159,7 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 			goto next;
 
 		/* Now this extent covers @start, convert it to em */
-		btrfs_extent_item_to_extent_map(inode, &path, fi, false, em);
+		btrfs_extent_item_to_extent_map(inode, &path, fi, em);
 		break;
 next:
 		ret = btrfs_next_item(root, &path);
-- 
2.37.3

