Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DFE716D71
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 21:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjE3TWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 15:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjE3TWc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 15:22:32 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731C68E
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 12:22:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C8D7632002D8;
        Tue, 30 May 2023 15:22:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 30 May 2023 15:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685474549; x=
        1685560949; bh=y2SXIgmt9UtLbFvRVYpI2LYvsOHy2NvcI6/KxedaWOQ=; b=B
        sKdlVhZzk3ietdvlBUzVBp8axs5rNTixgLHredwygrrLmhze++A9tT3VzvVQ7+yx
        2l0oThy8GE6R6aDhsBwTZMzfIn8Cgx1qVmv79/DR1xoCd8BEqcyNmPsAI7IfNG13
        HuYyMDak/2O0XjJZpfH+5Ac5rKvQjfSrRuqgtFtEthxavVtYITJiBWlBvsAoKf3g
        jSxY39cFDmuFDFG/bNbXkUpJQwpPZ3SNQRseGxV1PA9wIYfD5YbCtrPAyW+ze0Cz
        IQbVyVEaDboi6Jlnkb+TvidzW44XuN9obXF4aTW5NY3DE+skYRTHlqufj8FXfH54
        apnobhIGKH/QNSUaaJWsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685474549; x=1685560949; bh=y
        2SXIgmt9UtLbFvRVYpI2LYvsOHy2NvcI6/KxedaWOQ=; b=lvn30Jgw7tMJQNe6w
        Mirnc+Lr24E4e0hu9IubwXFGRS3QeujxoHOdt8jmdl50JVwsczQSzsdJfdbAfDIv
        SIKzP/wwfl2y7QnzJLIgyiRcpz07syH9DuCrVcjhiwz4697pGo9Jvah3aF1nAzK4
        kqF/PyyRO+8Yd/mGzrtqbUVSL6boU8A16Rgav5W3Cgj2usALczkT05ZqJNdnZ++X
        ClmeLAyeGnykiyNjHi7krjdUdjoxdAOwZEmGYKxWTtQPc3givL6f7bMHAeuYO9OQ
        gKGyPkG/J2suouYBQff48QTzoUPxmZP3H7HIeczZs/AW+Ao9ZaVtnpsMefKsErj1
        k3erA==
X-ME-Sender: <xms:9Ux2ZEfqcRIohabwPnZ3tRz8QCzTOvuijAaEfiLSkPzSHmEHWqiCbg>
    <xme:9Ux2ZGOmZgb6mtgFANYO5Ob6L2s1s5DDl5Rsk6WfA12eEftaca9cVlvPAV_hGZvX_
    j7Z8BqdJc4ZHLtXB-4>
X-ME-Received: <xmr:9Ux2ZFgi1ifZ9CI-aKEH_yDwMkqftwfaMsN8Sg7nuWJLHkc3f7M06TjC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:9Ux2ZJ8bC5d1JiZpMmtfM-_yuK5hXV2PtiedPvvxw_qK9ykVhTh4gw>
    <xmx:9Ux2ZAthY9-CliIXcxcR9JtQPnwBia8VZ674pyTDZZ41eHWBVQ02UQ>
    <xmx:9Ux2ZAHQiucgTTQwHl_ica9j_wATwzwVa-IBB-ZOFB0At5IuyJ0y2Q>
    <xmx:9Ux2ZG0y9OhhOuDG32WZIUhIp-JCTozFNtDUi-Q-wMW42O24dnUKQA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 15:22:28 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: insert tree mod log move in push_node_left
Date:   Tue, 30 May 2023 12:22:09 -0700
Message-Id: <4b1dd791ac009e413041c764999c7d1ef6079698.1685474140.git.boris@bur.io>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685474139.git.boris@bur.io>
References: <cover.1685474139.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a fairly unlikely race condition in tree mod log rewind that
can result in a kernel panic which has the following trace:

