Return-Path: <linux-btrfs+bounces-15646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B309AB0F438
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 15:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A1D16B6D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448802E7BA3;
	Wed, 23 Jul 2025 13:38:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01A2E7628
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277901; cv=none; b=MS6Na/v/SdFcMmLRHoA4NoXxyoTIOErlTtiprVIvppMNiRP61LhojH1qnP9LvnK/bir7FoWuHtX9l9JVUHQ4gt3AwSFpXRIic0kzVfoBeqKg4R6mMS/+RpIuAu/5S0XnK+v3efMGUdI8yBj3Bf/99EnxEfokzyx4Ds3MwwcUdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277901; c=relaxed/simple;
	bh=yj/7DmHwokSGE9TMjSV/DJMzcIBrTUWRWXJFeKVGbqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfKKu8nfznbkFYQChUjZ1kU+jhd/GrW+kRFoYi8L6cW43hk1QzOH9UEFhx77hpoIFS9+8MlLU4JHuvMTTppbgHbDFkozLOFEw9UC9ZFZVeTQE9zHtclc2tzd8LwYYtwh+JvBK27PnL2prbJ2Si/fgVnSrjUbPfM+BZkoILWpf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so3795450f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 06:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277898; x=1753882698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hg13aAgZaXjGK4VHSwrcPTVtqNeeR0MthOLA3jeZiK8=;
        b=DIbd8LSz7FIoPoXS0fMCR+rL46DTRcX8aqnMCwNulGYcih9Wt5yhAR8kYwWBCVbKKE
         JSUrqYb0UVHzhQ2yxX5UIsEJPjmEzbJ0KA299uL9ipyCqNSj/APQxSMtPlKDCtOD8rSi
         Jhxpee2S1UUlTdDot26pyrUCkZR/qMMJz+CBtIilsIQ4eE9SORWe6yRWNXMvdThYBndL
         olvQ2IdSNn9ZSppBLmhL51C2mznyWu3imeAodYG/5i+1RNmZc+zdQY/FUHlxjZ+gk4ta
         lhrxWdl8ITyvxfqxZ6V9wE02aww8RjS7kQiBlVubPi9mmKFZTpRc0He1haOEvChZyXWN
         OO5w==
X-Gm-Message-State: AOJu0Yxka/l+ZyDkTah1nMCfxdWBps25oAOQZ5FAGfZrjjJUdM3Ax5xk
	7eemU2mpOyLe7GHIbqZFGGN7Tljre0SZMy3R+vojadhzmF2xQEr1Cp9x+rvWmw==
X-Gm-Gg: ASbGncvuD5+5Dr5d2BtYgBZbj/q2S+trn8AefdcDjOI+4Feoe3du+dHdWIwSAI5fdlT
	tV92KQgdxwsnL8x9gTuZxGm7B0M4H5BFRnLhOO90wtjYvKMnub7CbQCgkimHEKb+GeJep1lHCoL
	9jnrsbuYSS0YCDjpqp9rf3/8NzvumDVpuuBcnyh8Y6FeMJ3pfaiN2SCYQIZlxOVzW3LaM1ZD55y
	UmyrpMCHrDnC2rxP67KGh7nG48aFppuUmVWcjs6nZokU8sqE5BZK+3tY9C4U1OA3jrcgD9fmHm8
	zp+Cc1Xq+N1cEPB60Ih91DUHodTPumcXPBcMFWDXp03Go3mvlBmG0EU/e7kfTjXgY3zUx6P8Sdt
	yaJd5zDLX64r75g5ur+AIiVtYW9wpT75eu2QSHOtsRgYx3P8pmglvVjgACYBteiJQKG8ooTIdYl
	44l5jp6Tv1Ev10D7HtfA==
X-Google-Smtp-Source: AGHT+IF2Iy9nn3aTzTjVAcVwMoYwYB5i9mXkuziV+rojPQGGBL7aRa11gRzcKaPaT0Ni5z/55JDg2Q==
X-Received: by 2002:a05:6000:2c0f:b0:3a6:d95c:5e8 with SMTP id ffacd0b85a97d-3b768f1abeamr2597876f8f.35.1753277898176;
        Wed, 23 Jul 2025 06:38:18 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f73305007e75d935364c0eea.dip0.t-ipconnect.de. [2003:f6:f733:500:7e75:d935:364c:eea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2dfe0sm16457881f8f.36.2025.07.23.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:38:17 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: skip ZONE FINISH of conventional zones
Date: Wed, 23 Jul 2025 15:38:10 +0200
Message-ID: <20250723133810.48179-1-jth@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't call ZONE FINISH for conventional zones as this will result in I/O
errors. Instead check if the zone that needs finishing is a conventional
zone and if yes skip it.

Also factor out the actual handling of finishing a single zone into a
helper function, as do_zone_finish() is growing ever bigger and the
indentations levels are getting higher.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
This is a preparation patch for Naohiro's patch titled:
"btrfs: zoned: limit active zones to max_open_zones"
which can be found at:
https://lore.kernel.org/linux-btrfs/47f7423f53492e0ee1cd40f204db8354efb8d6b1.1752652539.git.naohiro.aota@wdc.com
---
 fs/btrfs/zoned.c | 55 ++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index eeb049994cfe..ddacdb75d45c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2257,6 +2257,40 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
 	rcu_read_unlock();
 }
 
+static int call_zone_finish(struct btrfs_block_group *block_group,
+			    struct btrfs_io_stripe *stripe)
+{
+	struct btrfs_device *device = stripe->dev;
+	const u64 physical = stripe->physical;
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	int ret;
+
+	if (!device->bdev)
+		return 0;
+
+	if (zinfo->max_active_zones == 0)
+		return 0;
+
+	if (btrfs_dev_is_sequential(device, physical)) {
+		unsigned int nofs_flags;
+
+		nofs_flags = memalloc_nofs_save();
+		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
+				       physical >> SECTOR_SHIFT,
+				       zinfo->zone_size >> SECTOR_SHIFT);
+		memalloc_nofs_restore(nofs_flags);
+
+		if (ret)
+			return ret;
+	}
+
+	if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
+		zinfo->reserved_active_zones++;
+	btrfs_dev_clear_active_zone(device, physical);
+
+	return 0;
+}
+
 static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
@@ -2341,31 +2375,12 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	down_read(&dev_replace->rwsem);
 	map = block_group->physical_map;
 	for (i = 0; i < map->num_stripes; i++) {
-		struct btrfs_device *device = map->stripes[i].dev;
-		const u64 physical = map->stripes[i].physical;
-		struct btrfs_zoned_device_info *zinfo = device->zone_info;
-		unsigned int nofs_flags;
-
-		if (!device->bdev)
-			continue;
-
-		if (zinfo->max_active_zones == 0)
-			continue;
-
-		nofs_flags = memalloc_nofs_save();
-		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
-				       physical >> SECTOR_SHIFT,
-				       zinfo->zone_size >> SECTOR_SHIFT);
-		memalloc_nofs_restore(nofs_flags);
 
+		ret = call_zone_finish(block_group, &map->stripes[i]);
 		if (ret) {
 			up_read(&dev_replace->rwsem);
 			return ret;
 		}
-
-		if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
-			zinfo->reserved_active_zones++;
-		btrfs_dev_clear_active_zone(device, physical);
 	}
 	up_read(&dev_replace->rwsem);
 
-- 
2.50.1


