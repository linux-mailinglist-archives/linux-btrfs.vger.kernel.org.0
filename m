Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C123952A540
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349324AbiEQOvZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349298AbiEQOu4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:50:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621099FDD
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OGz/IStZR/uDiGjoLCJtFpfdkLD87lGH9LZW8nZ4hcY=; b=hDmlHEAgbt0Hm2NJRPJggYw1Kk
        lvvDApRE84FXBkpmUUUdOB/FJJmDnsYBUD8+0xUT2Q1V6lBriYyPID56IegNV/hJqYf22OVyuwWUL
        95FDgmpz0DhFid2dfwfxQ2nfH3ifAulPQ4c90VT/071tsm2k0GY72HbLFpwgD0NCo/Tz4W6erkg29
        g089SYcjLcE9vy0YpmF8lpHm8X9iyj+EwMIlJwnZR0ROOAP8m6Y+2xXk/R4wlaOLCKoVdqant36Ir
        TbpU3XDxg6tzgLwrmC28Is8Fs0Pnu6aIr8UstJiO8D33FGtY2XicvAS8u2AJXj3V70t6DJfi4uCZ8
        TApFGOLA==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXC-00EXAO-KU; Tue, 17 May 2022 14:50:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 02/15] btrfs: quit early if the fs has no RAID56 support for raid56 related checks
Date:   Tue, 17 May 2022 16:50:26 +0200
Message-Id: <20220517145039.3202184-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517145039.3202184-1-hch@lst.de>
References: <20220517145039.3202184-1-hch@lst.de>
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

