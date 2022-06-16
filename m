Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CDF54E654
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377111AbiFPPpy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 11:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFPPpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 11:45:53 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ABC3915A
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655394352; x=1686930352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FnUWjYVlcjE8no8J7C43gmV2S93JNcnEaSB2dpLOq+A=;
  b=GzProt0YDoPFK7pk0mCbiG83jVwaj10yjczhDSRLn/cm9e6Q8PDZjECZ
   1e9INF9dvOteDiWsdIaZ3C1J5ofzYzZwsfrxB3Petbp9u5C+zgLkfckzo
   UHxKVaA5Ih2bXmmXYBncAOCgKBd95Ja/K8UGZjH2gdisBadjtsnwvLbvU
   CpWHX8PcDhwli/MVCq6CvfqJ2+GLn/mTA2oexztX5+7rJ6VoTLqmT/l0C
   lsmt82goKegf+J87hy8wMByfvnnqemI0PFeKmff1rv5jf1QPtpw8Avn5W
   C5XTGdbs2M6zP9pW0bUsJxLGjCqBJAQyFa/nXbU6v3jC1vUk1IZrg1J5g
   A==;
X-IronPort-AV: E=Sophos;i="5.92,305,1650902400"; 
   d="scan'208";a="208198920"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 23:45:52 +0800
IronPort-SDR: uj/aaKN39krKk+PbxvG7pRA0yGMhl6zn2cBYSlZV4C5Z4xo0yAhxhb8cSbEjZDcFak6N9DcBjR
 2s7O2WyB71nY3eg3ZB+u7RO9I8FfofTvm5oWTRPXH0wopO6ptAD8a3h6uFI1e9Rlc98FIR19nT
 JsF9CGFvveC9GqYC+zcgOCRn/HtGKP/cqzG/ug6WQed7HK2AmthCwHHun5AtJAfMz9yVWaGceY
 KvdAHAOJK3TqjwkyeYVwyomZoTnGJgXR9RsJtXJrXSg3TRMVvKNMpVBw8sG4uni2lfO4hVUsde
 kQS5pduqX1BkCbjWiLkjIrd/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 08:04:05 -0700
IronPort-SDR: fnsC9IdEW/gCbWyo0c61zTCOGx143gWAA+Y5GwWnEOa/he/3VXxSL1i/KNSuZBsKE3ShVjY+eT
 D4zZcxq6EKdQfjptEdPs+r4qsT2QaTCyNIum6IGJwJximovp8aca33TXhaFBpgg2bsjBkQ4/Qy
 AEPS8ds5B6c0iDylf2EX5L+0p3D/kFMsHfj22AcawhgI5IRuwnIM39k/eu1xbNW09T6Z4PepXt
 nlmm3bAkblrnCOpLJagjv4CZ06+yW01DG0u4C5loHugYFwNJ7bLE1cYCqA0ZgYyj0VbwR534eb
 8SI=
WDCIronportException: Internal
Received: from jpf010151.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.117])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Jun 2022 08:45:52 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/4] btrfs: replace unnecessary goto with direct return
Date:   Fri, 17 Jun 2022 00:45:42 +0900
Message-Id: <7ccae9fc6975246cbb2be58c83d9ca6e3fcbb123.1655391633.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655391633.git.naohiro.aota@wdc.com>
References: <cover.1655391633.git.naohiro.aota@wdc.com>
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

The "goto out;"s in cow_file_range() just results in a simple "return
ret;" which are not really useful. Replace them with proper direct
"return"s. It also makes the success path vs failure path stands out.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cae15924fc99..055c573e2eb3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1253,7 +1253,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * inline extent or a compressed extent.
 			 */
 			unlock_page(locked_page);
-			goto out;
+			return 0;
 		} else if (ret < 0) {
 			goto out_unlock;
 		}
@@ -1366,8 +1366,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (ret)
 			goto out_unlock;
 	}
-out:
-	return ret;
+	return 0;
 
 out_drop_extent_cache:
 	btrfs_drop_extent_cache(inode, start, start + ram_size - 1, 0);
@@ -1425,7 +1424,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					     page_ops);
 		start += cur_alloc_size;
 		if (start >= end)
-			goto out;
+			return ret;
 	}
 
 	/*
@@ -1437,7 +1436,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	extent_clear_unlock_delalloc(inode, start, end, locked_page,
 				     clear_bits | EXTENT_CLEAR_DATA_RESV,
 				     page_ops);
-	goto out;
+	return ret;
 }
 
 /*
-- 
2.35.1

