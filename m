Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1498075F9B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGXOWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGXOWr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:22:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC63D7
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZJSGpxwxr/hSBv3Fud2DF+r+ppU6qxc6oTTz/Ybi4Ds=; b=N4KHwD++uorNpmcREM7d2m04mL
        3AtVc0yKDBx1Gg4EwzlAiISsob0EvOzQzeumqlf7VNoFjUuC6tZSeknYiQATGSl4Ell5nQR42eyMZ
        Ik5NkklTqmh1rQisPB680Nh0cwLCUBzZ+/W//Azqdv30Qp0zcRBltNnoCsJ2GN7zGwnGNq53KAnZR
        oHz0AnI1ybBt8G2qdh3DgpXQVLAvCTDtUbUCQie82/dq5i8DhWSd/JU7hPz+YbjMgwhVuKhSVGh3s
        38GBpJrz0f9nZIk5wC0ryghpoNQJbnkahmn1vh1i+LxBqfeXYaAB0Z9wzMMLMLWuIBcmEOUb8Yx2X
        FwpsC6hQ==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwSS-004b9v-1W;
        Mon, 24 Jul 2023 14:22:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: use nocow_end for the loop iteration in run_delalloc_cow
Date:   Mon, 24 Jul 2023 07:22:42 -0700
Message-Id: <20230724142243.5742-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724142243.5742-1-hch@lst.de>
References: <20230724142243.5742-1-hch@lst.de>
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

When run_delalloc_cow allocates an ordered extent for an actual
NOCOW range, it uses the nocow_end variable calculated based on
the current offset and the nocow_args.num_bytes value returned
from can_nocow_file_extent for all the actual I/O, but the loop
iteration then resets cur_offset to extent_end, which caused
me a lot of confusion.  It turns out that nocow_end is based
of the minimum of the extent end and the range end, and thus
actually works perfectly fine for the loop iteration, but
using a different variable here from the actual I/O submission
is horribly confusing and wasted some of my precious brain
cells when train to understand the logic.  Switch to using
nocow_end adjusted by the the off by one to make it an exclusive
range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 92182e0d27fdb5..caaf2c002d795d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2187,7 +2187,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					     EXTENT_CLEAR_DATA_RESV,
 					     PAGE_UNLOCK | PAGE_SET_ORDERED);
 
-		cur_offset = extent_end;
+		cur_offset = nocow_end + 1;
 
 		/*
 		 * btrfs_reloc_clone_csums() error, now we're OK to call error
-- 
2.39.2

