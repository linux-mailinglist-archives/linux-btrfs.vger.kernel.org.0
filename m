Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0B2663B0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 09:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjAJI3g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 03:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjAJI3d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 03:29:33 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948E2634B;
        Tue, 10 Jan 2023 00:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673339370; x=1704875370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dF4aP/T0MKvT528LEI1MEdeCR3UXfHK5116Zt6AkwyY=;
  b=INxE7c2y0NPXYw1o5LfmSBukpvKrBDcrFaIoYVhgKO1ONSqHgE2CXgky
   RpoUdrOj9kMG3XbniW1TdqRToPdd2oK4FeZwuaNy5Afhx3jJaZpfSUU3G
   9wYPy/wApBFuDSS18xvsMCCCH0bWLkZx0O1iwmDyVnpjeKNsCp2XRhHbw
   MTxgV6gKnVi5Uie3ScTSt5cBZb+SQHkHs9k7CzdfqVVTy7UM6p/zrKt2c
   fiZ4L9XKKb+ZFcjGM6SAgtq6jbKLqy7+42E38FnzgHVICwm4nP7NwJLYS
   DYhdU3iinbfkj/uhMhxJoFXryVsId0zeoTnklNMtBBVD8JejV6xwr/YMQ
   A==;
X-IronPort-AV: E=Sophos;i="5.96,314,1665417600"; 
   d="scan'208";a="332431254"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 16:29:29 +0800
IronPort-SDR: DGiZ3Y+mq7izaJABWMwHPqZTCVgCqZ5thtO9koIvnto9beQ5fItWTTSVXbsQpZTrmkwQUkSvys
 l+qh08sPiTGAnOYeL0DJyHyWEL0s9rPQoeuL0cJLpaxsVrOjPpGjj4zdH/tzBJC6ltB/CYLNMV
 U0y4FIZRER99qtO53d8ZNfvdhb3miEuxMMK9J14tqktVApQ5QD3yBR85o6h3264BuxWN/jcuts
 /VH+mYzyjFxuP+jnMNW/09y6P+Y+wtmO9VL/p9nqCshzHAzXv6nZLaUO1a8SVTXkoY2NPulluL
 POo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 23:41:35 -0800
IronPort-SDR: cjRZcn31OJcryk/j7nLY+K8HDlKGEEujs904J278rlog95TZ7KP0PQp71fgNLxQ6Zuz4UDawzc
 0dstmAnPKrOmfbemuaTSaQEZryxJ92O8zpKD0Hss5xN9uvIDhuYjlqb+Sk9bMa0Eknbfj2vlvS
 HURumJEroK5fK2PMhDJTIGte4afsC0TTGzENGwqD7vPP18h+2R4E9Gz3+ARTo/vApUvMeU+3Qk
 z1QvSqlg/IB00O/fYTUZUzM8h8eKJRGcCTshKUE4DtPCH+wn+k+iWT/eg1TmiPVEV7c+lKsE3B
 N9U=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2023 00:29:29 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs/012: check if ext4 is available
Date:   Tue, 10 Jan 2023 00:29:24 -0800
Message-Id: <20230110082924.1687152-1-johannes.thumshirn@wdc.com>
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

btrfs/012 is requiring ext4 support to test the conversion, but the test
case is only checking if mkfs.ext4 is available, not if the filesystem
driver is actually available on the test host.

Check if the driver is available as well, before trying to run the test.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/012 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index 60461a342545..86fbbb7ac189 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -32,6 +32,8 @@ _require_command "$E2FSCK_PROG" e2fsck
 _require_non_zoned_device "${SCRATCH_DEV}"
 _require_loop
 
+grep -q ext4 /proc/filesystems || _notrun "no ext4 support"
+
 BLOCK_SIZE=`_get_block_size $TEST_DIR`
 
 # Create & populate an ext4 filesystem
-- 
2.38.1

