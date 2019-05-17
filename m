Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8242321673
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfEQJml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729019AbfEQJmk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 571A5AECD
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F06F6DA871; Fri, 17 May 2019 11:43:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 12/15] btrfs: factor out devs_max setting in __btrfs_alloc_chunk
Date:   Fri, 17 May 2019 11:43:38 +0200
Message-Id: <c81578fdd1de6c8967752724ea3a4a176911a703.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Merge the repeated code before the if-else block.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3464bf1f0c48..9ee35fe9ee0f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4956,6 +4956,8 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	sub_stripes = btrfs_raid_array[index].sub_stripes;
 	dev_stripes = btrfs_raid_array[index].dev_stripes;
 	devs_max = btrfs_raid_array[index].devs_max;
+	if (!devs_max)
+		devs_max = BTRFS_MAX_DEVS(info);
 	devs_min = btrfs_raid_array[index].devs_min;
 	devs_increment = btrfs_raid_array[index].devs_increment;
 	ncopies = btrfs_raid_array[index].ncopies;
@@ -4964,8 +4966,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	if (type & BTRFS_BLOCK_GROUP_DATA) {
 		max_stripe_size = SZ_1G;
 		max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
-		if (!devs_max)
-			devs_max = BTRFS_MAX_DEVS(info);
 	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
 		/* for larger filesystems, use larger metadata chunks */
 		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
@@ -4973,13 +4973,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		else
 			max_stripe_size = SZ_256M;
 		max_chunk_size = max_stripe_size;
-		if (!devs_max)
-			devs_max = BTRFS_MAX_DEVS(info);
 	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
 		max_stripe_size = SZ_32M;
 		max_chunk_size = 2 * max_stripe_size;
-		if (!devs_max)
-			devs_max = BTRFS_MAX_DEVS_SYS_CHUNK;
 	} else {
 		btrfs_err(info, "invalid chunk type 0x%llx requested",
 		       type);
-- 
2.21.0

