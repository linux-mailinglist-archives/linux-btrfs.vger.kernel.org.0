Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D28E168375
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBUQbh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:31:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:43774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgBUQbg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 223D3AEEC;
        Fri, 21 Feb 2020 16:31:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B916BDA70E; Fri, 21 Feb 2020 17:31:17 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 08/11] btrfs: replace u_long type cast with unsigned long
Date:   Fri, 21 Feb 2020 17:31:17 +0100
Message-Id: <f21f18a03a86c32c44e60f9b08d67cc7ff0ea272.1582302545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582302545.git.dsterba@suse.com>
References: <cover.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't use the u_XX types anywhere, though they're defined.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 945b89e2104f..fe1f609c736b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6269,8 +6269,8 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	btrfs_debug_in_rcu(fs_info,
 	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		bio_op(bio), bio->bi_opf, (u64)bio->bi_iter.bi_sector,
-		(u_long)dev->bdev->bd_dev, rcu_str_deref(dev->name), dev->devid,
-		bio->bi_iter.bi_size);
+		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
+		dev->devid, bio->bi_iter.bi_size);
 	bio_set_dev(bio, dev->bdev);
 
 	btrfs_bio_counter_inc_noblocked(fs_info);
-- 
2.25.0

