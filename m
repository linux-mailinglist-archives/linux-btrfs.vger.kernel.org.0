Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B7140AA37
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhINJHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 05:07:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41994 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhINJHS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 05:07:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BF0B1FDD8;
        Tue, 14 Sep 2021 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631610361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+jN6EB4XqsSusJ8rUmDtOnfx2CCgdLMuPI9G+F0YPU=;
        b=MLHUA1KGtdFruW6/lUD2qfwMeqrdPIVGW8AECF0vrwSdmw8573CUNbi2LnihXzDcZtAkz+
        vSZrnlbxZlVDCpEvIHnuidBGycmp9xVyRq5au/ZaXYAeB1F/YRaBOWB1euTuQSfn29/oL8
        wvCUsHXJOfgqlLozvmrKwGXRS0WLl0I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C53C913D3F;
        Tue, 14 Sep 2021 09:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iG+tLfhlQGH5NwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 14 Sep 2021 09:06:00 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 3/8] btrfs-progs: Remove fs_info argument from leaf_data_end
Date:   Tue, 14 Sep 2021 12:05:53 +0300
Message-Id: <20210914090558.79411-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914090558.79411-1-nborisov@suse.com>
References: <20210914090558.79411-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function already takes an extent_buffer which has a reference to
the owning filesystem's fs_info. This also brings the function in line
with the kernel's signature.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 02eb975338e5..77766c2a7931 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -557,12 +557,11 @@ static int btrfs_comp_keys(struct btrfs_disk_key *disk,
  * this returns the address of the start of the last item,
  * which is the stop of the leaf data stack
  */
-static inline unsigned int leaf_data_end(const struct btrfs_fs_info *fs_info,
-					 const struct extent_buffer *leaf)
+static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
 {
 	u32 nr = btrfs_header_nritems(leaf);
 	if (nr == 0)
-		return BTRFS_LEAF_DATA_SIZE(fs_info);
+		return BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
 	return btrfs_item_offset_nr(leaf, nr - 1);
 }

@@ -1980,10 +1979,10 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	right_nritems = btrfs_header_nritems(right);

 	push_space = btrfs_item_end_nr(left, left_nritems - push_items);
-	push_space -= leaf_data_end(fs_info, left);
+	push_space -= leaf_data_end(left);

 	/* make room in the right data area */
-	data_end = leaf_data_end(fs_info, right);
+	data_end = leaf_data_end(right);
 	memmove_extent_buffer(right,
 			      btrfs_leaf_data(right) + data_end - push_space,
 			      btrfs_leaf_data(right) + data_end,
@@ -1992,8 +1991,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	/* copy from the left data area */
 	copy_extent_buffer(right, left, btrfs_leaf_data(right) +
 		     BTRFS_LEAF_DATA_SIZE(root->fs_info) - push_space,
-		     btrfs_leaf_data(left) + leaf_data_end(fs_info, left),
-		     push_space);
+		     btrfs_leaf_data(left) + leaf_data_end(left), push_space);

 	memmove_extent_buffer(right, btrfs_item_nr_offset(push_items),
 			      btrfs_item_nr_offset(0),
@@ -2130,7 +2128,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		     btrfs_item_offset_nr(right, push_items -1);

 	copy_extent_buffer(left, right, btrfs_leaf_data(left) +
-		     leaf_data_end(fs_info, left) - push_space,
+		     leaf_data_end(left) - push_space,
 		     btrfs_leaf_data(right) +
 		     btrfs_item_offset_nr(right, push_items - 1),
 		     push_space);
@@ -2157,13 +2155,12 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root

 	if (push_items < right_nritems) {
 		push_space = btrfs_item_offset_nr(right, push_items - 1) -
-						  leaf_data_end(fs_info, right);
+						  leaf_data_end(right);
 		memmove_extent_buffer(right, btrfs_leaf_data(right) +
 				      BTRFS_LEAF_DATA_SIZE(root->fs_info) -
 				      push_space,
 				      btrfs_leaf_data(right) +
-				      leaf_data_end(fs_info, right),
-				      push_space);
+				      leaf_data_end(right), push_space);

 		memmove_extent_buffer(right, btrfs_item_nr_offset(0),
 			      btrfs_item_nr_offset(push_items),
@@ -2222,8 +2219,7 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,

 	nritems = nritems - mid;
 	btrfs_set_header_nritems(right, nritems);
-	data_copy_size = btrfs_item_end_nr(l, mid) -
-		leaf_data_end(root->fs_info, l);
+	data_copy_size = btrfs_item_end_nr(l, mid) - leaf_data_end(l);

 	copy_extent_buffer(right, l, btrfs_item_nr_offset(0),
 			   btrfs_item_nr_offset(mid),
@@ -2231,9 +2227,8 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,

 	copy_extent_buffer(right, l,
 		     btrfs_leaf_data(right) +
-		     BTRFS_LEAF_DATA_SIZE(root->fs_info) -
-		     data_copy_size, btrfs_leaf_data(l) +
-		     leaf_data_end(root->fs_info, l), data_copy_size);
+		     BTRFS_LEAF_DATA_SIZE(root->fs_info) - data_copy_size,
+			 btrfs_leaf_data(l) + leaf_data_end(l), data_copy_size);

 	rt_data_off = BTRFS_LEAF_DATA_SIZE(root->fs_info) -
 		      btrfs_item_end_nr(l, mid);
@@ -2572,7 +2567,7 @@ int btrfs_truncate_item(struct btrfs_root *root, struct btrfs_path *path,
 		return 0;

 	nritems = btrfs_header_nritems(leaf);
-	data_end = leaf_data_end(root->fs_info, leaf);
+	data_end = leaf_data_end(leaf);

 	old_data_start = btrfs_item_offset_nr(leaf, slot);

@@ -2661,7 +2656,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 	leaf = path->nodes[0];

 	nritems = btrfs_header_nritems(leaf);
-	data_end = leaf_data_end(root->fs_info, leaf);
+	data_end = leaf_data_end(leaf);

 	if (btrfs_leaf_free_space(leaf) < data_size) {
 		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
@@ -2747,7 +2742,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];

 	nritems = btrfs_header_nritems(leaf);
-	data_end = leaf_data_end(root->fs_info, leaf);
+	data_end = leaf_data_end(leaf);

 	if (btrfs_leaf_free_space(leaf) < total_size) {
 		btrfs_print_leaf(leaf, BTRFS_PRINT_TREE_DEFAULT);
@@ -2940,7 +2935,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	nritems = btrfs_header_nritems(leaf);

 	if (slot + nr != nritems) {
-		int data_end = leaf_data_end(root->fs_info, leaf);
+		int data_end = leaf_data_end(leaf);

 		memmove_extent_buffer(leaf, btrfs_leaf_data(leaf) +
 			      data_end + dsize,
--
2.17.1

