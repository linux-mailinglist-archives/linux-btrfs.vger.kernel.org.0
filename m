Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4D469040
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 06:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhLFF4q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 00:56:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56888 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbhLFF4p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 00:56:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99DE91FD59
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 05:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638769996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=P/5KzqFbcENZhib584FYei6qOd31boFSCxBej6adyMk=;
        b=R4dAHV8pHAGjD6giRrY1uzrn3cHM4yiAEMWryqhEMdQFURjXMLhACAm/LhLVCxj2lffPNV
        2bSBZJUJFxVl3uhF6fS8CEnxTNTMHJYBy3QX+a7t7R4tv1LvtnY+lUdqQ64/4Nz38VqfPE
        3PNuCvLIfA5v3xzZQB9kb8EkfQmcuz4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E29B113A08
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 05:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GaQSKkulrWG/XAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 05:53:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: update SCRUB_MAX_PAGES_PER_BLOCK
Date:   Mon,  6 Dec 2021 13:52:57 +0800
Message-Id: <20211206055258.49061-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use BTRFS_MAX_METADATA_BLOCKSIZE and SZ_4K (minimal sectorsize) to
calculate this value.

And remove one stale comment on the value, in fact with recent subpage
support, BTRFS_MAX_METADATA_BLOCKSIZE * PAGE_SIZE is already beyond
BTRFS_STRIPE_LEN, just we don't use the full page.

Also since we're here, update the BUG_ON() related to
SCRUB_MAX_PAGES_PER_BLOCK to ASSERT().

As those ASSERT() are really only for developers to catch early obvious
bugs, not to let end users suffer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 15a123e67108..0870d8db92cd 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -49,11 +49,10 @@ struct scrub_ctx;
 #define SCRUB_BIOS_PER_SCTX	64	/* 8MB per device in flight */
 
 /*
- * the following value times PAGE_SIZE needs to be large enough to match the
+ * The following value times PAGE_SIZE needs to be large enough to match the
  * largest node/leaf/sector size that shall be supported.
- * Values larger than BTRFS_STRIPE_LEN are not supported.
  */
-#define SCRUB_MAX_PAGES_PER_BLOCK	16	/* 64k per node/leaf/sector */
+#define SCRUB_MAX_PAGES_PER_BLOCK	(BTRFS_MAX_METADATA_BLOCKSIZE / SZ_4K)
 
 struct scrub_recover {
 	refcount_t		refs;
@@ -1313,7 +1312,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 		recover->bioc = bioc;
 		recover->map_length = mapped_length;
 
-		BUG_ON(page_index >= SCRUB_MAX_PAGES_PER_BLOCK);
+		ASSERT(page_index < SCRUB_MAX_PAGES_PER_BLOCK);
 
 		nmirrors = min(scrub_nr_raid_mirrors(bioc), BTRFS_MAX_MIRRORS);
 
@@ -2297,7 +2296,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		BUG_ON(index >= SCRUB_MAX_PAGES_PER_BLOCK);
+		ASSERT(index < SCRUB_MAX_PAGES_PER_BLOCK);
 		scrub_page_get(spage);
 		sblock->pagev[index] = spage;
 		spage->sblock = sblock;
@@ -2631,7 +2630,7 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		BUG_ON(index >= SCRUB_MAX_PAGES_PER_BLOCK);
+		ASSERT(index < SCRUB_MAX_PAGES_PER_BLOCK);
 		/* For scrub block */
 		scrub_page_get(spage);
 		sblock->pagev[index] = spage;
-- 
2.34.1

