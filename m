Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4605D3FA950
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhH2F0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:26:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45812 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhH2F0P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:26:15 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B61D020016
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKeLbzx48Ff/UHwCOf/9ZOq/1RL0f88Tc4YllAOU2Ec=;
        b=bdzX0GU8IdRRpFad6B+/WyBUK/bZM6w+snPV15BQ3BFEMrO6PRu8sv0sHzr+0KRbCnpCFc
        IQkjWSGz5T/gWoM6zRLv2HaFHnmvDmYbSVffDliq2NsqygNZLUzjPcQtdwBm7Kk6KBuf2W
        5D+QI3JKF9aR/m5uuPdIcpSAVj3QkYA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F30FF13964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UKbcLEIaK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 18/26] btrfs: make btrfs_submit_compressed_write() to be subpage compatible
Date:   Sun, 29 Aug 2021 13:24:50 +0800
Message-Id: <20210829052458.15454-19-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
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
index 6e389f1c6091..6bfa626bbd0b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -504,7 +504,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
 	const unsigned int bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
 
-	WARN_ON(!PAGE_ALIGNED(start));
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
+	       IS_ALIGNED(len, fs_info->sectorsize));
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
 	if (!cb)
 		return BLK_STS_RESOURCE;
-- 
2.32.0

