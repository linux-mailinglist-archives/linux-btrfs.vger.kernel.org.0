Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF967AEEDE
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjIZOMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZOMA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 10:12:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFCDCE;
        Tue, 26 Sep 2023 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695737514; x=1727273514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=stxQJCGNdM+SFI1RDdyjFiqx/RgCTQgAOwlHZG8rbqI=;
  b=i4dqSTfn3daCEb3MdwrTUuJdNpChydO/3zJefsDRIJ2w1+FvEhi/PKDI
   p0IdW192tb5PYVLJUjqwn5fEBitJ3gHisD18j3hkRhskQy0Xngvrr+gig
   timTvj5qV9uoXQRr3fUyJ7pOSjGNNKh9vY7jHXQ5Oc1ApcNhoTlM7GXgg
   NYMEcKJVC0T/y0i5xnTFPoG+HE5NI6xXzlJyjFSvjbCN2rBLOBrGMM3iq
   9apxjQOFGgYwT8Qucgpz+HuKISujWlHuL2aU9JnYp8whU9nokujdR8qtl
   C83BlVctL+1h7+vOnucjNIh9hsQ9qa2UacNcjcblb1L/IKz8cdAuwHJij
   Q==;
X-CSE-ConnectionGUID: rGlVbxXjTcaDh9+csk9o2Q==
X-CSE-MsgGUID: YQDGhqBsQ76L2UnVJNh2eA==
X-IronPort-AV: E=Sophos;i="6.03,178,1694707200"; 
   d="scan'208";a="245323231"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2023 22:11:53 +0800
IronPort-SDR: KK0v6TQDqza1U+sfo8OUf5uirQd/rQZ519nUwf+LqnFp+NKU9jJHWTwDigDIZNRTtmcTBpdrcR
 lGRnwsXwaz070FbQLjT6oCZoNz4DdIv+jZERKyvLkmTomG1Qe1sQPWTA/Q3G2y0rn6fLbD8sux
 Q0FElw1tFqQ5NhdBjjinarbjVSAwHYmt9yPqXRoSbR2eoYs3JeAicHOU0sTHTy95yXIixDClou
 DQ7wGt0apvdQ3t//yQe9zNr11KSoDHThHh4CC3i5fG6QOBSehHeO4KNf+n34Sk1n4aVCQ8gK4o
 uMw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 06:18:40 -0700
IronPort-SDR: oDhDVC/S+DvLk1EZxwqsMzXT0P/Q1WjMnQ0LmRpBy1Dw6s+NqHjXpe7HQ9I8MpvKbwULgZN6+M
 RwoxQhD9RlMmRT+CvMIvzuXnimIiIph5q613/TlF4MJ28ij9UQJ1kpH/WQE31/N8ua1ITBQKkS
 ALF+gFKh+R+fXye3+454Pht/AJaAuwjGwmYuckkUK/hQeN5wYrypsAsbrvekCit5jwVHgzxn9U
 pgGMu1HAH3/p9LpDLaR6KtuJ6Qf6vNlIxIm+vzo8QFX4MzG/5m5ESdjdm5r8JY+4QyRyyUahVx
 yqo=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2023 07:11:53 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs/295: skip on zoned device as we cannot corrupt it directly
Date:   Tue, 26 Sep 2023 23:11:47 +0900
Message-ID: <20230926141147.471503-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use _pwrite_byte to corrupt the root node, but such overwrite won't work
on a sequential write required zone. So, skip the test on a zoned device.

Technically, we can run this test case by checking if the physical location
lands in a conventional zone. But, the logic should be no difference than
the regular mode and I don't think it's worth doing so.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/295 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/295 b/tests/btrfs/295
index a9a8e5530a80..00a5c5680b86 100755
--- a/tests/btrfs/295
+++ b/tests/btrfs/295
@@ -12,6 +12,8 @@ _begin_fstest auto quick dangerous
 . ./common/filter
 _supported_fs btrfs
 _require_scratch
+# Directly writing to the device, which may not work with a zoned device
+_require_non_zoned_device "$SCRATCH_DEV"
 
 # Use single metadata profile so we only need to corrupt one copy of tree block
 _scratch_mkfs -m single > $seqres.full
-- 
2.42.0

