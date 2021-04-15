Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5A360174
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhDOFG0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:06:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:38450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhDOFG0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:06:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOdMIOc1nu9KKfdO9dyyLnPsbew3s8n9wrT60krqNUU=;
        b=HX5maj2nF+J7+zftj8CHL8HSkNQRwSKv2syBqIpq0C2PE5qMIycBCl4jGAXw3u45L/8V7a
        dhY217G9EcOx1NJ8xh//tdmcRWGPMfMGE/i+d/RWCaOqgIWDXQmMAuuglpUwOI4ADC4WKu
        ELqxAmR62BsFoaSNLXFGmVPb9L2DCKs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C54BAF39
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:06:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 37/42] btrfs: disable inline extent creation for subpage
Date:   Thu, 15 Apr 2021 13:04:43 +0800
Message-Id: <20210415050448.267306-38-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running the following fsx command (extracted from generic/127) on
subpage btrfs, it can create inline extent with regular extents:

	fsx -q -l 262144 -o 65536 -S 191110531 -N 9057 -R -W $mnt/file > /tmp/fsx

The offending extent would look like:

        item 9 key (257 INODE_REF 256) itemoff 15703 itemsize 14
                index 2 namelen 4 name: file
        item 10 key (257 EXTENT_DATA 0) itemoff 14975 itemsize 728
                generation 7 type 0 (inline)
                inline extent data size 707 ram_bytes 707 compression 0 (none)
        item 11 key (257 EXTENT_DATA 4096) itemoff 14922 itemsize 53
                generation 7 type 2 (prealloc)
                prealloc data disk byte 102346752 nr 4096
                prealloc data offset 0 nr 4096

[CAUSE]
For subpage btrfs, the writeback is triggered in page unit, which means,
even if we just want to writeback range [16K, 20K) for 64K page system,
we will still try to writeback any dirty sector of range [0, 64K).

This is never a problem if sectorsize == PAGE_SIZE, but for subpage,
this can cause unexpected problems.

For above test case, the last several operations from fsx are:

 9055 trunc      from 0x40000 to 0x2c3
 9057 falloc     from 0x164c to 0x19d2 (0x386 bytes)

In operation 9055, we dirtied sector [0, 4096), then in falloc, we call
btrfs_wait_ordered_range(inode, start=4096, len=4096), only expecting to
writeback any dirty data in [4096, 8192), but nothing else.

Unfortunately, in subpage case, above btrfs_wait_ordered_range() will
trigger writeback of the range [0, 64K), which includes the data at [0,
4096).

And since at the call site, we haven't yet increased i_size, which is
still 707, this means cow_file_range() can insert an inline extent.

Resulting above inline + regular extent.

[WORKAROUND]
I don't really have any good short-term solution yet, as this means all
operations that would trigger writeback need to be reviewed for any
isize change.

So here I choose to disable inline extent creation for subpage case as a
workaround.
We have done tons of work just to avoid such extent, so I don't to
create an exception just for subpage.

This only affects inline extent creation, btrfs subpage support has no
problem reading existing inline extents at all.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e31a0521564e..5030bbf3a667 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -663,7 +663,11 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		}
 	}
 cont:
-	if (start == 0) {
+	/*
+	 * Check cow_file_range() for why we don't even try to create
+	 * inline extent for subpage case.
+	 */
+	if (start == 0 && fs_info->sectorsize == PAGE_SIZE) {
 		/* lets try to make an inline extent */
 		if (ret || total_in < actual_end) {
 			/* we didn't compress the entire range, try
@@ -1061,7 +1065,17 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
 
-	if (start == 0) {
+	/*
+	 * Due to the page size limit, for subpage we can only trigger the
+	 * writeback for the dirty sectors of page, that means data writeback
+	 * is doing more writeback than what we want.
+	 *
+	 * This is especially unexpected for some call sites like fallocate,
+	 * where we only increase isize after everything is done.
+	 * This means we can trigger inline extent even we didn't want.
+	 * So here we skip inline extent creation completely.
+	 */
+	if (start == 0 && fs_info->sectorsize == PAGE_SIZE) {
 		/* lets try to make an inline extent */
 		ret = cow_file_range_inline(inode, start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL);
-- 
2.31.1

