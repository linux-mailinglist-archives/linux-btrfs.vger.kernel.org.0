Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB293EE099
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 01:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhHPX4R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 19:56:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53232 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhHPX4Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 19:56:16 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE4A91FEFA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Aug 2021 23:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629158143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wcxRXq+dllcC0fnWwQiir1od3vxMuUPVIopSt4N4j94=;
        b=s0WzwC//KoWu2yXY5ei31ErvW0x94nqi3w0fGlV2V+LOnO5SeLUtg/e4/8ZwKQbADkVdzr
        WVp3zxVhjxTCYNTK7un95GM1gGPB4ddxgIkAMObDgkzTEqdFRcelAo1OEizUG+e+1kuVzc
        qk3ApGWBbLaxh+Sqb7x1aXVErHU5WFY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1A54013B95
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Aug 2021 23:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id N9aMMv76GmFcKAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Aug 2021 23:55:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with proper error handling
Date:   Tue, 17 Aug 2021 07:55:40 +0800
Message-Id: <20210816235540.9475-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a BUG_ON() in btrfs_csum_one_bio() to catch code logic error.

It has indeed caught several bugs during subpage development.

But the BUG_ON() itself will bring down the whole system which is
sometimes overkilled.

Replace it with a WARN() and exit gracefully, so that it won't crash the
whole system while we can still catch the code logic error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Re-send as an independent patch
- Add WARN() to catch the code logic error
---
 fs/btrfs/file-item.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2673c6ba7a4e..7f58d80a480f 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -665,7 +665,18 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 
 		if (!ordered) {
 			ordered = btrfs_lookup_ordered_extent(inode, offset);
-			BUG_ON(!ordered); /* Logic error */
+			/*
+			 * The bio range is not covered by any ordered extent,
+			 * must be a code logic error.
+			 */
+			if (unlikely(!ordered)) {
+				WARN(1, KERN_WARNING
+		"no ordered extent for root %llu ino %llu offset %llu\n",
+				     inode->root->root_key.objectid,
+				     btrfs_ino(inode), offset);
+				kvfree(sums);
+				return BLK_STS_IOERR;
+			}
 		}
 
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
-- 
2.32.0

