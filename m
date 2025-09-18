Return-Path: <linux-btrfs+bounces-16921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D7B843B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1F6189D401
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 10:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C42F3621;
	Thu, 18 Sep 2025 10:51:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B66279346
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192692; cv=none; b=OCKJT1drPXPiCndexshCGwXkaHyWEUvePLsETjSjF5RFdzKXpNKwpgYP35bE+wqrG9k9nRSp3821O35wbbpbygIr3zNbt5Uat1LePGZ++BLmiI1tC5+a4zDqHfOxWzbJK4JW4mqfqGJAvPrQW+7fV+nyQEd68TK/G0cHaZ6V/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192692; c=relaxed/simple;
	bh=RHoUQ4e5cRBHtlyKBzs8lz4+73ESSG7T6qRFCDJddpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7PK5cUPXMGvkCyY2CtFFbmkgxM+56n3Ek2bgC8ACnh9sFm+9JhdEsSWHW4Iohp3K99a+R1OYz4sNcvfprTk7MXJMIrUPDpnHVPPKbMhke5cqLp/kPwKH4mPWASVWczp/r7OeNJKLaaUjo0wRaftCLovjjZNiIdvwhr72Km5hPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee155e0c08so8063f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 03:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192688; x=1758797488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SclwkpXSRnTRPRt2z9GsoViCRpVRXJKEqbxfWPJfaC4=;
        b=ckUd7jQR2P+2KdqSurFsHJW+e0rcPHroU70tFgavu8WEYr3e2kYTcwvKeoGfGJMdbm
         gAUBVfw13/88FKT7YbOExnyis9J9VUABx6rHnkRcVwK9yxsoTZbReCzxEUBlk2GSKzWg
         CchZ5GhHshBkqGYnsdfl9Ao3j5MtEdkeqFiJkJIFD/iweTTn+Uqfr94Chk/vKyBLYBJm
         uThTBWCDhkXGUiNp7Q+Pt7mF6f8TfaF2Gl0Eb2Iim/fIIHWEqQK0U3oJ9LaQgeGrXWax
         p7hQN9ry4qL+wC+cEmKXSqgMI5BSm8foo3W0RkX8nIvMwF9ynpODUJi59lM7/fEZ8ReI
         hpKg==
X-Gm-Message-State: AOJu0YyFgUBHrKOGeoJoGRSCWuAt69vsACIh2wYi5HH1uV/8liREfyuV
	S6ujcCzVBKMhtMswRwilYptYlEUffkTN714UNdK67qz1Hgxxs0GrRBSYOf/f6Q==
X-Gm-Gg: ASbGncsyy5AUW0VFYcAz9aO7RWePcZ1AlnX/LaNxW4F2xhgqq8wbMnU4OnnxLHyjKBJ
	lnnpjQMzTIIWzC4lZoym/qR4CvQsrY1oSMMRKbD2vaNxZBN/ZGzAalsWqsskw5fuOPjRvtLkrB8
	vHBOc9dw6yTRIX1H0IRJJQLN6USeR/gHaB1v0yNYZ3+s3yS/U5qS1QPIV94FeYftGQ9cHVCUytM
	sgoPM3OHawoQIERSa/EFD950+M61kHJJ5aJXDxmC2Eay16UleGR2cx2O2NV5P7IErQ7tpw4FiSY
	EsRl4t4Xp0AFSaZiHt/HbGgi9LEF7knhGPO717xIeijZMNyxyxMn6dQB+OmN8NpysGDjuUkHLZF
	IfXFFbM+MSuyvtwDP/sb0K/lo+d7qrke9u6Lid/xH3ky0E6/b95EnGf8BRhyTBxekqr9HjTxBNT
	DRJ6ZwFcntiSFQjejM8KkI9l24zw==
X-Google-Smtp-Source: AGHT+IGWOcDuSgWWfi50zaROEJerZPyAGCQeTZGV97ZgE7fRQRHRpWtkKBHhRZI5IBFSaqXLpK8G1w==
X-Received: by 2002:a05:6000:22c1:b0:3ec:248f:f86a with SMTP id ffacd0b85a97d-3ecdfa37807mr4944149f8f.48.1758192688367;
        Thu, 18 Sep 2025 03:51:28 -0700 (PDT)
Received: from neo.fritz.box (p200300f6f713d700cba3da2d940e7060.dip0.t-ipconnect.de. [2003:f6:f713:d700:cba3:da2d:940e:7060])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613ddc01e6sm74066865e9.18.2025.09.18.03.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:51:27 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Yuwei Han <hrx@bupt.moe>
Subject: [PATCH] btrfs: zoned: don't fail mount needlessly due to too many active zones
Date: Thu, 18 Sep 2025 12:51:19 +0200
Message-ID: <20250918105119.41556-1-jth@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Previously BTRFS did not look at a device's reported max_open_zones limit,
but starting with commit 04147d8394e8 ("btrfs: zoned: limit active zones
to max_open_zones"), zoned BTRFS limited the number of concurrently used
block-groups to the number of max_open_zones a device reported, if it
hadn't already reported a number of max_active_zones.

Starting with commit 04147d8394e8 the number of open zones is treated the
same way as active zones. But this leads to mount failures on filesystems
which have been used before 04147d8394e8 because too many zones are in an
open state.

Ignore the new limitations on these filesystems, so zones can be finished
or evacuated.

Reported-by: Yuwei Han <hrx@bupt.moe>
Fixes: 04147d8394e8 ("btrfs: zoned: limit active zones to max_open_zones")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ba444e412613..e21b57a68b3c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -514,6 +514,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 
 	if (max_active_zones) {
 		if (nactive > max_active_zones) {
+			if (bdev_max_active_zones(bdev) == 0) {
+				max_active_zones = 0;
+				zone_info->max_active_zones = 0;
+				goto validate;
+			}
 			btrfs_err(device->fs_info,
 			"zoned: %u active zones on %s exceeds max_active_zones %u",
 					 nactive, rcu_dereference(device->name),
@@ -526,6 +531,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		set_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags);
 	}
 
+validate:
 	/* Validate superblock log */
 	nr_zones = BTRFS_NR_SB_LOG_ZONES;
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
-- 
2.51.0


