Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20EB49C060
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 01:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiAZA7M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 19:59:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51898 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiAZA7L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 19:59:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EEE4212BF
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 00:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643158750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Ifyv1QTiH2Zq9NR3agYP5g9yenhn5YlZ9Y5XogNio4=;
        b=nIYVZdYGy9lxFmm0nDdmTJj8OZjS/cCyt9yD8S6x5Vjyd3xbWa3JVbQPXKcRy9hpngarut
        Na5hDuczwQx1UPrf4UlHNAZCMmmm6tcHhatUJskp7LqNCmi/0ra83CCiK9DsP605CA2pGN
        2VZr/orYgrLa1gJItf5sKfGP9h4Qibg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71094133F5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 00:59:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qBfcDt2c8GH7BwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 00:59:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: defrag: use extent_thresh to replace the hardcoded size limit
Date:   Wed, 26 Jan 2022 08:58:49 +0800
Message-Id: <20220126005850.14729-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126005850.14729-1-wqu@suse.com>
References: <20220126005850.14729-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In defrag_lookup_extent() we use hardcoded extent size threshold, SZ_128K,
other than @extent_thresh in btrfs_defrag_file().

This can lead to some inconsistent behavior, especially the default
extent size threshold is 256K.

Fix this by passing @extent_thresh into defrag_check_next_extent() and
use that value.

Also, since the extent_thresh check should be applied to all extents,
not only physically adjacent extents, move the threshold check into a
dedicate if ().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0d8bfc716e6b..2911df12fc48 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1050,7 +1050,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 }
 
 static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
-				     bool locked)
+				     u32 extent_thresh, bool locked)
 {
 	struct extent_map *next;
 	bool ret = false;
@@ -1066,9 +1066,11 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	/* Preallocated */
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 		goto out;
-	/* Physically adjacent and large enough */
-	if ((em->block_start + em->block_len == next->block_start) &&
-	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
+	/* Extent is already large enough */
+	if (next->len >= extent_thresh)
+		goto out;
+	/* Physically adjacent */
+	if ((em->block_start + em->block_len == next->block_start))
 		goto out;
 	ret = true;
 out:
@@ -1231,7 +1233,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			goto next;
 
 		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
-							  locked);
+							  extent_thresh, locked);
 		if (!next_mergeable) {
 			struct defrag_target_range *last;
 
-- 
2.34.1

