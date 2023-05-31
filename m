Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3442717924
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjEaH4V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjEaH4D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:56:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D361BEC
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tNETbLbeNtMp4Lsy/PFA4QIa3K5DCPWdxTHaJP4ZWKY=; b=TPDxSHiSluRUtSgo7kDuKzbqAY
        usKqBU3kVDQRlX09L8GXwxfBVy4gaWIiG2hVSygldjLhmEjQxgLBty+tgPHroJELApiJzcf7Uz3ae
        LI8oiJhrytUhGp8oLBbgKggb16Usx9afqPFKsPlBevb4GLNu0bk7fhbRwl43YC+ga7sI+TwHRx9NK
        /0nSvXK2NpdNFFmUCUvIf/VTzox/hSrabyzz/uOddAWoaHlF+tfFI9sVc3ApcLdDCRP0dy6zvp0Mz
        PKS3LpuqTssC6O2iLpTnebGA1r8fwofFki6VXg1fBClvVci8qoOReey5jxE05W+1uZQA8MmCY4zCg
        vhc2Zv6w==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4GfF-00GWth-2j;
        Wed, 31 May 2023 07:54:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 08/17] btrfs: open code btrfs_bio_end_io in btrfs_dio_submit_io
Date:   Wed, 31 May 2023 09:54:01 +0200
Message-Id: <20230531075410.480499-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_dio_submit_io is the only place that uses btrfs_bio_end_io to end a
bio that hasn't been submitted using btrfs_submit_bio yet, and this
invariant will become a problem with upcoming changes to the btrfs bio
layer.  Just open code the assignment of bi_status and the call to
btrfs_dio_end_io.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e3f74c90280767..ba8a61fa3d81fc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7827,7 +7827,8 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 
 		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
 		if (ret) {
-			btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
+			bbio->bio.bi_status = errno_to_blk_status(ret);
+			btrfs_dio_end_io(bbio);
 			return;
 		}
 	}
-- 
2.39.2

