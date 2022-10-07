Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2242E5F77CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJGMD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 08:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJGMD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 08:03:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA8D57D2
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 05:03:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43D2F1F896
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665144201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUk5Mctg9e/g1+BQIsCYAvGio14p9u8YLR4TmxDog5w=;
        b=WhRSSX2GxAX8A/0h47W/1cQnQ+aCEUCgVAWGrmUFzUmdNja6eKrw3I5uVopk7PBO0bCSIc
        0GdgHK+KwBQcdQJWwDP3zDDozPXNZ5RAVWbgqsLvxFcEiig366h7g3vmLhyWSTGfYqtGKh
        S/DD8b9jFr6V9opoe6SIEdlGZGK/ebA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89CC513A3D
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 12:03:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gBoLFIgVQGPeUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Oct 2022 12:03:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: mkfs: fix a crash when enabling extent-tree-v2
Date:   Fri,  7 Oct 2022 20:03:00 +0800
Message-Id: <265f9914e5f66686647a716a7a038de81bb09aec.1665143843.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665143843.git.wqu@suse.com>
References: <cover.1665143843.git.wqu@suse.com>
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

[BUG]
When enabling extent-tree-v2 feature at mkfs time (need to enable
experimental features), mkfs.btrfs will crash:

  # ./mkfs.btrfs  -f -O extent-tree-v2 ~/test.img
  btrfs-progs v5.19.1
  See http://btrfs.wiki.kernel.org for more information.

  ERROR: superblock magic doesn't match
  NOTE: several default settings have changed in version 5.15, please make sure
        this does not affect your deployments:
        - DUP for metadata (-m dup)
        - enabled no-holes (-O no-holes)
        - enabled free-space-tree (-R free-space-tree)

  Segmentation fault (core dumped)

[CAUSE]
The block group tree looks like this after make_btrfs() call:

  (gdb) call btrfs_print_tree(root->fs_info->block_group_root->node, 0)
  leaf 1163264 items 1 free space 16234 generation 1 owner BLOCK_GROUP_TREE
  leaf 1163264 flags 0x0() backref revision 1
  checksum stored f137c1ac
  checksum calced f137c1ac
  fs uuid 450d4b15-4954-4574-9801-8c6d248aaec6
  chunk uuid 4c4cc54d-f240-4aa4-b88b-bd487db43444
	item 0 key (1048576 BLOCK_GROUP_ITEM 4194304) itemoff 16259 itemsize 24
		block group used 131072 chunk_objectid 256 flags SYSTEM|single
						       ^^^

This looks completely sane, but notice that chunk_objectid 256.
That 256 value is the expected one for regular non-extent-tree-v2 btrfs,
but for extent-tree-v2, chunk_objectid is reused as the global id of
extent tree where the block group belongs to.

With the old 256 value as chunk_objectid, btrfs will not find an extent
tree root for the block group, and return NULL for btrfs_extent_root()
call, and trigger segfault.

This is a regression caused by commit 1430b41427b5 ("btrfs-progs:
separate block group tree from extent tree v2"), which doesn't take
extent-tree-v2 on-disk format into consideration.

[FIX]
For the initial btrfs created by make_btrfs(), all block group items
will be in extent-tree global id 0, thus we can reset chunk_objectid to
0, if and only if extent-tree-v2 is enabled.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/common.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 3a517a503e61..d77688ba584d 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -227,12 +227,22 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
 				   u64 bg_offset, u64 bg_size, u64 bg_used)
 {
 	int ret;
+	u64 chunk_objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+
+	/*
+	 * For extent-tree-v2, chunk_objectid of block group item is reused
+	 * to indicate which extent-tree the block group is in.
+	 *
+	 * Thus for the initial image, we should set the chunk_objectid to 0,
+	 * as all initial bgs are in the extent tree with global id 0.
+	 */
+	if (cfg->features.incompat_flags & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+		chunk_objectid = 0;
 
 	memset(buf->data + sizeof(struct btrfs_header), 0,
 		cfg->nodesize - sizeof(struct btrfs_header));
 	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used,
-			       BTRFS_FIRST_CHUNK_TREE_OBJECTID,
-			       cfg->leaf_data_size -
+			       chunk_objectid, cfg->leaf_data_size -
 			       sizeof(struct btrfs_block_group_item));
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_BLOCK_GROUP_TREE_OBJECTID);
-- 
2.37.3

