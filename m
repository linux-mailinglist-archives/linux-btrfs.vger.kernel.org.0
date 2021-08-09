Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D743E3EC1
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 06:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhHIEQ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 00:16:56 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13744 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHIEQz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 00:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628482596; x=1660018596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hA1aSKCzLtksRSM7DvL1py+sHcG52yWUT2pbmXtY6p8=;
  b=AacDJ1joamSEvUptOXagwJVi7nPqENMtLpsDIDE5r0R9MqGw75+DZ0rb
   rqd91HhYA1X3ZEtHv8RJSquUIRpYVEYMeoo6Odj0YloXe6IaCI2eozytX
   F8Q2kivHC+DMKHeHQ5rKatoEP8jAfJIN1vefkez/xMTpc2cUbR2Bh7+lx
   R6fSpsDt9YjtiULRjGj5ZbUa+DvatQc2r4DULthe6hzN1EfcSqngHaBY0
   9bLbhIgiLuVjjgF64ASOxpEcspjj7NDmsRAo47kQYLPanNhJezhGaL2IM
   aYZnwqfsYZABwyQ7c3AwSHF3UOdJV/EemEcUF5j7h6cYXoCyflJDkeLon
   g==;
X-IronPort-AV: E=Sophos;i="5.84,305,1620662400"; 
   d="scan'208";a="177208482"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 12:16:36 +0800
IronPort-SDR: 2/3m9fRvmZJVHdjQo4DKGmigqopP3QXaE7DYeiAhQWOhnLM0mG+28LjV44Qx/rFIi7l9WZfpvR
 2AQB66Mt+RYX8yTm0TEBk0WrnpNAovTX3fsUqs8e0MF76LRRBxWpR03I0R4l+a+EP2G+W1ocjW
 8wzNEmxGopTmKtRGGha3ejwbfHM133P3MHN41W9SxG7reUhhZdBk635sA2CD0fYGsWxpWYe+XA
 kHxPAyapT2nSw4UJL1zX5F0VoTAs74zQnyLp1+3bofGgtnhjFxDmkewvhVSVsgT5r3135R7Ab3
 JBjOQS32IqpgPa3j3p+6QBmm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2021 20:53:59 -0700
IronPort-SDR: QDhulQRt6xNWZOMN+dUT18Djpi+Rt9KJFhlewpQ/M4Ez3yh/dpJUTPRirUA+beqNBY/ay9FCWV
 d5uWCK1x1mVA4I/czpNYEEPEHhxO1MDM0Qa3pxIbV4c9HZIseSGQWC08PZVfJFeC5+UohBAdoq
 +w2QuRr3QJX7LkgS12TGYhR37uUbrPBV4PtXPM3Fm1OPLUWaYzgU3RKa31ehMQYyuOseftb2/e
 PNbMp4GRhNdny9Zn+9YJKZvj1ty/2K35QrlO6CljbqWunWNTrbpH55BavUCkL9R5w7zMUkg5JA
 IQ8=
WDCIronportException: Internal
Received: from gczpn73.ad.shared (HELO naota-xeon.wdc.com) ([10.225.57.167])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Aug 2021 21:16:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix alloc offset calculation
Date:   Mon,  9 Aug 2021 13:13:44 +0900
Message-Id: <20210809041344.3002897-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

alloc_offset is offset from the start of a block group and @offset is
actually an address in logical space. Thus, we need to consider
block_group->start when calculating them.

Fixes: 011b41bffa3d ("btrfs: zoned: advance allocation pointer after tree log node")
Cc: stable@vger.kernel.org # 5.12+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8eeb65278ac0..e12f4d34e317 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2646,8 +2646,11 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 		 * btrfs_pin_extent_for_log_replay() when replaying the log.
 		 * Advance the pointer not to overwrite the tree-log nodes.
 		 */
-		if (block_group->alloc_offset < offset + bytes)
-			block_group->alloc_offset = offset + bytes;
+		if (block_group->start + block_group->alloc_offset <
+		    offset + bytes) {
+			block_group->alloc_offset =
+				offset + bytes - block_group->start;
+		}
 		return 0;
 	}
 
-- 
2.32.0

