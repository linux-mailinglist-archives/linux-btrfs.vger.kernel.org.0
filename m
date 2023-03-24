Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13FB6C75E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjCXCca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjCXCc2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:32:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8315061AD
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 19:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hCtqiXrsSWBbTZPjbcBUZ+xzxL2eFMkFfXgfmTfE3ZA=; b=DUCt9+7wshXBdklJ4ANifONCHX
        YBbUlU6s0T/xfKxhn8Lg5zT4AiFb2y05bJUm1fi/hb4ZopikUalfpcXNQWFpUfO5R2g0c9n8qnahH
        nyTammYuamNfeojNWJPhHYworMwCp1Vd8qsGOFPosJGitMjng+fyFk+6SBFh/96gNJbnCfhqLJoay
        g/1PiV/5nNa+0vxZdG/t4LmoVmbAsvUwt+v7fRXA1qWAZgGg2M1N/dmdSCf80MxHyh6l+f+axWYKO
        KKsaj5eu5xnAMMGisHFK07HSRtfwzzKQ+28mvj8MHna6Dfmb23NsBj/bELlJHh+XgFc3JNvqL9GHU
        aI64KlFQ==;
Received: from [122.147.159.89] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfXE8-003PGX-1c;
        Fri, 24 Mar 2023 02:32:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 02/11] btrfs: pass flags as unsigned long to btrfs_add_ordered_extent
Date:   Fri, 24 Mar 2023 10:31:58 +0800
Message-Id: <20230324023207.544800-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324023207.544800-1-hch@lst.de>
References: <20230324023207.544800-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

The ordered_extent flags are declared as unsigned long, so pass them as
such to btrfs_add_ordered_extent.

Signed-off-by: Boris Burkov <boris@bur.io>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ordered-data.c | 2 +-
 fs/btrfs/ordered-data.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 83a51c692406ab..1848d0d1a9c41e 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -270,7 +270,7 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
  */
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			     u64 disk_num_bytes, u64 offset, unsigned flags,
+			     u64 disk_num_bytes, u64 offset, unsigned long flags,
 			     int compress_type)
 {
 	struct btrfs_ordered_extent *ordered;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index c00a5a3f060fa2..18007f9c00add8 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -185,7 +185,7 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			int compress_type);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			     u64 disk_num_bytes, u64 offset, unsigned flags,
+			     u64 disk_num_bytes, u64 offset, unsigned long flags,
 			     int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
-- 
2.39.2

