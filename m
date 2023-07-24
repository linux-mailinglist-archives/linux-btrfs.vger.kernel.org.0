Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD80175F845
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGXN10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjGXN1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 09:27:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C17E77
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UYsvTds/y/Om/943qxrj8Wf0OVOAcYDC60XUQ941K7o=; b=3s2ML+l04xerF5KHR4BgCmpAPn
        nkrNwPwlU+QnvD/s04GXkJmn9/1FByITXkKcTlAuWeldBZ8aava3auvwh8jrxMe7pad0szz6aNini
        2g3OGbgjNGvNDaFJU/jlfZCQNfoowPN9VC8HUbU6ZGeAkC+6gV91bisgPhee7mxvrVkp8c+ubo2F0
        3aSRFS+Ps4Ai1nt4XNzNVa35XISfeN6Z/RTkZoyYh3j7az9dYKgDqJL+FWDCvdtFRi3+4GUlf9+i+
        KQMKpyW9Ukj16TT5nDUNDX5x8LT7n7ArGPVCbMES+oLit2S/oM3hdDw7OvCCj/o7774PXMMDVXCam
        H/8kaaww==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNvaY-004RLa-0Y;
        Mon, 24 Jul 2023 13:27:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/9] btrfs: don't wait for writeback on clean pages in extent_write_cache_pages
Date:   Mon, 24 Jul 2023 06:26:54 -0700
Message-Id: <20230724132701.816771-3-hch@lst.de>
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

__extent_writepage can have started on more pages than the one it was
called for.  This happens regularly for zoned file systems, and in theory
could happen for compressed I/O if the worker thread was executed very
quicky. For such pages extent_write_cache_pages waits for writeback
to complete before moving on to the next page, which is highly inefficient
as it blocks the flusher thread

Port over the PageDirty check that was added to write_cache_pages in
commit 515f4a037fb ("mm: write_cache_pages optimise page cleaning") to
fix this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 231e620e6c497d..1cc46bbbd888cd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2075,6 +2075,12 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 
+			if (!folio_test_dirty(folio)) {
+				/* someone wrote it for us */
+				folio_unlock(folio);
+				continue;
+			}
+
 			if (wbc->sync_mode != WB_SYNC_NONE) {
 				if (folio_test_writeback(folio))
 					submit_write_bio(bio_ctrl, 0);
-- 
2.39.2

