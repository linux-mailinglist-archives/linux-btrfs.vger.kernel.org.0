Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5557441AAD
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Nov 2021 12:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhKALdK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 07:33:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49766 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhKALdJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Nov 2021 07:33:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 687372191A;
        Mon,  1 Nov 2021 11:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635766235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2ibFnwGedMo3ogkahWehufT9bCp3bNLUouMQ2VK613g=;
        b=cRF7ZrMo+XfVjoYdh5xKWLgE97h5EGvXZHovc+QP1l3Ok0IASLN/vV69GsgI+d3cAtMuZS
        aWHD3sTx/qe0SUVIoZTL4Wdb9LCMJF7NRCnbde9YN9CpbtbV1psZhsQb+hg3gljRo1c2ks
        u5YDw+iZFn4UzO1OSyZBVh4zw3GzUQI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CE74133FE;
        Mon,  1 Nov 2021 11:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U+YJEdrPf2GjZQAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 01 Nov 2021 11:30:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: fix a lowmem mode crash where fatal error is not properly handled
Date:   Mon,  1 Nov 2021 19:30:17 +0800
Message-Id: <20211101113017.52665-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When a special image (diverted from fsck/012) has its unused slots (slot
number >= nritems) with garbage, lowmem mode btrfs check can crash:

  (gdb) run check --mode=lowmem ~/downloads/good.img.restored
  Starting program: /home/adam/btrfs/btrfs-progs/btrfs check --mode=lowmem ~/downloads/good.img.restored
  ...
  ERROR: root 5 INODE[5044031582654955520] nlink(257228800) not equal to inode_refs(0)
  ERROR: root 5 INODE[5044031582654955520] nbytes 474624 not equal to extent_size 0

  Program received signal SIGSEGV, Segmentation fault.
  0x0000555555639b11 in btrfs_inode_size (eb=0x5555558a7540, s=0x642e6cd1) at ./kernel-shared/ctree.h:1703
  1703	BTRFS_SETGET_FUNCS(inode_size, struct btrfs_inode_item, size, 64);
  (gdb) bt
  #0  0x0000555555639b11 in btrfs_inode_size (eb=0x5555558a7540, s=0x642e6cd1) at ./kernel-shared/ctree.h:1703
  #1  0x0000555555641544 in check_inode_item (root=0x5555556c2290, path=0x7fffffffd960) at check/mode-lowmem.c:2628

[CAUSE]
At check_inode_item() we have path->slot[0] at 29, while the tree block
only has 26 items.

This happens because two reasons:

- btrfs_next_item() never reverts its slots
  Even if we failed to read next leaf.

- check_inode_item() doesn't inform the caller that a fatal error
  happened
  In check_inode_item(), if btrfs_next_item() failed, it goes to out
  label, which doesn't really set @err properly.

This means, when check_inode_item() fails at btrfs_next_item(), it will
increase path->slots[0], while it's already beyond current tree block
nritems.

When the slot increases furthermore, and if the unused item slots have
some garbage, we will get invalid btrfs_item_ptr() result, and causing
above segfault.

[FIX]
Fix the problems by two ways:

- Make btrfs_next_item() to revert its path->slots[0] on failure

- Properly detect fatal error from check_inode_item()

By this, we will no longer crash on the crafted image.

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Issue: #412
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c   |  4 ++--
 kernel-shared/ctree.h | 13 +++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index b88b2b1980c9..696ad2157c2b 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2686,7 +2686,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 			ret = -EIO;
 
 		if (ret < 0) {
-			/* out will fill 'err' rusing current statistics */
+			err |= FATAL_ERROR;
 			goto out;
 		} else if (ret > 0) {
 			err |= LAST_ITEM;
@@ -2898,7 +2898,7 @@ again:
 	/* modify cur since check_inode_item may change path */
 	cur = path->nodes[0];
 
-	if (err & LAST_ITEM)
+	if (err & LAST_ITEM || err & FATAL_ERROR)
 		goto out;
 
 	/* still have inode items in this leaf */
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 563ea50b3587..8af09623f817 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2729,8 +2729,17 @@ static inline int btrfs_next_item(struct btrfs_root *root,
 				  struct btrfs_path *p)
 {
 	++p->slots[0];
-	if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
-		return btrfs_next_leaf(root, p);
+	if (p->slots[0] >= btrfs_header_nritems(p->nodes[0])) {
+		int ret;
+		ret = btrfs_next_leaf(root, p);
+		/*
+		 * Revert the increased slot, or the path may point to
+		 * an invalid item.
+		 */
+		if (ret)
+			p->slots[0]--;
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.33.1

