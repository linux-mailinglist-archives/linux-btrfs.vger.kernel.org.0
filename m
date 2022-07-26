Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7F0580E58
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 09:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbiGZH61 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 03:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbiGZH60 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 03:58:26 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91552AC4A;
        Tue, 26 Jul 2022 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658822304; x=1690358304;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qkHAN+wb0j3GgedI6w7FMz2s3c6qx5v9L3gaNGiYKB4=;
  b=STrbxJdDRz93O2Zw3bkZC3/4b6f1VdIjUIen9QDEnpdFA1sNCqeOJNSd
   pUy2uZKFXtyWjoQC3yrQXrevDOtr1Txz3PvaHjf3PFrxWQuWniwNMH/Sd
   PgUVOfUl8Kb/0eXXvbqttQCZwiaR1kn8QyRr9OAeIr+xA6g2MkSzGG2kS
   jVnuYWhLcWQA9fkGeDWReARtnIXz5wpa0bbpje+xO2QobVevDaHejgjDl
   993A9tUFGiSFe2Yp/WqMTzEIGL6LtB8CGnsdwDlhByyKSDRceFoGg24tZ
   HO/M05/3K6fNmLVqSJo4YcQRiTE4+J0bUMuD6QbnJQynRcCcMfbnI8Cu7
   g==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654531200"; 
   d="scan'208";a="206907719"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2022 15:58:23 +0800
IronPort-SDR: bnh8bjaHU9KcKd30SLlSFuHa2RecCu5SBPukV653EcZPGRGbfhLiMsBbNbvaR6ZohkBYpOJj6o
 mYf+Lzn/4CRd4XQ9HKqKO309CRU/VU3uuB+/DyyyCOKxiVhBzjGP0uC+haEJP2snEnuZtw5pQ8
 BgucWmTKuWezJnxJs4/CLlz9SWy7kjtNGwAWKZMKfkvjqhqduKFU0KQl1XPBj9DI+n7jeZ0Xyz
 sVuUoGZPIpcRA7tPzhoM2wdJ7p1ngqx20tMbAezm04O/KfVguX7qNVeXUx4PVlMAoKGfr7oQJn
 Xccbfk2uYl683JGnZb2hF49m
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jul 2022 00:19:38 -0700
IronPort-SDR: mBak0mjx8YKDLHbDepXe59mttKCUjR/ydlmkTP33lhbnCb7hEgd0qYCw8Rki5JWQarRneHK2SU
 ZcDr2C7kJrQi2V4AKB36YqEoyKAysDWfG9rx2s1ccBGEGqPYEqR8w62efnfSQyBPWxaptrJFF/
 QS1CDSo14xhj8fupuWbpjhT0rPgBVcDdAT3h/pTyLG++SvLO6FQEwLInQeFOMsayhykOZsvW7i
 bZDdFxF8I2Ki/xN/+r2vBmuqzRKlAeIegiOPvQBw9NoT4OStM2L9wuMLVlWmD8rrfEF9AjPI5B
 PYQ=
WDCIronportException: Internal
Received: from 46570j3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.118])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2022 00:58:24 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs/253: skip on zoned mode as we cannot change the chunk size
Date:   Tue, 26 Jul 2022 16:57:59 +0900
Message-Id: <20220726075759.3155494-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
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

On zoned mode, we have a fixed chunk size which is equal to the zone size.
So, we cannot change the chunk size, and running this test results in a
failure with below.

    --- tests/btrfs/253.out     2021-12-10 04:33:53.000000000 +0000
    +++ /host/results/btrfs/253.out.bad 2022-07-26 05:58:10.000000000 +0000
    @@ -2,9 +2,16 @@
     Capture default chunk sizes.
     First allocation.
     Second allocation.
    +./common/rc: line 4670: echo: write error: Invalid argument
    +./common/rc: line 4670: echo: write error: Invalid argument
     Calculate request size so last memory allocation cannot be completely fullfilled.
     Third allocation.
    ...

It is no use to test this feature on zoned mode. So, just skip it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/253 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/253 b/tests/btrfs/253
index fbbb81fae754..c746f41e9264 100755
--- a/tests/btrfs/253
+++ b/tests/btrfs/253
@@ -81,6 +81,8 @@ alloc_size() {
 _supported_fs btrfs
 _require_test
 _require_scratch
+# The chunk size on zoned mode is fixed to the zone size
+_require_non_zoned_device "$SCRATCH_DEV"
 
 # Delete log file if it exists.
 rm -f "${seqres}.full"
-- 
2.35.1

