Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDEB4B0F25
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 14:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbiBJNtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 08:49:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiBJNtC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 08:49:02 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2888CEA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 05:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644500941; x=1676036941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pxWNDcSvFaadlmJiGERuAw9TBtmsiqN/dCUBAP5jAzo=;
  b=CuEAFZ3ARwQA+0WrQQWyB5RI8Ssf1P3Mc81fBGuMRRwEAQZGKHrERN2N
   e6X5J6w/CNsKY1iJrzGxBUXwGTzE93kTUnkfEdE29dB74XsPOYVIEe6UZ
   z6YsHgFgXrFpC3jAX5M7wg3UQUGizip0gt2E0aqr5xXcpB1qZ74fHpbaL
   YlFE9UP4k49bhNHywGNoeL/7zNhyJVP3rvMcjcWyiqkBKWSccQ4o7ZdbI
   WjJwJAzMgWHoiglgDW0JYGXQDiSAXS+mO2WHo7y1rGOp1KDKaYRIJnArK
   EZuGkyHEDzfFd4w25jdipre/M4dgZyx7XDdONz9N6OOJB1MnaQa4FgfQz
   A==;
X-IronPort-AV: E=Sophos;i="5.88,358,1635177600"; 
   d="scan'208";a="197419954"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 21:49:01 +0800
IronPort-SDR: VecUtDvtEnMBFr48pKILJ/4vSsz+jYtNTKU8/sTgBylsCTA994KaprYbhslPoQt6REvm5htENI
 jNTDXC5WsOam6pihfmLIITcerAA8s3BKhDZwkpUZ2bp2KXKouLvP/tSbSZOLLEmNFtcNE37/PB
 n7KJSPJBUAAgozZUJVrIxFrSqRER2GGva9mF30q4WLEgb8kSLkipxf9YuwP9nTLLb2NCzqbna5
 vnv4w69UAFiwue2YVTXiLpCqGPZ/2HIdWe4qrtey8ce81JBs7lT37f8gAAumvGoV0Z+/A7AzhP
 jVxS8Op/F/XD3Bn6ra8fzCBn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:22:00 -0800
IronPort-SDR: 6tIDKxio0RADZivzvBHoMErmgcQlBLGYrw18LI1uh9WnMg9cLjRCJodtW0ptyu/AxFnKsfiTfv
 1odxhywXVGzZRg2acZOklKi2YkqdypldzSuhLtRXPnyqQQZCdqraFSgI88h3YGbgCBbVwyZ7y4
 +7ExeqrFp8KtJ055Dg1eg4MfB6UufR6XUISVhHuZW6zs8hKJF/pZzM93QiDX86mil4Ij4H57Ov
 iSNKiMv1cYAe6ItlLI8rCdozTQhIi8XffkYPiApPgpRmajHD/FlamtfeG13XOBuWKjnLzxq6wN
 eSk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Feb 2022 05:49:03 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: zoned: add upper and lower zone size boundarys
Date:   Thu, 10 Feb 2022 05:49:00 -0800
Message-Id: <20220210134900.184638-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.34.1
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

As we're not supporting arbitrarily big or small zone sizes in the kernel,
reject devices that don't fit in progs as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/zoned.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 2a11a1d723aa..2665861f23c4 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -47,6 +47,9 @@
 #define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
 #define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
 
+#define BTRFS_MAX_ZONE_SIZE		(8ULL * SZ_1G)
+#define BTRFS_MIN_ZONE_SIZE		SZ_64M
+
 #define EMULATED_ZONE_SIZE		SZ_256M
 
 static int btrfs_get_dev_zone_info(struct btrfs_device *device);
@@ -307,6 +310,17 @@ static int report_zones(int fd, const char *file,
 	/* Allocate the zone information array */
 	zinfo->zone_size = zone_bytes;
 	zinfo->nr_zones = device_size / zone_bytes;
+
+	if (zinfo->zone_size > BTRFS_MAX_ZONE_SIZE) {
+		error("zoned: zone size %llu larger than supported maximum %llu",
+		      zinfo->zone_size, BTRFS_MAX_ZONE_SIZE);
+		exit(1);
+	} else if (zinfo->zone_size < BTRFS_MIN_ZONE_SIZE) {
+		error("zoned: zone size %llu smaller than supported minimum %u",
+		      zinfo->zone_size, BTRFS_MIN_ZONE_SIZE);
+		exit(1);
+	}
+
 	if (device_size & (zone_bytes - 1))
 		zinfo->nr_zones++;
 
-- 
2.34.1

