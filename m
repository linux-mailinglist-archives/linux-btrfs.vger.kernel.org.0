Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2905936AC25
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhDZG26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:28:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhDZG25 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418495; x=1650954495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tLxYRaXGwiYIYF/mc8ILCrrBkTsc5FRTTCmIjbckHFM=;
  b=PygXUXwuHtRvonVRpPAOW807m0RzQ3BPu3G73cWRZpBcvd+KAmCnqlD1
   DgXiD508Fsl/ytTPYG/F0S/GijCZiB1pu6gPB7dmgiXVqqFNflsKtphPS
   Q1RHv7PfcAsB+uQOA/5WXOsrjrWR6Ynw1yg8Tus4KErpFmGx5pHvU7+YC
   2FnhOQem4wWXaMe2w7lcRdpy2wvK6PQjd5jZEgLNw/aR/VvYKR4ZAQK41
   83wbpjMIKOHXK9ztfBxWsN7VwTAJOP+SpkIHUkRrTeTSJLMkLcDIZWMEL
   qDRLU9Kt+PS1ol8Gnl1+FN0mZhlOzcWTKQT8huWasSykCrTY9BZ16dHSG
   w==;
IronPort-SDR: iz9/JN4pyo+sx//hMGM3tzJWS1XixjmsxJ92lUlX2+B8u8l0XZ9pi2ljZMCArIgzkSbMPX+lwy
 T3AGRK6bm2nSB4HlHtBmYaOkuNAwS5W7PF7cnkiaUL6a3hyZQbFgAeX/dsWQkCvfSzMBUvqLB2
 tJHmFf3wzQNLyvOaLVz0b953nWkWwONeej/M0FBEhLH9+G8h4M6plg/Grqht7QBVeTxcdrHXLT
 36G2lWpExfD0p18mL7oBMEN1cYoBYr2be9iaa92CbWxIl7laaMNAxzcBqlradOocqXDzzhJJWS
 2j0=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788114"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:15 +0800
IronPort-SDR: Jp68yTmtc2pqlgVELWunkiVyM4YkJgAFUj/0ILNTcDpSeeFuXio8O1atWdrzPb2YH4D1IIHafC
 3BYqyb6ogjpen0CQl1TGwFTG+RLCVv6njbCuigbaRapRIk42377aVec0F7mFit9ajJHnSiOi6K
 aTJz7c1b42Kynn8j4GU0x1sb+9udOWveTUZqJd3tqAnsBO9EWFOAhSKZKPDGglZt9Yd9DlT2VQ
 mZ2dzSCjlFqtY/MET1Vlu9dxc9Rpykwu/1Edf8sYfRdbGf+kLOFTudmvHlX+k3ak/m3oNBTwlJ
 xY4hbCsmeaJiFczrY6Y7QR2B
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:39 -0700
IronPort-SDR: OicOyqO345dlBQKyhZ3ZOP68RC4O1HuUgNUvilTriyVOft7LhJkmiVBwHSnqPzAHnC/AmUcqTQ
 13NP89VG8FX1tKpXg+07oaAMaq0uFjgnyo34gIDHt3++WpZwK0nP0TZX6okCBvwIGy770T/V6k
 vzzrvsi00xCscnPDS2DNYxBrpKEtIEtEofCSE5vBFbvPxB3s+ISu9hcLAJHXIe8y4R7VOmids1
 u/x6w7U5Aq1i14EOfjOhIoerkrb9FMvQxPjfOpwpk53uAa34FVB5OJ9NpRXl2X7xbshL+7lbwW
 Vrw=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:15 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 06/26] btrfs-progs: zoned: check and enable ZONED mode
