Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4F6A7E71
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCBJqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCBJq1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:46:27 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFBF3B65D
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750381; x=1709286381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VuCg9mvYmVdSiFqucgxEiGNf7TNxG6nEoCVr5b7cCKA=;
  b=n0x7/hUtu2QQJ4XPIAKMYuMZQ0vHdExJcBbzCEi0ZOv33lNs4+L2NxwS
   wXjCqS+Rurqdy7maEi91iiNKzDskD2aHEM86HwtjBJx6EhfhJ7knfE4dh
   ihgXWlGDiP/Ts5VAvZgFlZK2TN+Rf/iQ/6WthfqyXeCf0N1vY8ETEIbIB
   ieX6m5QaKzWXxGwWteH2Tpa+3JXY6ZQ6s/3g7wqspxJcnlspetKtX9NTr
   Amxfwn/nvigsQP98DpqMgekdTqp9kC/G7/QTRM5wiBiE4Go/9u2BuOpAB
   fFin6Myblef+rT+LNnDhc+9F07kNr1F7mLUcH1Nx39IpttQcPoKhApX6Q
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939204"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:49 +0800
IronPort-SDR: e7xoEw62pH4C7UQgizu3wlDMCzrWRU7lRkZi96tKkD/Eolt4KeFqBgvgnocmjADXpLHvP6Piwx
 gPuJ9wb24NIM5ge86X0FXfpjg5HFqs5E1AoCGYPcQbM/ivwNkAW72vlb74vtZ2mEhBTlBbWBiC
 Y1wd9SEau+ZqVSM8xXMCAbFrRzk4QmpL54GGq/BVxY1cND5IJfC9xMTq8SEB5ffRUmvN4GGK2D
 hjLfRMmrDoVuTgEIBe9vZ7v0CEZ/Lf650q4+7Ar104qdQsDjJP/2Sdh1A4oVgtJkD04t8SAUQy
 D2c=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:54 -0800
IronPort-SDR: ZLqGiNzGQBQiNnbvc27cAKB//GjTZuaEWqF1ceXE231u5BeUlAaA7jal0myJB5jT2+J80Zzg9v
 teiHbyl7HdVRCI94XPTZmGjv5SytnwEK8ZkFnGgn3fjQF5LHiB/iteYFJgTcagG5QrQkc+3AtX
 yMHjvWZ1d4mmItduAZqcm4hZ/7bgKoZUndCJfcgj+/LO5ado+kXcXrokPSDQFjNYOfO54mRQR9
 AEWWq4ewSrbItcrGkqWIQ2Jpq+tMRKPkDfFMj9+EC0UZTMDI+0oAeYdhLWiBrAYjJWsAV/boSB
 pHQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:50 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 11/13] btrfs: announce presence of raid-stripe-tree in sysfs
Date:   Thu,  2 Mar 2023 01:45:33 -0800
Message-Id: <5ed728a84c8f2077bdcd3ed76324d3026ed25958.1677750131.git.johannes.thumshirn@wdc.com>
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

If a filesystem with a raid-stripe-tree is mounted, show the RST feature
in sysfs.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 37fc58a7f27e..bf7190e0b17a 100644
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
2.39.1

