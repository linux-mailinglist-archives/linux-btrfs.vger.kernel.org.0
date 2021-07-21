Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F023D1288
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbhGUOz5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbhGUOz4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:55:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E13C0613C1;
        Wed, 21 Jul 2021 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VTPi1llWkhazjxtTAh8MC9pXMlokhMWd9PIJFYGaZ0c=; b=GHhxVNx+EMv/uR8uUiEKw2tfeu
        uhiZgS5J/xGji9jZGRFMoikU3TWRcuOhZSp0LM7fFIukzStST8cTNaVIwiI8JLa3+BnN5G3wmQFiq
        dlJu3xFNm8Zqh0lxFMUHCqMZFXSqRMj5Cn3wptFXD3pGxp4BdbfWrjPHSTCJTntov+o5HCUQbM6dg
        F5gD0rqDmnSo0zvTNicL66quz+BRtoiRqXkaVs7spbvhsxaeFuUPgU44SXPBWyEJF2N6DLswG8Tsa
        WZ863oZ0rHSqF7hYGtAOdG6QvmFO1jQ/NXANG778mu+Z5Vb70rcIJZVJmBEyCCL9KtvlNk+/anQoY
        FKAQNoxA==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EGN-009L9o-HA; Wed, 21 Jul 2021 15:36:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] block: assert the locking state in delete_partition
Date:   Wed, 21 Jul 2021 17:35:17 +0200
Message-Id: <20210721153523.103818-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721153523.103818-1-hch@lst.de>
References: <20210721153523.103818-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a lockdep assert instead of the outdated locking comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

