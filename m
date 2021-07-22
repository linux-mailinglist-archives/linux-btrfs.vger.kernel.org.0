Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A200A3D1F66
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 09:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGVHPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 03:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhGVHPW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 03:15:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB1AC061575;
        Thu, 22 Jul 2021 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iItEmE7p+vg87/aZAxmFjmCUgcaSsiegChORg9UMdI8=; b=I6YWkxh2KKyhfhb9Zi/5AR3CPN
        ASEEqgrVklAX6d4GnWsTy3hIclmGy2cCrSZPyBj64T8OfpGfW8a1sBurSvk+WrcmujlyZK9TT1KWZ
        Bc/3Xu2vu/fc/jx21Va4YRzcbql4ICtRehNZtyDyL4/c3gy1IJOOi2zTUoXA6oH0owvtciXOSHST0
        w/j/sZ1K+XW1v5tbqKRsXeApOFL8tFr44QpYWtmmjD9MpjM519Kxe9wq42Xs/YLKsXKeMLs8xgEE0
        ZCufvnVIBjq9NGKxJfWV4QtjNyZXjMiHWxa9G4vEjiY5P1ERiSODKFS1ugysR9tyY4g8YR3MmKsS4
        HRDL1b0A==;
Received: from [2001:4bb8:193:7660:643c:9899:473:314a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6TXb-00A1Ft-6U; Thu, 22 Jul 2021 07:54:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/9] block: assert the locking state in delete_partition
Date:   Thu, 22 Jul 2021 09:53:55 +0200
Message-Id: <20210722075402.983367-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722075402.983367-1-hch@lst.de>
References: <20210722075402.983367-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a lockdep assert instead of the outdated locking comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/partitions/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 4230d4f71879..9902b1635b7d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -281,12 +281,10 @@ struct device_type part_type = {
 	.uevent		= part_uevent,
 };
 
-/*
- * Must be called either with open_mutex held, before a disk can be opened or
- * after all disk users are gone.
- */
 static void delete_partition(struct block_device *part)
 {
+	lockdep_assert_held(&part->bd_disk->open_mutex);
+
 	fsync_bdev(part);
 	__invalidate_device(part, true);
 
-- 
2.30.2

