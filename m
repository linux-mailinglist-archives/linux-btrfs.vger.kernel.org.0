Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A1A3D2CC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 21:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhGVSwE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 14:52:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37822 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhGVSwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 14:52:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6B1C71FF0C;
        Thu, 22 Jul 2021 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626982358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xvIZzOywIgeyxIvE2uxZ9qTLVGuKeoUKADxQx8DgUx4=;
        b=TUx3L1COHL6FbAXEF1voZ5fBX4RwaEyvTBj21Ujn/YPSq+s5KKyYBLN1/YZzXk0yJA35z4
        WlYP52u6tL+13o0Vk/87lgPb0l5c9R4nyoy977ggMQMnYJHF1XnFA9+THwng2LgV/6c5Up
        W20IdDRR31Jce6lVQsAz2gyXaL01+xI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 63214A3B87;
        Thu, 22 Jul 2021 19:32:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F6A7DAF95; Thu, 22 Jul 2021 21:29:56 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: allow degenerate raid0/raid10
Date:   Thu, 22 Jul 2021 21:29:55 +0200
Message-Id: <20210722192955.18709-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The data on raid0 and raid10 are supposed to be spread over multiple
devices, so the minimum constraints are set to 2 and 4 respectively.
This is an artificial limit and there's some interest to remove it.

Change this to allow raid0 on one device and raid10 on two devices. This
works as expected eg. when converting or removing devices.

The only difference is when raid0 on two devices gets one device
removed. Unpatched would silently create a single profile, while newly
it would be raid0.

The motivation is to allow to preserve the profile type as long as it
possible for some intermediate state (device removal, conversion).

Unpatched kernel will mount and use the degenerate profiles just fine
but won't allow any operation that would not satisfy the stricter device
number constraints, eg. not allowing to go from 3 to 2 devices for
raid10 or various profile conversions.

Example output:

  # btrfs fi us -T .
  Overall:
      Device size:                  10.00GiB
      Device allocated:              1.01GiB
      Device unallocated:            8.99GiB
      Device missing:                  0.00B
      Used:                        200.61MiB
      Free (estimated):              9.79GiB      (min: 9.79GiB)
      Free (statfs, df):             9.79GiB
      Data ratio:                       1.00
      Metadata ratio:                   1.00
      Global reserve:                3.25MiB      (used: 0.00B)
      Multiple profiles:                  no

		Data      Metadata  System
  Id Path       RAID0     single    single   Unallocated
  -- ---------- --------- --------- -------- -----------
   1 /dev/sda10   1.00GiB   8.00MiB  1.00MiB     8.99GiB
  -- ---------- --------- --------- -------- -----------
     Total        1.00GiB   8.00MiB  1.00MiB     8.99GiB
     Used       200.25MiB 352.00KiB 16.00KiB

  # btrfs dev us .
  /dev/sda10, ID: 1
     Device size:            10.00GiB
     Device slack:              0.00B
     Data,RAID0/1:            1.00GiB
     Metadata,single:         8.00MiB
     System,single:           1.00MiB
     Unallocated:             8.99GiB

Note "Data,RAID0/1", with btrfs-progs 5.13+ the number of devices per
profile is printed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 86846d6e58d0..ad943357072b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -38,7 +38,7 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.sub_stripes	= 2,
 		.dev_stripes	= 1,
 		.devs_max	= 0,	/* 0 == as many as possible */
-		.devs_min	= 4,
+		.devs_min	= 2,
 		.tolerated_failures = 1,
 		.devs_increment	= 2,
 		.ncopies	= 2,
@@ -103,7 +103,7 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.sub_stripes	= 1,
 		.dev_stripes	= 1,
 		.devs_max	= 0,
-		.devs_min	= 2,
+		.devs_min	= 1,
 		.tolerated_failures = 0,
 		.devs_increment	= 1,
 		.ncopies	= 1,
-- 
2.31.1

