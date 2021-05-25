Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096A639072A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhEYRMk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 13:12:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:34062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233443AbhEYRMj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 13:12:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621962668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPua7UXqY2mCkxw/JFJjKXTP6BlrgcHiyjijvY9Pv2I=;
        b=tI3+y2Ks3ADkpFTWwn6+K2IGhJ2UYtd+JcOjcxbXELX2dhndu9wvU0PCqchlJ2I3sqgoCr
        u3qGaASJGeCt1iBB/zaT1koKS4BI+5dLh4OApaulNJx5EaRaKNPSNIL305CZMoh2j+pdj8
        q0FgIhyFxvgu+R6PuZPREeIPQX35cxA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C635FAEEB;
        Tue, 25 May 2021 17:11:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65CE8DA70B; Tue, 25 May 2021 19:08:32 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/9] btrfs: scrub: factor out common scrub_stripe constraints
Date:   Tue, 25 May 2021 19:08:32 +0200
Message-Id: <d175e98023012390c53755ba85f93606376f51a4.1621961965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621961965.git.dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are common values set for the stripe constraints, some of them
are already factored out. Do that for increment and mirror_num as well.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 518415d0c122..5839ad1e25a2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3204,28 +3204,23 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	physical = map->stripes[num].physical;
 	offset = 0;
 	nstripes = div64_u64(length, map->stripe_len);
+	mirror_num = 1;
+	increment = map->stripe_len;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
 		offset = map->stripe_len * num;
 		increment = map->stripe_len * map->num_stripes;
-		mirror_num = 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 		int factor = map->num_stripes / map->sub_stripes;
 		offset = map->stripe_len * (num / map->sub_stripes);
 		increment = map->stripe_len * factor;
 		mirror_num = num % map->sub_stripes + 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
-		increment = map->stripe_len;
 		mirror_num = num % map->num_stripes + 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
-		increment = map->stripe_len;
 		mirror_num = num % map->num_stripes + 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		get_raid56_logic_offset(physical, num, map, &offset, NULL);
 		increment = map->stripe_len * nr_data_stripes(map);
-		mirror_num = 1;
-	} else {
-		increment = map->stripe_len;
-		mirror_num = 1;
 	}
 
 	path = btrfs_alloc_path();
-- 
2.29.2

