Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F10A304676
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 19:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbhAZRXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:23:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:54326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390250AbhAZIfD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:35:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvgJRhDoI2g8+R39LA5UBDJg4jz8Blq9Uvk5XYgzQD8=;
        b=U/y2hxtNEHEpPf7JGSoSuygn2p0oFryDKFG/xR1A6dA+MyP6AJ4uqPcF0eyJo6abqsKpCh
        LeB6Q6/XOnjKIU2v5pc9OW4cag2gL01zrStozGvT+pqxLHD9UdCXp8v9mjZqHpc7xNY0s9
        AvY5PnXwk79XRNS7Kj7/t9cVQK9KvdQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C47FAAF2B
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 08:34:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 02/18] btrfs: set UNMAPPED bit early in btrfs_clone_extent_buffer() for subpage support
Date:   Tue, 26 Jan 2021 16:33:46 +0800
Message-Id: <20210126083402.142577-3-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the incoming subpage support, UNMAPPED extent buffer will have
different behavior in btrfs_release_extent_buffer().

This means we need to set UNMAPPED bit early before calling
btrfs_release_extent_buffer().

Currently there is only one caller which relies on
btrfs_release_extent_buffer() in its error path while set UNMAPPED bit
late:
- btrfs_clone_extent_buffer()

Make it subpage compatible by setting the UNMAPPED bit early, since
we're here, also move the UPTODATE bit early.

There is another caller, __alloc_dummy_extent_buffer(), setting UNAMPPED
bit late, but that function clean up the allocated page manually, thus
no need for any modification.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6cd81c6e8996..a56391839aca 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5062,6 +5062,13 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	if (new == NULL)
 		return NULL;
 
+	/*
+	 * Set UNMAPPED bfore calling btrfs_release_extent_buffer(), as
+	 * btrfs_release_extent_buffer() have different behavior for
+	 * UNMAPPED subpage extent buffer.
+	 */
+	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
+
 	for (i = 0; i < num_pages; i++) {
 		p = alloc_page(GFP_NOFS);
 		if (!p) {
@@ -5074,9 +5081,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 		new->pages[i] = p;
 		copy_page(page_address(p), page_address(src->pages[i]));
 	}
-
 	set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
-	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
 	return new;
 }
-- 
2.30.0

