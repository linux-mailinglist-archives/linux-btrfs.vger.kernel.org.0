Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0D5153C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380016AbiD2SfE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380022AbiD2SfD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:35:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF56D1AF
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:31:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3D72721877;
        Fri, 29 Apr 2022 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651257103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YUFaK2uGIlxILKr34UmM/FPe/HrlvYVR3Or433KBF0=;
        b=dtXF/beVewNq96c0aVRtcEyXegBPXl7II2uBZcaj0yF9bMJWLxKb9gBrgP+EJ1Vkuul+wh
        V+pzndURMTpgxSJnEiGqPO+02bU/aqIgvE+6vspruOHe1C5Eo9YRpT87OFrT58LhgEJCmo
        6KY2XdkZnkw6GH7PAxnKq51pz42eJQE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 356E02C141;
        Fri, 29 Apr 2022 18:31:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 92DA8DA7DE; Fri, 29 Apr 2022 20:27:35 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/9] btrfs: remove trivial helper update_nr_written
Date:   Fri, 29 Apr 2022 20:27:35 +0200
Message-Id: <fea480c17b89b32fe9ed21739d568750abe4674f.1651255990.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651255990.git.dsterba@suse.com>
References: <cover.1651255990.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper used to do more with the wbc state but now it's just one
subtraction, no need to have a special helper.

It became trivial in a91326679f2a ("Btrfs: make mapping->writeback_index
point to the last written page").

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f9d6dd310c42..15d27cc21750 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3839,12 +3839,6 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 	}
 }
 
-static void update_nr_written(struct writeback_control *wbc,
-			      unsigned long nr_written)
-{
-	wbc->nr_to_write -= nr_written;
-}
-
 /*
  * helper for __extent_writepage, doing all of the delayed allocation setup.
  *
@@ -4007,7 +4001,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	 * we don't want to touch the inode after unlocking the page,
 	 * so we update the mapping writeback index now
 	 */
-	update_nr_written(wbc, 1);
+	wbc->nr_to_write--;
 
 	while (cur <= end) {
 		u64 disk_bytenr;
@@ -4620,7 +4614,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
 	 */
 	if (no_dirty_ebs)
-		update_nr_written(wbc, 1);
+		wbc->nr_to_write--;
 	return ret;
 }
 
@@ -4656,7 +4650,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 			break;
 		}
 		disk_bytenr += PAGE_SIZE;
-		update_nr_written(wbc, 1);
+		wbc->nr_to_write--;
 		unlock_page(p);
 	}
 
-- 
2.34.1

