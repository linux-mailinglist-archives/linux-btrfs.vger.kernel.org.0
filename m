Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B11E36AC34
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhDZG3Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhDZG3L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418509; x=1650954509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0YA7DcbyvtO3SDNosMcpRwVPiz2Do5MC3wVv1b8aPKs=;
  b=S260SYDTAVkBPt8eegODHv8YwYaLO+Tx3rvxvzdsmQ24FHo3r81B2u8M
   ArB1NaC/YFS3dgl2g+Fd/4vaNqAMr706Qu/yK8LqJ55SF92o9U7vA24Dz
   klfc5DGa1qoK3BF/frqiemoyszv58PTnJgX2OGHgYgW7wWkSz44sMxpRt
   M6goPg5+bo5wb44iOmCv60nBakakOjURpq+Ik/R2j+QPU1K8kFYhYXbwC
   dva3JE8gieftKfxkgHz4A7ROrNDoOTV8lPJ+uOBfAmpaFr6VfIJrVXT1N
   xu4QtnA3873xuKuoWmUDrd3mVenUWLXdtW5R/IG00lcju+2SNUGr6Ftjo
   w==;
IronPort-SDR: cqicdXCZda9Egz39XURh34BsdNPMjV/eJbmoP70FlS8eZcjhZIOgwp9mPNaBc2QmPL/fsBUqn8
 hIefdy2AGQbJN0v9dpidFxYLl3B074HMOzB3YzJ2kbSq8AZ6y3Bgu/E55PWiILZKqIQ66c8+bj
 pWFb4j4lfzSWfjSnPeHsL6/zL+dIBwMV90RMtuO8u/05xM4AIVTbhyB3ktnDN5B+p/q3Dm+R2P
 BwsgoKlY1nK5r/H58l5yM7BQ/2TZI/0QxvHXFRzXrGu6cbeiL5H7Lz2//ajFhTooOlE2IUzY7l
 RXg=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788136"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:28 +0800
IronPort-SDR: 6504aNTL6yb5GxMMNAZJ0LwcmuA/mKQrqMHF2pjbeAmUS1U/Y4CbpoUV0WtdyG6B1KfTQhtVOa
 k/F4aYs3E8DxUciRgkJpqVCTI7nTNu/I5RjwPZztaLl48iHS5kVamV1cjQZIDO2S7wkqwFxEJq
 q9N559ylfu1R0KYEFXLt3y6suLomwQ8DrLCiScyesPN+0cDSdIxBpV2wOYpKQexNOa5ehop7+g
 eU4pWyUjv8ViHe2Rg+xAoSbG3Nwe4HaRt+GYGDFsv3TeTxRx6gWYbFMrO1rGM1g+5Rxru1JgR0
 tMSzdEuAvqu4mpAIarijvOXf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:53 -0700
IronPort-SDR: /tAlQBwlfX1ey15QYHGklUNDFWZZ/0C+sVNDr+W9tXXO05k3qU6YuaXD8/BCKMvwoJ3eaVXhAV
 VVEyexv0bJ21qCeG6bzfZYxPtUwHHm1Il9c47lUTAScNAdwswukaoNhjBNu79y9CnJ5RVfa53a
 Bd6rjM5LxpKK0fPbTxsk4um4nUl+IdZFjPujvgLjUzNYXAWlsgWbJJLwO/r5TRC37CTED5nUpW
 H//JW2K/CKr5iYW6JzS52BeNwF8ALp5nXHf+4Is9DdaBZPJ7uqQ6/RuQHu0Qk85TeP+P+7Q2PJ
 X70=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:29 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 19/26] btrfs-progs: zoned: support wiping SB on sequential write zone
Date:   Mon, 26 Apr 2021 15:27:35 +0900
Message-Id: <f364599e85396d50becbc7179b5dc00e0d9a9cc2.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We cannot overwrite superblock magic in a sequential required zone.
Instead, we can reset the zone to wipe it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-utils.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index c1006c501555..4230654653aa 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -106,7 +106,7 @@ static int zero_dev_clamped(int fd, struct btrfs_zoned_device_info *zinfo,
 	return zero_blocks(fd, start, end - start);
 }
 
-static int btrfs_wipe_existing_sb(int fd)
+static int btrfs_wipe_existing_sb(int fd, struct btrfs_zoned_device_info *zinfo)
 {
 	const char *off = NULL;
 	size_t len = 0;
@@ -141,14 +141,26 @@ static int btrfs_wipe_existing_sb(int fd)
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	memset(buf, 0, len);
-	ret = pwrite(fd, buf, len, offset);
-	if (ret < 0) {
-		error("cannot wipe existing superblock: %m");
-		ret = -1;
-	} else if (ret != len) {
-		error("cannot wipe existing superblock: wrote %d of %zd", ret, len);
-		ret = -1;
+	if (!zone_is_sequential(zinfo, offset)) {
+		memset(buf, 0, len);
+		ret = pwrite(fd, buf, len, offset);
+		if (ret < 0) {
+			error("cannot wipe existing superblock: %m");
+			ret = -1;
+		} else if (ret != len) {
+			error("cannot wipe existing superblock: wrote %d of %zd",
+			      ret, len);
+			ret = -1;
+		}
+	} else {
+		struct blk_zone *zone = &zinfo->zones[offset / zinfo->zone_size];
+
+		ret = btrfs_reset_dev_zone(fd, zone);
+		if (ret < 0) {
+			error(
+		"zoned: failed to wipe zones containing superblock: %m");
+			ret = -1;
+		}
 	}
 	fsync(fd);
 
@@ -227,7 +239,7 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		goto err;
 	}
 
-	ret = btrfs_wipe_existing_sb(fd);
+	ret = btrfs_wipe_existing_sb(fd, zinfo);
 	if (ret < 0) {
 		error("cannot wipe superblocks on %s", file);
 		goto err;
-- 
2.31.1

