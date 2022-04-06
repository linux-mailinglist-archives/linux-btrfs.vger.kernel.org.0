Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01C4F608C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiDFNxK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 09:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiDFNwv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 09:52:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1362DE84E
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 18:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649209430; x=1680745430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rOXLxbvaZe1o5dILFHxK0NT+oUhmuZwqonziGjljGkg=;
  b=WHDO3b0u16pYqKBa87MVuIvF0cD/mKpOph0OtY30uWTjEGSkKnFx3hpq
   FXRQPlCCq6L33yJXByCXr/2AOfmGxNhervi9t3eFLumFJkhj9Rk3D5dcm
   ZVfoIKJh2nrlAGzGd4X3PU70e+dAOXeXTpYRqW3x3d7fDSD558elwisDr
   OILfE+Ouexs/DiKunMyHOwqvfM/6t00SJx7FaRuf62pG74QwKj3VPl6fD
   HsTozIez/aS2Z2izA3QOYua6oHVVmbKuIbKIcD7EHzq9xXZKNMVaLV6Sj
   XOeSAwFWgnns7DV7Csx8uRkvsO9d3oPMw9AHxGfkaZ7WnGmRTr9ypKpQU
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="309153507"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 09:43:49 +0800
IronPort-SDR: tUnmGwJxdmHH9jEow4amZ0uvbq1ldEJiyd2BRHUrGFNYleBp4rMDtqpWrtFZB++1Aoiyz7ahlW
 K4Fao+NwY1wTIk8wmntmlaAWNEkf+mvYPzFvEDt+cPrJbxT6RjdNP11kEKF8ct/V+Yc95LNiP/
 7gPkJ/mu17/o95gNWwiduRzv+3tvwr9w94CNAHcZZqJbA7R8n+ePgycKEMzadTGoXmFMTFsaQ7
 zISuBBRGQ+4bDaXo0tsJKV87sO2JYBBmUJl+685Z9ad4IX/Ne2h7nwSkTIY3TUBLsCNPHIPGtq
 rUHb9BbnJgoLDWofYnZn3Sgr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:14:31 -0700
IronPort-SDR: r1n/LFly7Y6OyjEYuR2u3hg7NZ/P3IIVBcnN/MqH7AfGNGKyG9DvBWmOFwWeICKNQXNG7T7bvD
 pez25qGSX8Z1tKKqega4icrB/NGS/x974p2dF0olmkZzIMzA1VQf1kN+WV5A80NK1LG8s5vcwd
 UpNmurQ8URv2DvlEmRKr2tDOdhYEGwrAg16yPQSHQmXHXjfzh/68l7nOxUu4i+eYvTx65vNbp6
 u2qnwjepmcIDvzLa8PQ2MmVLPSVH0p/a5SfaV2Fk3DhSMIpYmsp93SJKjRaFRfVuVkmJuni+pm
 VwI=
WDCIronportException: Internal
Received: from 5cg2012qdx.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.10])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Apr 2022 18:43:49 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/4] btrfs-progs: fix ordering of hole_size setting and dev_extent_hole_check()
Date:   Wed,  6 Apr 2022 10:43:12 +0900
Message-Id: <20220406014313.993961-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406014313.993961-1-naohiro.aota@wdc.com>
References: <20220406014313.993961-1-naohiro.aota@wdc.com>
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

The hole_size is used by dev_extent_hole_check() to check the hole is OK as
a device extent. However, commit b031fe84fda8 ("btrfs-progs: zoned:
implement zoned chunk allocator") mis-ported the kernel code and placed
dev_extent_hole_check() before setting hole_check. That made the
dev_extent_hole_check() call here essentially pass through as we have
hole_size == 0 on mkfs time.

As a result, mkfs.btrfs creates data BG at 64 MB where the regular
superblock exists, when zone size is 16 MB.

Fix the ordering of hole_size setting and calling dev_extent_hole_check().

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index e24428db8412..0199bc26a8b4 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -774,14 +774,13 @@ next:
 	 * search_end may be smaller than search_start.
 	 */
 	if (search_end > search_start) {
+		hole_size = search_end - search_start;
 		if (dev_extent_hole_check(device, &search_start, &hole_size,
 					  num_bytes)) {
 			btrfs_release_path(path);
 			goto again;
 		}
 
-		hole_size = search_end - search_start;
-
 		if (hole_size > max_hole_size) {
 			max_hole_start = search_start;
 			max_hole_size = hole_size;
-- 
2.35.1

