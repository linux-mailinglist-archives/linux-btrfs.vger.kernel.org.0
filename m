Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD69429DC7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 08:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhJLGfV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 02:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhJLGfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 02:35:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B6CC061570
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 23:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=L7Xns7v9ExXsL446nqC4LsLBm2J7QKFmCNR4J05xIh4=; b=TFbfosPoD0S+3QwCznPj7X6gQx
        TGtYT/ZaDLJAtRyAtgU7idE1Bi9hS8edlF7ghmOwTeOCdFsWj0kp6CZQYIdg5C2GkTK/kNEmwWnrP
        v5bcsKrJAAHQJAfD72lzkKnV9UPkvi5kBkxP8J22UfwNw71Ibm+mbjSPWK7rXoVVbo/W0maNt/c8z
        J2nPvy/WsrSc0ZdZQH9lmDJSMjVdS9Y1dwRJu0CJz3GYcw3BVM2cyBClh7vibxQAw5xrhmgrHBEX5
        N+nlLZFd6iXR1aFld/4pYPUoayGn91ddCrxcb6M1YszwxrvTOon5Nu4RrEJO54Ytfo1rocpyQ0qwH
        Bt1m3U1A==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maBKN-006GgN-TT; Tue, 12 Oct 2021 06:32:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use bvec_kmap_local in btrfs_csum_one_bio
Date:   Tue, 12 Oct 2021 08:31:53 +0200
Message-Id: <20211012063153.380185-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Using local kmaps slightly reduces the chances to stray writes, and
the bvec interface cleans up the code a little bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/file-item.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 0b9401a5afd33..b9a80fa37d54d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -709,12 +709,12 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 				index = 0;
 			}
 
-			data = kmap_atomic(bvec.bv_page);
-			crypto_shash_digest(shash, data + bvec.bv_offset
-					    + (i * fs_info->sectorsize),
+			data = bvec_kmap_local(&bvec);
+			crypto_shash_digest(shash,
+					    data + (i * fs_info->sectorsize),
 					    fs_info->sectorsize,
 					    sums->sums + index);
-			kunmap_atomic(data);
+			kunmap_local(data);
 			index += fs_info->csum_size;
 			offset += fs_info->sectorsize;
 			this_sum_bytes += fs_info->sectorsize;
-- 
2.30.2

