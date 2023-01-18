Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3F6715EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jan 2023 09:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjARIPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Jan 2023 03:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjARIOp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Jan 2023 03:14:45 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D3446D50
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 23:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674027921; x=1705563921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6d3remRzgneLCz3PW+1IHV5PpOOnfVDPnU5Hwxy3mRY=;
  b=eibrHYVPxoyGF3F1e5ea5hd0QxPcNdbarXFM2S6kH3jEKjKAwI2/6bYy
   d6BxZRZlh2q+vnBqeKeFkqKxpmJiI9C3XhYnf6YfjhnAAB1gDgatqiHap
   m105AZcqtErEtZy3rmCuyYQk0itDm0LO6COGJDyjUORyTHlbLR4GBGX+b
   aLgz2KPoM964bo+RCPUvLewz9U2/gAuOWKYV3W7CW2GY6Belb1XBz1oAJ
   yHzMA3DqKmvkEkpfBHSIDcW+se40w3KSmRb/dstnycYx4cfu4uohDVOU0
   eKAlelPwggxVs/tEjMQ0RIBi7IV/uIM2z3TH/fQ652EENcwaw/kaMOkXJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,224,1669046400"; 
   d="scan'208";a="333108007"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2023 15:45:14 +0800
IronPort-SDR: QMZYZ0X0OF85y5SpNvF6E6lsRsHut8NQ/zfdyRzfGMz4ZxT+Lc2hgM0q9AxrXHR0Vr7FNdy1Wn
 qhlrziOsz7yzwZKIHlj26dXJ9cErxS4PBS/+Vk1znWI5FE3yQQQffpFVUf8IcgM7XyaPl/PLY4
 t89MKmZbtSFVeIl7jHDjVN7PFFjUCoURjS7w8WrdZwC13hRRKf8s4xDSf7ok9KuVIWeRKWOtjG
 DQyPEtCQvsPP0QBELfKf1N8Q+YlX3rlYKhpvSAMyJipZK19NjXB1kAo5/Jn8ENGtl6T4dD9Cjd
 dqM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2023 23:02:55 -0800
IronPort-SDR: fCLZWrrhgC1aUkP0xSKhgrRemND0z6RH8l9kS0BpLepofmF+XA6RS3w47HYusK9tO3QXUqTHxp
 BvosNVcu9xlqOwZCMH49KKKlJujWnEN+FV2xwSgxHUa7Jd+TfoSRo9VeNPTNXTh2LTRc3qu7DI
 9uilrhiWVzQo6VxnTsfq8/zuG0A7S4T74ck9HcJ3l9vEW+boBtCuQ/O8Sz8ub2pLvillubeE5S
 XJ+X2Wl/s8Z7Iplz4SYNReQwnM6I+jJxnPzBZUY6QhOcPmdoD9FC6rvpAgC/CWAqhjuHH39Ny5
 03g=
WDCIronportException: Internal
Received: from f9rd9y2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.16])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2023 23:45:14 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/3] btrfs-progs: docs: add chunk_size description
Date:   Wed, 18 Jan 2023 16:44:58 +0900
Message-Id: <20230118074458.2985005-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230118074458.2985005-1-naohiro.aota@wdc.com>
References: <20230118074458.2985005-1-naohiro.aota@wdc.com>
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

Add description for /sys/fs/btrfs/<uuid>/allocation/<type>/chunk_size.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 Documentation/ch-sysfs.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ch-sysfs.rst b/Documentation/ch-sysfs.rst
index 569879aadf27..09e409a41aa5 100644
--- a/Documentation/ch-sysfs.rst
+++ b/Documentation/ch-sysfs.rst
@@ -125,6 +125,12 @@ bg_reclaim_threshold
         Reclaimable space percentage of block group's size (excluding permanently unusable space) to reclaim the block group.
         Used for zoned devices.
 
+chunk_size
+        (RW, since: 6.0)
+
+        Shows the chunk size. Can be changed for data and metadata.
+        Cannot be set for zoned devices.
+
 Files in `/sys/fs/btrfs/<UUID>/devinfo/<DEVID>` directory are:
 
 error_stats:
-- 
2.39.1

