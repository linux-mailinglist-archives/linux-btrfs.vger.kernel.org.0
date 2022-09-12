Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945FD5B6089
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiILS0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 14:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiILSZn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 14:25:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47C19010;
        Mon, 12 Sep 2022 11:25:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso4635575pjq.1;
        Mon, 12 Sep 2022 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vD6EjjDMoxaFUA+mx+1Z6aV95S5MJYOdc07mIzZAFKw=;
        b=UqzmvjvODJhLS5eprd3SsVA8aYyAs1wZcKWHylaNWO7CS4j6NYjGTX+zpkhRa8+LoA
         nmh8lUNTGNmHH69IGw2Qja814CxC8xVJHgX9OT2P0WMme6Y46Kc0+AkAVHOT9LTnjvLD
         qWh/QE2ozCiJJbF64vhq8Rdc1NvupnRG57jdogiRHGTTs5f496uYcX69OhLB6yiMLY4P
         LgjSKzS30dTuN0N10mZkwZKDfNrOYg+7YYZOSpnV44a2iR5OVlXyPMqknDxbzHLqqY+E
         6Udb7E2cL70veVfJxizDgswHLxJOAXDYa0yj+5OI4LCqh76g8IkASxNybfVgprSJG90d
         /0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vD6EjjDMoxaFUA+mx+1Z6aV95S5MJYOdc07mIzZAFKw=;
        b=rSssLAhIi9Y3yyZ8zgJ4obyDO7buiGddXqK4MGVpF3xpy/b67E8c/ktVBmIsDn0oHm
         3hCogMUYFE5UnDd6pCJNaSq0egjLC8zZlqRg+Ftfmh1mPwguaWgvfZFfmNF+gxkIXE4c
         Up/z91so6JUXcTlG7lgWLQhksYwTFu1SU6mnvuIRaGh903lfSdveXD4cJ4FCxw9DRHBk
         IVxV9VT8H/m6OigVWYIj63P1Vl7wJomh4MpQDG8Dso1wDB25/2ALtaR2cCY0dKEBLOLS
         LEBFy3DvAa3qnF2tQcEEBrJIl+EX7JV2xAYaBvtQ6og0IQLcDSuLedmRHDB6ZvdsjcLt
         8Fkg==
X-Gm-Message-State: ACgBeo2lKUQmPIT3A9kF6l5vgmMvtPgEjPu1nykBvqy92tWaEaJTehXU
        4UdxY3rqXtyjBg03QWqIIfR/GBLNDys/QQ==
X-Google-Smtp-Source: AA6agR7zQQqP5xvmjooRtUQxw4kQdhrf8U+2E9FarhnDRQvlrhlSFF3G7X4Zjeh0ukqPZYQP0bsu3w==
X-Received: by 2002:a17:90a:4fc2:b0:1fb:3486:7b3d with SMTP id q60-20020a17090a4fc200b001fb34867b3dmr25673001pjh.49.1663007134972;
        Mon, 12 Sep 2022 11:25:34 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:34 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 08/23] ceph: Convert ceph_writepages_start() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:09 -0700
Message-Id: <20220912182224.514561-9-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

This change does NOT support large folios. This shouldn't be an issue as
of now since ceph only utilizes folios of size 1 anyways, and there is a
lot of work to be done on ceph conversions to folios for later patches
at some point.

Also some minor renaming for consistency.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/ceph/addr.c | 138 +++++++++++++++++++++++++------------------------
 1 file changed, 70 insertions(+), 68 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index dcf701b05cc1..33dbe55b08be 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -792,7 +792,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 	struct ceph_vino vino = ceph_vino(inode);
 	pgoff_t index, start_index, end = -1;
 	struct ceph_snap_context *snapc = NULL, *last_snapc = NULL, *pgsnapc;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	int rc = 0;
 	unsigned int wsize = i_blocksize(inode);
 	struct ceph_osd_request *req = NULL;
@@ -821,7 +821,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 	if (fsc->mount_options->wsize < wsize)
 		wsize = fsc->mount_options->wsize;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 	start_index = wbc->range_cyclic ? mapping->writeback_index : 0;
 	index = start_index;
