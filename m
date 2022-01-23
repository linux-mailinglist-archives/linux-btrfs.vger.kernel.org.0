Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94836496FC2
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jan 2022 05:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiAWExG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jan 2022 23:53:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43172 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiAWExF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jan 2022 23:53:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73DB621129
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 04:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642913580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AOsrUw8tEf+i4t277LBAN6HfXtIONlK31GjGmsyuhSM=;
        b=cCJPFFEZi1o4ftjYlvFjNIeGmvve6KsM+4MkrQie/elz2/B7BK3P+YAiU0kBpV4zRmrzpZ
        1RCAYnwLoAR+o9a4rqMGYQHBdgzlD6mgdno3EibbLIZnq0lezUC9jYJSGL5hv/hdSdk0Xe
        w393m/h/qSQaVBDh0YsMP/Kx8x42pZE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C68421333C
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 04:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n0CDIyvf7GEkOgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 04:52:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: defrag: don't try to merge regular extents with preallocated extents
Date:   Sun, 23 Jan 2022 12:52:42 +0800
Message-Id: <20220123045242.25247-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
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
  If so, don't defrag current extent

- Add comments on each case we don't defrag

This will reduce the IO caused by defrag ioctl and autodefrag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 91ba2efe9792..dfa81b377e89 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1049,23 +1049,40 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	return em;
 }
 
+/*
+ * Return if current extent @em is a good candidate for defrag.
+ *
+ * This is done by checking against the next extent after @em.
+ */
 static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
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
+	/* No next extent or a hole, no way to merge */
 	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
-		ret = false;
-	else if ((em->block_start + em->block_len == next->block_start) &&
-		 (em->block_len > SZ_128K && next->block_len > SZ_128K))
-		ret = false;
+		goto out;
 
+	/* Next extent is preallocated, no sense to defrag current extent */
+	if (test_bit(EXTENT_FLAG_PREALLOC, &next->flags))
+		goto out;
+
+	/*
+	 * Next extent are not only mergable but also adjacent in their
+	 * logical address, normally an excellent candicate, but if they
+	 * are already large enough, then no need to defrag current extent.
+	 */
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

