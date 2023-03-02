Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E826A7E72
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCBJqw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjCBJqj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:46:39 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3B3E637
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750384; x=1709286384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjQbsF1ne03+nUqwRERuk1yUqBeoGcdCoxumcqJrz8I=;
  b=gzFLBHw9sbHjK52+LQw5yiSQQ45ei5gkPPVilqtO0dQnV2QPuZivIhCs
   Mplgcn9jIIsxLQRbaxf6a5/auoCl7j+fgaf1Hq/azvwGDj4sOEW323ca9
   FqxAey60jjfQUQoe3O3AnEAvoCgtXgJ7k+9wW6kUAN4m/FzsRsWlsQv6v
   rgZ6YSdeRAu15MVic8JKnU/rgz7UKUGVVhVx9El1OdZ+TWwNYoXuGpDNg
   hJurXMm1JEHdL8xonrAod5zHyjFa9o9Hd3bQiEI1P6l7E5xM7CtGqG5N2
   rBbzM/OjQ7WFxYRkT94WwX8GEgU0G6rTczmSXFDvcHg7KIyCKZvtNVJPY
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939206"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:51 +0800
IronPort-SDR: I515wWw5Yw58bj96Tj+w9wJ4ui69vG/SE75NCB1/cn075Tdew5Oci4VRUT1rUXObCpSvbEtsVZ
 AVFp/dtvUtwUi24PHa4NY+RgtZ0v5lKEpLljGCkpYd2gCGEAF/aiHHoTBfnH2u+Eshys5czdZl
 bFO3q+Qj0+nFe1tFUiH5ymlspmld7jo3dqAIU9SRc77zy/UUnEKrhIo1raZKMGlh8la2mBSdDc
 z/KPBvoc/YxkZ6zNt84xAH9uWoNMx0qAVOQapPMsIZ/JuZAHOv2HD/jtKoq+rum302pK3Oi3uJ
 muk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:56 -0800
IronPort-SDR: Q/z8FpBbQnGrP15n2BRH3NwOtachSozFAxzJq0jgydB1r7XrCWwiqlsUYUSM3cDwKx3vinzTjv
 2Kcay5E8C+K5oaP1ykY4F+wg6AkS8/kv1AHgTcSCUmoFmITGhYJetrHdw7m+f7EDqdPuJ7mYMD
 lengNA84kiRqHA5AtYVLokK2l+74Esie3sUa8oa4QLTEyrGhpatCO8rK/LVZDCu9/kjuULKLh4
 bkuvCRiUTLP3GeDhJq0HTJcOLqCHTqrS21VxGaXnEPlNSYlbAYHiSx53AfTul8jywh+vezjtcm
 nwA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:51 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 13/13] btrfs: add raid-stripe-tree to features enabled with debug
Date:   Thu,  2 Mar 2023 01:45:35 -0800
Message-Id: <98922293ba48f88d3a71241ccc8341f5b3f7ca33.1677750131.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677750131.git.johannes.thumshirn@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
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

Until the RAID stripe tree code is well enough tested and feature
complete, "hide" it behind CONFIG_BTRFS_DEBUG so only people who
want to use it are actually using it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index d0d80540b32b..dd151538d2b1 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -214,7 +214,8 @@ enum {
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
 	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	|	\
+	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
-- 
2.39.1

