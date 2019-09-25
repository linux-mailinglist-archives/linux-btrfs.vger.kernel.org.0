Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2289BD655
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 04:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391763AbfIYCNe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 22:13:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:39426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390331AbfIYCNe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 22:13:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DCEA9ADF1;
        Wed, 25 Sep 2019 02:13:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Murphy <lists@colorremedies.com>
Subject: [PATCH] btrfs: Fix a regression which we can't convert to SINGLE profile
Date:   Wed, 25 Sep 2019 10:13:27 +0800
Message-Id: <20190925021327.90095-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With v5.3 kernel, we just can't convert to SINGLE profile by all means:
  # btrfs balance start -f -dconvert=single $mnt
  ERROR: error during balancing '/mnt/btrfs': Invalid argument
  # dmesg -t | tail
  validate_convert_profile: data profile=0x1000000000000 allowed=0x20 is_valid=1 final=0x1000000000000 ret=1
  BTRFS error (device dm-3): balance: invalid convert data profile single

[CAUSE]
With the extra debug output added, it shows that the @allowed bit is
lacking the special in-memory only SINGLE profile bit.

Thus we fail at that (profile & ~allowed) check.

This regression is caused by commit 081db89b13cb ("btrfs: use raid_attr
to get allowed profiles for balance conversion") and the fact that we
don't use any bit to indicate SINGLE profile on-disk, but uses special
in-memory only bit to help distinguish different profiles.

[FIX]
Add that BTRFS_AVAIL_ALLOC_BIT_SINGLE to @allowed, so the code should be
the same as it was and fix the regression.

Reported-by: Chris Murphy <lists@colorremedies.com>
Fixes: 081db89b13cb ("btrfs: use raid_attr to get allowed profiles for balance conversion")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 05d328ce229f..1d9c856ea099 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4072,7 +4072,14 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	}
 
 	num_devices = btrfs_num_devices(fs_info);
-	allowed = 0;
+
+	/*
+	 * SINGLE profile on-disk has no profile bit, but in-memory we have a
+	 * special bit for it, to make it easier to distinguish.
+	 * Thuss we need to manual set that bit, or kernel will refuse single
+	 * profile.
+	 */
+	allowed = BTRFS_AVAIL_ALLOC_BIT_SINGLE;
 	for (i = 0; i < ARRAY_SIZE(btrfs_raid_array); i++)
 		if (num_devices >= btrfs_raid_array[i].devs_min)
 			allowed |= btrfs_raid_array[i].bg_flag;
-- 
2.23.0

