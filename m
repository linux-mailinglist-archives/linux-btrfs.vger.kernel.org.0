Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B072A46A0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgKCNcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:46022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgKCNcs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReCnin450+o8Y1L+TErRvh3LWhDgG9HrvPVoYKSx8Qc=;
        b=YBOzUGAdWcbedHdYC/RQQe7zkeZbVx0Gusgbxs/Bm9CPh0ZW4nq04QBRGNg+H2+zPL4ScS
        XIgmr3xSNr9BFml4KbYLQWQHW7qmLkCMeoRwxKDqtn2fgt6yWtgCPTXNb2wCyM6U7UcMDX
        D3/oZMgrlxR4+3rV2YibSbr3OHBPTaU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34BA4AFB0
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 32/32] btrfs: scrub: support subpage data scrub
Date:   Tue,  3 Nov 2020 21:31:08 +0800
Message-Id: <20201103133108.148112-33-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
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
index deee5c9bd442..d1cbea7a6db0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1822,15 +1822,19 @@ static int scrub_checksum_data(struct scrub_block *sblock)
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
 
 	if (memcmp(csum, spage->csums, sctx->fs_info->csum_size))
 		sblock->checksum_error = 1;
-
 	return sblock->checksum_error;
 }
 
-- 
2.29.2

