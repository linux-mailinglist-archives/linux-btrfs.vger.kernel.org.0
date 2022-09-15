Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63C75B9649
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiIOIYT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 04:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiIOIXs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 04:23:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939CC98A59
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 01:23:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A73335BE25
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663230193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgdLBmyKIrBVZfiAC35bTiRTCLRLQaBTHuiDBHbKA1A=;
        b=sH0T42xPPoUKWMWi8kkL1NIs2GGUISwbMTfbtBzkNKMM8vvVGtYyiadxcBXQqdL0EOwPv1
        w3blYkGqcwJwb7HmEQcLVdrzfME2ufrExvDrOqbSlqL3KWBSBqp6PCKmoQGGJkk3l0YOHu
        k/cfR4Ph4hpny/UvJeF7ZGhyKf2lqdU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEFBE139C8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 08:23:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SEq0LPDgImNaeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 08:23:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: selftests: remove impossible inline extent at non-zero file offset
Date:   Thu, 15 Sep 2022 16:22:52 +0800
Message-Id: <2cacb71b07ac4497a6b92dd95c56a306bda1d7fa.1663229903.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663229903.git.wqu@suse.com>
References: <cover.1663229903.git.wqu@suse.com>
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

In our inode-tests.c, we create an inline offset at file offset 5, which
is no longer possible since the introduction of tree-checker.

Thus I don't think we should spend time maintaining some corner cases
which are already ruled out by tree-checker.

So this patch will:

- Change the inline extent to start at file offset 0

  Also change its length to 6 to cover the original length

- Add an extra ASSERT() for btrfs_add_extent_mapping()

  This is to make sure tree-checker is working correctly.

- Update the inode selftest

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.c        |  7 +++++
 fs/btrfs/tests/inode-tests.c | 56 ++++++++++++------------------------
 2 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 6fee14ce2e6b..59e5a035359b 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -610,6 +610,13 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 	int ret;
 	struct extent_map *em = *em_in;
 
+	/*
+	 * Tree-checker should have rejected any inline extent with non-zero
+	 * file offset. Here just do a sanity check.
+	 */
+	if (em->block_start == EXTENT_MAP_INLINE)
+		ASSERT(em->start == 0);
+
 	ret = add_extent_mapping(em_tree, em, 0);
 	/* it is possible that someone inserted the extent into the tree
 	 * while we had the lock dropped.  It is also possible that
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index cac89c388131..0521c31610a4 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -72,8 +72,8 @@ static void insert_inode_item_key(struct btrfs_root *root)
  * diagram of how the extents will look though this may not be possible we still
  * want to make sure everything acts normally (the last number is not inclusive)
  *
- * [0 - 5][5 -  6][     6 - 4096     ][ 4096 - 4100][4100 - 8195][8195 - 12291]
- * [hole ][inline][hole but no extent][  hole   ][   regular ][regular1 split]
+ * [0  - 6][     6 - 4096     ][ 4096 - 4100][4100 - 8195][8195  -  12291]
+ * [inline][hole but no extent][    hole    ][   regular ][regular1 split]
  *
  * [12291 - 16387][16387 - 24579][24579 - 28675][ 28675 - 32771][32771 - 36867 ]
  * [    hole    ][regular1 split][   prealloc ][   prealloc1  ][prealloc1 written]
@@ -90,19 +90,12 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	u64 disk_bytenr = SZ_1M;
 	u64 offset = 0;
 
-	/* First we want a hole */
-	insert_extent(root, offset, 5, 5, 0, 0, 0, BTRFS_FILE_EXTENT_REG, 0,
-		      slot);
-	slot++;
-	offset += 5;
-
 	/*
-	 * Now we want an inline extent, I don't think this is possible but hey
-	 * why not?  Also keep in mind if we have an inline extent it counts as
-	 * the whole first page.  If we were to expand it we would have to cow
-	 * and we wouldn't have an inline extent anymore.
+	 * Tree-checker has strict limits on inline extents that they can only
+	 * exist at file offset 0, thus we can only have one inline file extent
+	 * at most.
 	 */
-	insert_extent(root, offset, 1, 1, 0, 0, 0, BTRFS_FILE_EXTENT_INLINE, 0,
+	insert_extent(root, offset, 6, 6, 0, 0, 0, BTRFS_FILE_EXTENT_INLINE, 0,
 		      slot);
 	slot++;
 	offset = sectorsize;
@@ -281,37 +274,24 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start != EXTENT_MAP_HOLE) {
-		test_err("expected a hole, got %llu", em->block_start);
-		goto out;
-	}
-	if (em->start != 0 || em->len != 5) {
-		test_err(
-		"unexpected extent wanted start 0 len 5, got start %llu len %llu",
-			em->start, em->len);
-		goto out;
-	}
-	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
-		goto out;
-	}
-	offset = em->start + em->len;
-	free_extent_map(em);
-
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
-	if (IS_ERR(em)) {
-		test_err("got an error when we shouldn't have");
-		goto out;
-	}
 	if (em->block_start != EXTENT_MAP_INLINE) {
 		test_err("expected an inline, got %llu", em->block_start);
 		goto out;
 	}
 
-	if (em->start != offset || em->len != (sectorsize - 5)) {
+	/*
+	 * For inline extent, we always round up the em to sectorsize, as
+	 * they are either:
+	 * a) a hidden hole
+	 *    The range will be zeroed at inline extent read time.
+	 *
+	 * b) a file extent with unaligned bytenr
+	 *    Tree checker will reject it.
+	 */
+	if (em->start != 0 || em->len != sectorsize) {
 		test_err(
-	"unexpected extent wanted start %llu len 1, got start %llu len %llu",
-			offset, em->start, em->len);
+	"unexpected extent wanted start 0 len %u, got start %llu len %llu",
+			sectorsize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
-- 
2.37.3

