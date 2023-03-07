Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBF6AE6EA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 17:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCGQms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 11:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCGQmV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 11:42:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BB96C0E
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 08:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GRzg7t/WTJr4Es62ge5iNhsv0t0DTv+ZqYmEl7Dy3yE=; b=0R/UobueHOO2E52/IJ5qlN1ew+
        hK92kLIDp5vyfBjCHMbD3Y8eU/2RLagCV2eQL9quyrFtDbVBYWTnS/32lV/zTmUmP0LmuNcVULWrl
        9nSbje9jLORiU+HF1mi/CmDW6rMuCluzLVltSM6qsOSzAYfRM7UPoTHGGMZ8+EFtXkIRuhKV28YQG
        CeeOX1CFZ/94gz1g93I/h6e91QL9yAQE2BZ3Vnn3joKuuMLWJmBxEpmQbtLl/Kk2mFpyowFbf3oDn
        J+eSYH/mtMgsz7ViJNcdhB60sNzA089lRRvOKg71dZHgyG9mAQry+SgaSlEi76G82uaKStb7t+V5o
        ohdqLGyg==;
Received: from [213.208.157.31] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZaM8-001bNl-Iu; Tue, 07 Mar 2023 16:40:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 01/10] btrfs: remove unused members from struct btrfs_encoded_read_private
Date:   Tue,  7 Mar 2023 17:39:36 +0100
Message-Id: <20230307163945.31770-2-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307163945.31770-1-hch@lst.de>
References: <20230307163945.31770-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The inode and file_offset members in struct btrfs_encoded_read_private
are unused, so remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 45102785c72329..cce4729bbca177 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9926,8 +9926,6 @@ static ssize_t btrfs_encoded_read_inline(
 }
 
 struct btrfs_encoded_read_private {
-	struct btrfs_inode *inode;
-	u64 file_offset;
 	wait_queue_head_t wait;
 	atomic_t pending;
 	blk_status_t status;
@@ -9958,8 +9956,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  u64 disk_io_size, struct page **pages)
 {
 	struct btrfs_encoded_read_private priv = {
-		.inode = inode,
-		.file_offset = file_offset,
 		.pending = ATOMIC_INIT(1),
 	};
 	unsigned long i = 0;
-- 
2.39.1

