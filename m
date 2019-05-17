Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E512166B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfEQJm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:33308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728985AbfEQJm0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CE42AEEA
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EDBBCDA871; Fri, 17 May 2019 11:43:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 06/15] btrfs: use raid_attr table in calc_stripe_length for nparity
Date:   Fri, 17 May 2019 11:43:24 +0200
Message-Id: <a4a37111b3166662450059a35eb9998cf8f9677b.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The table is already used for ncopies, replace open coding of stripes
with the raid_attr value.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 995a15a816f2..743ed1f0b2a6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6652,19 +6652,14 @@ static u64 calc_stripe_length(u64 type, u64 chunk_len, int num_stripes)
 {
 	int index = btrfs_bg_flags_to_raid_index(type);
 	int ncopies = btrfs_raid_array[index].ncopies;
+	int nparity = btrfs_raid_array[index].nparity;
 	int data_stripes;
 
-	switch (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
-	case BTRFS_BLOCK_GROUP_RAID5:
-		data_stripes = num_stripes - 1;
-		break;
-	case BTRFS_BLOCK_GROUP_RAID6:
-		data_stripes = num_stripes - 2;
-		break;
-	default:
+	if (nparity)
+		data_stripes = num_stripes - nparity;
+	else
 		data_stripes = num_stripes / ncopies;
-		break;
-	}
+
 	return div_u64(chunk_len, data_stripes);
 }
 
-- 
2.21.0

