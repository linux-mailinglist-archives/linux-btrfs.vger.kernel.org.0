Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231D73DD0D4
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhHBGzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 02:55:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37038 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhHBGzD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Aug 2021 02:55:03 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4CC561FF2D
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Aug 2021 06:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627887293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQuiN15iyQXxgwE2CGj+tEnb8nIn3lPQH6veFLumHR8=;
        b=EiC2rqH+FGJrPnyZK0fuht0HDyVzefnbbMgIJtxDnJTeAlfz0zwWoMX5PGYyTzZT/6B1LC
        L9J0BiFJvL11mZa5YZAnn2TaM+Z+iktOnjRxiZ9DLV4SVr0wdxpgpLBWOVNethJynDf9Rq
        8fBlLvauNi0CmsIMYxWppIjrRTAU6wI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8694F1371C
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Aug 2021 06:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0A54EryWB2FtawAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Aug 2021 06:54:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with proper error handling
Date:   Mon,  2 Aug 2021 14:54:47 +0800
Message-Id: <20210802065447.178726-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802065447.178726-1-wqu@suse.com>
References: <20210802065447.178726-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The BUG_ON() in btrfs_csum_one_bio() means we're trying to submit a bio
while we don't have ordered extent for it at all.

Normally this won't happen and is indeed a code logical error.

But previous fix has already shown another possibility that, some call
sites don't handle error properly and submit the write bio after its
ordered extent has already been cleaned up.

This patch will add an extra safe net by replacing the BUG_ON() to
proper error handling.

And even if some day we hit a regression that we're submitting bio
without an ordered extent, we will return error and the pages will be
marked Error, and being caught properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2673c6ba7a4e..25205b9dad69 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -665,7 +665,19 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 
 		if (!ordered) {
 			ordered = btrfs_lookup_ordered_extent(inode, offset);
-			BUG_ON(!ordered); /* Logic error */
+			/*
+			 * No ordered extent mostly means the OE has been
+			 * removed (mostly for error handling). Normally for
+			 * such case we should not flush_write_bio(), but
+			 * end_write_bio().
+			 *
+			 * But an extra safe net will never hurt. Just error
+			 * out.
+			 */
+			if (unlikely(!ordered)) {
+				kvfree(sums);
+				return BLK_STS_IOERR;
+			}
 		}
 
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
-- 
2.32.0

