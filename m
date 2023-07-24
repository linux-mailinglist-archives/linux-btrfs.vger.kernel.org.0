Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC1475F842
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 15:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjGXN1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 09:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjGXN1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 09:27:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AFF106
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3nNvfzNF93rFxsmZklRHmKc5CAnVSqAcDlcgaG/Rczo=; b=xpd0Fj5ogWsRLBCjiHSGZwzFMi
        bw+CmyPVAtTeWdVOsPOLTaUNhQVVFIAmMiYMgs9HV00u2055lj0ujEkidsiF4Kq33sBhgP2igFens
        8AvmRD2toTvB7YOc1D08trllV2OxLGU19l5IzgVkCgeI9wrvn3xJoO8hpDXW9zRAr7+O2imKsUoaE
        HaZm4LkZCV/RF/TZZPItBdVdyMb7PNSOVRfn9ERfqFmWmkL2+ygNLz51cx1My4lFutFOlwMYv0ZeY
        fZ1SgXJx5x8DC+dGjTRImdahAEPJEJUQZaMHP1+un9cdhhQC3e/6ElDrwtKambpLsIqKXye4AQWGc
        zGk3Uc9w==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNvaZ-004RMO-1r;
        Mon, 24 Jul 2023 13:27:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs: lift the call to mapping_set_error out of cow_file_range
Date:   Mon, 24 Jul 2023 06:27:01 -0700
Message-Id: <20230724132701.816771-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724132701.816771-1-hch@lst.de>
References: <20230724132701.816771-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of calling mapping_set_error in cow_file_range for the
!locked_page case, make the submit_uncompressed_range call
mapping_set_error also for the !locked_page as that is the only caller
that might pass a NULL locked_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0d33bff5ca176f..b04eacc0fed44e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1077,6 +1077,7 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 	wbc_detach_inode(&wbc);
 	if (ret < 0) {
 		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
+		mapping_set_error(inode->vfs_inode.i_mapping, ret);
 		if (locked_page) {
 			const u64 page_start = page_offset(locked_page);
 
@@ -1088,7 +1089,6 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			btrfs_page_clear_uptodate(inode->root->fs_info,
 						  locked_page, page_start,
 						  PAGE_SIZE);
-			mapping_set_error(locked_page->mapping, ret);
 			unlock_page(locked_page);
 		}
 	}
@@ -1526,12 +1526,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * However, in case of @keep_locked, we still need to unlock the pages
 	 * (except @locked_page) to ensure all the pages are unlocked.
 	 */
-	if (keep_locked && orig_start < start) {
-		if (!locked_page)
-			mapping_set_error(inode->vfs_inode.i_mapping, ret);
+	if (keep_locked && orig_start < start)
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
 					     locked_page, 0, page_ops);
-	}
 
 	/*
 	 * For the range (2). If we reserved an extent for our delalloc range
-- 
2.39.2

