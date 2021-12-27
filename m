Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C7847FA74
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Dec 2021 07:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhL0GLe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Dec 2021 01:11:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhL0GLe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Dec 2021 01:11:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A57751F3A1;
        Mon, 27 Dec 2021 06:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640585492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ef3ekS8fALHJ+U1VwwDHRvRETSDnhXwRcKsUWeaIo9E=;
        b=D8RRgj9Tp5c8Knb3Y/1pGRpsF8YJZ9Krq3P48SiY2DGpsPzYhArei+wQbUcbms96PAI7Fz
        S5IM6RXOWGpqC8I4FOAlTPcPYjv0c+CCJ+IuleqsOg8QzvTUuzC1fIzvuxgUJT0/eB43it
        MAKOyv58tyJKM/6QBtqSumjI5lDm/HM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A565813491;
        Mon, 27 Dec 2021 06:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fVLKGRNZyWE4HgAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 27 Dec 2021 06:11:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fs/btrfs: fix a bug that U-boot fs btrfs implementation doesn't handle NO_HOLE feature correctly
Date:   Mon, 27 Dec 2021 14:11:14 +0800
Message-Id: <20211227061114.54326-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When passing a btrfs with NO_HOLE feature to U-boot, and if one file
contains holes, then the hash of the file is not correct in U-boot:

 # mkfs.btrfs -f test.img	# Since v5.15, mkfs defaults to NO_HOLES
 # mount test.img /mnt/btrfs
 # xfs_io -f -c "pwrite 0 4k" -c "pwrite 8k 4k" /mnt/btrfs/file
 # md5sum /mnt/btrfs/file
 277f3840b275c74d01e979ea9d75ac19  /mnt/btrfs/file
 # umount /mnt/btrfs
 # ./u-boot
 => host bind 0 /home/adam/test.img
 => ls host 0
 <   >      12288  Mon Dec 27 05:35:23 2021  file
 => load host 0 0x1000000 file
 12288 bytes read in 0 ms
 => md5sum 0x1000000 0x3000
 md5 for 01000000 ... 01002fff ==> 855ffdbe4d0ccc5acab92e1b5330e4c1

The md5sum doesn't match at all.

[CAUSE]
In U-boot btrfs implementation, the function btrfs_read_file() has the
following iteration for file extent iteration:

	/* Read the aligned part */
	while (cur < aligned_end) {
		ret = lookup_data_extent(root, &path, ino, cur, &next_offset);
		if (ret < 0)
			goto out;
		if (ret > 0) {
			/* No next, direct exit */
			if (!next_offset) {
				ret = 0;
				goto out;
			}
		}
		/* Read file extent */

But for NO_HOLES features, hole extents will not have any extent item
for it.
Thus if @cur is at a hole, lookup_data_extent() will just return >0, and
update @next_offset.

But we still believe there is some data to read for @cur for ret > 0
case, causing we read extent data from the next file extent.

This means, what we do for above NO_HOLES btrfs is:
- Read 4K data from disk to file offset [0, 4K)
  So far the data is still correct

- Read 4K data from disk to file offset [4K, 8K)
  We didn't skip the 4K hole, but read the data at file offset [8K, 12K)
  into file offset [4K, 8K).

  This causes the checksum mismatch.

[FIX]
Add extra check to skip to the next non-hole range after
lookup_data_extent().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This bug exposed another missing link, that we don't have good test
coverage in U-boot btrfs.

This is partially caused by the fact that, btrfs-progs code is not
designed to read file contents, but just to check the cross-reference
(aka, btrfs-check).

If we really only want read-only support in U-boot, and don't ever plan
to add write support, then I'd say the btrfs-fuse project
(https://github.com/adam900710/btrfs-fuse/) is more suitable for U-boot.

As that project already has full fs content verification selftest along
with extra multi-device recovery tests.
And shares the same code style between btrfs-progs/kernel.
---
 fs/btrfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2c2379303d74..d00b5153336d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -717,6 +717,14 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
 				ret = 0;
 				goto out;
 			}
+			/*
+			 * Find a extent gap, mostly caused by NO_HOLE feature.
+			 * Just to next offset directly.
+			 */
+			if (next_offset > cur) {
+				cur = next_offset;
+				continue;
+			}
 		}
 		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
 				    struct btrfs_file_extent_item);
-- 
2.34.1

