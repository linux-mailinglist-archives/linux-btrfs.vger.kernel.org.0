Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222AB3A58D5
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhFMNnN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhFMNnM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:12 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20ABC21970;
        Sun, 13 Jun 2021 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nFwya3HpVdIReFAFEOI0CgYeJmvPV3+ZZPtBBolb3c=;
        b=cSPbNqQTU4O1aKBQU2C2TtIdGYl8h6VcPvw8BxiJH6LOJdLwLeJtx4el3reYkGgmhmPmlZ
        JIS+gYPrUHVtuOItBcibqhn+ebR+f+pX1QfQ38XN2s49Scrpy4LakWlk5Xt6WRwQV3YVW5
        FFOQMFpHmtbmfCj8lXu8s/1zg2EIrHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nFwya3HpVdIReFAFEOI0CgYeJmvPV3+ZZPtBBolb3c=;
        b=2CXsLoq7m8sP73Yb41QUd9/3cbcUk0YwuN27eJxBUZz9zC8YLE87egQdvHU+HqUH/NEOF+
        MKQ1MLhauoqJaOAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B8DEA118DD;
        Sun, 13 Jun 2021 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nFwya3HpVdIReFAFEOI0CgYeJmvPV3+ZZPtBBolb3c=;
        b=cSPbNqQTU4O1aKBQU2C2TtIdGYl8h6VcPvw8BxiJH6LOJdLwLeJtx4el3reYkGgmhmPmlZ
        JIS+gYPrUHVtuOItBcibqhn+ebR+f+pX1QfQ38XN2s49Scrpy4LakWlk5Xt6WRwQV3YVW5
        FFOQMFpHmtbmfCj8lXu8s/1zg2EIrHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nFwya3HpVdIReFAFEOI0CgYeJmvPV3+ZZPtBBolb3c=;
        b=2CXsLoq7m8sP73Yb41QUd9/3cbcUk0YwuN27eJxBUZz9zC8YLE87egQdvHU+HqUH/NEOF+
        MKQ1MLhauoqJaOAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id YbfHIfYKxmCgJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:41:10 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 26/31] btrfs: use srcmap for read-before-write cases
Date:   Sun, 13 Jun 2021 08:39:54 -0500
Message-Id: <9d48e1e7fce37455cb6e1a39ae2f2427ae13cebe.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

srcmap supplies the iomap structure to read from in case the write is
not aligned to blocksize boundaries.

Note, range is already locked, so no extent locking is required.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b3e48bfd75df..b10252d93462 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -64,6 +64,9 @@ struct btrfs_iomap {
 	struct extent_state *cached_state;
 	int extents_locked;
 
+	/* Source extent-map in order to read from in case not sector aligned */
+	struct extent_map *em;
+
 	/* Reservation */
 	bool metadata_only;
 	struct extent_changeset *data_reserved;
@@ -1479,6 +1482,7 @@ static void btrfs_iomap_release(struct inode *inode,
 		}
 	}
 	extent_changeset_free(bi->data_reserved);
+	free_extent_map(bi->em);
 	kfree(bi);
 }
 
@@ -1491,11 +1495,37 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	size_t sector_offset = pos & (fs_info->sectorsize - 1);
 	struct btrfs_iomap *bi;
+	loff_t end = pos + length;
 
 	bi = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);
 	if (!bi)
 		return -ENOMEM;
 
+	if ((pos & (PAGE_SIZE - 1) || end & (PAGE_SIZE - 1))) {
+		loff_t isize = i_size_read(inode);
+
+		if (pos >= isize) {
+			srcmap->addr = IOMAP_NULL_ADDR;
+			srcmap->type = IOMAP_HOLE;
+			srcmap->offset = isize;
+			srcmap->length = end - isize;
+		} else {
+			bi->em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
+					pos - sector_offset, length);
+			if (IS_ERR(bi->em)) {
+				kfree(bi);
+				return PTR_ERR(bi->em);
+			}
+			btrfs_em_to_iomap(inode, bi->em, srcmap,
+					pos - sector_offset);
+		}
+	}
+
+	if ((srcmap->type != IOMAP_HOLE) &&
+	    (end > srcmap->offset + srcmap->length))
+			write_bytes = srcmap->offset + srcmap->length - pos;
+
+
 	ret = btrfs_check_data_free_space(BTRFS_I(inode),
 			&bi->data_reserved, pos, write_bytes);
 	if (ret < 0) {
-- 
2.31.1

