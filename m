Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6A7C7030
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 16:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjJLOTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjJLOTm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 10:19:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDA7B8
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697120381; x=1728656381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IdAAzt6f3rUYtThAbrxcaozlewOgzEiWr447HHOtaO4=;
  b=IWyk8bCywBjDyOFqcMHr0yZtsvDLdg5H0rX+vqlleY/CQT+siAnsJ6k1
   o6tPjjPRxU2ymNmwi9W27+hRt4pGlAcbMQ8vRm/0CXj1MRV5sxxhLMf6L
   5KTnaterOFbBeRd9IK5LM1fNRdPL1/XVJR7B6e4fXmwKaAS3rImq+ILfi
   9upKlw0YmbyB7LoF8AVeCS7Qx7E6gAhi0HxqN2VzVN8ZC73gH8P5RS/8X
   ZBpWSLsS7ACXIa/g6SHvY2KHFmatcxjYNH0xPyNpLv8kDZ5cXr0zC2HGL
   imzpEOWVkL7cOeCp7bZuPbVnwihGZqkYx4/hhBBGoL9SlN/xmkPqE/Kpu
   Q==;
X-CSE-ConnectionGUID: mnignU45R8eIOxSiHF3xMQ==
X-CSE-MsgGUID: IRtZUPIrTgylxNdfxyglyg==
X-IronPort-AV: E=Sophos;i="6.03,219,1694707200"; 
   d="scan'208";a="351743177"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 22:19:39 +0800
IronPort-SDR: zFUKbf8dYmGjYS9pd6GkpC0LjgEJ0Q9XkvknSxQ28x7l3YGmg4/hCqO44U5IKw6i3ZbDRzRJ2r
 U1jMRc5UI4R6Gqo9PfV9IWzB/YJ65JgXXiTSn4kNPcTHUetcjmNJpBeASMBMbm/wx28UflmF/+
 bjYffXkbdGkZuav3XhB1rbtr1OC6dhnM7NCI4AQl75z3Yhnetvo3w2lX2MY/n+XixSqpKWpeoP
 p3yA+5OIYy5XD4aOgnKPhfxw5tbcd2Ee5nKxVM5IrZY6atY5YdKU9Wui3QHnW2sXEY6HPn59Jn
 KtA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2023 06:31:47 -0700
IronPort-SDR: CZEobGRVgPWckf+o0Gie8AGKN6cFS8/dSPQXkE7KZDPWOZD+EU8Mapxp2EYey1SZk8tyH7GzxF
 xMyNjc1LzyaVDjXdJZuQ/yQBdqAroWzcymmi77ijqazihQNy+FhY8tZqJPTGfHt/x1vxuf1UmC
 dQ3BfhFHK5Ngqtx1PMx6hvlq2UEzd+UZuUiZgZ2phXK9MLHiw4OXQAE+TGRz4gjVPG+8Op/GWu
 EP6u2VSNL/cPyke01S4O19xymt42oVUHziBmfIzUX+cZxHntnHIRcEl22cKisIxzfwUlZSV09B
 q+0=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.25])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Oct 2023 07:19:40 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] btrfs-progs: zoned: introduce sb_bytenr_to_sb_zone()
Date:   Thu, 12 Oct 2023 23:19:29 +0900
Message-ID: <c1cd55d17422293d19bf8f8b0acd2a7d8b94c7a7.1697104952.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697104952.git.naohiro.aota@wdc.com>
References: <cover.1697104952.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce sb_bytenr_to_sb_zone(), which converts the original superblock
location to the zone number of superblock log writing.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 16e83f8b6331..206ad906c985 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -478,6 +478,21 @@ static int sb_log_location(int fd, struct blk_zone *zones, int rw, u64 *bytenr_r
 	return 0;
 }
 
+static u32 sb_bytenr_to_sb_zone(u64 bytenr, int zone_size_shift)
+{
+	int i, mirror = -1;
+
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		if (bytenr == btrfs_sb_offset(i)) {
+			mirror = i;
+			break;
+		}
+	}
+	ASSERT(mirror != -1);
+
+	return sb_zone_number(zone_size_shift, mirror);
+}
+
 size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
 {
 	size_t count = BTRFS_SUPER_INFO_SIZE;
@@ -489,8 +504,6 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
 	u32 zone_num;
 	u32 zone_size_sector;
 	size_t rep_size;
-	int mirror = -1;
-	int i;
 	int ret;
 	size_t ret_sz;
 
@@ -532,16 +545,7 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
 
 	ASSERT(IS_ALIGNED(zone_size_sector, sb_size_sector));
 
-	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
-		if (offset == btrfs_sb_offset(i)) {
-			mirror = i;
-			break;
-		}
-	}
-	ASSERT(mirror != -1);
-
-	zone_num = sb_zone_number(ilog2(zone_size_sector) + SECTOR_SHIFT,
-				  mirror);
+	zone_num = sb_bytenr_to_sb_zone(offset, ilog2(zone_size_sector) + SECTOR_SHIFT);
 
 	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone) * 2;
 	rep = calloc(1, rep_size);
-- 
2.42.0

