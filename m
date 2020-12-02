Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF592CB546
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbgLBGtx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:49:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:53486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgLBGtx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:49:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGd++jE3b60PgZRvV2KRonRU8+aZziCu6mgAkgyGAWc=;
        b=MvuAg64HPuXudcnij3aYhc5h6S9zM/C1ryI+zS9KUBQwqdxMQY8eDJaAjmLSO+HpUr2VUo
        WWH1mfD9QjmrUNHjGHb0/y8BXIQr/M5uG5sQCs122il0TKMC7P3vRlbHVSR7LmAe0TpPNy
        BB4aoBgohDhboDaLbYt+dDYezIJ2J5c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67010AECD;
        Wed,  2 Dec 2020 06:48:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 07/15] btrfs: extent_io: update num_extent_pages() to support subpage sized extent buffer
Date:   Wed,  2 Dec 2020 14:48:03 +0800
Message-Id: <20201202064811.100688-8-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage sized extent buffer, we have ensured no extent buffer will
cross page boundary, thus we would only need one page for any extent
buffer.

This patch will update the function num_extent_pages() to handle such
case.
Now num_extent_pages() would return 1 instead of for subpage sized
extent buffer.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 02b4786478b6..811f44d82c7c 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -203,8 +203,14 @@ void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
 
 static inline int num_extent_pages(const struct extent_buffer *eb)
 {
-	return (round_up(eb->start + eb->len, PAGE_SIZE) >> PAGE_SHIFT) -
-	       (eb->start >> PAGE_SHIFT);
+	/*
+	 * For sectorsize == PAGE_SIZE case, since nodesize is always aligned to
+	 * sectorsize, it's just eb->len >> PAGE_SHIFT.
+	 *
+	 * For sectorsize < PAGE_SIZE case, we could have nodesize < PAGE_SIZE,
+	 * thus have to ensure we get at least one page.
+	 */
+	return eb->len >> PAGE_SHIFT ?: 1;
 }
 
 static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
-- 
2.29.2

