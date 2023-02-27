Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB56A3D97
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 09:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjB0I4t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 03:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjB0I4L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 03:56:11 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959EC1114F;
        Mon, 27 Feb 2023 00:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677487689; x=1709023689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8LlWHiILWzU6UM2EHpB7dniqAhKHMKZtA1qzRXHnHgo=;
  b=asFhr8M3T1h4CtMtToS0bqRjrDl05N8XEKOcSOBfDEQ+gBWnoL18ws/X
   i2lXbqNP+ju/ZJ/vmrNViDbbTGWzxDpg1NOyTWtlML4udUA02+SWQAslM
   S4zyamQQa2y/P1qIZ/CkpsiTv66L/Us+83JZw2lO2xDL1yEaphlEohxb7
   KRriqjeOy6HY9+nohO42HvD6VokSy8+I3b0zCGldJ7qVnN7qTBC2Sol2G
   xMtUKbyk1XhgImVSGxZF5GWbJmbJIIzti0qZ2z2rWcMuR9HZMD/XTXwb0
   y56IBNMh/yjYBGeniOxMCTZpy8Mt9/ooB0Lg+DtnZ8SeWgQRb/3ItxUur
   w==;
X-IronPort-AV: E=Sophos;i="5.97,331,1669046400"; 
   d="scan'208";a="224310894"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2023 16:27:24 +0800
IronPort-SDR: lOEGi9hSo2rdtg4cODzPZqbQQsljDQHVMfvfURqEfN8pbhKXPTaiGZqqmaWVbTXid+KfUNr/HU
 H57m9wzgvkcsPZ1varmHv1eKL0TJgK7BSjzB5f9nLNRnxDYN7RNzNvpdJPcXLbAVeCzxuYK5cO
 X8MruIANfDqc36jSVPw08Czu9Hvwx3svF9DZjwPDesBjRyfWPsit9se1DmOX0LJPUBZohChyda
 xbvwn+cPvT5/5Bdw9j7v5wC/4VtfEblq8up9B2BJfT6bGhwg00mhxCWYVKNwuzMlyXMWWX/reW
 yDg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2023 23:38:33 -0800
IronPort-SDR: m4YPKTAdjLd/5Tic5M+KNi8otvn0t3gbnlaxsc6f3Cckj4cTKPbj4KUxaW0vK+75fEqzpYfB8D
 Q9JUjIqzW3R+JqUXNgCJO1TnLsqG3JN/gL5IhnB0s8lKJLe2nz+PJPq3dxyxx5XipYTiNpzWjU
 nRr7PvfPydEtE/44sRasbVZ6msfBzuV23kimg8cU/GFnIOEfknYBI4dUM5mubzafQD0IVqF5kB
 hueaaiJJJMzBP+DAIxsgEaFl8/VwLIFgLj9KvOZfX3TUeaF8OlYbP/DZmUxzUZF9tiHQ0UVKm7
 dbk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Feb 2023 00:27:24 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] common/rc: don't clear superblock for zoned scratch pools
Date:   Mon, 27 Feb 2023 00:27:17 -0800
Message-Id: <20230227082717.325929-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
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

_require_scratch_dev_pool() zeros the first 100 sectors of each device to
clear eventual remains of older filesystems.

On zoned devices this won't work as a plain dd will end up creating
unaligned write errors failing all subsequent actions on the device.

For zoned devices it is enough to simply reset the first two zones of the
device to achieve the same result.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/rc | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 654730b21ead..739abbdbfc8c 100644
--- a/common/rc
+++ b/common/rc
@@ -3459,9 +3459,15 @@ _require_scratch_dev_pool()
 		            exit 1
 		        fi
 		fi
-		# to help better debug when something fails, we remove
-		# traces of previous btrfs FS on the dev.
-		dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
+		# To help better debug when something fails, we remove
+		# traces of previous btrfs FS on the dev. For zoned devices we
+		# can't use dd as it'll lead to unaligned writes so simply
+		# reset the first two zones.
+		if [ "`_zone_type "$i"`" = "none" ]; then
+			dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
+		else
+			blkzone reset -c 2 $i
+		fi
 	done
 }
 
-- 
2.39.1

