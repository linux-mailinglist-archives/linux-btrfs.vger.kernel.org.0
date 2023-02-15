Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A2697E77
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBOOeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBOOeI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:08 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8AA392A7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471647; x=1708007647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7XU4wLrOB0mDh21cJDSAGXcKCGiGV9CrA3HzDj/iXqU=;
  b=BVdAzoXjbU7uxGHsu8Rb/Sjy9SWBtu14hzu42L+N1op0FwWZDXF/3yfo
   oIhmprpJ7sxko62vhmX7dVsPxDhLW5OUT4bTHVgoKjKeVUBlqT8lh7WMb
   2mkMXAMeLAH4bj+oLGIZ6F0RSC23RCYlZ3If1glRd3+7MKmDynmYAM96o
   Y+7v2m3enD9PVxO20/i+HSjdyz5ZY7G2652/QnCywesN2Jz2WTtiyCqYD
   Dib+AP5wTIXCvQpMifJz8LT9mX9ltrWUGV8K1l81TQ/sfmrowJMpT4KcL
   1tpv+xTCRHL+0e7jPLjGpy7EIhkj3DMzW7oINsYE6fjcd4kUqWBtDYrB7
   A==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394077"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:48 +0800
IronPort-SDR: HrWKqGV9S02bIiaqQNpdFsXyp6z2Fp5+K9nC43CcrQHTBJ7dTIYUuKm4N6k4njzuhnj+Z43Zms
 2WBn1STAkjiOh+EP6AEpGB22av4jDTc6FrOhSDAj1tiQphUlujFDRWjXY8H/rmo86Vds33ydpG
 atBcYq/t0tsURd8d5li7CNZMi0HZ8dForEvgDaCFsx+dNzmj3rvmoclwvy9jQrAuUM52afvvCr
 i77+CmB4q8odC2EtSU4ItQTwjkVLSer03cbGru2vJuuISt92wbNnraMVyzcA3PanNw8fOxaXL9
 XGc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:10 -0800
IronPort-SDR: kpZVkw28MQrKtUY64evnH8jHCGoNjVHW6Sd9VDWvfQ0I2D6wvhPDE05DT6JS5sl48U7nLqQl7Z
 K6tClEdrKs8iT2CJ94vWKkePeoBdPC5Qj3KZ5PbnEbPEdUFkErsb4sOJgKobqWUd6c7DjMbeCy
 cduiNKna9PMoqGTvccf2bikhPDcw61SmbXwe1xuJk0KF1ZoZTh2uBrlkrAQlXebCHHh46JTMWs
 TgYmoM4SDz4BrIVFPdUGJAJdxjm/l00PwhwrZejhhGcGs+vJhk2UBRcXxVdj+gb/Yowu421fKU
 2Bc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:48 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 11/13] btrfs: announce presence of raid-stripe-tree in sysfs
Date:   Wed, 15 Feb 2023 06:33:32 -0800
Message-Id: <9782b6e409fd456f70cbc07f3eb07e3ca4659578.1676470614.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1676470614.git.johannes.thumshirn@wdc.com>
References: <cover.1676470614.git.johannes.thumshirn@wdc.com>
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
index 8c5efa5813b3..8675bb6ddd67 100644
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

