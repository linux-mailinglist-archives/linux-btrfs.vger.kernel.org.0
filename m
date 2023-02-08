Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46A68F607
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 18:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjBHRsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 12:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjBHRrv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 12:47:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDE92E834
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 09:47:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE266B81F18
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 17:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3419DC433EF
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675878414;
        bh=SwCmCGGyPTIB2eBEWOxWW6IDjZNBWoudDUiFAL3+GRo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CumQof+uxZBXnNUZjVbuTcaDyvjs2nEDpeBe1EwCkHJ7l2vSwCpAfGS5iUgweQpF5
         x/bA7WoB/OyGyatCBZDfIZnG8hLUiUjeqfwazwY8RQTICEbghqJX0BMdJqeMKDaP0v
         PEwOtS0gSH1E5k/Vhq+QpYUpqetL2vKCutdUvihqECWnWthk6LZQCmKR2R8CnAdmRR
         hMO4XcpXhxHqf9eVwVgZc43O+exsgeE74RAhTtBldVJbzYpcKvjiPPcGgOSKhNExqh
         yMNYI7Q2NoJd0Ty6RVjgsqIKhnmdNfNYYpwaq2W3+slIACJ3EDw0CZyZNtQ9sY7ZRP
         6eZlwZ7y56VoQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: do unsigned integer division in the extent buffer binary search loop
Date:   Wed,  8 Feb 2023 17:46:49 +0000
Message-Id: <ba00af7d2e579d5b8feba8a2f8bd02e986a1cd35.1675877903.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675877903.git.fdmanana@suse.com>
References: <cover.1675877903.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In the search loop of the binary search function, we are doing a division
by 2 of the sum of the high and low slots. Because the slots are integers,
the generated assembly code for it is the following on x86_64:

   0x00000000000141f1 <+145>:	mov    %eax,%ebx
   0x00000000000141f3 <+147>:	shr    $0x1f,%ebx
   0x00000000000141f6 <+150>:	add    %eax,%ebx
   0x00000000000141f8 <+152>:	sar    %ebx

It's a few more instructions than a simple right shift, because signed
integer division needs to round towards zero. However we know that slots
can never be negative (btrfs_header_nritems() returns an u32), so we
can instead use unsigned types for the low and high slots and therefore
use unsigned integer division, which results in a single instruction on
x86_64:

   0x00000000000141f0 <+144>:	shr    %ebx

So use unsigned types for the slots and therefore unsigned division.

This is part of a small patchset comprised of the following two patches:

  btrfs: eliminate extra call when doing binary search on extent buffer
  btrfs: do unsigned integer division in the extent buffer binary search loop

The following fs_mark test was run on a non-debug kernel (Debian's default
kernel config) before and after applying the patchset:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi
  MOUNT_OPTIONS="-o ssd"
  MKFS_OPTIONS="-O no-holes -R free-space-tree"
  FILES=100000
  THREADS=$(nproc --all)
  FILE_SIZE=0

  umount $DEV &> /dev/null
  mkfs.btrfs -f $MKFS_OPTIONS $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  OPTS="-S 0 -L 6 -n $FILES -s $FILE_SIZE -t $THREADS -k"
  for ((i = 1; i <= $THREADS; i++)); do
      OPTS="$OPTS -d $MNT/d$i"
  done

  fs_mark $OPTS

  umount $MNT

Results before applying patchset:

  FSUse%        Count         Size    Files/sec     App Overhead
       2      1200000            0     174472.0         11549868
       4      2400000            0     253503.0         11694618
       4      3600000            0     257833.1         11611508
       6      4800000            0     247089.5         11665983
       6      6000000            0     211296.1         12121244
      10      7200000            0     187330.6         12548565

Results after applying patchset:

  FSUse%        Count         Size    Files/sec     App Overhead
       2      1200000            0     207556.0         11393252
       4      2400000            0     266751.1         11347909
       4      3600000            0     274397.5         11270058
       6      4800000            0     259608.4         11442250
       6      6000000            0     238895.8         11635921
       8      7200000            0     211942.2         11873825

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 17 +++++++++++------
 fs/btrfs/ctree.h |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 34c76b217b52..93df9c1b6c9a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -853,8 +853,8 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 /*
  * Search for a key in the given extent_buffer.
  *
- * The lower boundary for the search is specified by the slot number @low. Use a
- * value of 0 to search over the whole extent buffer.
+ * The lower boundary for the search is specified by the slot number @first_slot.
+ * Use a value of 0 to search over the whole extent buffer.
  *
  * The slot in the extent buffer is returned via @slot. If the key exists in the
  * extent buffer, then @slot will point to the slot where the key is, otherwise
@@ -863,18 +863,23 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
  * Slot may point to the total number of items (i.e. one position beyond the last
  * key) if the key is bigger than the last key in the extent buffer.
  */
-int btrfs_generic_bin_search(struct extent_buffer *eb, int low,
+int btrfs_generic_bin_search(struct extent_buffer *eb, int first_slot,
 			     const struct btrfs_key *key, int *slot)
 {
 	unsigned long p;
 	int item_size;
-	int high = btrfs_header_nritems(eb);
+	/*
+	 * Use unsigned types for the low and high slots, so that we get a more
+	 * efficient division in the search loop below.
+	 */
+	u32 low = first_slot;
+	u32 high = btrfs_header_nritems(eb);
 	int ret;
 	const int key_size = sizeof(struct btrfs_disk_key);
 
-	if (low > high) {
+	if (unlikely(low > high)) {
 		btrfs_err(eb->fs_info,
-		 "%s: low (%d) > high (%d) eb %llu owner %llu level %d",
+		 "%s: low (%u) > high (%u) eb %llu owner %llu level %d",
 			  __func__, low, high, eb->start,
 			  btrfs_header_owner(eb), btrfs_header_level(eb));
 		return -EINVAL;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 322f2171275d..97897107fab5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -508,7 +508,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 int __init btrfs_ctree_init(void);
 void __cold btrfs_ctree_exit(void);
 
-int btrfs_generic_bin_search(struct extent_buffer *eb, int low,
+int btrfs_generic_bin_search(struct extent_buffer *eb, int first_slot,
 			     const struct btrfs_key *key, int *slot);
 
 /*
-- 
2.35.1

