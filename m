Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEBA3E9458
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 17:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhHKPNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 11:13:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39986 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhHKPNY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 11:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628694779; x=1660230779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7CU0P+8VJ4+R9x8XmFTIOdMI1rRPEB7YQ5E7pSeMbIY=;
  b=j0fEg6q84MWmwq2q1ROP8e83cbe+xfN0VsPUh/BpvO4tmXuS/c2aIU37
   nI+aIDfwDPMSMsKRTpL+0CCYFAr23f4fX/7vPtWhR4JeMYH477b3kAs7c
   ywo9mXDqgJXPKcYL9Yv1NDQ34OPsjySyKB/3I75WzUTj+OhtsFNAMNoWI
   eCjzNfwOrnOgbbqDwISbCmNEQ68xnNmaAbiyEtDIw1kv2ENSy3DShBSRL
   fFfB/PlC+qymqxjAcu8TqkenwNK045iO5BGDLRf1711h+yKmvB1Cghew/
   wUSA6MM9KM4FkCug80ozK7lgd7A/myKQ0bu+KiQ5jaLvgBY2yNkVY+DCZ
   A==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176942569"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 23:12:58 +0800
IronPort-SDR: S+0qNqaFivJ/ohoF0njWqqFgs/hE9RIMu+jYw6GJALYMkskslK4C3QLTHRzTysxgFkZYvPIs6D
 79pTqhrFlmhwo7oHR8qEv2zgRxZlLyrO0ZjOkTHj+M0zQxyivREIwq4E8F3aMyhIoFF4JLvTY7
 XEoXTrkK5NDutC3SwkjTuGPDI9TZw5ZQIOKHWu+lS4xp279S0CHwfHZSLqIcLV5i7BBomjQ827
 OkqHAx5rMZ9nWD0odSD1OhDfR+6UXspHjHpMOJ3fiqFekrOT7Gfej+D52w2h4OO0fM3gZ5vOwI
 MFvjmMrIj/xq1GkRRULL8DpE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:48:30 -0700
IronPort-SDR: zp3MTPftmHo7btnA8yBqDt8ODbXXIsT3ooeA3Wc0jLpXUlqWTCJHwndqwnf8coqtDQUT0uKfh5
 qijlvvEJXQGwaXxPaLyB0egnR/D/Q0qhHdlQyOf5nLaujWn1I0D6JnN7p71R9jVV8NyISF8hlZ
 gNwBLkJ66Jp0VwLi1c12CTDkmKioHa5gr0MAw0P9qsBPdnFQYLcQjntsD3UoSOvGBTbWPmgG88
 DVGnCiKRsiNe/Q+Fft1DaVhU9LcOdfBnutP9hwhY0TKvByRZX2l4eIXLXKKRZyIPp4HRarqmKJ
 DGI=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 08:13:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 5/8] common: add zoned block device checks
Date:   Thu, 12 Aug 2021 00:12:29 +0900
Message-Id: <20210811151232.3713733-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151232.3713733-1-naohiro.aota@wdc.com>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

dm-error and dm-snapshot does not have DM_TARGET_ZONED_HM nor
DM_TARGET_MIXED_ZONED_MODEL feature and does not implement
.report_zones(). So, it cannot pass the zone information from the down
layer (zoned device) to the upper layer.

Loop device also cannot pass the zone information.

This patch requires non-zoned block device for the tests using these
ones.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/dmerror    | 3 +++
 common/dmhugedisk | 3 +++
 common/rc         | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/common/dmerror b/common/dmerror
index 01a4c8b5e52d..64ee78d85b95 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -15,6 +15,9 @@ _dmerror_setup()
 	export DMLINEAR_TABLE="0 $blk_dev_size linear $dm_backing_dev 0"
 
 	export DMERROR_TABLE="0 $blk_dev_size error $dm_backing_dev 0"
+
+	# dm-error cannot handle zone information
+	_require_non_zoned_device "${dm_backing_dev}"
 }
 
 _dmerror_init()
diff --git a/common/dmhugedisk b/common/dmhugedisk
index 502f0243772d..715f95efde29 100644
--- a/common/dmhugedisk
+++ b/common/dmhugedisk
@@ -16,6 +16,9 @@ _dmhugedisk_init()
 	local dm_backing_dev=$SCRATCH_DEV
 	local chunk_size="$2"
 
+	# We cannot ensure sequential writes on the backing device
+	_require_non_zoned_device $dm_backing_dev
+
 	if [ -z "$chunk_size" ]; then
 		chunk_size=512
 	fi
diff --git a/common/rc b/common/rc
index 7b80820ff680..03b7e0310a84 100644
--- a/common/rc
+++ b/common/rc
@@ -1837,6 +1837,9 @@ _require_loop()
     else
 	_notrun "This test requires loopback device support"
     fi
+
+    # loop device does not handle zone information
+    _require_non_zoned_device ${TEST_DEV}
 }
 
 # this test requires kernel support for a secondary filesystem
@@ -1966,6 +1969,10 @@ _require_dm_target()
 	if [ $? -ne 0 ]; then
 		_notrun "This test requires dm $target support"
 	fi
+
+	if [ $target = thin-pool ]; then
+		_require_non_zoned_device ${SCRATCH_DEV}
+	fi
 }
 
 _zone_type()
-- 
2.32.0

