Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8B49DA00
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 06:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiA0FZE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 00:25:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48366 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbiA0FZD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 00:25:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C648218F1;
        Thu, 27 Jan 2022 05:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643261102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIkzZtbSAZxoMvphFoEF8ySkYy8yA+knJGEfTdGDSic=;
        b=QFF1brMT8CzMBFhKv+oai7URocIPxfIh14Qteuob5arBv7hGnzzJnbZ6JhOdSm4tkz7vsA
        d8ojw3+17tU5S9khFEz0AQ+x5vIA8JJCrSSqHweD2jv4UWqDpkgk6i1GnS+kHPvLpN4nEQ
        S1ROyIz8xCBr5URGwi+/5QKY5ov95aM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A24FA13F58;
        Thu, 27 Jan 2022 05:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GAlBG60s8mFOXgAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 27 Jan 2022 05:25:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] btrfs: defrag: don't defrag extents which is already at its max capacity
Date:   Thu, 27 Jan 2022 13:24:42 +0800
Message-Id: <9511adf7a32cb7200f62bc65741cd86dbf2a9365.1643260816.git.wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643260816.git.wqu@suse.com>
References: <cover.1643260816.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For compressed extents, defrag ioctl will always try to defrag any
compressed extents, wasting not only IO but also CPU time to
compress/decompress:

   mkfs.btrfs -f $DEV
   mount -o compress $DEV $MNT
   xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/foobar
   sync
   xfs_io -f -c "pwrite -S 0xcd 128K 128K" $MNT/foobar
   sync
   echo "=== before ==="
   xfs_io -c "fiemap -v" $MNT/foobar
   btrfs filesystem defrag $MNT/foobar
   sync
   echo "=== after ==="
   xfs_io -c "fiemap -v" $MNT/foobar

Then it shows the 2 128K extents just get CoW for no extra benefit, with
extra IO/CPU spent:

    === before ===
    /mnt/btrfs/file1:
     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
       0: [0..255]:        26624..26879       256   0x8
       1: [256..511]:      26632..26887       256   0x9
    === after ===
    /mnt/btrfs/file1:
     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
       0: [0..255]:        26640..26895       256   0x8
       1: [256..511]:      26648..26903       256   0x9

This affects not only v5.16 (after the defrag rework), but also v5.15
(before the defrag rework).

[CAUSE]
From the very beginning, btrfs defrag never checks if one extent is
already at its max capacity (128K for compressed extents, 128M
otherwise).

And the default extent size threshold is 256K, which is already beyond
the compressed extent max size.

This means, by default btrfs defrag ioctl will mark all compressed
extent which is not adjacent to a hole/preallocated range for defrag.

[FIX]
Introduce a helper to grab the maximum extent size, and then in
defrag_collect_targets() and defrag_check_next_extent(), reject extents
which are already at their max capacity.

Reported-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 137d3732af33..a03c31e1ff18 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1049,6 +1049,13 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	return em;
 }
 
+static u32 get_extent_max_capacity(struct extent_map *em)
+{
+	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
+		return BTRFS_MAX_COMPRESSED;
+	return BTRFS_MAX_EXTENT_SIZE;
+}
+
 static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 				     bool locked)
 {
@@ -1065,6 +1072,12 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 		goto out;
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 		goto out;
+	/*
+	 * If the next extent is at its max capcity, defragging current extent
+	 * makes no sense, as the total number of extents won't change.
+	 */
+	if (next->len >= get_extent_max_capacity(em))
+		goto out;
 	/* Physically adjacent and large enough */
 	if ((em->block_start + em->block_len == next->block_start) &&
 	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
@@ -1229,6 +1242,13 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (em->len >= extent_thresh)
 			goto next;
 
+		/*
+		 * Skip extents already at its max capacity, this is mostly for
+		 * compressed extents, which max cap is only 128K.
+		 */
+		if (em->len >= get_extent_max_capacity(em))
+			goto next;
+
 		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
 							  locked);
 		if (!next_mergeable) {
-- 
2.34.1

