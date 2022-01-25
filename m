Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537D049ACC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 07:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385497AbiAYGyl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 01:54:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58996 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376770AbiAYGvT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 01:51:19 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE8FB210F6
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 06:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643093477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOWzFbcS/vnp8RV51T+2kqawjqkGCr98vZUM6lAZEeY=;
        b=l1KxFxyEM5o4m7il4uv7c4Llsvt0IWoOLS8rVisJwbvxRUg2SVM9Wom/2O4A7iLGteAR40
        Ss2hx2b37wFjK0dJIGmUps3t24DRdq8wXOYOKcOetVyMZ0+1muX3l6VyYgOLKrcvTOEke4
        3aVU8/8IARYL3iB5625ztCBDoP3Usco=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37DFD13BAA
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 06:51:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yL3IAeWd72H5AQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 06:51:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [POC for v5.15 2/2] btrfs: defrag: limit cluster size to the first hole/prealloc range
Date:   Tue, 25 Jan 2022 14:50:57 +0800
Message-Id: <20220125065057.35863-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125065057.35863-1-wqu@suse.com>
References: <20220125065057.35863-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We always use 256K as cluster size if possible, but it's very common
that there are only several small regular extents which are target for
defrag.

But those extents are not filling the whole 256K cluster, and the holes
after those extents will make defrag to reject the whole cluster.

This patch will mitigate the problem by doing another search for the
hole/preallocated range, and limit the size of the cluster just to the
regular extents part.

By this, defrag can do more of its work without being interrupted by a
hole.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8350864a4bd8..b66bb10e2e4a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1481,6 +1481,29 @@ static int cluster_pages_for_defrag(struct inode *inode,
 
 }
 
+static u64 get_cluster_size(struct inode *inode, u64 start, u64 len)
+{
+	u64 cur = start;
+	u64 cluster_len = 0;
+	while (cur < start + len) {
+		struct extent_map *em;
+
+		em = defrag_lookup_extent(inode, cur, false);
+		if (!em)
+			break;
+		/*
+		 * Here we don't do comprehensive checks, we just
+		 * find the first hole/preallocated.
+		 */
+		if (em->block_start >= EXTENT_MAP_LAST_BYTE ||
+		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
+			break;
+		cluster_len += min(em->start + em->len - cur, start + len - cur);
+		cur = min(em->start + em->len, start + len);
+	}
+	return cluster_len;
+}
+
 /*
  * Entry point to file defragmentation.
  *
@@ -1618,6 +1641,13 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		} else {
 			cluster = max_cluster;
 		}
+		cluster = min_t(unsigned long,
+				get_cluster_size(inode, i << PAGE_SHIFT,
+						 cluster << PAGE_SHIFT)
+					>> PAGE_SHIFT,
+			        cluster);
+		if (cluster == 0)
+			goto next;
 
 		if (i + cluster > ra_index) {
 			ra_index = max(i, ra_index);
@@ -1644,6 +1674,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		balance_dirty_pages_ratelimited(inode->i_mapping);
 		btrfs_inode_unlock(inode, 0);
 
+next:
 		if (newer_than) {
 			if (newer_off == (u64)-1)
 				break;
-- 
2.34.1

