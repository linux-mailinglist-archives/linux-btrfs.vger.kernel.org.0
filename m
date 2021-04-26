Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530D636AC36
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhDZG3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhDZG3N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418511; x=1650954511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FkTWq40rmGdCVEdnixL5+cbs5NMtmsI4916/9B1ciTc=;
  b=ADPrGYzM4fVZW60AnzDovmE/spdF++wP/iGpk5xyYea8ERPO0mGZVfdm
   fW/8S74fAcnYjkTrjRpSOJ/zMH4FAVPmcWBdkA0PzP0bbPa/OKNRMhw08
   mxbTju/fONUvWvJZk9YQ/CHXGks9t63+PJ+OtJGgtWt1Wpsg4Nmr1c2Hn
   KgPz+cguyZm/ifqckHBmUyetC93/ao/ylk8Y3uZtDjNVkfgH/VqxFSVwR
   jx/HhzLFoeVfnnvJ8KKryrXAKJzlJ7+8FT0EKAN+JwIWTbv4xiFtj0dkR
   EjgUX71F+qi5/dmavXEV0RXbZmbFwFZa2aEXkm3yKoqe8f/qnDoqrcAxL
   w==;
IronPort-SDR: SEhP6ZWH4ikwiFT/C+gMIWHruYM0p5AYiBrscMApKPOPHFt2gjMTJyhwXkz6zoUg3h4r6Rs+2E
 5X/8Rl5D7UwSGAmzHYYBOYDLwdfZMoilMV/jYzgC701LvAKTn4IF4bI/KFaRP1OqbHMzPImCyJ
 Disd9ZfhkaHKcd9Ml0xrZFrqvhOTUfHsSCTQbvB6E9BHxhGOyGkFtPR1K9pQ2hoewhswGDV4X9
 42Xia7u4zDO+m7mfel66a22RxdOpkU/vmznUidYHHyTlMFwSVsQ9NfPhvIBHNZB7ZCWNXj8NmC
 bls=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788140"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:30 +0800
IronPort-SDR: lZi/9NUlyNvRozttcyzgeVAZYzCvtNxVeDlkxppNrU415wn2XVKOoSG9Yj0tWgjUjdg5IvUE1w
 Owz6YvNULsZqLBuhdY/keV2DbYJ/RIdm+QcpDirGHIfidIg/if1bsh3WD1b/Fymq662kwM2Nvq
 Uji/UjFtzQjAANgNt0UXCjujiLLW70qq/f7F381vcdWxugnuilYBJDNzsse978DiEGq6gH3YW1
 dSjglvwoQcsPc1mcKkXDySxJHqF+v9QVitrUXB/8G4u8idO9RVLKwDRPoiYonuO/vC92CX9MPn
 7EDi2ZL9B9g68xolcwRfednH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:56 -0700
IronPort-SDR: OtCZLyauE2Jfxh/HCBdLTj8k2IqEaMej/JhqSP+7r0WCtrZsnME4X9vtk+gXBc5JFYnRAoUJp0
 XquFOvfFqDPD9WT84qPzduzUuhAnZDPiEHWVja3qbSBUF0jhNGE9zXpki1Sijkx24O11KnQgXw
 CPJ5Z2iscWJgNtvj9KOCbOXw0kcIwX1XYmMSmZW5ts8cHq2e7rrHnY6ZgZ8dK3vEq4DNlzDfVm
 YYtyW8YB6a4jkm3dfMzS3F/CsNkT8YDXX9yRQPgi4YHdaKlejjYa1qPoh6Eqc8pkJznFFFaDE4
 lWs=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:31 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 21/26] btrfs-progs: mkfs: zoned: check incompatible features with zoned btrfs
Date:   Mon, 26 Apr 2021 15:27:37 +0900
Message-Id: <e5868bb9c387edd53b3863efcc366056998b28c8.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit disables some features which are incompatible with zoned btrfs.

RAID/DUP is disabled because we cannot handle two zone append writes to
different zones in the kernel. MIXED_BG is disabled because the allocated
metadata region will be write holes for data writes. Space-cache (v1)
require in-place updatings.

It also disables the "--rootdir" option for now. The copying from a
directory needs some tweaks for zoned btrfs (e.g. zone size aware space
calculation), and we do not implement them yet.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/common.c |  5 ++++-
 mkfs/main.c   | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 368f3b06f75e..6b0c434fbd6a 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -204,7 +204,10 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
 	btrfs_set_super_csum_type(&super, cfg->csum_type);
 	btrfs_set_super_chunk_root_generation(&super, 1);
-	btrfs_set_super_cache_generation(&super, -1);
+	if (cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)
+		btrfs_set_super_cache_generation(&super, 0);
+	else
+		btrfs_set_super_cache_generation(&super, -1);
 	btrfs_set_super_incompat_flags(&super, cfg->features);
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
diff --git a/mkfs/main.c b/mkfs/main.c
index 42e6e6b58b04..9407cdfa8fe7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1191,6 +1191,23 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		features |= BTRFS_FEATURE_INCOMPAT_RAID1C34;
 	}
 
+	if (zoned) {
+		if (source_dir_set) {
+			error("the option -r and zoned feature are incompatible");
+			exit(1);
+		}
+
+		if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) {
+			error("cannot enable mixed-bg with zoned feature");
+			exit(1);
+		}
+
+		if (features & BTRFS_FEATURE_INCOMPAT_RAID56) {
+			error("cannot enable RAID5/6 with zoned feature");
+			exit(1);
+		}
+	}
+
 	if (btrfs_check_nodesize(nodesize, sectorsize,
 				 features))
 		goto error;
@@ -1280,6 +1297,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (ret)
 		goto error;
 
+	if (zoned && ((metadata_profile | data_profile) &
+			      BTRFS_BLOCK_GROUP_PROFILE_MASK)) {
+		error("cannot use RAID/DUP profile on zoned mode");
+		goto error;
+	}
+
 	dev_cnt--;
 
 	/*
-- 
2.31.1

