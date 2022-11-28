Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA463A871
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 13:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiK1Mav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 07:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiK1Mab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 07:30:31 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ADF17E39;
        Mon, 28 Nov 2022 04:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669638596; x=1701174596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7sY2S5+qLikwQWi919rHRp5zUl5g+7YXqvjyZGwL4io=;
  b=aT+m+iprFUXsBBO0Gtn7kHMTrFnyoMKjWq3kDaLrwycxRrwnLx5cW2ya
   s0FzYZ8Out9a476/EvzcuJJUUu1run5QMqp0fHnmBWwpz52/CkUrd4rps
   YQa8G4tqOFLPqd/0vB3GAxjVnF/FXGN22dVnrV96a89bFIuU6bAqtgXbu
   fJHF2jEQwaQozz5I0xIK8zxd03IQUyPDzzc4EBQdAaEbIHi+USGaYQDzO
   bLpqZIVMpgOJ2wjcjGCP9ZMMgymA8HQS0fbtF6fCE3E32AJ6RX435Q3xA
   aGLI/BOR1Z4/4/ny1Uh0bfJeH96L5a97LFTwbp4EoaPrZ9gN3ambVNmkh
   A==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665417600"; 
   d="scan'208";a="321693545"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2022 20:29:55 +0800
IronPort-SDR: lJ2cKCOaT7Vw8CiJxIPFT2NtGDAHDAUWb/HpWzsgsfYp7RkBCYQeYXUDUYM80c5vNDW/KnFYp5
 3F/imj2O2JDmrI5jJRd2xIS8WJpd0KvHNB1h+Qj1EBQOCaH3uHL0JVegdarZV5bRtAJLWdwhR7
 J3P26uVAbTd+GapUcq25Z35N7XQKgTb4+GHv8m+MQrJodz1gROU4oZkgziqcWPvXoGW7LUkHoB
 j+i1BfVdmufp9TowV/mnxmtWDqJm3Jrid476LGpZz4xV5u0XrX4u9863sEVrsjbjxBYujGiQzd
 cQU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2022 03:42:52 -0800
IronPort-SDR: U3p2ci+b5mfqqzwEJ7DtJHEUhNDOjRLDxeWjh6YvLeuj2aua+TJXniCGfoTnMoJ6GkuHskBoZg
 kwbHbv4sNgdJ74CLZ2K+54Mxd6e2Bl9QxcWZqhLaHq3pbv9t7Pb39FWpJKi2UfMgyl4Lyf2Zfz
 ZG3LSV9ayN97qHmcl8VJlNi+spg8m3vUVP7SUCVamwvUiTbp62yxHZ1b9jL2ZVRytoscqcwX1p
 OgMRMMNpvAaTxUMY+qaR+D0V8apntWDcyh/f+LleEQIfAY+gb2AJpKpY00PHp+Zwy0gR1TQ/ys
 GS0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Nov 2022 04:29:54 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: skip btrfs/253 for zoned devices
Date:   Mon, 28 Nov 2022 04:29:52 -0800
Message-Id: <20221128122952.51680-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
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

The test-case btrfs/253 tests btrfs' chunk size setting, which is not
available on zoned btrfs, so the test will always fail.

Skip the test in case of a zoned device.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/253 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/253 b/tests/btrfs/253
index fbbb81fae754..99eaee1e7cde 100755
--- a/tests/btrfs/253
+++ b/tests/btrfs/253
@@ -81,6 +81,7 @@ alloc_size() {
 _supported_fs btrfs
 _require_test
 _require_scratch
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 # Delete log file if it exists.
 rm -f "${seqres}.full"
-- 
2.38.1

