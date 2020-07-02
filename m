Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13021238D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgGBMlw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 08:41:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:50202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbgGBMlw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 08:41:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 204A610271;
        Thu,  2 Jul 2020 12:41:51 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/8] btrfs: Increment device corruption error in case of checksum error
Date:   Thu,  2 Jul 2020 15:23:32 +0300
Message-Id: <20200702122335.9117-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702122335.9117-1-nborisov@suse.com>
References: <20200702122335.9117-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that btrfs_io_bio have access to btrfs_device we can safely
increment the device corruption counter on error. There is one notable
exception - repair bios for raid. Since those don't go through the
normal submit_stripe_bio callpath but through raid56_parity_recover thus
repair bios won't have their device set.

Link: https://lore.kernel.org/linux-btrfs/4857863.FCrPRfMyHP@liv/
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e7600b0fd9b5..c6824d0ce59d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2822,6 +2822,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 zeroit:
 	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
 				    io_bio->mirror_num);
+	if (io_bio->dev)
+		btrfs_dev_stat_inc_and_print(io_bio->dev,
+					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
 	memset(kaddr + pgoff, 1, len);
 	flush_dcache_page(page);
 	kunmap_atomic(kaddr);
--
2.17.1

