Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94348301D62
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 17:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbhAXQER (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 11:04:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:58834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbhAXQEQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 11:04:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611504209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WdZFkFAf4l/w6NPBXSa+c7etYUomM8JaKiUuKeOgs+Q=;
        b=FHboDtVgMGulz/Sxdk5p1J84kzwu7f6lKT5Tu1ORJUUJFkzotg+M1Ir3OIdMDR+TdlMuoe
        h+bVv9Y+dW1hUr3M9cTd0DkefiUYti66/tM6TczQJ+DMMEiN2BX9hrBVTvIElONHqFnu7N
        GBmWEZYm1mnRe2rVflWPV6xKILGmwVs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5BE56AE6D;
        Sun, 24 Jan 2021 16:03:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove unused variable
Date:   Sun, 24 Jan 2021 18:03:21 +0200
Message-Id: <20210124160321.744187-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This fixes fs/btrfs/zoned.c:491:6: warning: variable ‘zone_size’ set but not used [-Wunused-but-set-variable]
  491 |  u64 zone_size;

Which got introduced in 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/zoned.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c38846659019..41d27fefd306 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -488,7 +488,6 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	unsigned int zone_sectors;
 	u32 sb_zone;
 	int ret;
-	u64 zone_size;
 	u8 zone_sectors_shift;
 	sector_t nr_sectors;
 	u32 nr_zones;
@@ -503,7 +502,6 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (!is_power_of_2(zone_sectors))
 		return -EINVAL;
-	zone_size = zone_sectors << SECTOR_SHIFT;
 	zone_sectors_shift = ilog2(zone_sectors);
 	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
-- 
2.25.1