[ 1222530.569417] BTRFS critical (device sda3): unable to find logical 0
length 4096
[ 1222530.585809] BTRFS critical (device sda3): unable to find logical 0
length 4096
[ 1222530.602227] BUG: kernel NULL pointer dereference, address:
0000000000000002
[ 1222530.618003] #PF: supervisor read access in kernel mode
[ 1222530.629746] #PF: error_code(0x0000) - not-present page
[ 1222530.641491] PGD 0 P4D 0
[ 1222530.647480] Oops: 0000 [#1] SMP
[ 1222530.654812] CPU: 30 PID: 398973 Comm: below Kdump: loaded Tainted:
G S         O  K   5.12.0-0_fbk13_clang_7455_gb24de3bdb045 #1
[ 1222530.680772] Hardware name: Quanta Mono Lake-M.2 SATA
1HY9U9Z001G/Mono Lake-M.2 SATA, BIOS F20_3A15 08/16/2017
[ 1222530.703081] RIP: 0010:__btrfs_map_block+0xaa/0xd00
[ 1222530.714070] Code: 00 4c 8b 40 18 48 89 44 24 38 4c 8b 48 20 4d 01
c1 4d 39 e0 0f 87 85 03 00 00 4c 3b 4c 24 30 0f 82 7a 03 00 00 48 8b 44
24 38 <4c> 8b 40 18 4c 8b 60 70 48 8b 4c 24 30 4c 29 c1 4d 8b 6c 24 10
   48
   [ 1222530.755971] RSP: 0018:ffffc9002c2f7600 EFLAGS: 00010246
   [ 1222530.767894] RAX: ffffffffffffffea RBX: ffff888292e41000 RCX:
   f2702d8b8be15100
   [ 1222530.784058] RDX: ffff88885fda6fb8 RSI: ffff88885fd973c8 RDI:
   ffff88885fd973c8
   [ 1222530.800219] RBP: ffff888292e410d0 R08: ffffffff82fd7fd0 R09:
   00000000fffeffff
   [ 1222530.816380] R10: ffffffff82e57fd0 R11: ffffffff82e57d70 R12:
   0000000000000000
   [ 1222530.832541] R13: 0000000000001000 R14: 0000000000001000 R15:
   ffffc9002c2f76f0
   [ 1222530.848702] FS:  00007f38d64af000(0000)
   GS:ffff88885fd80000(0000) knlGS:0000000000000000
   [ 1222530.866978] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   [ 1222530.880080] CR2: 0000000000000002 CR3: 00000002b6770004 CR4:
   00000000003706e0
   [ 1222530.896245] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
   0000000000000000
   [ 1222530.912407] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
   0000000000000400
   [ 1222530.928570] Call Trace:
   [ 1222530.934368]  ? btrfs_printk+0x13b/0x18c
   [ 1222530.943241]  ? btrfs_bio_counter_inc_blocked+0x3d/0x130
   [ 1222530.955191]  btrfs_map_bio+0x75/0x330
   [ 1222530.963683]  ? kmem_cache_alloc+0x12a/0x2d0
   [ 1222530.973322]  ? btrfs_submit_metadata_bio+0x63/0x100
   [ 1222530.984501]  btrfs_submit_metadata_bio+0xa4/0x100
   [ 1222530.995297]  submit_extent_page+0x30f/0x360
   [ 1222531.004940]  read_extent_buffer_pages+0x49e/0x6d0
   [ 1222531.015733]  ? submit_extent_page+0x360/0x360
   [ 1222531.025770]  btree_read_extent_buffer_pages+0x5f/0x150
   [ 1222531.037522]  read_tree_block+0x37/0x60
   [ 1222531.046202]  read_block_for_search+0x18b/0x410
   [ 1222531.056422]  btrfs_search_old_slot+0x198/0x2f0
   [ 1222531.066641]  resolve_indirect_ref+0xfe/0x6f0
   [ 1222531.076472]  ? ulist_alloc+0x31/0x60
   [ 1222531.084773]  ? kmem_cache_alloc_trace+0x12e/0x2b0
   [ 1222531.095569]  find_parent_nodes+0x720/0x1830
   [ 1222531.105222]  ? ulist_alloc+0x10/0x60
   [ 1222531.113530]  iterate_extent_inodes+0xea/0x370
   [ 1222531.123543]  ? btrfs_previous_extent_item+0x8f/0x110
   [ 1222531.134914]  ? btrfs_search_path_in_tree+0x240/0x240
   [ 1222531.146283]  iterate_inodes_from_logical+0x98/0xd0
   [ 1222531.157268]  ? btrfs_search_path_in_tree+0x240/0x240
   [ 1222531.168638]  btrfs_ioctl_logical_to_ino+0xd9/0x180
   [ 1222531.179622]  btrfs_ioctl+0xe2/0x2eb0

This occurs when logical inode resolution takes a tree mod log sequence
number, and then while backref walking hits a rewind on a busy node
which has the following sequence of tree mod log operations (numbers
filled in from a specific example, but they are somewhat arbitrary)

REMOVE_WHILE_FREEING slot 532
REMOVE_WHILE_FREEING slot 531
REMOVE_WHILE_FREEING slot 530
...
REMOVE_WHILE_FREEING slot 0
REMOVE slot 455
REMOVE slot 454
REMOVE slot 453
...
REMOVE slot 0
ADD slot 455
ADD slot 454
ADD slot 453
...
ADD slot 0
MOVE src slot 0 -> dst slot 456 nritems 533
REMOVE slot 455
REMOVE slot 454
REMOVE slot 453
...
REMOVE slot 0

When this sequence gets applied via btrfs_tree_mod_log_rewind, it
allocates a fresh rewind eb, and first inserts the correct key info for
the 533 elements, then overwrites the first 456 of them, then decrements
the count by 456 via the add ops, then rewinds the move by doing a
memmove from 456:988->0:532. We have never written anything past 532, so
that memmove writes garbage into the 0:532 range. In practice, this
results in a lot of fully 0 keys. The rewind then puts valid keys into
slots 0:455 with the last removes, but 456:532 are still invalid.

When search_old_slot uses this eb, if it uses one of those invalid
slots, it can then read the extent buffer and issue a bio for offset 0
which ultimately panics looking up extent mappings.

This bad tree mod log sequence gets generated when the node balancing
code happens to do a balance_node_right followed by a push_node_left
while logging in the tree mod log. Illustrated for ebs L and R (left and
right):

      L                 R
start:
[XXX|YYY|...]      [ZZZ|...|...]
balance_node_right:
[XXX|YYY|...]      [...|ZZZ|...] move Z to make room for Y
[XXX|...|...]      [YYY|ZZZ|...] copy Y from L to R
push_node_left:
[XXX|YYY|...]      [...|ZZZ|...] copy Y from R to L
[XXX|YYY|...]      [ZZZ|...|...] move Z into emptied space (NOT LOGGED!)

This is because balance_node_right logs a move, but push_node_left
explicitly doesn't. That is because logging the move would remove the
overwritten src < dst range in the right eb, which was already logged
when we called btrfs_tree_mod_log_eb_copy. The correct sequence would
include a move from 456:988 to 0:532 after remove 0:455 and before
removing 0:532. Reversing that sequence would entail creating keys for
0:532, then moving those keys out to 456:988, then creating more keys
for 0:455.

i.e.,
REMOVE_WHILE_FREEING slot 532
REMOVE_WHILE_FREEING slot 531
REMOVE_WHILE_FREEING slot 530
...
REMOVE_WHILE_FREEING slot 0
MOVE src slot 456 -> dst slot 0 nritems 533
REMOVE slot 455
REMOVE slot 454
REMOVE slot 453
...
REMOVE slot 0
ADD slot 455
ADD slot 454
ADD slot 453
...
ADD slot 0
MOVE src slot 0 -> dst slot 456 nritems 533
REMOVE slot 455
REMOVE slot 454
REMOVE slot 453
...
REMOVE slot 0

Fix this to log the move but avoid the double remove by putting all the
logging logic in btrfs_tree_mod_log_eb_copy which has enough information
to detect these cases and properly log moves, removes, and adds. Leave
btrfs_tree_mod_log_insert_move to handle insert_ptr and delete_ptr's
tree mod logging.

Unfortunately, this is quite difficult to reproduce, and I was only
able to reproduce it by adding sleeps in btrfs_search_old_slot that
would encourage more log rewinding during ino_to_logical ioctls. I was
able to hit the warning in the previous patch in the series without the
fix quite quickly, but not after this patch.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ctree.c        | 19 ++++++-----
 fs/btrfs/tree-mod-log.c | 73 +++++++++++++++++++++++++++++++++++------
 2 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2f2071d64c52..eac9e84cb064 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2785,8 +2785,8 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 
 	if (push_items < src_nritems) {
 		/*
-		 * Don't call btrfs_tree_mod_log_insert_move() here, key removal
-		 * was already fully logged by btrfs_tree_mod_log_eb_copy() above.
+		 * btrfs_tree_mod_log_eb_copy handles logging the move, so we
+		 * don't need to do an explicit tree mod log operation for it.
 		 */
 		memmove_extent_buffer(src, btrfs_node_key_ptr_offset(src, 0),
 				      btrfs_node_key_ptr_offset(src, push_items),
@@ -2847,12 +2847,6 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
-	ret = btrfs_tree_mod_log_insert_move(dst, push_items, 0, dst_nritems);
-	BUG_ON(ret < 0);
-	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(dst, push_items),
-				      btrfs_node_key_ptr_offset(dst, 0),
-				      (dst_nritems) *
-				      sizeof(struct btrfs_key_ptr));
 
 	ret = btrfs_tree_mod_log_eb_copy(dst, src, 0, src_nritems - push_items,
 					 push_items);
@@ -2860,6 +2854,15 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
+
+	/*
+	 * btrfs_tree_mod_log_eb_copy handles logging the move, so we
+	 * don't need to do an explicit tree mod log operation for it.
+	 */
+	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(dst, push_items),
+			      btrfs_node_key_ptr_offset(dst, 0),
+			      (dst_nritems) * sizeof(struct btrfs_key_ptr));
+
 	copy_extent_buffer(dst, src,
 			   btrfs_node_key_ptr_offset(dst, 0),
 			   btrfs_node_key_ptr_offset(src, src_nritems - push_items),
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 1b1ae9ce9d1e..9d481ee0e296 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -248,6 +248,25 @@ int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
 	return ret;
 }
 
+static struct tree_mod_elem *tree_mod_log_alloc_move(struct extent_buffer *eb,
+						     int dst_slot, int src_slot,
+						     int nr_items)
+{
+	struct tree_mod_elem *tm = NULL;
+
+	tm = kzalloc(sizeof(*tm), GFP_NOFS);
+	if (!tm)
+		return ERR_PTR(-ENOMEM);
+
+	tm->logical = eb->start;
+	tm->slot = src_slot;
+	tm->move.dst_slot = dst_slot;
+	tm->move.nr_items = nr_items;
+	tm->op = BTRFS_MOD_LOG_MOVE_KEYS;
+
+	return tm;
+}
+
 int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
 				   int dst_slot, int src_slot,
 				   int nr_items)
