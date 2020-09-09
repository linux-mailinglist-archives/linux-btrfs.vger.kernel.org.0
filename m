Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C84262C74
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgIIJtd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 05:49:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbgIIJtU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 05:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 238BDB160;
        Wed,  9 Sep 2020 09:49:20 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 03/10] btrfs: Simplify metadata pages reading
Date:   Wed,  9 Sep 2020 12:49:07 +0300
Message-Id: <20200909094914.29721-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909094914.29721-1-nborisov@suse.com>
References: <20200909094914.29721-1-nborisov@suse.com>
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
 fs/btrfs/extent_io.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ac92c0ab1402..1789a7931312 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5575,20 +5575,14 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
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
 				ret = err;
-				/*
-				 * We use &bio in above __extent_read_full_page,
-				 * so we ensure that if it returns error, the
-				 * current page fails to add itself to bio and
-				 * it's been unlocked.
-				 *
-				 * We must dec io_pages by ourselves.
-				 */
+				SetPageError(page);
+				unlock_page(page);
 				atomic_dec(&eb->io_pages);
 			}
 		} else {
-- 
2.17.1

