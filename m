Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A4798F6E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 21:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344846AbjIHTc0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 15:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344864AbjIHTcV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 15:32:21 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D23211D
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:31:58 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-414b3da2494so15435281cf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694201504; x=1694806304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=weBTowEJTbKnABwiRe7gRmhtHNPUdWpyEnQsWOQ5K6U=;
        b=vR0DauLeTqn+UDK8DjT2LFKGZixpZIyHNdg7IdMpW7LAL3MlENU9Hx2BCDX8KHC1nD
         Cswp/jWifQwM/FaIKc3CAVxIq7yS+0yIi71HSP8JO2oHlszytq6qAf4FpPHqy9YcK4fU
         JUCTRFmYRYH3TXW+7D4o7mwHT2kPkEDgg64tScwT2tJ9I8D0a6xvQr0fg84wnRZC5PUK
         RpWW3RWiBSTm0EwrY5yiqrJq8OoeLX29pJGImC8WATciPDAS3OflPOAJUYGFSxgVeBsY
         735q/ux9klWebGHBGTzhJ0azQlAC/dzSq5NQDKveBDK47bjynZym+ZBd3woi7EJf/k2a
         mqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694201504; x=1694806304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weBTowEJTbKnABwiRe7gRmhtHNPUdWpyEnQsWOQ5K6U=;
        b=moPbBd9H6KslxH110PrOrUSdd/oZNnRjF4Hhj7yV18iDmxEunWqaq3gq+p3Ca+UX7+
         dvcXyFOQsUglcD0B3TlkUcKkCpraEfdG8H6dLWlg4cu+aiciX4bLgNs6zxH2U6xhv5jD
         lLA2XLWO55HCLsU0qteQbFVKHGGcuzB8gdMK3OZxsMo3LyI8rjxl04GJTCGgK0Iz7pCt
         Tfd346p31yBm5ZAqRDQagm14WcJFPDSRZhHMM2mEhc1qt8xLSXh2k8pwIzT+RMybxDSV
         xuUFKRS2Cvrx/3+hv+rjY8u2Nu8jNju1LLL++JfOVdt6pdbXipgt7s78aLjnrjYgTArE
         ClsQ==
X-Gm-Message-State: AOJu0YyasHsaOQ8j0KTlqnNnUuhNur5wzVNfKsaVIBbgFoyxm5gyxHHG
        tx3AAT6/s8x8CB6Ufyn9AyUhxroJ9BNRJ9xX+IosoQ==
X-Google-Smtp-Source: AGHT+IGJilICsv1ITMbztAyrG37T1YFRGrmVMnyM8D+797fZzWwQINIXvhGHKsj6OwIHi0QemjPJXQ==
X-Received: by 2002:a0c:a78a:0:b0:649:8f20:552e with SMTP id v10-20020a0ca78a000000b006498f20552emr2918635qva.62.1694201503848;
        Fri, 08 Sep 2023 12:31:43 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cy20-20020a05621418d400b0064f46422ddasm323509qvb.145.2023.09.08.12.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 12:31:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: don't clear uptodate on write errors
Date:   Fri,  8 Sep 2023 15:31:39 -0400
Message-ID: <b709ff69f5d190ec620b7e4a21530be08442bf4b.1694201483.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have been consistently seeing hangs with generic/648 in our subpage
GitHub CI setup.  This is a classic deadlock, we are calling
btrfs_read_folio() on a folio, which requires holding the folio lock on
the folio, and then finding a ordered extent that overlaps that range
and calling btrfs_start_ordered_extent(), which then tries to write out
the dirty page, which requires taking the folio lock and then we
deadlock.

The hang happens because we're writing to range [1271750656, 1271767040), page
index [77621, 77622], and page 77621 is !Uptodate.  It is also Dirty, so we call
btrfs_read_folio() for 77621 and which does btrfs_lock_and_flush_ordered_range()
for that range, and we find an ordered extent which is [1271644160, 1271746560),
page index [77615, 77621].  The page indexes overlap, but the actual bytes don't
overlap.  We're holding the page lock for 77621, then call
btrfs_lock_and_flush_ordered_range() which tries to flush the dirty page, and
tries to lock 77621 again and then we deadlock.

The byte ranges do not overlap, but with subpage support if we clear
uptodate on any portion of the page we mark the entire thing as not
uptodate.

We have been clearing page uptodate on write errors, but no other file
system does this, and is in fact incorrect.  This doesn't hurt us in the
!subpage case because we can't end up with overlapped ranges that don't
also overlap on the page.

Fix this by not clearing uptodate when we have a write error.  The only
thing we should be doing in this case is setting the mapping error and
carrying on.  This makes it so we would no longer call
btrfs_read_folio() on the page as it's uptodate and eliminates the
deadlock.

With this patch we're now able to make it through a full xfstests run on
our subpage blocksize vms.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 9 +--------
 fs/btrfs/inode.c     | 4 ----
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ac3fca5a5e41..6954ae763b86 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -484,10 +484,8 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 				   bvec->bv_offset, bvec->bv_len);
 
 		btrfs_finish_ordered_extent(bbio->ordered, page, start, len, !error);
-		if (error) {
-			btrfs_page_clear_uptodate(fs_info, page, start, len);
+		if (error)
 			mapping_set_error(page->mapping, error);
-		}
 		btrfs_page_clear_writeback(fs_info, page, start, len);
 	}
 
@@ -1456,8 +1454,6 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	if (ret) {
 		btrfs_mark_ordered_io_finished(BTRFS_I(inode), page, page_start,
 					       PAGE_SIZE, !ret);
-		btrfs_page_clear_uptodate(btrfs_sb(inode->i_sb), page,
-					  page_start, PAGE_SIZE);
 		mapping_set_error(page->mapping, ret);
 	}
 	unlock_page(page);
@@ -1624,8 +1620,6 @@ static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
 		struct page *page = bvec->bv_page;
 		u32 len = bvec->bv_len;
 
-		if (!uptodate)
-			btrfs_page_clear_uptodate(fs_info, page, start, len);
 		btrfs_page_clear_writeback(fs_info, page, start, len);
 		bio_offset += len;
 	}
@@ -2201,7 +2195,6 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 		if (ret) {
 			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
 						       cur, cur_len, !ret);
-			btrfs_page_clear_uptodate(fs_info, page, cur, cur_len);
 			mapping_set_error(page->mapping, ret);
 		}
 		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f09fbdc43f0f..478999dcb2a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1085,9 +1085,6 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			btrfs_mark_ordered_io_finished(inode, locked_page,
 						       page_start, PAGE_SIZE,
 						       !ret);
-			btrfs_page_clear_uptodate(inode->root->fs_info,
-						  locked_page, page_start,
-						  PAGE_SIZE);
 			mapping_set_error(locked_page->mapping, ret);
 			unlock_page(locked_page);
 		}
@@ -2791,7 +2788,6 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		mapping_set_error(page->mapping, ret);
 		btrfs_mark_ordered_io_finished(inode, page, page_start,
 					       PAGE_SIZE, !ret);
-		btrfs_page_clear_uptodate(fs_info, page, page_start, PAGE_SIZE);
 		clear_page_dirty_for_io(page);
 	}
 	btrfs_page_clear_checked(fs_info, page, page_start, PAGE_SIZE);
-- 
2.41.0

