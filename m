Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEA04E66A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 17:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351411AbiCXQIM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbiCXQIK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 12:08:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B74B1D1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XvYWHFuzCsjx3KqA9MIhIzNPISiS7QTfJzatfCFpMHA=; b=1jwKgUZeu2WeM53zQ0uevMACQn
        lhwcDVRbMicUaRNcVA+BG2U7xEgFJmPt627YQ8Nx0CeRxaV/p5vjLfC/C2PDron/LAlx3qpbD3Sxn
        IgDdFdzmB03r2n7huH5rFZOHYZjkalkJfm3bH0dw4LUeEBT421vROAlK7HeN2Xcdd83IgZZhwk9Pt
        XH/cr3QFibu6w5GTbXyJNuZVPA89GV/3amUkbIXSh1ZEfsZ2bhiJ0EdmTFBYoVsP1XtRcEqI45YRL
        rV+0ZSPuXIWxRYBIb4Yov72J6/KSi4QCAiSbJpLrnm/VBIroxvqETJWZ1xm1P3LD8d6DRQv1YvrjW
        e1kj2+Hw==;
Received: from [2001:4bb8:19a:b822:2a44:1428:2337:3096] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXPyu-00H8xr-9s; Thu, 24 Mar 2022 16:06:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix direct I/O writes for split bios on zoned devices
Date:   Thu, 24 Mar 2022 17:06:28 +0100
Message-Id: <20220324160628.1572613-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220324160628.1572613-1-hch@lst.de>
References: <20220324160628.1572613-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a bio is split in btrfs_submit_direct, dip->file_offset contains
the file offset for the first bio.  But this means the start value used
in btrfs_end_dio_bio to record the write location for zone devices is
incorrect for subsequent bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 762133fac0df1..c6f71551ba135 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7861,6 +7861,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 static void btrfs_end_dio_bio(struct bio *bio)
 {
 	struct btrfs_dio_private *dip = bio->bi_private;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	blk_status_t err = bio->bi_status;
 
 	if (err)
@@ -7871,12 +7872,12 @@ static void btrfs_end_dio_bio(struct bio *bio)
 			   bio->bi_iter.bi_size, err);
 
 	if (bio_op(bio) == REQ_OP_READ)
-		err = btrfs_check_read_dio_bio(dip, btrfs_bio(bio), !err);
+		err = btrfs_check_read_dio_bio(dip, bbio, !err);
 
 	if (err)
 		dip->dio_bio->bi_status = err;
 
-	btrfs_record_physical_zoned(dip->inode, dip->file_offset, bio);
+	btrfs_record_physical_zoned(dip->inode, bbio->file_offset, bio);
 
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
-- 
2.30.2

