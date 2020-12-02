Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1F92CB54C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbgLBGuC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:50:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:53520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387531AbgLBGuB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:50:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tmBF4FvB7n9EWQf/JKg3aO2YROU0a0ills3tduD1rQ=;
        b=t48WSRCttvncf1QhhN3yCAkBs1wl+oWaeiyk884phTJQn/FKBYXFvPCUloe9cmDltC6izn
        R5X+sThqBkaiskvfaAL3eWcKcVQfBOu5vwPaSXG5bEKNuKmYFcZ8weWjE7pPGlYSpGCui4
        YdZHId32Xi996he9zUu4ANNcfQpbOII=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEFC6AEF5
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 06:48:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 14/15] btrfs: scrub: support subpage data scrub
Date:   Wed,  2 Dec 2020 14:48:10 +0800
Message-Id: <20201202064811.100688-15-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs scrub is in fact much more flex than buffered data write path, as
we can read an unaligned subpage data into page offset 0.

This ability makes subpage support much easier, we just need to check
each scrub_page::page_len and ensure we only calculate hash for [0,
page_len) of a page, and call it a day for subpage scrub support.

There is a small thing to notice, for subpage case, we still do sector
by sector scrub.
This means we will submit a read bio for each sector to scrub, resulting
the same amount of read bios, just like the 4K page systems.

This behavior can be considered as a good thing, if we want everything
to be the same as 4K page systems.
But this also means, we're wasting the ability to submit larger bio
using 64K page size.
This is another problem to consider in the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a4d30106bacb..8a43e8cb10a6 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1795,11 +1795,15 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
-	crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
 
-	if (memcmp(csum, spage->csum, sctx->fs_info->csum_size))
-		sblock->checksum_error = 1;
+	/*
+	 * In scrub_pages() and scrub_pages_for_parity() we ensure
+	 * each spage only contains just one sector of data.
+	 */
+	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
 
+	if (memcmp(csum, spage->csum, fs_info->csum_size))
+		sblock->checksum_error = 1;
 	return sblock->checksum_error;
 }
 
-- 
2.29.2

