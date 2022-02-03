Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E53D4A87C0
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 16:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351898AbiBCPgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 10:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351895AbiBCPgx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 10:36:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CBBC061714
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 07:36:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CF06B8347D
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 15:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3913C340E4
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643902611;
        bh=ndrOC7y0VIiUHGV+9MDS4811jq1UvQ97gdWkI2fwcPM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uWfaqp8NCoE3aUT3rZF03KwUupJZ9GrN9fYRjXSY9gHLW7seIqXtoG8xjWQdh86Y+
         nPTxU+AClt84wlEPFXVrzgRuKW378MZK+2XbKz+U1U7md5uXWYoO7WSYxGcf/nSNYz
         NGYCHs6a/tOYsusmNFvlp07esT308VHZjQgE883QMCLMM9o1QhRT02hs+poNfLmkFU
         +fjRs5vezfcwNLo5eAn/OG8AfgR0yIPgtEkT6hcc5wCXLCcv5sZGtDfFFMQ4SJ1hiq
         yuhflD1WUgupvgZ68HZP8nG1bTALFedaRVHF/S8Q6ZYalW08+bF24ahIvEv6u0n0dB
         DCxUS139xi5BA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: remove no longer used counter when reading data page
Date:   Thu,  3 Feb 2022 15:36:44 +0000
Message-Id: <4e9e29d0e2ee9fd1301b3b6d149db23eb13156bc.1643902108.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643902108.git.fdmanana@suse.com>
References: <cover.1643902108.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After commit 92082d40976ed0 ("btrfs: integrate page status update for
data read path into begin/end_page_read"), the 'nr' counter at
btrfs_do_readpage() is no longer used, we increment it but we never
read from it. So just remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e713355c0e15..5f7f902076f3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3563,7 +3563,6 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	u64 cur_end;
 	struct extent_map *em;
 	int ret = 0;
-	int nr = 0;
 	size_t pg_offset = 0;
 	size_t iosize;
 	size_t blocksize = inode->i_sb->s_blocksize;
@@ -3722,9 +3721,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 					 end_bio_extent_readpage, 0,
 					 this_bio_flag,
 					 force_bio_submit);
-		if (!ret) {
-			nr++;
-		} else {
+		if (ret) {
 			unlock_extent(tree, cur, cur + iosize - 1);
 			end_page_read(page, false, cur, iosize);
 			goto out;
-- 
2.33.0