@@ -869,9 +869,9 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 	while (!done && index <= end) {
 		int num_ops = 0, op_idx;
-		unsigned i, pvec_pages, max_pages, locked_pages = 0;
+		unsigned i, nr_folios, max_pages, locked_pages = 0;
 		struct page **pages = NULL, **data_pages;
-		struct page *page;
+		struct folio *folio;
 		pgoff_t strip_unit_end = 0;
 		u64 offset = 0, len = 0;
 		bool from_pool = false;
@@ -879,28 +879,28 @@ static int ceph_writepages_start(struct address_space *mapping,
 		max_pages = wsize >> PAGE_SHIFT;
 
 get_more_pages:
-		pvec_pages = pagevec_lookup_range_tag(&pvec, mapping, &index,
-						end, PAGECACHE_TAG_DIRTY);
-		dout("pagevec_lookup_range_tag got %d\n", pvec_pages);
-		if (!pvec_pages && !locked_pages)
+		nr_folios = filemap_get_folios_tag(mapping, &index,
+				end, PAGECACHE_TAG_DIRTY, &fbatch);
+		dout("filemap_get_folios_tag got %d\n", nr_folios);
+		if (!nr_folios && !locked_pages)
 			break;
-		for (i = 0; i < pvec_pages && locked_pages < max_pages; i++) {
-			page = pvec.pages[i];
-			dout("? %p idx %lu\n", page, page->index);
+		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
+			folio = fbatch.folios[i];
+			dout("? %p idx %lu\n", folio, folio->index);
 			if (locked_pages == 0)
-				lock_page(page);  /* first page */
-			else if (!trylock_page(page))
+				folio_lock(folio); /* first folio */
+			else if (!folio_trylock(folio))
 				break;
 
 			/* only dirty pages, or our accounting breaks */
-			if (unlikely(!PageDirty(page)) ||
-			    unlikely(page->mapping != mapping)) {
-				dout("!dirty or !mapping %p\n", page);
-				unlock_page(page);
+			if (unlikely(!folio_test_dirty(folio)) ||
+			    unlikely(folio->mapping != mapping)) {
+				dout("!dirty or !mapping %p\n", folio);
+				folio_unlock(folio);
 				continue;
 			}
 			/* only if matching snap context */
-			pgsnapc = page_snap_context(page);
+			pgsnapc = page_snap_context(&folio->page);
 			if (pgsnapc != snapc) {
 				dout("page snapc %p %lld != oldest %p %lld\n",
 				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
@@ -908,11 +908,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 				    !ceph_wbc.head_snapc &&
 				    wbc->sync_mode != WB_SYNC_NONE)
 					should_loop = true;
-				unlock_page(page);
+				folio_unlock(folio);
 				continue;
 			}
-			if (page_offset(page) >= ceph_wbc.i_size) {
-				struct folio *folio = page_folio(page);
+			if (folio_pos(folio) >= ceph_wbc.i_size) {
 
 				dout("folio at %lu beyond eof %llu\n",
 				     folio->index, ceph_wbc.i_size);
@@ -924,25 +923,26 @@ static int ceph_writepages_start(struct address_space *mapping,
 				folio_unlock(folio);
 				continue;
 			}
-			if (strip_unit_end && (page->index > strip_unit_end)) {
-				dout("end of strip unit %p\n", page);
-				unlock_page(page);
+			if (strip_unit_end && (folio->index > strip_unit_end)) {
+				dout("end of strip unit %p\n", folio);
+				folio_unlock(folio);
 				break;
 			}
-			if (PageWriteback(page) || PageFsCache(page)) {
+			if (folio_test_writeback(folio) ||
+					folio_test_fscache(folio)) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
-					dout("%p under writeback\n", page);
-					unlock_page(page);
+					dout("%p under writeback\n", folio);
+					folio_unlock(folio);
 					continue;
 				}
-				dout("waiting on writeback %p\n", page);
-				wait_on_page_writeback(page);
-				wait_on_page_fscache(page);
+				dout("waiting on writeback %p\n", folio);
+				folio_wait_writeback(folio);
+				folio_wait_fscache(folio);
 			}
 
-			if (!clear_page_dirty_for_io(page)) {
-				dout("%p !clear_page_dirty_for_io\n", page);
-				unlock_page(page);
+			if (!folio_clear_dirty_for_io(folio)) {
+				dout("%p !clear_page_dirty_for_io\n", folio);
+				folio_unlock(folio);
 				continue;
 			}
 
@@ -958,7 +958,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				u32 xlen;
 
 				/* prepare async write request */
-				offset = (u64)page_offset(page);
+				offset = (u64)folio_pos(folio);
 				ceph_calc_file_object_mapping(&ci->i_layout,
 							      offset, wsize,
 							      &objnum, &objoff,
@@ -966,7 +966,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				len = xlen;
 
 				num_ops = 1;
-				strip_unit_end = page->index +
+				strip_unit_end = folio->index +
 					((len - 1) >> PAGE_SHIFT);
 
 				BUG_ON(pages);
@@ -981,54 +981,53 @@ static int ceph_writepages_start(struct address_space *mapping,
 				}
 
 				len = 0;
-			} else if (page->index !=
+			} else if (folio->index !=
 				   (offset + len) >> PAGE_SHIFT) {
 				if (num_ops >= (from_pool ?  CEPH_OSD_SLAB_OPS :
 							     CEPH_OSD_MAX_OPS)) {
-					redirty_page_for_writepage(wbc, page);
-					unlock_page(page);
+					folio_redirty_for_writepage(wbc, folio);
+					folio_unlock(folio);
 					break;
 				}
 
 				num_ops++;
-				offset = (u64)page_offset(page);
+				offset = (u64)folio_pos(folio);
 				len = 0;
 			}
 
-			/* note position of first page in pvec */
+			/* note position of first page in fbatch */
 			dout("%p will write page %p idx %lu\n",
-			     inode, page, page->index);
+			     inode, folio, folio->index);
 
 			if (atomic_long_inc_return(&fsc->writeback_count) >
 			    CONGESTION_ON_THRESH(
 				    fsc->mount_options->congestion_kb))
 				fsc->write_congested = true;
 
-			pages[locked_pages++] = page;
-			pvec.pages[i] = NULL;
+			pages[locked_pages++] = &folio->page;
+			fbatch.folios[i] = NULL;
 
-			len += thp_size(page);
+			len += folio_size(folio);
 		}
 
 		/* did we get anything? */
 		if (!locked_pages)
-			goto release_pvec_pages;
+			goto release_folio_batches;
 		if (i) {
 			unsigned j, n = 0;
-			/* shift unused page to beginning of pvec */
-			for (j = 0; j < pvec_pages; j++) {
-				if (!pvec.pages[j])
+			/* shift unused folio to the beginning of fbatch */
+			for (j = 0; j < nr_folios; j++) {
+				if (!fbatch.folios[j])
 					continue;
 				if (n < j)
-					pvec.pages[n] = pvec.pages[j];
+					fbatch.folios[n] = fbatch.folios[j];
 				n++;
 			}
-			pvec.nr = n;
-
-			if (pvec_pages && i == pvec_pages &&
+			fbatch.nr = n;
+			if (nr_folios && i == nr_folios &&
 			    locked_pages < max_pages) {
-				dout("reached end pvec, trying for more\n");
-				pagevec_release(&pvec);
+				dout("reached end of fbatch, trying for more\n");
+				folio_batch_release(&fbatch);
 				goto get_more_pages;
 			}
 		}
@@ -1056,7 +1055,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			BUG_ON(IS_ERR(req));
 		}
 		BUG_ON(len < page_offset(pages[locked_pages - 1]) +
-			     thp_size(page) - offset);
+			     folio_size(folio) - offset);
 
 		req->r_callback = writepages_finish;
 		req->r_inode = inode;
@@ -1098,7 +1097,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			set_page_writeback(pages[i]);
 			if (caching)
 				ceph_set_page_fscache(pages[i]);
-			len += thp_size(page);
+			len += folio_size(folio);
 		}
 		ceph_fscache_write_to_cache(inode, offset, len, caching);
 
@@ -1108,7 +1107,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			/* writepages_finish() clears writeback pages
 			 * according to the data length, so make sure
 			 * data length covers all locked pages */
-			u64 min_len = len + 1 - thp_size(page);
+			u64 min_len = len + 1 - folio_size(folio);
 			len = get_writepages_data_length(inode, pages[i - 1],
 							 offset);
 			len = max(len, min_len);
@@ -1164,10 +1163,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
 			done = true;
 
-release_pvec_pages:
-		dout("pagevec_release on %d pages (%p)\n", (int)pvec.nr,
-		     pvec.nr ? pvec.pages[0] : NULL);
-		pagevec_release(&pvec);
+release_folio_batches:
+		dout("folio_batch_release on %d batches (%p)", (int) fbatch.nr,
+				fbatch.nr ? fbatch.folios[0] : NULL);
+		folio_batch_release(&fbatch);
 	}
 
 	if (should_loop && !done) {
@@ -1180,19 +1179,22 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (wbc->sync_mode != WB_SYNC_NONE &&
 		    start_index == 0 && /* all dirty pages were checked */
 		    !ceph_wbc.head_snapc) {
-			struct page *page;
+			struct folio *folio;
 			unsigned i, nr;
 			index = 0;
 			while ((index <= end) &&
-			       (nr = pagevec_lookup_tag(&pvec, mapping, &index,
-						PAGECACHE_TAG_WRITEBACK))) {
+				(nr = filemap_get_folios_tag(mapping, &index,
+						(pgoff_t)-1,
+						PAGECACHE_TAG_WRITEBACK,
+						&fbatch))) {
 				for (i = 0; i < nr; i++) {
-					page = pvec.pages[i];
-					if (page_snap_context(page) != snapc)
+					folio = fbatch.folios[i];
+					if (page_snap_context(&folio->page) !=
+							snapc)
 						continue;
-					wait_on_page_writeback(page);
+					folio_wait_writeback(folio);
 				}
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				cond_resched();
 			}
 		}
-- 
2.36.1

