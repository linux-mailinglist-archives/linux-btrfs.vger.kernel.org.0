Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B46B3E3F10
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 06:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhHIEgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 00:36:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:35321 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHIEgZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 00:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628483765; x=1660019765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/UextGNgC5UBKfiJntyIJ8W0ypHKds/GTE5WsdxJo5g=;
  b=eLL4D/oyfe05hJCdwQW2K7bDW7DEjXDk7en10d8Vid5ToaMblUQZkjvT
   Sbp0DNV9/h6a1tXQsDHfjABkxRZhrLbUcz042U0eIW+87dk33DDtlNzJT
   1g2A6z8l4h1lWGwlGZoUkRJUBz+zFld0lvQtWb/Z1w8mE9exWeMoDUIWF
   /fILPcxM6lRT17b15Jzh6p/DadWEk+jndET1dB2HxrH3m6A0Lk8BTmKyy
   teI/C1496amcWOuyHPSV5YcS2fTrtrVPDVyGlwjr5t17T5wyMiOUURC/Z
   E7bOkqo2cVeUWCMkCsWnSYuxxRsaRrG3fgrSugcve9kV6kdqtGoTX9U1N
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,305,1620662400"; 
   d="scan'208";a="181461533"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 12:36:04 +0800
IronPort-SDR: OGP7ME+9hDlYvV1FkFC3SXme2a3KZwboNKPZ52x9yS4MfgZ0inhDyu7U4rgEsYNsrOvy+cz9Y0
 1u8Yg9Mgo8m+ZK/Pyzw+Tcz2Q6qiqsVQX9o5XjB4Y8rlc0RKTwKuy4Y6jX+tCi8Z5hX1n7I0ie
 ZT+DU6lEenpHpuh+5GvTUHD6E2ZaErqizWVsilQC3N8OFlleNBIxgTXPb6QqLUwFXs5GQWf2ss
 cDxtix4VVaCYoFOrE1ZPfk/aPoUeAckXYnD2osiiMWHl5DSV1g3OAIpQSVMdXWB09dWLSZJquf
 jgsZfgAcGPFdVqrDAR0xv230
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2021 21:11:38 -0700
IronPort-SDR: EBRh7NZlwd7OC0NWCaALUIiQDFsLWBe7sMcvg5ZGGz1TZJLRh3vTkdCmFxpYVRzPerzP6Oda+q
 03zhXbZVWQtTyhKDHVOyHt9JWGInRW+b1LJtXq8wRTSWbZcPL0hkYIMJE7ePQyCgQNf5YPLYvu
 UG0cKU5c5eGT0ndtB6WyjATxvuqgnuIOHyUnDH9CylNPpvk812KI96N50//nkYF7raVL0OfObr
 EBd1ygqDIS62bDA9ev9zJmEgKcmGkuMYx4E4pIwerf/hjXSAHYRyzmUfHkV/DKX3EqE3CNhnu2
 jj8=
WDCIronportException: Internal
Received: from gczpn73.ad.shared (HELO naota-xeon.wdc.com) ([10.225.57.167])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Aug 2021 21:36:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: suppress reclaim error message on EAGAIN
Date:   Mon,  9 Aug 2021 13:32:30 +0900
Message-Id: <20210809043230.3033804-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_relocate_chunk() can fail with -EAGAIN when e.g. send operations are
running. The message can fail btrfs/187 and it's unnecessary because we
anyway add it back to the reclaim list.

Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d5421ee0d366..a3b830b8410a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1561,7 +1561,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
-		if (ret)
+		if (ret && ret != -EAGAIN)
 			btrfs_err(fs_info, "error relocating chunk %llu",
 				  bg->start);
 
-- 
2.32.0

