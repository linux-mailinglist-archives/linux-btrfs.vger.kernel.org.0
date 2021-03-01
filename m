Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8A3279B1
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 09:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhCAIpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 03:45:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:43618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233420AbhCAIpg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 03:45:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614588288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NyXfuLSNkKHCqJkVaQiixSPcqD7Iu3GyJU9jigZIBd4=;
        b=BFQ391k72h+8d0ILjm/i7p7SMyIaQ3dKUF+1N2Ch7KrplJVX0p9mAe6IGD/Zgx0Y2kxW3c
        kRShHg8tPqc70b3uf9GqpVRWcO8SskVkcD9a2OHCgs00pNnbcM0VZxyBziXvh59FcS51Yg
        5kLsb8nFV3Wh+Vk4sY86Trs+uvo0wXY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93CD0AF84;
        Mon,  1 Mar 2021 08:44:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: fix the false data csum mismatch error caused
Date:   Mon,  1 Mar 2021 16:44:22 +0800
Message-Id: <20210301084422.103716-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running fstresss, we can hit strange data csum mismatch where the
on-disk data is in fact correct (passes both scrub and btrfs check
--check-data-csum).

With some extra debug info added, we have the following traces:

510482us : btrfs_do_readpage: root=5 ino=284 offset=393216, submit force=0 pgoff=0 iosize=8192
510494us : btrfs_do_readpage: root=5 ino=284 offset=401408, submit force=0 pgoff=8192 iosize=4096
510498us : btrfs_submit_data_bio: root=5 ino=284 bio first bvec=393216 len=8192
510591us : btrfs_do_readpage: root=5 ino=284 offset=405504, submit force=0 pgoff=12288 iosize=36864
510594us : btrfs_submit_data_bio: root=5 ino=284 bio first bvec=401408 len=4096
510863us : btrfs_submit_data_bio: root=5 ino=284 bio first bvec=405504 len=36864
510933us : btrfs_verify_data_csum: root=5 ino=284 offset=393216 len=8192
510967us : btrfs_do_readpage: root=5 ino=284 offset=442368, skip beyond isize pgoff=49152 iosize=16384
511047us : btrfs_verify_data_csum: root=5 ino=284 offset=401408 len=4096
511163us : btrfs_verify_data_csum: root=5 ino=284 offset=405504 len=36864
511290us : check_data_csum: !!! root=5 ino=284 offset=438272 pg_off=45056 !!!
517387us : end_bio_extent_readpage: root=5 ino=284 before pending_read_bios=0

[CAUSE]
Normally we expect all submitted bio read to only touch the range we
specified, and under subpage context, it means we should only touch the
range spcified in each bvec.

But in data read path, inside end_bio_extent_readpage(), we have page
zeroing which only takes regular page size into consideration.

This means for subpage if we have an inode whose content looks like below:

  0       16K     32K     48K     64K
  |///////|       |///////|       |

  |//| = data needs to be read from disk
  |  | = hole

And i_size is 64K initially.

Then the following race can happen:

		T1		|		T2
--------------------------------+--------------------------------
btrfs_do_readpage()		|
|- isize = 64K;			|
|  At this time, the isize is 	|
|  64K				|
|				|
|- submit_extent_page()		|
|  submit previous assembled bio|
|  assemble bio for [0, 16K)	|
|				|
|- submit_extent_page()		|
   submit read bio for [0, 16K) |
   assemble read bio for	|
   [32K, 48K)			|
 				|
				| btrfs_setsize()
				| |- i_size_write(, 16K);
				|    Now i_size is only 16K
end_io() for [0K, 16K)		|
|- end_bio_extent_readpage()	|
   |- btrfs_verify_data_csum()  |
   |  No csum error		|
   |- i_size = 16K;		|
   |- zero_user_segment(16K,	|
      PAGE_SIZE);		|
      !!! We zeroed range	|
      !!! [32K, 48K)		|
				| end_io for [32K, 48K)
				| |- end_bio_extent_readpage()
				|    |- btrfs_verify_data_csum()
				|       ! CSUM MISMATCH !
				|       ! As the range is zeroed now !

[FIX]
To fix the problem, make end_bio_extent_readpage() to only zero the
range of bvec.

Thankfully the bug only affects subpage read-write support, as for full
read-only mount we can't change i_size thus won't hit the race
condition.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 424fc9ae99bc..8479ea84b6d9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3041,12 +3041,23 @@ static void end_bio_extent_readpage(struct bio *bio)
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
 			pgoff_t end_index = i_size >> PAGE_SHIFT;
-			unsigned off;
 
-			/* Zero out the end if this page straddles i_size */
-			off = offset_in_page(i_size);
-			if (page->index == end_index && off)
-				zero_user_segment(page, off, PAGE_SIZE);
+			/*
+			 * Zero out the remaining part if this range straddles
+			 * i_size.
+			 *
+			 * Here we should only zero the range inside the
+			 * bvec, not touch anything else.
+			 *
+			 * NOTE: i_size is exclusive while end is inclusive.
+			 */
+			if (page->index == end_index && i_size <= end) {
+				u32 zero_start = max(offset_in_page(i_size),
+						     offset_in_page(end));
+
+				zero_user_segment(page, zero_start,
+						  offset_in_page(end) + 1);
+			}
 		}
 		ASSERT(bio_offset + len > bio_offset);
 		bio_offset += len;
-- 
2.30.1

