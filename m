Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAE5552AF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbiFUG0f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 02:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiFUG0f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 02:26:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25C1192B8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 23:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YDg/jbU+1R38H55fEeoQwVMsUd2ARR4Y26wxWipKEmA=; b=FZ4SMoj0KNkqlRGUK/hjGCOMa/
        b4Z7I+Og2APMFEZS7MVo3iyPz+3T5i/8wjWzGFhKmdU+vzuhogSKlBLr7FBMnbk04krnF0VQed86t
        qvbtGoO1jQ4J8c4+HEFrZDd+5tzaTFgYs12oid0p2wawRVO5yBa4ulkyCCDyegGGnXTXPtZ4r6JIF
        9gF6WJs69QQ3Lau/YHvHsKucA+FA3l1HT3gwzLOpJZrWtUgSbmqQ0kGRnmA69jr63vRVstQIlLpa5
        xrSsGS47bWoYYU9E7ynlQIZD1etBPC1kxJRfFXtpw1wmj9+axVQxf7mMaH+0+19ehdBraxtRp8lZe
        rfimXl3g==;
Received: from [2001:4bb8:189:7251:337b:5150:462e:1c35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3XLK-003rXN-6N; Tue, 21 Jun 2022 06:26:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: don't limit direct reads to a single sector
Date:   Tue, 21 Jun 2022 08:26:27 +0200
Message-Id: <20220621062627.2637632-1-hch@lst.de>
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
own performance problem for small I/O, but that will be addressed later).

There is no fundamental limit in btrfs itself to limit the I/O size
except for the size of the checksum array that scales linearly with
the number of sectors in an I/O.  Pick a somewhat arbitrary limit of
256 limits, which matches what the buffered reads typically see as
the upper limit as the limit for direct I/O as well.

This significantly improves direct read performance.  For example a fio
run doing 1 MiB aio reads with a queue depth of 1 roughly triples the
throughput:

Baseline:

READ: bw=65.3MiB/s (68.5MB/s), 65.3MiB/s-65.3MiB/s (68.5MB/s-68.5MB/s), io=19.1GiB (20.6GB), run=300013-300013msec

With this patch:

READ: bw=196MiB/s (206MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s), io=57.5GiB (61.7GB), run=300006-300006msc

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
  - keep a (large) upper limit on the I/O size.

 fs/btrfs/inode.c   | 6 +++++-
 fs/btrfs/volumes.h | 7 +++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 33ba4d22e1430..f6dc6e8c54e3a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7592,8 +7592,12 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	const u64 data_alloc_len = length;
 	bool unlock_extents = false;
 
+	/*
+	 * Cap the size of reads to that usually seen in buffered I/O as we need
+	 * to allocate a contiguous array for the checksums.
+	 */
 	if (!write)
-		len = min_t(u64, len, fs_info->sectorsize);
+		len = min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_SECTORS);
 
 	lockstart = start;
 	lockend = start + len - 1;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b61508723d5d2..5f2cea9a44860 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -354,6 +354,13 @@ struct btrfs_fs_devices {
 				- 2 * sizeof(struct btrfs_chunk))	\
 				/ sizeof(struct btrfs_stripe) + 1)
 
+/*
+ * Maximum number of sectors for a single bio to limit the size of the
+ * checksum array.  This matches the number of bio_vecs per bio and thus the
+ * I/O size for buffered I/O.
+ */
+#define BTRFS_MAX_SECTORS	256
+
 /*
  * Additional info to pass along bio.
  *
-- 
2.30.2

