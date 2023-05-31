Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE2717690
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjEaGFf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjEaGFd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E37411D
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BTF/fowlJXxRLAv+TuwF0phmMWOWDUXfJU6eqwdq8L4=; b=5BzPcQosJJaSaF3lNH+8gNcBXE
        hby5SdCTxWfZsEnfJKvAeKG/EqHSa4c4aAtRxyBHsTkTeSD1Njlucou8p96VSqIzeE8ayed3Rx/6a
        mlNwZTfiHQYah1BO/pEOu4Io2Olg+sWKF5jmmi6A7GdZoZH9DyzWc3XcsDd12YAvB6mo0q2xzv+hP
        NgTeryIQUSYjj+U8gKCHMd/pR/WX/eKiCPPONdOvweFRWIkbtJ+rk5g82EV5dLMX3ynROnfA3LET1
        JK2M9cK0lO1GND1aeoHlzRNHvQzCcnE9E+VrJgurZ5Lel62/4dBQHSRrdiDrVIbk04+VFqx0QURVY
        XgDiH3jg==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Exe-00GF5q-1k;
        Wed, 31 May 2023 06:05:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/16] btrfs: don't check PageError in __extent_writepage
Date:   Wed, 31 May 2023 08:04:56 +0200
Message-Id: <20230531060505.468704-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
References: <20230531060505.468704-1-hch@lst.de>
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

__extent_writepage currenly sets PageError whenever any error happens,
and the also checks for PageError to decide if to call error handling.
This leads to very unclear responsibility for cleaning up on errors.
In the VM and generic writeback helpers the basic idea is that once
I/O is fired off all error handling responsibility is delegated to the
end I/O handler.  But if that end I/O handler sets the PageError bit,
and the submitter checks it, the bit could in some cases leak into the
submission context for fast enough I/O.

Fix this by simply not checking PageError and just using the local
ret variable to check for submission errors.  This also fundamentally
solves the long problem documented in a comment in __extent_writepage
by never leaking the error bit into the submission context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 178e8230c28af9..33e5f0a31c21a7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1557,38 +1557,7 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 		set_page_writeback(page);
 		end_page_writeback(page);
 	}
-	/*
-	 * Here we used to have a check for PageError() and then set @ret and
-	 * call end_extent_writepage().
-	 *
-	 * But in fact setting @ret here will cause different error paths
-	 * between subpage and regular sectorsize.
-	 *
-	 * For regular page size, we never submit current page, but only add
-	 * current page to current bio.
-	 * The bio submission can only happen in next page.
-	 * Thus if we hit the PageError() branch, @ret is already set to
-	 * non-zero value and will not get updated for regular sectorsize.
-	 *
-	 * But for subpage case, it's possible we submit part of current page,
-	 * thus can get PageError() set by submitted bio of the same page,
-	 * while our @ret is still 0.
-	 *
-	 * So here we unify the behavior and don't set @ret.
-	 * Error can still be properly passed to higher layer as page will
-	 * be set error, here we just don't handle the IO failure.
-	 *
-	 * NOTE: This is just a hotfix for subpage.
-	 * The root fix will be properly ending ordered extent when we hit
-	 * an error during writeback.
-	 *
-	 * But that needs a bigger refactoring, as we not only need to grab the
-	 * submitted OE, but also need to know exactly at which bytenr we hit
-	 * the error.
-	 * Currently the full page based __extent_writepage_io() is not
-	 * capable of that.
-	 */
-	if (PageError(page))
+	if (ret)
 		end_extent_writepage(page, ret, page_start, page_end);
 	if (bio_ctrl->extent_locked) {
 		struct writeback_control *wbc = bio_ctrl->wbc;
-- 
2.39.2

