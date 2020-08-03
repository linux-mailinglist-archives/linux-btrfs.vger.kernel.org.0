Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E310D239FFD
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 09:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgHCHGh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 03:06:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgHCHGg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 03:06:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE006AD68
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Aug 2020 07:06:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: volumes: check stripe end against device boundary
Date:   Mon,  3 Aug 2020 15:06:30 +0800
Message-Id: <20200803070630.33234-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a report of kernel generationg READ bio access beyond device
boundary.

To make sure it's not caused by on-disk chunk items, add extra stripe
check against device total_bytes so that btrfs check can detect such
problem early on.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 volumes.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/volumes.c b/volumes.c
index 538f799e7211..0467dd63d5cb 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1843,6 +1843,7 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 	u64 type;
 	u32 chunk_ondisk_size;
 	u32 sectorsize = fs_info->sectorsize;
+	int i;
 
 	/*
 	 * Basic chunk item size check.  Note that btrfs_chunk already contains
@@ -1953,6 +1954,34 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 		return -EIO;
 	}
 
+	/*
+	 * Stripe check against device boundary
+	 */
+	for (i = 0; i < num_stripes; i++) {
+		struct btrfs_device *dev;
+		u64 physical;
+		u64 devid;
+		u64 stripe_len;
+
+		devid = btrfs_stripe_devid_nr(leaf, chunk, i);
+		physical = btrfs_stripe_offset_nr(leaf, chunk, i);
+		stripe_len = calc_stripe_length(type, length, num_stripes);
+		dev = btrfs_find_device(fs_info, devid, NULL, NULL);
+		/*
+		 * Device not found? Then we may be in the bootstrap process for
+		 * system chunks. Skip.
+		 */
+		if (!dev)
+			continue;
+		if (physical + stripe_len > dev->total_bytes) {
+			error(
+"chunk %llu stripe %d is beyond device boundary: devid %llu total_bytes %llu stripe start %llu len %llu",
+				logical, i, devid, dev->total_bytes, physical,
+				stripe_len);
+			return -EUCLEAN;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.28.0

