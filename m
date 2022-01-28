Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8494349F448
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 08:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346749AbiA1HVm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 02:21:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60570 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346746AbiA1HVm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 02:21:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 273BF2171F
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643354501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Aw03wqEo0PF3FBeeL4pSZKfIo0x+2Gmm1OtIIgWX/0=;
        b=bJCfpG33KTXjRChKSoLF3tusznnIjWBNzK9poXpC7a60KnE9GO5YYhu1W7wK/AaJxvQuqk
        0BJ3jBRrKGoOUwOJhQTF/aB7pTuEhMQSIYLTrTGN2bXONk5M6l8RmW6lEDGP+4AeoWuV1U
        SroEbfnu8Mz5CwZn/DRVbQg3CL/w8ts=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FA5D139C4
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 07:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kEUcGISZ82HHQQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 07:21:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 1/3] btrfs: defrag: don't try to merge regular extents with preallocated extents
Date:   Fri, 28 Jan 2022 15:21:20 +0800
Message-Id: <631137433533de5eb304d9e87c799a65cd4cf62f.1643354254.git.wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643354254.git.wqu@suse.com>
References: <cover.1643354254.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With older kernels (before v5.16), btrfs will defrag preallocated extents.
While with newer kernels (v5.16 and newer) btrfs will not defrag
preallocated extents, but it will defrag the extent just before the
preallocated extent, even it's just a single sector.

This can be exposed by the following small script:

	mkfs.btrfs -f $dev > /dev/null

	mount $dev $mnt
	xfs_io -f -c "pwrite 0 4k" -c sync -c "falloc 4k 16K" $mnt/file
	xfs_io -c "fiemap -v" $mnt/file
	btrfs fi defrag $mnt/file
	sync
	xfs_io -c "fiemap -v" $mnt/file

The output looks like this on older kernels:

/mnt/btrfs/file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..7]:          26624..26631         8   0x0
   1: [8..39]:         26632..26663        32 0x801
/mnt/btrfs/file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..39]:         26664..26703        40   0x1

Which defrags the single sector along with the preallocated extent, and
replace them with an regular extent into a new location (caused by data
COW).
This wastes most of the data IO just for the preallocated range.

On the other hand, v5.16 is slightly better:

/mnt/btrfs/file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..7]:          26624..26631         8   0x0
   1: [8..39]:         26632..26663        32 0x801
/mnt/btrfs/file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..7]:          26664..26671         8   0x0
   1: [8..39]:         26632..26663        32 0x801

The preallocated range is not defragged, but the sector before it still
gets defragged, which has no need for it.

[CAUSE]
One of the function reused by the old and new behavior is
defrag_check_next_extent(), it will determine if we should defrag
current extent by checking the next one.

It only checks if the next extent is a hole or inlined, but it doesn't
check if it's preallocated.

On the other hand, out of the function, both old and new kernel will
reject preallocated extents.

Such inconsistent behavior causes above behavior.

[FIX]
- Also check if next extent is preallocated
  If so, don't defrag current extent.

- Add comments for each branch why we reject the extent

This will reduce the IO caused by defrag ioctl and autodefrag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 91ba2efe9792..a622b1ac0fec 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1053,19 +1053,24 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 				     bool locked)
 {
 	struct extent_map *next;
-	bool ret = true;
+	bool ret = false;
 
 	/* this is the last extent */
 	if (em->start + em->len >= i_size_read(inode))
-		return false;
+		return ret;
 
 	next = defrag_lookup_extent(inode, em->start + em->len, locked);
+	/* No more em or hole */
 	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
-		ret = false;
-	else if ((em->block_start + em->block_len == next->block_start) &&
-		 (em->block_len > SZ_128K && next->block_len > SZ_128K))
-		ret = false;
-
+		goto out;
+	if (test_bit(EXTENT_FLAG_PREALLOC, &next->flags))
+		goto out;
+	/* Physically adjacent and large enough */
+	if ((em->block_start + em->block_len == next->block_start) &&
+	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
+		goto out;
+	ret = true;
+out:
 	free_extent_map(next);
 	return ret;
 }
-- 
2.34.1

