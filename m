Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A45375352F
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 10:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjGNIm6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 04:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjGNIm4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 04:42:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFB42683
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 01:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=verzVAAhXUHMWKY7Gi7rGy7j6s23gqqKSotzn+0OiUw=; b=F+x+733fWPz5c30H1W9tnOhpUn
        IFwovgW39BADMxnHU6ND+8xCWuNyUugRQ2Mf7OORuSCh1YqTjuZ5sXacP8JBfcYVjQWLp5/FI64ON
        B8uClom7nR+1VSKok5eWMid19xfmNxza7l7qKJmuwIuP6yMIqbKyGTzqQO6KZ3brVtBm2xMj7HoKa
        rCgKujnudJVvZ2D2vFQ1lvDfdumXBkb/pwfofLBQVhRssu7Qv7z90JzBFnoyGhA+EfiFQ907ctD1x
        vK6PDu8Z4A2sGq9Z03OGyVwAnBpWEMwaiZqe4EjBkrNp/kDPwcaBZ0OOZTRh30S7mC96tDbRHzGFJ
        pX6Nz7lg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKEO1-005YBr-2W;
        Fri, 14 Jul 2023 08:42:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org,
        syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>
Subject: [PATCH] btrfs: fix ordered extent split error handling in btrfs_dio_submit_io
Date:   Fri, 14 Jul 2023 10:42:41 +0200
Message-Id: <20230714084241.548739-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the call to btrfs_extract_ordered_extent in btrfs_dio_submit_io
fails to allocate memory for a new ordered_extent, it calls into the
btrfs_dio_end_io for error handling.  btrfs_dio_end_io then assumes that
bbio->ordered is set because it is supposed to be at this point, except
for this error handling corner case.  Try to not overload the
btrfs_dio_end_io with error handling of a bio in a non-canonical state,
and instead call btrfs_finish_ordered_extent and iomap_dio_bio_end_io
directly for this error case.

Fixes: b41b6f6937dc ("btrfs: use btrfs_finish_ordered_extent to complete direct writes")
Reported-by: syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dbbb67293e345c..a7064c2bee5b8e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7849,8 +7849,11 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 
 		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
 		if (ret) {
-			bbio->bio.bi_status = errno_to_blk_status(ret);
-			btrfs_dio_end_io(bbio);
+			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
+						    file_offset, dip->bytes,
+						    !ret);
+			bio->bi_status = errno_to_blk_status(ret);
+			iomap_dio_bio_end_io(bio);
 			return;
 		}
 	}
-- 
2.39.2

