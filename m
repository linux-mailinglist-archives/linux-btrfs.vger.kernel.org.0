Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119353E89DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 07:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhHKFpe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 01:45:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33888 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbhHKFpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 01:45:33 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A55352200D
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 05:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628660709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XLK7v1D1tAK47kGiNJn5MJMU0v4ggYF5s2QtUJjS8jo=;
        b=pvkaMyYnSlgZdnW05IlInEq0eKnV2NeB4JHoy1IvdnA9/ECcCmh8A0c8AQIWIe9qnoN5tC
        J7i6LphXcUgwIz8+U0xK/R+4j89Rm/IVkFSi53/7omOQ+t+78sOJRDnuRU5c/3MAnidkhg
        O69sUjInPkl0lgDFiBIthEwfDAfStGg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C71DE137DA
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 05:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ifspIORjE2FWTAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 05:45:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH] btrfs: prevent falloc to mix inline and regular extents
Date:   Wed, 11 Aug 2021 13:45:05 +0800
Message-Id: <20210811054505.186828-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
The following script can create a fs with mixed inline and regular
extents:

 mkfs.btrfs -f -s 4k $dev
 mount $dev $mnt -o nospace_cache

 xfs_io -f -c "pwrite 0 1k" -c "sync" \
	-c "falloc 0 4k" -c "pwrite 4k 4k" $mnt/file
 umount $mnt

It will result the following file extents layout:

        item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
                index 2 namelen 4 name: file
        item 6 key (257 EXTENT_DATA 0) itemoff 14824 itemsize 1045
                generation 8 type 0 (inline)
                inline extent data size 1024 ram_bytes 1024 compression 0 (none)
        item 7 key (257 EXTENT_DATA 4096) itemoff 14771 itemsize 53
                generation 8 type 1 (regular)
                extent data disk byte 13631488 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)

Which mixes inline and regular extents.

Without above falloc operation, we would get proper regular extent only
layout.

[CAUSE]
Normally we rely on btrfs_truncate_block() to convert the inline extent
to regular extent.

For example, if without falloc(), at the 2nd pwrite, we will call
btrfs_truncate_block() to zero the tailing part of the inline extent,
then at writeback time, we find the isize is larger than inline
threshold and will not create inline extent, but write back the first
sector as regular extent.

While in falloc, although we also call btrfs_truncate_block(), it's
called before we enlarge the inode size.

And we start writeback of the range immediately, with inode size
unchanged.

This means, we just re-create an inline extent inside btrfs_fallocate().

[FIX]
Only call btrfs_truncate_block() after we have updated inode size inside
btrfs_fallocate().

By this later writeback will properly writeback the first sector as
regular extent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

There is a long existing discussion on whether we should allow mixing
inline and regular extents.

I totally understand the idea that mixing such extents won't cause
anything wrong, the existing kernel can handle them pretty well, and no
data corruption or whatever.

But since it's really not that simple to create such mixed extents
(except the method mentioned above), I really don't believe that's the
expected behavior.

Thus even it's not a big deal, I still want to prevent such mixed
extents.
---
 fs/btrfs/file.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7ff577005d0f..a09cf02537b4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3325,6 +3325,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	struct falloc_range *range;
 	struct falloc_range *tmp;
 	struct list_head reserve_list;
+	u64 old_isize;
 	u64 cur_offset;
 	u64 last_byte;
 	u64 alloc_start;
@@ -3365,6 +3366,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	}
 
 	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
+	old_isize = i_size_read(inode);
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size) {
 		ret = inode_newsize_ok(inode, offset + len);
@@ -3373,7 +3375,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	}
 
 	/*
-	 * TODO: Move these two operations after we have checked
+	 * TODO: Move this operation after we have checked
 	 * accurate reserved space, or fallocate can still fail but
 	 * with page truncated or size expanded.
 	 *
@@ -3384,15 +3386,6 @@ static long btrfs_fallocate(struct file *file, int mode,
 					alloc_start);
 		if (ret)
 			goto out;
-	} else if (offset + len > inode->i_size) {
-		/*
-		 * If we are fallocating from the end of the file onward we
-		 * need to zero out the end of the block if i_size lands in the
-		 * middle of a block.
-		 */
-		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, 0, 0);
-		if (ret)
-			goto out;
 	}
 
 	/*
@@ -3515,6 +3508,18 @@ static long btrfs_fallocate(struct file *file, int mode,
 out_unlock:
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
 			     &cached_state);
+
+	/*
+	 * If we are fallocating from the end of the file onward we
+	 * need to zero out the end of the block if i_size lands in the
+	 * middle of a block.
+	 *
+	 * This needs to be done after isize update, or the truncated sector
+	 * will still be written back as inline extent, resulting mixing
+	 * inline and regular extents.
+	 */
+	if (!ret && offset + len > old_isize)
+		ret = btrfs_truncate_block(BTRFS_I(inode), old_isize, 0, 0);
 out:
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	/* Let go of our reservation. */
-- 
2.32.0

