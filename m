Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AF56D853D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDERvj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 13:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjDERvi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 13:51:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE38D4ED2
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 10:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5574C62A01
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 17:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE8EC433EF
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 17:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680717095;
        bh=3DlxpWMBUuLlJrjt8HY3Igryya4pzdVms6u2NOfWgYM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BnxjrMh/B4brb+TNWKrpq2exAlW9/OZAmzn6GsdvGMj0YIqJ+09wgl8Ea3Bt2RIMS
         UNJUMVEgwIltI4WKHLTdHXRGLJ9FxJdbW/E1S/7X1cXwAZrPbjD0bH9HWvJset7moK
         aKtGKHEpy6FSKl+6sDBVlTI6g+DGMA8rclydBSIF8Z934JCugqk71hK98Lr1J3Flts
         TI9X8i8REObuRuupJ258eKduELijKuHluNLO7IjvdTd1GwGlzasJe+oWT0dzgpiGhP
         4vxbktPj1BBQGudyMSRwL0PezCG1uDGqmp1DTEpS5w+PbNdbhXgIDCDZBypNpSVeMI
         zD9NcQhc4Hpwg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: use log root when iterating over index keys when logging directory
Date:   Wed,  5 Apr 2023 18:51:30 +0100
Message-Id: <cd9c2250345d6bce7cd9ddcd8c3c79dfe6f5a1b6.1680716778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1680716778.git.fdmanana@suse.com>
References: <cover.1680716778.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging dir dentries of a directory, we iterate over the subvolume
tree to find dir index keys on leaves modified in the current transaction.
This however is heavy on locking, since btrfs_search_forward() may often
keep locks on extent buffers for quite a while when walking the tree to
find a suitable leaf modified in the current transaction and with a key
not smaller than then the provided minimum key. That means it will block
other tasks trying to access the subvolume tree, which may be common fs
operations like creating, renaming, linking, unlinking, reflinking files,
etc.

A better solution is to iterate the log tree, since it's much smaller than
a subvolume tree and just use plain btrfs_search_slot() (or the wrapper
btrfs_for_each_slot()) and only contains dir index keys added in the
current transaction.

The following bonnie++ test on a non-debug kernel (with Debian's default
kernel config) on a 20G null block device, was used to measure the impact:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/nullb0
   MNT=/mnt/nullb0

   NR_DIRECTORIES=20
   NR_FILES=20480  # must be a multiple of 1024
   DATASET_SIZE=$(( (8 * 1024 * 1024 * 1024) / 1048576 )) # 8 GiB as megabytes
   DIRECTORY_SIZE=$(( DATASET_SIZE / NR_FILES ))
   NR_FILES=$(( NR_FILES / 1024 ))

   umount $DEV &> /dev/null
   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   bonnie++ -u root -d $MNT \
       -n $NR_FILES:$DIRECTORY_SIZE:$DIRECTORY_SIZE:$NR_DIRECTORIES \
       -r 0 -s $DATASET_SIZE -b

   umount $MNT

Before patchset:

   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
   debian0          8G  376k  99  1.1g  98  939m  92 1527k  99  3.2g  99  9060 256
   Latency             24920us     207us     680ms    5594us     171us    2891us
   Version 2.00a       ------Sequential Create------ --------Random Create--------
   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
                 files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 20/20 20480  96 +++++ +++ 20480  95 20480  99 +++++ +++ 20480  97
   Latency              8708us     137us    5128us    6743us      60us   19712us

After patchset:

   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
   debian0          8G  384k  99  1.2g  99  971m  91 1533k  99  3.3g  99  9180 309
   Latency             24930us     125us     661ms    5587us      46us    2020us
   Version 2.00a       ------Sequential Create------ --------Random Create--------
   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
                 files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 20/20 20480  90 +++++ +++ 20480  99 20480  99 +++++ +++ 20480  97
   Latency              7030us      61us    1246us    4942us      56us   16855us

The patchset consists of this patch plus a previous one that has the
following subject:

   "btrfs: avoid iterating over all indexes when logging directory"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 51 +++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c2a467276071..f298d7b03b8c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5428,45 +5428,34 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 
 	while (true) {
 		struct inode *vfs_inode;
-		struct extent_buffer *leaf;
-		struct btrfs_key min_key;
+		struct btrfs_key key;
+		struct btrfs_key found_key;
 		u64 next_index;
 		bool continue_curr_inode = true;
-		int nritems;
-		int i;
+		int iter_ret;
 
-		min_key.objectid = ino;
-		min_key.type = BTRFS_DIR_INDEX_KEY;
-		min_key.offset = btrfs_get_first_dir_index_to_log(curr_inode);
-		next_index = min_key.offset;
+		key.objectid = ino;
+		key.type = BTRFS_DIR_INDEX_KEY;
+		key.offset = btrfs_get_first_dir_index_to_log(curr_inode);
+		next_index = key.offset;
 again:
-		ret = btrfs_search_forward(root, &min_key, path, trans->transid);
-		if (ret < 0) {
-			break;
-		} else if (ret > 0) {
-			ret = 0;
-			goto next;
-		}
-
-		leaf = path->nodes[0];
-		nritems = btrfs_header_nritems(leaf);
-		for (i = path->slots[0]; i < nritems; i++) {
+		btrfs_for_each_slot(root->log_root, &key, &found_key, path, iter_ret) {
+			struct extent_buffer *leaf = path->nodes[0];
 			struct btrfs_dir_item *di;
 			struct btrfs_key di_key;
 			struct inode *di_inode;
 			int log_mode = LOG_INODE_EXISTS;
 			int type;
 
-			btrfs_item_key_to_cpu(leaf, &min_key, i);
-			if (min_key.objectid != ino ||
-			    min_key.type != BTRFS_DIR_INDEX_KEY) {
+			if (found_key.objectid != ino ||
+			    found_key.type != BTRFS_DIR_INDEX_KEY) {
 				continue_curr_inode = false;
 				break;
 			}
 
-			next_index = min_key.offset + 1;
+			next_index = found_key.offset + 1;
 
-			di = btrfs_item_ptr(leaf, i, struct btrfs_dir_item);
+			di = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
 			type = btrfs_dir_ftype(leaf, di);
 			if (btrfs_dir_transid(leaf, di) < trans->transid)
 				continue;
@@ -5508,12 +5497,20 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 
 		btrfs_release_path(path);
 
-		if (continue_curr_inode && min_key.offset < (u64)-1) {
-			min_key.offset++;
+		if (iter_ret < 0) {
+			ret = iter_ret;
+			goto out;
+		} else if (iter_ret > 0) {
+			continue_curr_inode = false;
+		} else {
+			key = found_key;
+		}
+
+		if (continue_curr_inode && key.offset < (u64)-1) {
+			key.offset++;
 			goto again;
 		}
 
-next:
 		btrfs_set_first_dir_index_to_log(curr_inode, next_index);
 
 		if (list_empty(&dir_list))
-- 
2.34.1