Date:   Mon, 26 Apr 2021 15:27:22 +0900
Message-Id: <ce43d7316c67d11e136cb511f2328aac521e8e64.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce function btrfs_check_zoned_mode() to check if ZONED flag is
enabled on the file system and if the file system consists of zoned devices
with equal zone size.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/ctree.h   | 14 +++++++
 kernel-shared/disk-io.c |  6 +++
 kernel-shared/zoned.c   | 85 +++++++++++++++++++++++++++++++++++++++++
 kernel-shared/zoned.h   |  1 +
 4 files changed, 106 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 77a5ad488104..aab631a44785 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1213,8 +1213,22 @@ struct btrfs_fs_info {
 	u32 nodesize;
 	u32 sectorsize;
 	u32 stripesize;
+
+	/*
+	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
+	 * if the mode is enabled
+	 */
+	union {
+		u64 zone_size;
+		u64 zoned;
+	};
 };
 
+static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
+{
+	return fs_info->zoned != 0;
+}
+
 /*
  * in ram representation of the tree.  extent_root is used for all allocations
  * and for the extent tree extent_root root.
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 0519cb2358b5..4aba237f5a5c 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1326,6 +1326,12 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 		goto out_chunk;
 	}
 
+	ret = btrfs_check_zoned_mode(fs_info);
+	if (ret) {
+		error("zoned: failed to initialize zoned mode: %d", ret);
+		goto out_chunk;
+	}
+
 	eb = fs_info->chunk_root->node;
 	read_extent_buffer(eb, fs_info->chunk_tree_uuid,
 			   btrfs_header_chunk_tree_uuid(eb),
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 370d93915c6e..7cb5262ba481 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -240,3 +240,88 @@ int btrfs_get_zone_info(int fd, const char *file,
 
 	return 0;
 }
+
+int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 zoned_devices = 0;
+	u64 nr_devices = 0;
+	u64 zone_size = 0;
+	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
+	int ret = 0;
+
+	/* Count zoned devices */
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		enum btrfs_zoned_model model;
+
+		if (device->fd == -1)
+			continue;
+
+		model = zoned_model(device->name);
+		/*
+		 * A Host-Managed zoned device must be used as a zoned device.
+		 * A Host-Aware zoned device and a non-zoned devices can be
+		 * treated as a zoned device, if ZONED flag is enabled in the
+		 * superblock.
+		 */
+		if (model == ZONED_HOST_MANAGED ||
+		    (model == ZONED_HOST_AWARE && incompat_zoned) ||
+		    (model == ZONED_NONE && incompat_zoned)) {
+			struct btrfs_zoned_device_info *zone_info =
+				device->zone_info;
+
+			zoned_devices++;
+			if (!zone_size) {
+				zone_size = zone_info->zone_size;
+			} else if (zone_info->zone_size != zone_size) {
+				error(
+		"zoned: unequal block device zone sizes: have %llu found %llu",
+				      device->zone_info->zone_size,
+				      zone_size);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+		nr_devices++;
+	}
+
+	if (!zoned_devices && !incompat_zoned)
+		goto out;
+
+	if (!zoned_devices && incompat_zoned) {
+		/* No zoned block device found on ZONED filesystem */
+		error("zoned: no zoned devices found on a zoned filesystem");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (zoned_devices && !incompat_zoned) {
+		error("zoned: mode not enabled but zoned device found");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (zoned_devices != nr_devices) {
+		error("zoned: cannot mix zoned and regular devices");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in
+	 * __btrfs_alloc_chunk(). Since we want stripe_len == zone_size,
+	 * check the alignment here.
+	 */
+	if (!IS_ALIGNED(zone_size, BTRFS_STRIPE_LEN)) {
+		error("zoned: zone size %llu not aligned to stripe %u",
+		      zone_size, BTRFS_STRIPE_LEN);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fs_info->zone_size = zone_size;
+
+out:
+	return ret;
+}
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 461a2d624c67..a6134babdf41 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -38,5 +38,6 @@ u64 zone_size(const char *file);
 int btrfs_get_zone_info(int fd, const char *file,
 			struct btrfs_zoned_device_info **zinfo);
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info);
+int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 
 #endif /* __BTRFS_ZONED_H__ */
-- 
2.31.1

