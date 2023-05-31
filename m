Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04B3717501
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 06:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjEaERt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 00:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjEaERr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 00:17:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71FFFC
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 21:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=C7Z7TRCi1iuPvZKu4nbmuo9WuHT7TKxaniJJ7CmBCrg=; b=mH1DnAmRZiqahNG+QbBr7Cp/kc
        8/BzhWPgFjrqCgatLrxy+DKuzjJJQ98wOBOfGKyc7K96ezH19o2BWIYlqWASJKv5PnKAx6sOWeCgP
        FPwqaRK9MOUBvl4Y2hncf31pt8qhpx4Qa0IlQnix5HjQxE5XWEtO/UnrG2hUOTgBsmi8tSfhM7sjs
        UwqJGeFWuoSOOWXXDEWx+0YUfZfmtsteW/l5BftTYAtD8vla3aDjJtHSTYJDExfS3/DjOOQxfKyTe
        SUiKGGdsLhtOTj9aF2EomUq65jWoy1ZIPXcawvaeafFFKLyUuvhh/vEqKOYqrg4jP3n6pDhJWZIAF
        O6KjfvNg==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4DHM-00G1Oc-2N;
        Wed, 31 May 2023 04:17:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: remove BTRFS_MAP_DISCARD
Date:   Wed, 31 May 2023 06:17:34 +0200
Message-Id: <20230531041740.375963-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531041740.375963-1-hch@lst.de>
References: <20230531041740.375963-1-hch@lst.de>
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

BTRFS_MAP_DISCARD is never set, as REQ_OP_DISCARD is never passed to
btrfs_op() only only checked in two ASSERTS.

Remove it and let the catchall WARN_ON in btrfs_op() deal with accidental
REQ_OP_DISCARDs leaked into btrfs_op().

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 3 ---
 fs/btrfs/volumes.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a4bfec088617ec..c236bfba0cec3b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6182,8 +6182,6 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 			    u64 offset, u32 *stripe_nr, u64 *stripe_offset,
 			    u64 *full_stripe_start)
 {
-	ASSERT(op != BTRFS_MAP_DISCARD);
-
 	/*
 	 * Stripe_nr is the stripe where this block falls.  stripe_offset is
 	 * the offset of this block in its stripe.
@@ -6261,7 +6259,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	u64 max_len;
 
 	ASSERT(bioc_ret);
-	ASSERT(op != BTRFS_MAP_DISCARD);
 
 	num_copies = btrfs_num_copies(fs_info, logical, fs_info->sectorsize);
 	if (mirror_num > num_copies)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 16fc640cabd3f7..e960a51abf873d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -556,15 +556,12 @@ struct btrfs_dev_lookup_args {
 enum btrfs_map_op {
 	BTRFS_MAP_READ,
 	BTRFS_MAP_WRITE,
-	BTRFS_MAP_DISCARD,
 	BTRFS_MAP_GET_READ_MIRRORS,
 };
 
 static inline enum btrfs_map_op btrfs_op(struct bio *bio)
 {
 	switch (bio_op(bio)) {
-	case REQ_OP_DISCARD:
-		return BTRFS_MAP_DISCARD;
 	case REQ_OP_WRITE:
 	case REQ_OP_ZONE_APPEND:
 		return BTRFS_MAP_WRITE;
-- 
2.39.2

