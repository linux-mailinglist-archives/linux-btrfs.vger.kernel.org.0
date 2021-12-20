Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A5A47A55A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Dec 2021 08:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhLTHXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 02:23:10 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43773 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234251AbhLTHXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 02:23:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.7HlBi_1639984987;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V.7HlBi_1639984987)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Dec 2021 15:23:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dsterba@suse.cz
Cc:     clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] btrfs: Fix argument list that the kdoc format and script verified.
Date:   Mon, 20 Dec 2021 15:23:06 +0800
Message-Id: <20211220072306.42133-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The warnings were found by running scripts/kernel-doc, which is
caused by using 'make W=1'.

fs/btrfs/extent_io.c:3210: warning: Function parameter or member
'bio_ctrl' not described in 'btrfs_bio_add_page'
fs/btrfs/extent_io.c:3210: warning: Excess function parameter 'bio'
description in 'btrfs_bio_add_page'
fs/btrfs/extent_io.c:3210: warning: Excess function parameter
'prev_bio_flags' description in 'btrfs_bio_add_page'
fs/btrfs/space-info.c:1602: warning: Excess function parameter 'root'
description in 'btrfs_reserve_metadata_bytes'
fs/btrfs/space-info.c:1602: warning: Function parameter or member
'fs_info' not described in 'btrfs_reserve_metadata_bytes'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/btrfs/extent_io.c  | 5 ++---
 fs/btrfs/space-info.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9234d96a7fd5..a6b4a78848dd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3187,13 +3187,12 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 /**
  * Attempt to add a page to bio
  *
- * @bio:	destination bio
+ * @bio_ctrl:	record both the bio, and its bio_flags
  * @page:	page to add to the bio
  * @disk_bytenr:  offset of the new bio or to check whether we are adding
  *                a contiguous page to the previous one
- * @pg_offset:	starting offset in the page
  * @size:	portion of page that we want to write
- * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
+ * @pg_offset:	starting offset in the page
  * @bio_flags:	flags of the current bio to see if we can merge them
  *
  * Attempt to add a page to bio considering stripe alignment etc.
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index dbf8bfb8fcb3..618b59ff44ae 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1583,7 +1583,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 /**
  * Trye to reserve metadata bytes from the block_rsv's space
  *
- * @root:       the root we're allocating for
+ * @fs_info:    the filesystem
  * @block_rsv:  block_rsv we're allocating for
  * @orig_bytes: number of bytes we want
  * @flush:      whether or not we can flush to make our reservation
-- 
2.20.1.7.g153144c

