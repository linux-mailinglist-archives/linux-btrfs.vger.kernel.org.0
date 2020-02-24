Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0555816A687
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgBXM4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 07:56:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:48708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXM4b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 07:56:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB87BAD79;
        Mon, 24 Feb 2020 12:56:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Fix uninitialized ret in btrfsic_process_superblock_dev_mirror
Date:   Mon, 24 Feb 2020 14:56:28 +0200
Message-Id: <20200224125628.27121-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We could return ret uninitlaized in case of success. Before the code was
returning 0 explicitly in case of success but now it will be a random value from
the stack. That's due to ret being set only in error conditions.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/check-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 23dd65e1c5e3..85b27e9742c8 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -766,7 +766,7 @@ static int btrfsic_process_superblock_dev_mirror(
 	struct block_device *const superblock_bdev = device->bdev;
 	struct page *page;
 	struct address_space *mapping = superblock_bdev->bd_inode->i_mapping;
-	int ret;
+	int ret = 0;

 	/* super block bytenr is always the unmapped device bytenr */
 	dev_bytenr = btrfs_sb_offset(superblock_mirror_num);
--
2.17.1

