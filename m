Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A184AB3C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 07:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiBGFut (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 00:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350023AbiBGDLG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 22:11:06 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF2CC061A73;
        Sun,  6 Feb 2022 19:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644203465; x=1675739465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqFAptI4CAvK6M8wR+plx0XzaNREix5nWvG4orfRMAg=;
  b=XpvkIudmsVwYXdfvRVxrEu3YI9mg2Tp/0r7mkkWgvbkPayzMFBccPi8J
   2hI3Wj/ynKAXTYVvF11qPRvv/Slbe7dlTDCGq54miL58QSp/BYDHx9tNL
   ZpGO62dnX+6nlfihJxiG4r3gnylekQ6+pm8wgGBx6ueXhmO7RB61NqbC0
   hb986S+jBDvKx4PeUUMx16QhbCr/4eg5DigZ3P6YThIM9Q3RTLbHaKyCi
   v8QRtekxAAed2Kl9suIRrR8L2o/B2ha5iyWRBvzwZmUavrZIqV1MvPZVN
   FZPNUlRvlnL9yu+C1SPmKkO9bUQkgR+JHKKrnFHd9OmHFbnbmAaQ4vFl1
   A==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="304195997"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 11:10:02 +0800
IronPort-SDR: SdOoGQzB2Zm48iE5HGZVuZb2pRxbnhkRHh5soKkyDrvBmM8kIWM87T3DRCkBwMnEhPfS5E7fB4
 8SJVOhq231bRoc3ajO+W/kicQB1Hw5v5yQFVhArBXPG4MlvpyNU6Ux6Sy6jjFbsdoHmuQiTigI
 1UqOwraOtnS3ydG07MuXgjcBVqswTYcW2E1CSUeeaSxadFE4eRUtXa5JIYwgZimqDgh1LZOfaP
 i2yHJbfExoUbsnB0ydYINWKW8R2IHXtDQTTCHA35xuGVY2tkUgC+MPl+3tbZzIR/kTdarQisxS
 zzjzimXuk+DYK0J51cZE0mad
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 18:41:53 -0800
IronPort-SDR: SPduAgPqpHjDHi4kbUW4++2yG6CydfIH0z+JM0CoyBFWYpKHkL333gEEPc4u5BSct9Ambige/H
 ShtjhnhUCR7JkbHpzn6KeZiZieYRls7iebq1Tm1Od+0Mbx0NTcZmITNwuSPBK5K9NMedUSxa2n
 Tv/IViTSdoiJxTiCF4yXbSb6X6PLdbJ/bXyXBbKZYl4aMRGNX+PPiww6npn+Pp/ujaNsEMkB5U
 KPvzgKy9uwqiES6TxvrRvIP3wWQW8J0XzXWO8md3F5xOpzSNAq+MYYVWa09bGNYt7ByOoHP0WT
 WXM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 19:10:02 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 3/7] ext4/021: check _scratch_mkfs_sized return code
Date:   Mon,  7 Feb 2022 12:09:54 +0900
Message-Id: <20220207030958.230618-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
References: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The test cases ext4/021 calls _scratch_mkfs before _scratch_mkfs_sized,
and does not check return code of _scratch_mkfs_sized. Even if
_scratch_mkfs_sized failed, _scratch_mount after it cannot detect the
sized mkfs failure because _scratch_mkfs already created a file system
on the device. This results in unexpected test condition.

To avoid the unexpected test condition, check return code of
_scratch_mkfs_sized.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/ext4/021 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/021 b/tests/ext4/021
index 62768c60..a9277abf 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -24,7 +24,7 @@ _scratch_unmount
 
 # With 4k block size, this amounts to 10M FS instance.
 fssize=$((2560 * $blocksize))
-_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
+_scratch_mkfs_sized $fssize >> $seqres.full 2>&1 || _fail "mkfs failed"
 _require_metadata_journaling $SCRATCH_DEV
 
 offset=0
-- 
2.34.1

