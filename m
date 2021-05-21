Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB9738C2CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 11:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhEUJMj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 05:12:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13757 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhEUJMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 05:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621588297; x=1653124297;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fdbOBg3aB6yhFRL4vghQRON4vmtB9yO3Pb/BCZgMS3o=;
  b=DcgKgXdmPjQvSfkt5pLoSyz0vJE9kfr5bo79C5xtdFwzhOJ4boL/UMKr
   WEv5dTcFeocgqlnDxNcyTkX+Yp1I4YUuI8RQ5eahpFGVHGLn0ZsLnYE+5
   hXBudrMz8g+Tvk3Q79t5QT5hy2YIqpmQ6ukjNOjzLvkyLtoGCQkxAHobv
   P3h6cgwWkYb1RkL8ljgEoPCq03ZPypzBKIIVOMphz6PuRVQY6xtwEEnvy
   tkZ15ZU+t25Ix4+FCRLrLeDCDUYlnlJ3Mo+2yYv4mN19HbXlcOFG/xhEL
   6EUQZ93lMIhT95T2/a5ezElJTIvCjB3uvtllUEqjtFZCUAL2mhBrQCoc5
   g==;
IronPort-SDR: fOnyhJKWCa2FfzHpcJJ5UySf/LVlUL2UQNwJ6bWujQ0amO6iszz6jiJF9CMA33hcztDQADbmO+
 LFxMoxy7vs6RiGRlYYFv5I5BYPy9gXm9ogxSv6c0MnaPTnxDyhzXmb88GV80l9/Cp8ch/hTB6a
 HQpG/wZgvA7Ac8frgVAsoeXJVu9ySjAto7UJpoc3FKCSEu5jbscprZdU6JyFoSVzmd4K/Akbbs
 kdNFLQrnrGH84kjiejyMSvGiyGKanZecmnvYECB6X4O1gcGsR37BBQ+jpfuE1VD3OxPRZfx0NF
 TaQ=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="272899606"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 17:11:36 +0800
IronPort-SDR: /gMg0uJvtduQSTzHJogxBiYM4/G3aWQ48Pn5n0hDxO0J/aCbjmLG9VAYx1KIV/g/S1iE8vIras
 pwJ1OXGptXdp7e4mkieNhqbwEp8vsEjpQEHFdDQfN1WbWruV0FkCRwt34tyqQ75rVZADwCY4/8
 FW/X49EHpq9GUkYuYxM9fm8xsvPozQSHjdZY0u28imBGVkwyo90Mb5UYIxTbEXqhh9uQHHunDZ
 OQs1uKT3LD+U628TBeY7VFwj8KCzJlRH1whr7KN+DlqCetpeG7+WduaSvnVa0UXbiJ8pemW03p
 myHa6WJ3BFrSv5WLwgPvWdE1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 01:50:51 -0700
IronPort-SDR: zJrcRn5jiXmQ0KGdZ+PxxhMPk0uyjyodNq4mtB0HuJqE2egVAsZY+MmP33XeRp1nUddJHAXwdY
 Dmwc2pBkWZBoa8AIP+p3AhQ7cCl1BxGhJ5nxErWRo6vhnMt+Mxjv/7LNxdnGqQ8FzspM7gUcxa
 qlCjje5OFGGPAZCuoUAEoU/fHtOCOUYXec4NHEtyd2PH3e6k2hK27Bq51ip9iKZG6h6qgCO018
 83D0xObmsLtdB2ciMvFKwDpk1UmOcwvQiRP8jDwTzJ9X1DIcG4m2AguV8odeuRp+RU0d7wMsB9
 v4g=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2021 02:11:15 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Date:   Fri, 21 May 2021 18:11:04 +0900
Message-Id: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Damien reported a test failure with btrfs/209. The test itself ran fine,
but the fsck run afterwards reported a corrupted filesystem.

The filesystem corruption happens because we're splitting an extent and
then writing the extent twice. We have to split the extent though, because
we're creating too large extents for a REQ_OP_ZONE_APPEND operation.

When dumping the extent tree, we can see two EXTENT_ITEMs at the same
start address but different lengths.

$ btrfs inspect dump-tree /dev/nullb1 -t extent
...
   item 19 key (269484032 EXTENT_ITEM 126976) itemoff 15470 itemsize 53
           refs 1 gen 7 flags DATA
           extent data backref root FS_TREE objectid 257 offset 786432 count 1
   item 20 key (269484032 EXTENT_ITEM 262144) itemoff 15417 itemsize 53
           refs 1 gen 7 flags DATA
           extent data backref root FS_TREE objectid 257 offset 786432 count 1

On a zoned filesystem, limit the size of an ordered extent to the maximum
size that can be issued as a single REQ_OP_ZONE_APPEND operation.

Note: This patch breaks fstests btrfs/079, as it increases the number of
on-disk extents from 80 to 83 per 10M write.

Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 78d3f2ec90e0..e823b2c74af5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1860,6 +1860,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				    u64 *end)
 {
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
 	u64 delalloc_start;
 	u64 delalloc_end;
@@ -1868,6 +1869,9 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	int ret;
 	int loops = 0;
 
+	if (fs_info && fs_info->max_zone_append_size)
+		max_bytes = ALIGN_DOWN(fs_info->max_zone_append_size,
+				       PAGE_SIZE);
 again:
 	/* step one, find a bunch of delalloc bytes starting at start */
 	delalloc_start = *start;
-- 
2.31.1

