Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5656729483B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440789AbgJUG1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:43792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440787AbgJUG1K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nATJwzB7HNMv3p8xpmRB7SDjAV7YkGig36/MnT0PnCc=;
        b=iOHHw0m2wiHaReFK+UOdRPq4lZD1vXcfptpo5IYPmmfg6cYPq8e0Ko6p8OGLcMc0ViEUaX
        X5ZQUXq2J0PRsIZiRcTH/tWwTrc5p1DXjcVvct4RCRwTrDtiT0s6KjcQVPLNkPmdMypmIk
        pL+PUCwyTkMILlaH2933GqU8IYIRBoc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D118AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 32/68] btrfs: disk-io: only clear EXTENT_LOCK bit for extent_invalidatepage()
Date:   Wed, 21 Oct 2020 14:25:18 +0800
Message-Id: <20201021062554.68132-33-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In extent_invalidatepage() it will try to clear all possible bits since
it's calling clear_extent_bit() with delete == 1.
That would try to clear all existing bits.

This is currently fine, since for btree io tree, it only utilizes
EXTENT_LOCK bit.
But this could be a problem for later subpage support, which will
utilize extra io tree bit to represent extra info.

This patch will just convert that clear_extent_bit() to
unlock_extent_cached().

As for btree io tree, only EXTENT_LOCKED bit is utilized, this doesn't
change the behavior, but provides a much cleaner basis for incoming
subpage support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1ca121ca28aa..10bdb0a8a92f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -996,8 +996,13 @@ static void extent_invalidatepage(struct extent_io_tree *tree,
 
 	lock_extent_bits(tree, start, end, &cached_state);
 	wait_on_page_writeback(page);
-	clear_extent_bit(tree, start, end, EXTENT_LOCKED | EXTENT_DELALLOC |
-			 EXTENT_DO_ACCOUNTING, 1, 1, &cached_state);
+
+	/*
+	 * Currently for btree io tree, only EXTENT_LOCKED is utilized,
+	 * so here we only need to unlock the extent range to free any
+	 * existing extent state.
+	 */
+	unlock_extent_cached(tree, start, end, &cached_state);
 }
 
 static void btree_invalidatepage(struct page *page, unsigned int offset,
-- 
2.28.0

