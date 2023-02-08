Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C165868ED60
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBHK6I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjBHK6E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:58:04 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAEB144A3
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853883; x=1707389883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I0Gn7m5tulzrtzgvKene6GK3lQmNBfTo7Rai58K13dY=;
  b=NdLYgc4jfbPuW1flTxpXs1gPoh1FdM1s9io818qeSBzMrY/qjWaZOki0
   +NA/nqVEz4fslAPguNEnG0Kv0h0Ypc3EzaKVXwoQyx2q6gyh/Mwbl6DMR
   NqUXzGOmQdN8R6JCrerI0nkSmDwFGeosRbvbgoyHyaHyb/WH2XNBDOBbj
   H0Jmitcgc4e1uNZA96YwmVWpEaqI77W51uCjbMk/AjYQw/VdVxV+1ZsZx
   AhvOuNFoLJQapjcA1K0uVSDEf+Q5ZcvtBF/np7qmD6y+zd7J9aTokJUE4
   1Ye3FQJkGETEooSq7XewtCuUvzlajcmVAe+9Lzsil/IYedgBXTFI/E+WI
   w==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115647"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:58:03 +0800
IronPort-SDR: lpryzls5OmJYtJozy7BIsIOjzAof6GRqT9kAX6OEMXDmitRtF457KlZjiHBfOmwQHcTKZ2Tl7J
 zbujgkZYojzfLXBseCINfiPWUaPVMafbcb3bGYO3IEpzmOBNSN6TQP96f/NQRWyapKcpSvsfji
 bqdDo+sPrPng1p9o5nObT9b384RnIVlGpoXPGSZuVrkwR3Ns80nYLrq3il1VqyPZuXQ5mUt0g7
 GN6RDSxMfWlcAtNoNzDGUTjmGT0JlLcH7qt9T7Lt4bsh3DW7N1pBXfwDdbsD3hCT/04iWhQDyM
 Am8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:19 -0800
IronPort-SDR: 9CiCrT+4HAfOy8YeLBz12EkL75j0TeWG/mV6Am4emqaHHe7KjoiYsBH5MVnulamheOsV3NZ5M7
 NafwTu0yHIoUpRYSYj1sHx5ldM+O5Rrz+i9B5GgFaCjDU8lgzGm0ToTDGj7uDvVdcVt3aCeibO
 e3un90zoYWRG/BcUCc/awPUQO/AUfKv/tt6h+H2HsLk9ZTNiY32GaNBYfMhuwKfxVe7iuCMS1Y
 +NCe6f3QMd4+D6zSknHk5TZumAFUZ/djSTlkzY58tRYkOmfkB4ifgntpVgN4hZUKAIo2KM433p
 9tc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:58:03 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 11/13] btrfs: announce presence of raid-stripe-tree in sysfs
Date:   Wed,  8 Feb 2023 02:57:48 -0800
Message-Id: <ef669592a878eb975e4bee1d869d17446e10c111.1675853489.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675853489.git.johannes.thumshirn@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
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

If a filesystem with a raid-stripe-tree is mounted, show the RST feature
in sysfs.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 108aa3876186..776f9b897642 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -296,6 +296,8 @@ BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #ifdef CONFIG_BTRFS_DEBUG
 /* Remove once support for extent tree v2 is feature complete */
 BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
+/* Remove once support for raid stripe tree is feature complete */
+BTRFS_FEAT_ATTR_INCOMPAT(raid_stripe_tree, RAID_STRIPE_TREE);
 #endif
 #ifdef CONFIG_FS_VERITY
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
@@ -326,6 +328,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #endif
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
+	BTRFS_FEAT_ATTR_PTR(raid_stripe_tree),
 #endif
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),
-- 
2.39.0

