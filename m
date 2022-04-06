Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531334F607B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 15:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiDFNxL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 09:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiDFNwv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 09:52:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE762DE84B
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 18:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649209430; x=1680745430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iyo/T2F7zIihT49w53yL0fog+bdlpAC+n01ffJe1qCI=;
  b=fU4yu22ogg75pErIUHcIOlq6hoxWd+6HlGmQ1w/8lc7pQYvwB4F/UeQ5
   +8vh5jDywqWwt30jTnUBsAOfVAWq/ya0TagrHM+nLytNOpi/DHjkndbO+
   Vsx7Yvx3N0+njk8lgb7XXIID2VSpLQgaHF6wFWNR0N1xUhn1GriltW9pB
   Pc4/MPAGh+40KR72gfNlkBzzI1oOPHHNe8lYA2nFdAqlVOa6FOcCvYaRw
   25HqDrfUXPKCovkogEQcehP8Hg3v5kVD5YsXqlus4Op2z/KXcfY9zM+BZ
   bmDNUKOf+TgAS4Fc5F1MmN9aBn6uKu5GBdI88UfKoMRCxPLChMMeEcQIw
   A==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="309153509"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 09:43:49 +0800
IronPort-SDR: CCWAhGVB0S0EkCa6r8X62c1qDmavRUcpSNI74zSOa65NoXX5LHVjHYTj8L3UcuwZlyAmKlghZ+
 2a3AeqzRSF7IxBGb+igIdH2oCl4uC4EFkgjSN5mIjfVCS9St5QuYlMN6wokYm36Q1xwv8uel6D
 oV9YSIMNfvJrmCwNZNC/ZLGDQuUA15X0g4uMKtuiZ5bUdOoiW8CN7Gj+W6DABPYwAV4rqYZefj
 AkFGqAqzxYEesaZogT+Z39Guu+zn4LZ+aH0UHUbIwbSxlwYdjnXmqkjrDj0FC3wKMgAz1s35WG
 XzlH7fIZ2d314yIoZoAaG46t
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:14:32 -0700
IronPort-SDR: hzyNIKQfcaAaaLELA6joBUN7ryIgkGkj1ZocysnC393XViebCt+3Rap3R0wg/xQxMaRGEXn/Nj
 iN4IkG8lq/avlPAxxxqKR9DtuIBO8k5Mjs0tu3eoFjN9gJJyrC4Q37bA2SJlOALP1fVZCFk9q2
 OjC1AiQVjHm71S/tecVY813jadThZC4755xT065u02etVtQb7N7zsPjR2re7cw2fxmgz8IxNCa
 GiztnNDebv6iqNzNxXLCZL7ed3CpWEjFQ+IPDNxeFIsTV2/2iGNrKA3GoianWCju+VPP6tp/aM
 whw=
WDCIronportException: Internal
Received: from 5cg2012qdx.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.10])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Apr 2022 18:43:50 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/4] btrfs-progs: zoned: fix and simplify dev_extent_hole_check_zoned()
Date:   Wed,  6 Apr 2022 10:43:13 +0900
Message-Id: <20220406014313.993961-5-naohiro.aota@wdc.com>
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

The previous patch revealed a bug in dev_extent_hole_check_zoned(). If the
given hole is OK to use as is, it should have just returned the hole. But
on the contrary, it shifts the hole start position by one zone. That
results in refusing any hole.

We don't use btrfs_ensure_empty_zones() in the btrfs-progs version of
dev_extent_hole_check_zoned() unlike the kernel side, because
btrfs_find_allocatable_zones() itself is doing the necessary checks. So, we
can just "return changed" if the "pos" is unchanged. That also makes the
loop and "changed" variable unnecessary.

So, fix and simplify the code in one shot.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 0199bc26a8b4..598ac553442c 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -583,30 +583,19 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 					u64 *hole_start, u64 *hole_size,
 					u64 num_bytes)
 {
-	u64 zone_size = device->zone_info->zone_size;
 	u64 pos;
-	bool changed = false;
-
-	ASSERT(IS_ALIGNED(*hole_start, zone_size));
-
-	while (*hole_size > 0) {
-		pos = btrfs_find_allocatable_zones(device, *hole_start,
-						   *hole_start + *hole_size,
-						   num_bytes);
-		if (pos != *hole_start) {
-			*hole_size = *hole_start + *hole_size - pos;
-			*hole_start = pos;
-			changed = true;
-			if (*hole_size < num_bytes)
-				break;
-		}
 
-		*hole_start += zone_size;
-		*hole_size -= zone_size;
-		changed = true;
+	ASSERT(IS_ALIGNED(*hole_start, device->zone_info->zone_size));
+
+	pos = btrfs_find_allocatable_zones(device, *hole_start,
+					   *hole_start + *hole_size, num_bytes);
+	if (pos != *hole_start) {
+		*hole_size = *hole_start + *hole_size - pos;
+		*hole_start = pos;
+		return true;
 	}
 
-	return changed;
+	return false;
 }
 
 /**
-- 
2.35.1

