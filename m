Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82449168374
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBUQbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:31:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:43764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgBUQbe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C190DAEEE;
        Fri, 21 Feb 2020 16:31:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66141DA70E; Fri, 21 Feb 2020 17:31:15 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 07/11] btrfs: raid56: simplify sort_parity_stripes
Date:   Fri, 21 Feb 2020 17:31:15 +0100
Message-Id: <1b125ae0b051c8b4075e9d6cf11c062cdb30dd8e.1582302545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582302545.git.dsterba@suse.com>
References: <cover.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove trivial comprator and open coded swap of two values.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 997f2c70cb6c..945b89e2104f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5428,31 +5428,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	return preferred_mirror;
 }
 
-static inline int parity_smaller(u64 a, u64 b)
-{
-	return a > b;
-}
-
 /* Bubble-sort the stripe set to put the parity/syndrome stripes last */
 static void sort_parity_stripes(struct btrfs_bio *bbio, int num_stripes)
 {
-	struct btrfs_bio_stripe s;
 	int i;
-	u64 l;
 	int again = 1;
 
 	while (again) {
 		again = 0;
 		for (i = 0; i < num_stripes - 1; i++) {
-			if (parity_smaller(bbio->raid_map[i],
-					   bbio->raid_map[i+1])) {
-				s = bbio->stripes[i];
-				l = bbio->raid_map[i];
-				bbio->stripes[i] = bbio->stripes[i+1];
-				bbio->raid_map[i] = bbio->raid_map[i+1];
-				bbio->stripes[i+1] = s;
-				bbio->raid_map[i+1] = l;
-
+			/* Swap if parity is on a smaller index */
+			if (bbio->raid_map[i] > bbio->raid_map[i + 1]) {
+				swap(bbio->stripes[i], bbio->stripes[i + 1]);
+				swap(bbio->raid_map[i], bbio->raid_map[i + 1]);
 				again = 1;
 			}
 		}
-- 
2.25.0

