Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1249C05F
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 01:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiAZA7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 19:59:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51892 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiAZA7K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 19:59:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C2F621122
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 00:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643158749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vxuxrwFizSCtowF8HPPpCs6xQ5QeSd0VtpH6bXDH/eg=;
        b=AXtRESNcamJosTIhlYFKPZLz1VDUcvsaD1S7YvQH36TkarE3PnMDFTiawWDqkGGBCutHrY
        4S3Jeg8124Y6sQoL1VzAGDH+gbf4AKQa5yudpLuQ4bYjT0Dn+Qodf+EFfDDlXv4ovk8dmL
        yWrp5iftmICAAqb9MHSZTxvrTScD+0E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E338133F5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 00:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id doEgCtyc8GH7BwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 00:59:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: defrag: don't try to merge regular extents with preallocated extents
Date:   Wed, 26 Jan 2022 08:58:48 +0800
Message-Id: <20220126005850.14729-1-wqu@suse.com>
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
  If so, don't defrag current extent.

- Add comments for each branch why we reject the extent

This will reduce the IO caused by defrag ioctl and autodefrag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use @extent_thresh from caller to replace the harded coded threshold
  Now caller has full control over the extent threshold value.

- Remove the old ambiguous check based on physical address
  The original check is too specific, only reject extents which are
  physically adjacent, AND too large.
  Since we have correct size check now, and the physically adjacent check
  is not always a win.
  So remove the old check completely.

v3:
- Split the @extent_thresh and physicall adjacent check into other
  patches

- Simplify the comment
---
 fs/btrfs/ioctl.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 91ba2efe9792..0d8bfc716e6b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1053,19 +1053,25 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
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
+	/* Preallocated */
+	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
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

