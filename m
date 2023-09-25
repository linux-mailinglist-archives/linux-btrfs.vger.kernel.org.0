Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6307ACF9B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 07:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjIYFzy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 01:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIYFzx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 01:55:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294A983;
        Sun, 24 Sep 2023 22:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695621345; x=1727157345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5dHZwuLOoad7Dv/ZTwEbxO/erIfjG+1LZsKASkt7Ap4=;
  b=dVqviYJXATN78qSr5iy8BAQBOHwj0MXTx7swu3oJGpLblYdooqT0H1Z8
   EYZw/lbfwNkVVoPkvoLp+4M0SDReZHfrsJdD2XjdOAXPln+c7gozVOAlP
   4h9dWrUyFvOMP241VVL7gTomewfRbGovVyoIjeBfocPrXEc9UYw+r7HxX
   TX3i8yzuVqixmThhrKzNsXWJ5JsRoYumUQnYkg11eqpwvxLQo3L4NWnKu
   3UfDt8io9VZQznSddnFsklG/b5iBv0NY8Gfn3cz1Q4297G+QnBf59nntE
   4ur1BwlbkoXEKhF/aRsEgmloyvDvhpAxY4j+kmT/z/GFKdhYVhgy40VGC
   A==;
X-CSE-ConnectionGUID: CE7OxVVlTwGDL83nMo0a1w==
X-CSE-MsgGUID: BW09gjArQQKPhSnzJpCrKQ==
X-IronPort-AV: E=Sophos;i="6.03,174,1694707200"; 
   d="scan'208";a="243047963"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2023 13:55:45 +0800
IronPort-SDR: uGShNZF43c3j5+w2X9/nujs3hkBVrYrxK18fVCpYpAZH1kyMIQLsFuDFDUhFdNl/Bi00EtGFY9
 IbS4X6dZL7w4uGaT0bxhBIi7l0/P3gKw76JCAasvZs+obdUue9waO/eZ6BhE54vINmi8dusbju
 wrZuddCYDSkd0aQwLo1FnzKR8pNV1A0Ay/3K5Y8o5TFuLq0cazlAsiOltu32fKnQfATJf24eRz
 oPfflZVAu/gQ3u8EJjGhNrswoJFwFpIw24P3yvujwzjthY1Hx59DGNx1UXIcDXjSn6m99h3PTH
 ePI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2023 22:08:15 -0700
IronPort-SDR: UJhujDd9w5X7dpN+JmBfI56u/X+DZXQLFWYfAtk+LWWZylHRZqpBr2tK7B0AXpUGw4O2iUegdT
 Fm4WHNeR+PRtEqMET5QwXY4MA80HqYX91Bo68z3NcpsAfozPIDORoKmvSxyaJopnj58Ksbc4Yj
 /3Layi+ilyySdJYULoJ9zqYxszrs15YV+V4QDQCNpJlQhsA0zQfRnv7k/G8Rbdw6ioaSoYPk1U
 Rba9Y6D6LAvyZq272KB2KDt4aAztdhHkACl2fuigooQmyOGXdt8KOhiwLsyx1Xq0qslmu8H9V6
 iUQ=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.101])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Sep 2023 22:55:44 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs/283: skip if we cannot write into one extent
Date:   Mon, 25 Sep 2023 14:55:41 +0900
Message-ID: <20230925055541.2848073-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On the zoned mode, the extent size is limited also by
queue/zone_append_max_bytes. This breaks the assumption that the file "foo"
has a single extent and corrupts the test output.

It is difficult to support the case, so let's just skip the test in this
case.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/283 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/btrfs/283 b/tests/btrfs/283
index c1f6007d5398..118df08b8958 100755
--- a/tests/btrfs/283
+++ b/tests/btrfs/283
@@ -25,6 +25,14 @@ _require_fssum
 _wants_kernel_commit c7499a64dcf6 \
 	     "btrfs: send: optimize clone detection to increase extent sharing"
 
+extent_size=$(( 128 * 1024 ))
+if _scratch_btrfs_is_zoned; then
+	zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
+	if [[ $zone_append_max -gt 0 && $zone_append_max -lt $extent_size ]]; then
+		_notrun "zone append max $zone_append_max is smaller than wanted extent size $extent_size"
+	fi
+fi
+
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 send_stream=$send_files_dir/snap.stream
 snap_fssum=$send_files_dir/snap.fssum
-- 
2.42.0

