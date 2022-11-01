Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69649614EFC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKAQQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiKAQQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C68F1C919
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A51C96166F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97567C433C1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319365;
        bh=kxHUVuPlHxXy2xDMayvGUUmQn57kpjF4kaPqZJaQrjc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Zbi4CH3eLFxxR+MPkjYnkegwc+GGVn/f0eZ0J31npOhvtJESFMJWencCV0kC77mC5
         V3YZoIJj1Jm9XZRg1IUSkcdUcO1KKRlGalNmRTL9O7n9QXkx8f+wkoSZI2CK4fUsQj
         y+toPmFkkbJJI/OVWHG9xnQLeq9gdOM6Yg5a1MCHcUdsVOk/JNha26Ks997M5+Rlgi
         h2H0ML0753mOss8Y2StnbTULw6l0Y3SFRYvvPy7GaOXOEwdLa3v6kOuZVrxLoRzudr
         ebhWSYGNv77FRlu1kbYM+5fWk1d5bZkkv7GkMWLz+9fskrRpuQCKRmSA+mBSFkK1QR
         jQ0+OzTm+QIgw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/18] btrfs: send: avoid unnecessary backref lookups when finding clone source
Date:   Tue,  1 Nov 2022 16:15:44 +0000
Message-Id: <e64e975d5ab361b43b7888d5ada6826aa13a983b.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At find_extent_clone(), unless we are given an inline extent, a file
extent item that represents hole or an extent that starts beyond the
i_size, we always do backref walking to look for clone sources, unless
if we have more than SEND_MAX_EXTENT_REFS (64) known references on the
extent.

However if we know we only have one reference in the extent item and only
one clone source (the send root), then it's pointless to do the backref
walking to search for clone sources, as we can't clone from any other
root. So skip the backref walking in that case.

The following test was run on a non-debug kernel (Debian's default kernel
config):

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdi
   MNT=/mnt/sdi

   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   # Create an extent tree that's not too small and none of the
   # extents is shared.
   for ((i = 1; i <= 50000; i++)); do
      xfs_io -f -c "pwrite 0 4K" $MNT/file_$i > /dev/null
      echo -ne "\r$i files created..."
   done
   echo

   btrfs subvolume snapshot -r $MNT $MNT/snap

   start=$(date +%s%N)
   btrfs send $MNT/snap > /dev/null
   end=$(date +%s%N)

   dur=$(( (end - start) / 1000000 ))
   echo -e "\nsend took $dur milliseconds"

   umount $MNT

Before this change:

   send took 5389 milliseconds

After this change:

   send took 4519 milliseconds  (-16.1%)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 61496d3e1355..35c12fc7a864 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1354,6 +1354,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	u64 disk_byte;
 	u64 num_bytes;
 	u64 extent_item_pos;
+	u64 extent_refs;
 	u64 flags = 0;
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *eb = path->nodes[0];
@@ -1408,14 +1409,22 @@ static int find_extent_clone(struct send_ctx *sctx,
 
 	ei = btrfs_item_ptr(tmp_path->nodes[0], tmp_path->slots[0],
 			    struct btrfs_extent_item);
+	extent_refs = btrfs_extent_refs(tmp_path->nodes[0], ei);
 	/*
 	 * Backreference walking (iterate_extent_inodes() below) is currently
 	 * too expensive when an extent has a large number of references, both
 	 * in time spent and used memory. So for now just fallback to write
 	 * operations instead of clone operations when an extent has more than
 	 * a certain amount of references.
+	 *
+	 * Also, if we have only one reference and only the send root as a clone
+	 * source - meaning no clone roots were given in the struct
+	 * btrfs_ioctl_send_args passed to the send ioctl - then it's our
+	 * reference and there's no point in doing backref walking which is
+	 * expensive, so exit early.
 	 */
-	if (btrfs_extent_refs(tmp_path->nodes[0], ei) > SEND_MAX_EXTENT_REFS) {
+	if ((extent_refs == 1 && sctx->clone_roots_cnt == 1) ||
+	    extent_refs > SEND_MAX_EXTENT_REFS) {
 		ret = -ENOENT;
 		goto out;
 	}
-- 
2.35.1

