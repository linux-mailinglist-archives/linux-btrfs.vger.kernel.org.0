Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4743F49C061
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 01:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiAZA7N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 19:59:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45420 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiAZA7M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 19:59:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3005D1F396
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 00:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643158751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3HbIc1QZlwcEPP/zpbKdgUv8acVnfzPD3G/e3dSIvY=;
        b=F/4sIoyrhvYdUfpVIXKjGAvvkYsHwFnQMqSMA0HU6P3BcbCxd1XJvtA8bBKVFKjopQMLIy
        MT/nGFxVDpj/jijy+BRmFQX2yCd+4e/NFO0QgbxjaG6KRyU/D29JJG8IBCJU27cOcDNzlw
        oqp719jY7FHDkr0hmsuiwfIwr2MZcWg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8264E133F5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 00:59:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +LgdE96c8GH7BwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 00:59:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: defrag: remove the physical adjacent extents rejection in defrag_check_next_extent()
Date:   Wed, 26 Jan 2022 08:58:50 +0800
Message-Id: <20220126005850.14729-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126005850.14729-1-wqu@suse.com>
References: <20220126005850.14729-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a rejection for physically adjacent extents in
defrag_check_next_extent() from the very beginning.

The check will reject physically adjacent extents which are also large
enough.

The extent size threshold check is now a generic check, and the
benefit of rejecting physically adjacent extents is unsure.

Sure physically adjacent extents means no extra seek time, thus
defragging them may not bring much help.

On the other hand, btrfs also benefits from reduced number of extents
(which can reduce the size of extent tree, thus reduce the mount time).

So such rejection is not a full win.

Remove such check, and policy on which extents should be defragged is
mostly on @extent_thresh and @newer_than parameters.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2911df12fc48..0929d08bb378 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1069,9 +1069,6 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	/* Extent is already large enough */
 	if (next->len >= extent_thresh)
 		goto out;
-	/* Physically adjacent */
-	if ((em->block_start + em->block_len == next->block_start))
-		goto out;
 	ret = true;
 out:
 	free_extent_map(next);
-- 
2.34.1

