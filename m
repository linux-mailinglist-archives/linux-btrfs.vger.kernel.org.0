Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124414D60BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 12:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348300AbiCKLgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 06:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348289AbiCKLgq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 06:36:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7421BFDE9
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 03:35:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D572461C2C
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 11:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BFBC340F4
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 11:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646998542;
        bh=/2/hXwzKtCycLRPOeoeGu+EQfIByq2oQG8lL7N+fZgk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AthWO6vHbm+B70AxHjbVigwe/So2qcV0DiBWl4rhGYDwnlxgNAmdQpgrN5p3/hob6
         INJackNiQ3mSgg/TsoYdSSZECvxAHUUkOfHUqZyWzzNp8OHz4o83whyxj+uqvbiAUT
         dcJMFCCJ3Nies89rg0+8pgjKZW5eyI3RCDAFnEj+OFMKHUKsl9tlN4awECd1UNBZtp
         Bn7dI9JafskIbK65gipl9w/mUe1O9dkofTaq72iWqtaJEabH9mzJNhoaM81KvllPyH
         yabnKhuV7AyMsYmOuKbXuxcCu2gfsf7zQ1pwHCvC5b3Ja6i6o70bx2HeiQGvWMrECC
         nGIUPSDfDa+Iw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: remove trivial wrapper btrfs_read_buffer()
Date:   Fri, 11 Mar 2022 11:35:34 +0000
Message-Id: <160fad9b4d845f6fb404f88df2fbc458ba5260fe.1646998177.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646998177.git.fdmanana@suse.com>
References: <cover.1646998177.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The function btrfs_read_buffer() is useless, it just calls
btree_read_extent_buffer_pages() with exactly the same arguments.

So remove it and rename btree_read_extent_buffer_pages() to
btrfs_read_extent_buffer(), which is a shorter name, has the "btrfs_"
prefix (since it's used outside disk-io.c) and the name is clear enough
about what it does.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c    |  2 +-
 fs/btrfs/disk-io.c  | 16 ++++------------
 fs/btrfs/disk-io.h  |  4 ++--
 fs/btrfs/qgroup.c   |  2 +-
 fs/btrfs/tree-log.c |  9 +++++----
 5 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 13d4833afcd3..a795e89de3f1 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1450,7 +1450,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			btrfs_unlock_up_safe(p, level + 1);
 
 		/* now we're allowed to do a blocking uptodate check */
-		ret = btrfs_read_buffer(tmp, gen, parent_level - 1, &first_key);
+		ret = btrfs_read_extent_buffer(tmp, gen, parent_level - 1, &first_key);
 		if (ret) {
 			free_extent_buffer(tmp);
 			btrfs_release_path(p);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 09693ab4fde0..d429a53704d0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -374,9 +374,9 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
  * @level:		expected level, mandatory check
  * @first_key:		expected key of first slot, skip check if NULL
  */
-static int btree_read_extent_buffer_pages(struct extent_buffer *eb,
-					  u64 parent_transid, int level,
-					  struct btrfs_key *first_key)
+int btrfs_read_extent_buffer(struct extent_buffer *eb,
+			     u64 parent_transid, int level,
+			     struct btrfs_key *first_key)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct extent_io_tree *io_tree;
@@ -1117,8 +1117,7 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	if (IS_ERR(buf))
 		return buf;
 
-	ret = btree_read_extent_buffer_pages(buf, parent_transid,
-					     level, first_key);
+	ret = btrfs_read_extent_buffer(buf, parent_transid, level, first_key);
 	if (ret) {
 		free_extent_buffer_stale(buf);
 		return ERR_PTR(ret);
@@ -4850,13 +4849,6 @@ void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info)
 	__btrfs_btree_balance_dirty(fs_info, 0);
 }
 
-int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid, int level,
-		      struct btrfs_key *first_key)
-{
-	return btree_read_extent_buffer_pages(buf, parent_transid,
-					      level, first_key);
-}
-
 static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
 {
 	/* cleanup FS via transaction */
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 2e10514ecda8..2a401592124d 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -120,8 +120,8 @@ void btrfs_put_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
-int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid, int level,
-		      struct btrfs_key *first_key);
+int btrfs_read_extent_buffer(struct extent_buffer *buf, u64 parent_transid,
+			     int level, struct btrfs_key *first_key);
 blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
 			enum btrfs_wq_endio_type metadata);
 blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 75e835cd4d91..db723c0026bd 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2290,7 +2290,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 		return 0;
 
 	if (!extent_buffer_uptodate(root_eb)) {
-		ret = btrfs_read_buffer(root_eb, root_gen, root_level, NULL);
+		ret = btrfs_read_extent_buffer(root_eb, root_gen, root_level, NULL);
 		if (ret)
 			goto out;
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 571dae8ad65e..338646a2cc4e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -333,7 +333,7 @@ static int process_one_buffer(struct btrfs_root *log,
 	 * pin down any logged extents, so we have to read the block.
 	 */
 	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
-		ret = btrfs_read_buffer(eb, gen, level, NULL);
+		ret = btrfs_read_extent_buffer(eb, gen, level, NULL);
 		if (ret)
 			return ret;
 	}
@@ -2575,7 +2575,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 	int i;
 	int ret;
 
-	ret = btrfs_read_buffer(eb, gen, level, NULL);
+	ret = btrfs_read_extent_buffer(eb, gen, level, NULL);
 	if (ret)
 		return ret;
 
@@ -2786,7 +2786,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 			path->slots[*level]++;
 			if (wc->free) {
-				ret = btrfs_read_buffer(next, ptr_gen,
+				ret = btrfs_read_extent_buffer(next, ptr_gen,
 							*level - 1, &first_key);
 				if (ret) {
 					free_extent_buffer(next);
@@ -2815,7 +2815,8 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 			free_extent_buffer(next);
 			continue;
 		}
-		ret = btrfs_read_buffer(next, ptr_gen, *level - 1, &first_key);
+		ret = btrfs_read_extent_buffer(next, ptr_gen, *level - 1,
+					       &first_key);
 		if (ret) {
 			free_extent_buffer(next);
 			return ret;
-- 
2.33.0

