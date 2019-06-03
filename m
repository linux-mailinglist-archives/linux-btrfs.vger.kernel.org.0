Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B87A332E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfFCO7F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 10:59:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:60904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729349AbfFCO7D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 10:59:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 858D4AE16;
        Mon,  3 Jun 2019 14:59:02 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 03/13] btrfs: use btrfs_crc32c{,_final}() in for free space cache
Date:   Mon,  3 Jun 2019 16:58:49 +0200
Message-Id: <20190603145859.7176-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190603145859.7176-1-jthumshirn@suse.de>
References: <20190603145859.7176-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The CRC checksum in the free space cache is not dependant on the super
block's csum_type field but always a CRC32C.

So use btrfs_crc32c() and btrfs_crc32c_final() instead of btrfs_csum_data()
and btrfs_csum_final() for computing these checksums.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/free-space-cache.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f74dc259307b..26ed8ed60722 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -465,9 +465,8 @@ static void io_ctl_set_crc(struct btrfs_io_ctl *io_ctl, int index)
 	if (index == 0)
 		offset = sizeof(u32) * io_ctl->num_pages;
 
-	crc = btrfs_csum_data(io_ctl->orig + offset, crc,
-			      PAGE_SIZE - offset);
-	btrfs_csum_final(crc, (u8 *)&crc);
+	crc = btrfs_crc32c(crc, io_ctl->orig + offset, PAGE_SIZE - offset);
+	btrfs_crc32c_final(crc, (u8 *)&crc);
 	io_ctl_unmap_page(io_ctl);
 	tmp = page_address(io_ctl->pages[0]);
 	tmp += index;
@@ -493,9 +492,8 @@ static int io_ctl_check_crc(struct btrfs_io_ctl *io_ctl, int index)
 	val = *tmp;
 
 	io_ctl_map_page(io_ctl, 0);
-	crc = btrfs_csum_data(io_ctl->orig + offset, crc,
-			      PAGE_SIZE - offset);
-	btrfs_csum_final(crc, (u8 *)&crc);
+	crc = btrfs_crc32c(crc, io_ctl->orig + offset, PAGE_SIZE - offset);
+	btrfs_crc32c_final(crc, (u8 *)&crc);
 	if (val != crc) {
 		btrfs_err_rl(io_ctl->fs_info,
 			"csum mismatch on free space cache");
-- 
2.16.4

