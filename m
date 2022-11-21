Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A59631E33
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 11:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiKUKXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 05:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiKUKXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 05:23:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB56920BDA
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 02:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24838B80DA0
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 10:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2FCC4347C
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 10:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669026209;
        bh=dOSA949IMNkQu2YjQE+CFqlXlCEdTSMaImfi63V74Uo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AAnNsLFDsFPPAZc7dwnNypHIcp3euoynClXnIqaTAAPVE3y3kasQaaE9M6fTi4KVO
         COMazAn6GbteH1/vZ+ZZiV6xdp6tHXp9hv4yLQhWv+3YjCu5fsNeS+YoTLZqjB2HxO
         iSfbMz8iwgFfxXRDMCNA0zVaGTbf5kx7/WegCWB0haEvMOEu2d5NXpam42ZtjBwZe/
         cXxGS82iIBNoIZff9QueIrMExgR0l5TbxdBl7DAHSWqlWyFzGaq47V9JLNiCq7sMsL
         XF0Vj2ApKkhZnXNtIWMn+QUT/igpnenmGAz6U7p9RO2kUpiehLDcu269CA46WK1NkB
         FON53p/gmVshQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: unify overwrite_item() and do_overwrite_item()
Date:   Mon, 21 Nov 2022 10:23:23 +0000
Message-Id: <f0245136d1e1ab36fa6ab307b56d443f9f3cd0a3.1669025204.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669025204.git.fdmanana@suse.com>
References: <cover.1669025204.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After commit 193df6245704 ("btrfs: search for last logged dir index if
it's not cached in the inode"), there are no more callers of
do_overwrite_item(), except overwrite_item().

Originally both used to be the same function, but were split in
commit 086dcbfa50d3 ("btrfs: insert items in batches when logging a
directory when possible"), as there was the need to execute all logic
of overwrite_item() but skip the tree search, since in the context of
directory logging we already had a path with a leaf to copy data from.

So unify them again as there is no more need to have them split.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 76 ++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f7b1bb9c63e4..742f26a217d7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -359,11 +359,25 @@ static int process_one_buffer(struct btrfs_root *log,
 	return ret;
 }
 
-static int do_overwrite_item(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root,
-			     struct btrfs_path *path,
-			     struct extent_buffer *eb, int slot,
-			     struct btrfs_key *key)
+/*
+ * Item overwrite used by replay and tree logging.  eb, slot and key all refer
+ * to the src data we are copying out.
+ *
+ * root is the tree we are copying into, and path is a scratch
+ * path for use in this function (it should be released on entry and
+ * will be released on exit).
+ *
+ * If the key is already in the destination tree the existing item is
+ * overwritten.  If the existing item isn't big enough, it is extended.
+ * If it is too large, it is truncated.
+ *
+ * If the key isn't in the destination yet, a new item is inserted.
+ */
+static int overwrite_item(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root,
+			  struct btrfs_path *path,
+			  struct extent_buffer *eb, int slot,
+			  struct btrfs_key *key)
 {
 	int ret;
 	u32 item_size;
@@ -380,22 +394,10 @@ static int do_overwrite_item(struct btrfs_trans_handle *trans,
 	item_size = btrfs_item_size(eb, slot);
 	src_ptr = btrfs_item_ptr_offset(eb, slot);
 
-	/* Our caller must have done a search for the key for us. */
-	ASSERT(path->nodes[0] != NULL);
-
-	/*
-	 * And the slot must point to the exact key or the slot where the key
-	 * should be at (the first item with a key greater than 'key')
-	 */
-	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
-		struct btrfs_key found_key;
-
-		btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
-		ret = btrfs_comp_cpu_keys(&found_key, key);
-		ASSERT(ret >= 0);
-	} else {
-		ret = 1;
-	}
+	/* Look for the key in the destination tree. */
+	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
+	if (ret < 0)
+		return ret;
 
 	if (ret == 0) {
 		char *src_copy;
@@ -573,36 +575,6 @@ static int do_overwrite_item(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-/*
- * Item overwrite used by replay and tree logging.  eb, slot and key all refer
- * to the src data we are copying out.
- *
- * root is the tree we are copying into, and path is a scratch
- * path for use in this function (it should be released on entry and
- * will be released on exit).
- *
- * If the key is already in the destination tree the existing item is
- * overwritten.  If the existing item isn't big enough, it is extended.
- * If it is too large, it is truncated.
- *
- * If the key isn't in the destination yet, a new item is inserted.
- */
-static int overwrite_item(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root,
-			  struct btrfs_path *path,
-			  struct extent_buffer *eb, int slot,
-			  struct btrfs_key *key)
-{
-	int ret;
-
-	/* Look for the key in the destination tree. */
-	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
-	if (ret < 0)
-		return ret;
-
-	return do_overwrite_item(trans, root, path, eb, slot, key);
-}
-
 static int read_alloc_one_name(struct extent_buffer *eb, void *start, int len,
 			       struct fscrypt_str *name)
 {
@@ -5395,7 +5367,7 @@ struct btrfs_dir_list {
  *    has a size that doesn't match the sum of the lengths of all the logged
  *    names - this is ok, not a problem, because at log replay time we set the
  *    directory's i_size to the correct value (see replay_one_name() and
- *    do_overwrite_item()).
+ *    overwrite_item()).
  */
 static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *start_inode,
-- 
2.35.1

