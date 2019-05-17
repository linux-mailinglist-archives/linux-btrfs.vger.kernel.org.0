Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1492166F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfEQJmf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729019AbfEQJmf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A746DAECD
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5410CDA871; Fri, 17 May 2019 11:43:34 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 10/15] btrfs: factor out helper for counting data stripes
Date:   Fri, 17 May 2019 11:43:34 +0200
Message-Id: <bb3b0614e5157cb4adba593deb44479bba796fda.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor the sequence of ifs to a helper, the 'data stripes' here means
the number of stripes without redundancy and parity.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3d65fdf7884c..3464bf1f0c48 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3474,6 +3474,18 @@ static int chunk_devid_filter(struct extent_buffer *leaf,
 	return 1;
 }
 
+static u64 calc_data_stripes(u64 type, int num_stripes)
+{
+	const int index = btrfs_bg_flags_to_raid_index(type);
+	const int ncopies = btrfs_raid_array[index].ncopies;
+	const int nparity = btrfs_raid_array[index].nparity;
+
+	if (nparity)
+		return num_stripes - nparity;
+	else
+		return num_stripes / ncopies;
+}
+
 /* [pstart, pend) */
 static int chunk_drange_filter(struct extent_buffer *leaf,
 			       struct btrfs_chunk *chunk,
@@ -3483,22 +3495,15 @@ static int chunk_drange_filter(struct extent_buffer *leaf,
 	int num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
 	u64 stripe_offset;
 	u64 stripe_length;
+	u64 type;
 	int factor;
 	int i;
 
 	if (!(bargs->flags & BTRFS_BALANCE_ARGS_DEVID))
 		return 0;
 
-	if (btrfs_chunk_type(leaf, chunk) & (BTRFS_BLOCK_GROUP_DUP |
-	     BTRFS_BLOCK_GROUP_RAID1 | BTRFS_BLOCK_GROUP_RAID10)) {
-		factor = num_stripes / 2;
-	} else if (btrfs_chunk_type(leaf, chunk) & BTRFS_BLOCK_GROUP_RAID5) {
-		factor = num_stripes - 1;
-	} else if (btrfs_chunk_type(leaf, chunk) & BTRFS_BLOCK_GROUP_RAID6) {
-		factor = num_stripes - 2;
-	} else {
-		factor = num_stripes;
-	}
+	type = btrfs_chunk_type(leaf, chunk);
+	factor = calc_data_stripes(type, num_stripes);
 
 	for (i = 0; i < num_stripes; i++) {
 		stripe = btrfs_stripe_nr(chunk, i);
-- 
2.21.0

