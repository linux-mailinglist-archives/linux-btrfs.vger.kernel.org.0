Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C14298743
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 08:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770942AbgJZHLn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 03:11:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:51400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770928AbgJZHLm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 03:11:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603696300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eN1LW7f+PaO+xk5GpELYs3XmQV4VoqvhUKFHIr+JJEQ=;
        b=hxARkBtyUftjHVYkYpudErJQPXWQ8E5AhQqajAN/H2YmnoYPR2TVQAXO1a6iiaQ7Py+w9A
        ginBYzjPyKEmeesnLXKW3axaRkT5Y31LE8vE+sAaSutpEB+116gOvlXGL4DXKhn0BgdMAZ
        YmsNdz1gtARb9Zow1zW6l85FBWOdP50=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36252ACA3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:11:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: scrub: support subpage data scrub
Date:   Mon, 26 Oct 2020 15:11:15 +0800
Message-Id: <20201026071115.57225-9-wqu@suse.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026071115.57225-1-wqu@suse.com>
References: <20201026071115.57225-1-wqu@suse.com>
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
 fs/btrfs/scrub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 13355cc2b1ae..55a357e9416e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1824,15 +1824,19 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	if (!spage->have_csum)
 		return 0;
 
+	/*
+	 * In scrub_pages() and scrub_pages_for_parity() we ensure
+	 * each spage only contains just one sector of data.
+	 */
+	ASSERT(spage->page_len == sctx->fs_info->sectorsize);
 	kaddr = page_address(spage->page);
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
-	crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
+	crypto_shash_digest(shash, kaddr, spage->page_len, csum);
 
 	if (memcmp(csum, spage->csums, sctx->csum_size))
 		sblock->checksum_error = 1;
-
 	return sblock->checksum_error;
 }
 
-- 
2.29.0

