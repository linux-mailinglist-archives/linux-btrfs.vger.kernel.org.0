Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A173D5946
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhGZLhd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:37:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58022 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhGZLhb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:37:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BEA2A1FE78;
        Mon, 26 Jul 2021 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627301878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RDZHtGDBQpoMMlt165k/oTrcf7tr8eoUMEbtd1+6kg=;
        b=KGiXmVA7BrYSEHuuXA7z3cmB9U6tA+yVGUhRKnIkxQrwnB/wy3ied0iCNI7SnCyKROu2s7
        8K5jIDvd2WDcLXPPdNI9dfDx1bmVYYqplzbJWkVAUoIGUutvQAOruzCCTA4M87V0N/zBE3
        ahKm/kDhTYl9rxS0/caQbqL4EI4gGRo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B7984A3C0B;
        Mon, 26 Jul 2021 12:17:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 17EB9DA8D8; Mon, 26 Jul 2021 14:15:15 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 04/10] btrfs: tree-checker: use table values for stripe checks
Date:   Mon, 26 Jul 2021 14:15:15 +0200
Message-Id: <b7a7bb037ee8622784d94f39997d8ab1fbec892a.1627300614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627300614.git.dsterba@suse.com>
References: <cover.1627300614.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are hardcoded values in several checks regarding chunks and stripe
constraints. We have that defined in the raid table and ought to use it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-checker.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a8b2e0d2c025..ac9416cb4496 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -873,13 +873,18 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 		}
 	}
 
-	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 && sub_stripes != 2) ||
-		     (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes != 2) ||
-		     (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < 2) ||
-		     (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes < 3) ||
-		     (type & BTRFS_BLOCK_GROUP_DUP && num_stripes != 2) ||
+	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 &&
+		      sub_stripes != btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
+		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID5 &&
+		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID5].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID6 &&
+		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID6].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_DUP &&
+		      num_stripes != btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) ||
 		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
-		      num_stripes != 1))) {
+		      num_stripes != btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes))) {
 		chunk_err(leaf, chunk, logical,
 			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
 			num_stripes, sub_stripes,
-- 
2.31.1

