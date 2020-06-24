Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F386E2072A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 13:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403837AbgFXLzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 07:55:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:46032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403802AbgFXLzn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 07:55:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B536AED7;
        Wed, 24 Jun 2020 11:55:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jiachen YANG <farseerfc@gmail.com>
Subject: [PATCH 1/2] btrfs-progs: convert: Ensure the data chunks size never exceed device size
Date:   Wed, 24 Jun 2020 19:55:26 +0800
Message-Id: <20200624115527.855816-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following script could lead to corrupted btrfs fs after
btrfs-convert:

  fallocate -l 1G test.img
  mkfs.ext4 test.img
  mount test.img $mnt
  fallocate -l 200m $mnt/file1
  fallocate -l 200m $mnt/file2
  fallocate -l 200m $mnt/file3
  fallocate -l 200m $mnt/file4
  fallocate -l 205m $mnt/file1
  fallocate -l 205m $mnt/file2
  fallocate -l 205m $mnt/file3
  fallocate -l 205m $mnt/file4
  umount $mnt
  btrfs-convert test.img

The result btrfs will have a device extent beyond its boundary:
  pening filesystem to check...
  Checking filesystem on test.img
  UUID: bbcd7399-fd5b-41a7-81ae-d48bc6935e43
  [1/7] checking root items
  [2/7] checking extents
  ERROR: dev extent devid 1 physical offset 993198080 len 85786624 is beyond device boundary 1073741824
  ERROR: errors found in extent allocation tree or chunk allocation
  [3/7] checking free space cache
  [4/7] checking fs roots
  [5/7] checking only csums items (without verifying data)
  [6/7] checking root refs
  [7/7] checking quota groups skipped (not enabled on this FS)
  found 913960960 bytes used, error(s) found
  total csum bytes: 891500
  total tree bytes: 1064960
  total fs tree bytes: 49152
  total extent tree bytes: 16384
  btree space waste bytes: 144885
  file data blocks allocated: 2129063936
   referenced 1772728320

[CAUSE]
Btrfs-convert first collect all used blocks in the original fs, then
slightly enlarge the used blocks range as new btrfs data chunks.

However the enlarge part has a problem, that it doesn't take the device
boundary into consideration.

Thus it caused device extents and data chunks to go beyond device
boundary.

[FIX]
Just to extra check before inserting data chunks into
btrfs_convert_context::data_chunk.

Reported-by: Jiachen YANG <farseerfc@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/convert/main.c b/convert/main.c
index c86ddd988c63..7709e9a6c085 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -669,6 +669,8 @@ static int calculate_available_space(struct btrfs_convert_context *cctx)
 			cur_off = cache->start;
 		cur_len = max(cache->start + cache->size - cur_off,
 			      min_stripe_size);
+		/* data chunks should never exceed device boundary */
+		cur_len = min(cctx->total_bytes - cur_off, cur_len);
 		ret = add_merge_cache_extent(data_chunks, cur_off, cur_len);
 		if (ret < 0)
 			goto out;
-- 
2.27.0

