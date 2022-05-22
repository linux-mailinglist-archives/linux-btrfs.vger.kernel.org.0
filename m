Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDEE5302BE
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 13:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245290AbiEVLsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiEVLsD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 07:48:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF215FFD
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 04:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3zdoWbjR7q9HGRpCbM/l1g4FWdIgFwy39PbYkNxELYA=; b=dl214vYqzvo9g+n7OZqCcYRW5l
        iRLMDcaKYNxVSUsBMiRxu73Z7N9MfPm0ycv/9OsHt+Cg6U/erZIMmZYViElTjJJNDzwTuiVe3BLTz
        5H4A8fU8l1hY4kQwVEutNNQYrsJorTMIfGr11I+Fb7bNSAPXq3L8un2V26pmhiPU44NCrp92UOlXC
        4ZJ9Vp+dWdhn9jOiMRHQcwnklW4w1iiZMca3Z7aemuuPcnfqgr0lQdR+oKVrZ4pMlznDH9RSI4MoU
        6367fuafjEWxSRZoejcJLrGOpzj9FrjZkb7htwJxsGg0YZXX3Pnz6yNJKnaJn4od9BK0CcdU6tCRB
        7/KIFWew==;
Received: from [2001:4bb8:19a:6dab:76a3:f7ab:4f04:784a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsk3z-001E1M-RM; Sun, 22 May 2022 11:48:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/8] btrfs: quit early if the fs has no RAID56 support for raid56 related checks
Date:   Sun, 22 May 2022 13:47:47 +0200
Message-Id: <20220522114754.173685-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220522114754.173685-1-hch@lst.de>
References: <20220522114754.173685-1-hch@lst.de>
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

From: Qu Wenruo <wqu@suse.com>

The following functions do special handling for RAID56 chunks:

- btrfs_is_parity_mirror()
  Check if the range is in RAID56 chunks.

- btrfs_full_stripe_len()
  Either return sectorsize for non-RAID56 profiles or full stripe length
  for RAID56 chunks.

But if a filesystem without any RAID56 chunks, it will not have RAID56
incompt flags, and we can skip the chunk tree looking up completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 58f3eece8a48c..0819db46dbc42 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5769,6 +5769,9 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 	struct map_lookup *map;
 	unsigned long len = fs_info->sectorsize;
 
+	if (!btrfs_fs_incompat(fs_info, RAID56))
+		return len;
+
 	em = btrfs_get_chunk_map(fs_info, logical, len);
 
 	if (!WARN_ON(IS_ERR(em))) {
@@ -5786,6 +5789,9 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	struct map_lookup *map;
 	int ret = 0;
 
+	if (!btrfs_fs_incompat(fs_info, RAID56))
+		return 0;
+
 	em = btrfs_get_chunk_map(fs_info, logical, len);
 
 	if(!WARN_ON(IS_ERR(em))) {
-- 
2.30.2