@@ -265,17 +284,9 @@ int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
 	if (!tm_list)
 		return -ENOMEM;
 
-	tm = kzalloc(sizeof(*tm), GFP_NOFS);
-	if (!tm) {
-		ret = -ENOMEM;
+	tm = tree_mod_log_alloc_move(eb, dst_slot, src_slot, nr_items);
+	if (IS_ERR(tm))
 		goto free_tms;
-	}
-
-	tm->logical = eb->start;
-	tm->slot = src_slot;
-	tm->move.dst_slot = dst_slot;
-	tm->move.nr_items = nr_items;
-	tm->op = BTRFS_MOD_LOG_MOVE_KEYS;
 
 	for (i = 0; i + dst_slot < src_slot && i < nr_items; i++) {
 		tm_list[i] = alloc_tree_mod_elem(eb, i + dst_slot,
@@ -489,6 +500,10 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 	struct tree_mod_elem **tm_list_add, **tm_list_rem;
 	int i;
 	bool locked = false;
+	struct tree_mod_elem *dst_move_tm = NULL;
+	struct tree_mod_elem *src_move_tm = NULL;
+	u32 dst_move_nr_items = btrfs_header_nritems(dst) - dst_offset;
+	u32 src_move_nr_items = btrfs_header_nritems(src) - (src_offset + nr_items);
 
 	if (!tree_mod_need_log(fs_info, NULL))
 		return 0;
@@ -501,6 +516,24 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 	if (!tm_list)
 		return -ENOMEM;
 
+	if (dst_move_nr_items) {
+		dst_move_tm = tree_mod_log_alloc_move(dst, dst_offset + nr_items,
+						      dst_offset, dst_move_nr_items);
+		if (IS_ERR(dst_move_tm)) {
+			ret = PTR_ERR(dst_move_tm);
+			goto free_tms;
+		}
+	}
+	if (src_move_nr_items) {
+		src_move_tm = tree_mod_log_alloc_move(src, src_offset,
+						      src_offset + nr_items,
+						      src_move_nr_items);
+		if (IS_ERR(src_move_tm)) {
+			ret = PTR_ERR(src_move_tm);
+			goto free_tms;
+		}
+	}
+
 	tm_list_add = tm_list;
 	tm_list_rem = tm_list + nr_items;
 	for (i = 0; i < nr_items; i++) {
@@ -523,6 +556,11 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 		goto free_tms;
 	locked = true;
 
+	if (dst_move_tm) {
+		ret = tree_mod_log_insert(fs_info, dst_move_tm);
+		if (ret)
+			goto free_tms;
+	}
 	for (i = 0; i < nr_items; i++) {
 		ret = tree_mod_log_insert(fs_info, tm_list_rem[i]);
 		if (ret)
@@ -531,6 +569,11 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 		if (ret)
 			goto free_tms;
 	}
+	if (src_move_tm) {
+		ret = tree_mod_log_insert(fs_info, src_move_tm);
+		if (ret)
+			goto free_tms;
+	}
 
 	write_unlock(&fs_info->tree_mod_log_lock);
 	kfree(tm_list);
@@ -538,6 +581,16 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 	return 0;
 
 free_tms:
+	if (dst_move_tm && !IS_ERR(dst_move_tm)) {
+		if (!RB_EMPTY_NODE(&dst_move_tm->node))
+			rb_erase(&dst_move_tm->node, &fs_info->tree_mod_log);
+		kfree(dst_move_tm);
+	}
+	if (src_move_tm && !IS_ERR(src_move_tm)) {
+		if (!RB_EMPTY_NODE(&src_move_tm->node))
+			rb_erase(&src_move_tm->node, &fs_info->tree_mod_log);
+		kfree(src_move_tm);
+	}
 	for (i = 0; i < nr_items * 2; i++) {
 		if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
 			rb_erase(&tm_list[i]->node, &fs_info->tree_mod_log);
-- 
2.40.1

