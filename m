Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1936AC39
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhDZG3T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhDZG3Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418515; x=1650954515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxdTftG6NiT2MFIWuKJzxmh1xXy8Tl6pDMJVV/Y3K2c=;
  b=bkJJSgqHZmwkEkHUpqrwO2anWobeIJaNBtUadc+1+uXbFarRI0mwMLOy
   EyU9Krzb9LW6t3Gzgy6ZmJ+ZPwoUYJC8WF/czmuwA25PpupNLc8UFFloV
   FnXWwJWZdL/+pSjQVS3w/FTf3TzSnHscuX6e4duR8ug2VH1qJMxlFS0DE
   HSCa7BqDRByBVQD1Gf9t4LkAw/cjtBbP0WgGlE5SsLQaCOsvhmJQoXBy6
   66BkGzwN0uDnQRJWnBt3VlYWhxNZ+fNiFuRejDooUesWgmWEnydYcI7rp
   dYNroEiWGXoLCrJjlbvWMNbE1uiAlHszoYQtuVI6psRHSvk0gz5sYbwvw
   Q==;
IronPort-SDR: ZvzAdVybFmGlSMU2dFjMcFZa/Snpq0cTmUTPK8KaOrZ2EfwLpT266t0OO2UtmrjwqHSDAHE2N6
 nYILNL89YIv08Sxu/9CE/zds+lDDn6MNdGU7d1sl65VqV2XdNMoukcu4sJ3L3bhqSOLKkdrray
 xD2xfRiGBqWSltL59eOD6sVPv7J6hclr5+zpxxiUTbyQ2wBhIeiM0KKZBqx3KUFHPw0d9UrLzJ
 Xety/dUTsmQ/jH/EV7pfU7EOMSvGQOuDy/kINRGarqxbTfYxFPQas4IYjRVIXrU0cIAFFMrMWi
 K7U=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788143"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:35 +0800
IronPort-SDR: W95lNDP/3B77bB16TpzuLRxBSzXKgEYLNZKItmoEK70CC6eH2edm+TbqkQGRAn377QPImEEHPx
 8YeR1ZuY+ig5w3L7Z+FVyPcE3D6q/KYnM8DEDC4//uFWrGZbJpvs0OrfT8wTyt216xC3Q9V7ut
 c/Vy8qEbaXwOUF2hDWkIqIUDUFTdZZ9eZmAz+lGW53cEhAPl6ZWLCkdMeS+T+i99NhU4mo9T1g
 VBt0tYo3gL/U3usWDZIZ8bY4AoyhnxiFRPPEaSkvwbJjDX8+7cH6b10xSMM/wetk940dmRx0EN
 UgIET3sJ9aYyXvNnokNpEqEc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:59 -0700
IronPort-SDR: Z6uVk2pKgKb7aWNlf7M0gO4VPeTU+nt4Iv+yDJhM5k0De8JgwKbQbQArrzNuhZHmwJXtKMvPDk
 pNZ1HQboS63PEaqddvtYsU7Ry04kZh7WI3swz5QP8ZihssmD2xC+gdhIfxHoaa+8jkELfbYJta
 qBP8LpfL+YqzwQ4z550ij43z2ksDJcUHIaKBEtR8vN7M5mcjuuDp8d4mkb+mbUYTmNMVSbO8YR
 neKGJdw+n/Lw9Kx/lD9gwISnC3soegNo0fk0PutpbRcKX6cj3egw+y4Edc0/3dQp8A1SrUtAiM
 xOA=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 24/26] btrfs-progs: zoned: wipe temporary superblocks in superblock log zone
Date:   Mon, 26 Apr 2021 15:27:40 +0900
Message-Id: <3425b775916cd02bb7bdf57e018ea0ead833db4e.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mkfs.btrfs uses a temporary superblock during the initialization process.
The temporary superblock uses BTRFS_MAGIC_TEMPORARY as its magic which is
different from a regular superblock. As a result, libblkid, which only
supports the usual magic, cannot recognize the volume as btrfs. So, let's
wipe the temporary magic before writing out the usual superblock.

Technically, we can add the temporary magic to the libblkid's table. But,
it will result in recognizing a half-baked filesystem as btrfs, which is
not ideal.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/disk-io.c |  6 ++++++
 kernel-shared/zoned.c   | 20 ++++++++++++++++++++
 kernel-shared/zoned.h   |  6 ++++++
 3 files changed, 32 insertions(+)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index d79d6a00cdf8..355010277ca9 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1951,6 +1951,12 @@ int close_ctree_fs_info(struct btrfs_fs_info *fs_info)
 	}
 
 	if (fs_info->finalize_on_close) {
+		ret = btrfs_wipe_temporary_sb(fs_info->fs_devices);
+		if (ret) {
+			error("zoned: failed to wipe temporary super blocks: %m");
+			goto skip_commit;
+		}
+
 		btrfs_set_super_magic(fs_info->super_copy, BTRFS_MAGIC);
 		root->fs_info->finalize_on_close = 0;
 		ret = write_all_supers(fs_info);
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 3c476eebf004..8801ed43157e 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -975,6 +975,26 @@ int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info, u64 devid,
 	return 0;
 }
 
+int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices)
+{
+	struct list_head *head = &fs_devices->devices;
+	struct btrfs_device *dev;
+	int ret = 0;
+
+	list_for_each_entry(dev, head, dev_list) {
+		struct btrfs_zoned_device_info *zinfo = dev->zone_info;
+
+		if (!zinfo)
+			continue;
+
+		ret = btrfs_reset_dev_zone(dev->fd, &zinfo->zones[0]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 #endif
 
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 9e1ce3ae103f..a2e84464a221 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -94,6 +94,7 @@ int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info, u64 devid,
 int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo);
 int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
 		     size_t len);
+int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices);
 #else
 #define sbread(fd, buf, offset) \
 	pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
@@ -154,6 +155,11 @@ static inline int zero_zone_blocks(int fd,
 	return -EOPNOTSUPP;
 }
 
+static inline int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices)
+{
+	return 0;
+}
+
 #endif /* BTRFS_ZONED */
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

