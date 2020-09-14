Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7875B268895
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgINJhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 05:37:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:41188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgINJhR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 05:37:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 670E9AE85;
        Mon, 14 Sep 2020 09:37:31 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/9] btrfs: Simplify metadata pages reading
Date:   Mon, 14 Sep 2020 12:37:04 +0300
Message-Id: <20200914093711.13523-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093711.13523-1-nborisov@suse.com>
References: <20200914093711.13523-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Metadata pages currently use __do_readpage to read metadata pages,
unfortunately this function is also used to deal with ordinary data
pages. This makes the metadata pages reading code to go through multiple
hoops in order to adhere to __do_readpage invariants. Most of these are
necessary for data pages which could be compressed. For metadata it's
enough to simply build a bio and submit it.

To this effect simply call submit_extent_page directly from
read_extent_buffer_pages which is the only callpath used to populate
extent_buffers with data. This in turn enables further cleanups.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1e070ec7ad8..0a6cda4c30ed 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5573,20 +5573,19 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 			}
 
 			ClearPageError(page);
-			err = __extent_read_full_page(page,
-						      btree_get_extent, &bio,
-						      mirror_num, &bio_flags,
-						      REQ_META);
+			err = submit_extent_page(REQ_OP_READ | REQ_META, NULL,
+					 page, page_offset(page), PAGE_SIZE, 0,
+					 &bio, end_bio_extent_readpage,
+					 mirror_num, 0, 0, false);
 			if (err) {
-				ret = err;
 				/*
-				 * We use &bio in above __extent_read_full_page,
-				 * so we ensure that if it returns error, the
-				 * current page fails to add itself to bio and
-				 * it's been unlocked.
-				 *
-				 * We must dec io_pages by ourselves.
+				 * We failed to submit the bio so it's the
+				 * caller's responsibility to perform cleanup
+				 * i.e unlock page/set error bit.
 				 */
+				ret = err;
+				SetPageError(page);
+				unlock_page(page);
 				atomic_dec(&eb->io_pages);
 			}
 		} else {
-- 
2.17.1

