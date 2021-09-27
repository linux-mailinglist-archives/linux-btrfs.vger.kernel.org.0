Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A11418FE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhI0HY2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhI0HYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E60620090
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XR9ToOeyrTYvFVeFqbu0m0in+uld5+AOMucN/FkITsU=;
        b=uRciCDqZoOJYRWF9Gv+WSJtizHLQZOVT1i/o46BkdAYEe5rjZwwDEgoH6SaYPq9kfaIdZx
        Etq7SWfSEuikP6gHOj5ADbkfdcmEqWIJq7q1FUP8uY432mcfsLdG/+Yk+Yd6Ak3QJ6RdED
        BaFY7UyIuUmhk117cNzWe1U9QASVXL8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C65A013A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +G9VJERxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 18/26] btrfs: make btrfs_submit_compressed_write() to be subpage compatible
Date:   Mon, 27 Sep 2021 15:22:00 +0800
Message-Id: <20210927072208.21634-19-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a WARN_ON() checking if @start is aligned to PAGE_SIZE, not
sectorsize, which will cause false alert for subpage.

Fix it to check against sectorsize.

Furthermore:

- Use ASSERT() to do the check
  So that in the future we may skip the check for production build

- Also check alignment for @len

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 61738c5beeac..9a87f949a036 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -505,7 +505,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
 	const unsigned int bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
 
-	WARN_ON(!PAGE_ALIGNED(start));
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
+	       IS_ALIGNED(len, fs_info->sectorsize));
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
 	if (!cb)
 		return BLK_STS_RESOURCE;
-- 
2.33.0

