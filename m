Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DDB68ED6C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBHK6L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBHK6G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:58:06 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E22715CA6
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853885; x=1707389885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HoksUmEZ3eyxw4qrFGWYGpsHqq/p34pWEDYoQk8BqRU=;
  b=Rv41EJcAhOet/9UejZUlhxaOyxAWgtAXwaApQbvs+Y/EafttgWkS9Q5s
   4dAh/IikiFz0vimTLkxFxjVUj2t8lPFjVYyYu4i3R/3leNQwQmxHJsqE9
   VO32WAjlv9jBZ68OeVBK9fhhfyFsofNwvhaSSeB+YwKE/rKd8eNly9a6K
   PYxj5mC6bJteekTi/yNVjZ1JfZghEcrWvIT/IY4R6F66TdHVmvOH5NOyZ
   HVU2sH1uQg3RKSyobM57FkXEdsEFwy2b58EuXwGRS7NYfWtYm+X1MJ6Q+
   m9W6cLDAVeraaeq0c7VopeA/ECHaJiLG3odB6iYm8ju71KCJJCfVsqf3r
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115651"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:58:04 +0800
IronPort-SDR: SWfL8jaqcHeZlRFN/iU8S/T9bpWQE9u08tX5+kNx1WJ32Emy4b9Spq6RgTi/0gOB5z411kvjLz
 0Y0GMArud/wqGkmQjQjy8SOtqqoMBfO8LPyxEJKMKGG0gPa1/TslcScUKcpCa3S8wNd63doxja
 GuQFxZYf/T+ASGHid81nFEtHAUXLUJQe9dkCBl+SoQkGgmCMKNZgVBQv4EhDD+dHnKu16eVK6U
 tGbXPAitIj3KI9q0fTJbkvdy8FcUth7NkqeVgv6alXE99QKwQ8iZKrO3HtVoih5kVByh14oWMO
 FdA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:20 -0800
IronPort-SDR: dhPxIrbEdKWdJm9/pPFogxkHR3KlnStyFExDborFFwQfxf1iXYpGNKdhoMuXj+ARrX00kGy7sU
 i839BwTwb3l+anwiV6T2W2P+/EJGcQgMeWMR1fTKEjSn+V9sGV9HmS5QuA0gZCUcIrYKOG/Vfx
 2dTPawVjifXVhaEoKDPQRKQj7iY5dAWLs3ijSFzmTWurMJkFknwKoZkWmyCoMM9Tr70vVVPc6E
 SC5dxRI2oAX0QRMBToRlgpTR7FI4FQo2b24KSebC0cWFve6k4xySKoGcJ50wtndzoqwHXSBIX7
 6yo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:58:05 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 13/13] btrfs: add raid-stripe-tree to features enabled with debug
Date:   Wed,  8 Feb 2023 02:57:50 -0800
Message-Id: <fcc0db899a9dbbac3c862b2f91afe9de82b164ac.1675853489.git.johannes.thumshirn@wdc.com>
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

Until the RAID stripe tree code is well enough tested and feature
complete, "hide" it behind CONFIG_BTRFS_DEBUG so only people who
want to use it are actually using it.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index bee7ed0304cd..c0d6dd89e3b0 100644
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
2.39.0

