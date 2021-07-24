Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A793D4589
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 09:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhGXGdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 02:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGXGdg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 02:33:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95CFC061575;
        Sat, 24 Jul 2021 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IzbPl3rhQlkNu4LwWkqjxNIKlOD/VrKugpLHg7bjM8A=; b=eoEMdpdTs3bWusstwvIzLeI/Rd
        E2qoQwNPvcZ3QYNvQ7o/GaYGetkCjvFYv+Ux6V7MDmINK/zK6r//BJmtGhGWDwka2Ji6/vXl7QA0D
        MQvbP7frLdq4G3kNP/3K8ZpGBWdnvH/ZWgR+JGD/n3LAVv7P6VSyS3eL7k65gMNS3oyzq2sCbquZh
        KJDCpEKr5SFDr4qqMhaW3WXcZ2xrg8qPGUNt7mJGmxUgSjGHO8szI/keunn5dZ4/LlrCqTxc26V7l
        PBwYbpRpSSuCgnFj0VkNx6NVwWwyos2/5F/We2tnCrQVs0lmWML8Anf3UrCzXLv86jzgADlG87cpO
        iBaRCSfQ==;
Received: from [2001:4bb8:184:87c5:85d0:a26b:ef67:d32c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7Bqe-00C4X1-U1; Sat, 24 Jul 2021 07:13:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 02/10] block: assert the locking state in delete_partition
Date:   Sat, 24 Jul 2021 09:12:41 +0200
Message-Id: <20210724071249.1284585-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724071249.1284585-1-hch@lst.de>
References: <20210724071249.1284585-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a lockdep assert instead of the outdated locking comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
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

