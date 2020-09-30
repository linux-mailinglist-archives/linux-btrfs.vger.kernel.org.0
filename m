Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE88A27DE17
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgI3B4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:50664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729917AbgI3B4u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nATJwzB7HNMv3p8xpmRB7SDjAV7YkGig36/MnT0PnCc=;
        b=AJ0OIRfAMiBOcY+giO0pWLBvrv9mgy0AcsiFt+xjEFNpN8Ha4YVFPxwfGfG5/18ieN+Im7
        h0Lb+rCxPk/GPglgbR6RQRnSzqmDCs3Wyu1Zey0gWtOoqPofNYS1EgwT3jSiXBOVe0EdBT
        1cDo6Paas12bSFDLnk191qPwvOuSqjY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE42BAFAB
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 30/49] btrfs: disk-io: only clear EXTENT_LOCK bit for extent_invalidatepage()
Date:   Wed, 30 Sep 2020 09:55:20 +0800
Message-Id: <20200930015539.48867-31-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
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

