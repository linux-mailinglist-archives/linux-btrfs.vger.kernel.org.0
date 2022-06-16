Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0954DC6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 10:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359504AbiFPICl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 04:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359605AbiFPICk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 04:02:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A3C41
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 01:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZRuiY0byxDjpii4unjKXnpW9QcV+lNUcXct75jX23rk=; b=tkWF5/HFSRJ1YwSMUPiY06UqZe
        UMVgqaeOqWyEDgGTaye28myjpgY7Q1HKjv1qlOgkIiB/vhSBC+Y1WCBoX91UmwI71YPJsnN68zXP3
        u0HcBHScwXWKISvyX0uL2t2ffAKVJ1AA4xXsVGZhH3nV/tj+VtpnDu/F1u4p8d/6SjmO8sFR1jg2I
        66yEfgFU3ZxrqKg+CmklSiLMU3QWVgS1E912rZ6xi8GaQ/kBlvjhpcVskJ9vYs3o1njeCnu/cw9aE
        Ufz1of8pq9mTg7y5CdL3KHqsbRiuVKp53cxNZ6ZE8ujmZM1zpHyKJ4AFINLKZEiDtzMbOtf1N/IGi
        TuryAi1w==;
Received: from [2001:4bb8:180:36f6:3f0b:1d4d:7e68:da99] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1kSR-001G6K-NG; Thu, 16 Jun 2022 08:02:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't limit direct reads to a single sector
Date:   Thu, 16 Jun 2022 10:02:24 +0200
Message-Id: <20220616080224.953968-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs currently limits direct I/O reads to a single sector, which goes
back to commit c329861da406 ("Btrfs: don't allocate a separate csums
array for direct reads") from Josef.  That commit changes the direct I/O
code to ".. use the private part of the io_tree for our csums.", but ten
years later that isn't how checksums for direct reads work, instead they
use a csums allocation on a per-btrfs_dio_private basis (which have their
own performane problem for small I/O, but that will be addressed later).

Lift this limit to improve performance for large direct reads.  For
example a fio run doing 1 MiB aio reads with a queue depth of 1 roughly
tripples the throughput:

Baseline:

READ: bw=65.3MiB/s (68.5MB/s), 65.3MiB/s-65.3MiB/s (68.5MB/s-68.5MB/s), io=19.1GiB (20.6GB), run=300013-300013msec

With this patch:

READ: bw=196MiB/s (206MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s), io=57.5GiB (61.7GB), run=300006-300006msc

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6f665bf59f620..deb79e80e4e95 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7585,19 +7585,14 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_dio_data *dio_data = iter->private;
-	u64 lockstart, lockend;
+	u64 lockstart = start;
+	u64 lockend = start + length - 1;
 	const bool write = !!(flags & IOMAP_WRITE);
 	int ret = 0;
 	u64 len = length;
 	const u64 data_alloc_len = length;
 	bool unlock_extents = false;
 
-	if (!write)
-		len = min_t(u64, len, fs_info->sectorsize);
-
-	lockstart = start;
-	lockend = start + len - 1;
-
 	/*
 	 * iomap_dio_rw() only does filemap_write_and_wait_range(), which isn't
 	 * enough if we've written compressed pages to this area, so we need to
-- 
2.30.2

