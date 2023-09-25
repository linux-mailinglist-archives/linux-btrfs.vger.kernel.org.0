Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E17ACF2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 06:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjIYEeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 00:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYEeK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 00:34:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F91292;
        Sun, 24 Sep 2023 21:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695616444; x=1727152444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GSsWrEnVBcTS9RcQdaIN1VajYycMG3WVV2SjHsBJQ4A=;
  b=Q+aCMrIJK1yohvhzsZoz2zR3TRVyzdB7Lwpkvj32bjgvK2iDckak3kTS
   BIWmTxtwcCqTKY8VHdc7aWgANiMryiB7r0MGA1a+EBtG09e/vc45yK+ro
   dz7Q74erYyIk+miuoMrIXXyXVmqlkKZxWQhMrePpVwXi86wfXPolpMDBe
   bI0aO6WNqQXoNKFVTByVPEHaFDiPVqYIHm82swAGSvSR5SXKxwbHybj2Q
   7LDod4+9rrPrJr6HEEzCybADMn9hPo1jUJ+HLjmRGkuS64AKhXPPj8niE
   kvUSCEGCfKYWRlfFq48JbQEfkeHvLXru/ws1uBVjcNpwYS8xP0ogwIHwZ
   A==;
X-CSE-ConnectionGUID: w32u5i7hSga6qbTnDczVjQ==
X-CSE-MsgGUID: Cj62FVQOT/WOO8ofbihjxQ==
X-IronPort-AV: E=Sophos;i="6.03,174,1694707200"; 
   d="scan'208";a="249332116"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2023 12:34:03 +0800
IronPort-SDR: 8UYE02MpIdCdvrvDXmHP+citUP9uubh+4KpL8ogdukxsQqbZeMIPMdx3hwA/PBv5cGXeu+5yu0
 UbX8ueX8K0f+zydZL2xqbMF2gpHAhsHBCCkh0eSFEjr8yoF9Js5M5jt2fAFFgjNG/OjIWtmCuE
 itQuuxj5rzPGVsD+DbBe0YRsfKLKG/56p93cjiflXKrX6alvBz6G1moLCtWP7RXehAYs+CdeRc
 avFPyHrFv1q6m8v6eWxM0xg2+tRMOjQETZw2DqcbUStkJ5/FmEZmAbwyMa4vAVbWyGGnlLdMsY
 +qg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2023 20:46:33 -0700
IronPort-SDR: GDG9Vw3d0LYrYRaSnJo8XycQDdiw60FRzrTdoTxZ6Mj24HhE3AkRMDciMsnygV0+8kj2mTQ5Q4
 OPz6BjEVve0I3g2xfoaGzb5Gz8kCPwD8rjmbRMzLxqm9NEbyVgTzf+v3xn6M7Y2g4rLTcgJ4oW
 Lf7m33ivJ/9hloXArMSp/4t68NGHJPpGBL7WOFIKVec+w6ApztXAXJaI7um1koygKraKHB7xbD
 ZBSLvByhp1M2MjMrqOXZu4xJt429gY5bRe5V7AT6UJ3/rggGSvNvLfZt+KBMv51hLBtGCj5BMN
 rL4=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.101])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Sep 2023 21:34:03 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs/076: fix file_size variable
Date:   Mon, 25 Sep 2023 13:33:59 +0900
Message-ID: <20230925043359.2765806-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
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

The file size written below is 10 MB, but the variable is set to 1 MB. Fix
it, or the test will fail.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/076 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/076 b/tests/btrfs/076
index 23f9bd534a0a..894a1ac7fa5d 100755
--- a/tests/btrfs/076
+++ b/tests/btrfs/076
@@ -37,7 +37,7 @@ if _scratch_btrfs_is_zoned; then
 		max_extent_size=$(( $zone_append_max / 4096 * 4096 ))
 	fi
 fi
-file_size=$(( 1 * 1024 * 1024 ))
+file_size=$(( 10 * 1024 * 1024 ))
 expect=$(( (file_size + max_extent_size - 1) / max_extent_size ))
 
 _scratch_mkfs >> $seqres.full 2>&1
-- 
2.42.0

