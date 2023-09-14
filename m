Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE827A0A68
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbjINQHj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbjINQHU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CEF1FFC;
        Thu, 14 Sep 2023 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707636; x=1726243636;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=D+BzdF5oP8uW6qZ5ynzhWFTIk+tOOC9drG8BemLcBr8=;
  b=FkmCiYs7ZQL5tJuTDHq3ncCQrXPjjzu6MG+ixXAl98jgq1sndvX6S/ua
   WB4vxT7q5vWi++fG+iaBQhK44tESYw6Hq/FuSO69cFin5AzQFGEUWcljh
   +xDehtMmpUAXEIQry1ck7Zxfb4uaclQswkFnzxuQxCOu5c9OM6Jkrxf1m
   Pf2/+xCQ5tKzYRVSQzmHFrUsTE3ZuFhZmQ4g6f2bGZ0/E3Tsc7+vEqOGe
   7C8hv6ECS11XLWKGzTeQAQ3ezeVqWGQolNnf8tt2SCZzaXRKvh68/lD+Y
   2VG5N0UMLmKwYSDtZ5iOAQlLHOMtl7dl8cJH9MD//EqZvEMqq20uZNts6
   g==;
X-CSE-ConnectionGUID: rJBrTymTTcaM/UiAnmdt/g==
X-CSE-MsgGUID: ESow74hIRhuMDGqnZl3+Zw==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490553"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:16 +0800
IronPort-SDR: 5G4AWbt3pQNhr4i2mGZ3W7mXiYM8uofLbDKCL/jS5YUFsCcGadLKBD5s06W8wQ3p9fn44pGidE
 R/TUL4XCyOVvYM/ZkdNt5amK9Y6W6gZH8hK0jTRwPqQ0xPJ+0UcH6aPmrNzkO6geUPedKXbdgQ
 fFOEx6R2S53kBV8ZevpgrCTNi/WpO6o8kM0Qb0AcKI3rdcSbSCxADkhu3Dlv/ZNzFAKTD+uF8l
 Jjzk7yYYfzjHucynoAtMoHa7CZ7y2pyF10owjMIbqTeSLlmAotHTr0rf3qCqcXYSgrVeb9focB
 T30=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:17 -0700
IronPort-SDR: N1WXyOUfqrjmicfm0H5/OJBvzXOsz3EdCOpOOwZfZdLO8njeyNysLUf/CO+TaInLtZ7wIup3d6
 R0qxzOVMak2IWRvpWIDmRnVBUrGCDqUoW9b8sgY+GjE6Sunny/8gU6V7WhwaYAlHBOToBYu79+
 wVQbk9mVxJPo4WuQwpy4sSjKZvR1lQRHNzfrBu86TYBsaWQJdOcA6afBV/WUDl1JWpo28Z+tR5
 ihEOI7Hy87cAMY+CFi2a0J4UJ9pWZ80Pa1f18i27BNYHCIBKpa1wLu0yv3rHjih+xUn3lzrTPD
 UMU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:16 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:07:04 -0700
Subject: [PATCH v9 09/11] btrfs: announce presence of raid-stripe-tree in
 sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v9-9-15d423829637@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=1119;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=D+BzdF5oP8uW6qZ5ynzhWFTIk+tOOC9drG8BemLcBr8=;
 b=YPAqYzFyF2l2Wc3Vu/AtB90BNmJELAGsgqlNfc/E/C220KQQTvthliF/KHwDAwFykdjPPV9k2
 4RMCO4lcraaCCJzt1hTOc/DBEKeof2MdvAD1+3NO9fy6eD/CicHlnFm
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a filesystem with a raid-stripe-tree is mounted, show the RST feature
in sysfs.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b1d1ac25237b..1bab3d7d251e 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -297,6 +297,8 @@ BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #ifdef CONFIG_BTRFS_DEBUG
 /* Remove once support for extent tree v2 is feature complete */
 BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
+/* Remove once support for raid stripe tree is feature complete */
+BTRFS_FEAT_ATTR_INCOMPAT(raid_stripe_tree, RAID_STRIPE_TREE);
 #endif
 #ifdef CONFIG_FS_VERITY
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
@@ -327,6 +329,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #endif
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
+	BTRFS_FEAT_ATTR_PTR(raid_stripe_tree),
 #endif
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),

-- 
2.41.0

