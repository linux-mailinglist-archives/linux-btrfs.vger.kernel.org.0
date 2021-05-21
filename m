Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8752E38BDA8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 06:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhEUFAB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 01:00:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33623 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhEUE76 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 00:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621573114; x=1653109114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mPGgMAweEGvRR91DavcmPlyA9iS6PleDUIzgcMY0930=;
  b=qFHIXWJqaxViVFp2JtQQuRurLwFgPzTBGzio92qEw+ZOfmOzBlPRmJut
   xhm+hzTfvTVDm7GNjCmCciBjcO485/HiiUxprSMS4d+CxvqWmCrblAoZ5
   +ihX1rj+1YDVniGQBDFkZIQOyxnhmo3BzSktsTdZbuldlI2SqdCHerDGJ
   XjUBffOqM1HdH1GfG04Xi/7shFCmkE5/p/pvKNLnSieGpg0RTxepxVFpf
   nEqHHmUJ4jpTqT+MqeGVWBnHOzCFy/AbrESp+gOUqTn6LC8qXTp5FVI0A
   BOG4NemkK8arcb4fObw5c6crWMo5PLz8MoYXzk9iYHs5w26v2YvqcB9do
   A==;
IronPort-SDR: v23UgeuDovguCvOUNxyxFcfVxB78L0nOfo4YFHYjGcLpwVmxSrZGlaHLJFhObli9QdxsOPgxX7
 WUmvY4jJafhY1Fo+0QAti/LEbVwbzyFrb202dw5Fti5BePxvHRSMEbNzE4i7aGmXgeGyloJV9d
 dS6kDtjd5PHAallZjHCKiRy5UDhelkAD+O1fbOCww2eS+/389TOJ4zfHuV42M3P2HlN/+K+MFX
 TKo6gPcLyscvw8HiYAqKRxj8uaxvjVxHtZMgtFeq8liGp3O0/RiP3UoMNhDEc3hgg1maahoyAR
 WnM=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168955585"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 12:58:34 +0800
IronPort-SDR: q0ec/fyrYYh8xOF8IUF3Ssf4IYncV3cViSOcLuA5vJogSs7bm+k/vbBHkoj3STeeHQBo0PKwJV
 fBq6+rhyqrHt2t8ifjAcJ+bPEQmTkRIXwjjTUQ+N1t0feAMW8fFEQ6Vz3nf7qxnplw8KC8Rwok
 2YE8Z7yqe7PMmM3H1iDCWphXcTnsKVrE55Gr3HaieJxS+FdXek/Qg3b0wBclxCJlos4fsyUfNY
 bMpZ05WUZR2u43EZGSM2Qp4H7LrSrsAODaiqNOh947tUtKDjWEt/iiQP5X8qeNR541XLHZ7JSB
 z6xib/TyhXltmW1t/shl9yPt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 21:36:59 -0700
IronPort-SDR: AWR4TYUiikVOA06yxx/ryFrI88w8fjONnJY4tgj/XAQOm6uBKQejqvK0K/qvpFUV9j0I0aKLQX
 Ytuby/L+pXN6Fc314roDf4hFwnSLdX6qilbhmEKV+2QbZlj2qXLMoIhzeseWXMyNGVDgLabOHt
 qT/ov5baYpN1YZ6/OcGsugN3iMGiAeKcvslexARXdbh9zV1Eb9kcmxpAuSYhIPcCanjcwo9vMH
 DPxiDnyUZor/LQQKfcDfetiJE5JbRyTUC+uncnuta3ud8e0N5xtK617WJSasTEKpQ0nUCj2JyQ
 bNk=
WDCIronportException: Internal
Received: from 9rp4l33.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.75])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 21:58:36 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/5] common/rc: introduce minimal fs size check
Date:   Fri, 21 May 2021 13:58:21 +0900
Message-Id: <20210521045825.1720305-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521045825.1720305-1-naohiro.aota@wdc.com>
References: <20210521045825.1720305-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

_scratch_mkfs_sized() create a file system with specified size
limit. It can, however, too small for certain kind of devices. For
example, zoned btrfs requires at least 5 zones to make a file system.

This commit introduces MIN_FSSIZE, which specify the minimum size of the
possible file system. We can set this variable e.g. $ZONE_SIZE *
$MIN_ZONE_COUNT.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 README    |  4 ++++
 common/rc | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/README b/README
index 048491a68838..a7888281aa09 100644
--- a/README
+++ b/README
@@ -117,6 +117,10 @@ Preparing system for tests:
                name of a file to compress; and it must accept '-d -f -k' and
                the name of a file to decompress.  In other words, it must
                emulate gzip.
+	     - Set MIN_FSSIZE to specify the minimal size (bytes) of a
+               filesystem we can create. Setting this parameter will
+               skip the tests creating a filesystem less than
+               MIN_FSSIZE.
 
         - or add a case to the switch in common/config assigning
           these variables based on the hostname of your test
diff --git a/common/rc b/common/rc
index b18cf61e8a96..9a8458d4a3b6 100644
--- a/common/rc
+++ b/common/rc
@@ -956,6 +956,16 @@ _available_memory_bytes()
 	fi
 }
 
+_check_minimal_fs_size()
+{
+	local fssize=$1
+
+	if [ -n "$MIN_FSSIZE" ]; then
+		[ $MIN_FSSIZE -gt "$fssize" ] &&
+			_notrun "specified filesystem size is too small"
+	fi
+}
+
 # Create fs of certain size on scratch device
 # _scratch_mkfs_sized <size in bytes> [optional blocksize]
 _scratch_mkfs_sized()
@@ -989,6 +999,8 @@ _scratch_mkfs_sized()
 
 	local blocks=`expr $fssize / $blocksize`
 
+	_check_minimal_fs_size $fssize
+
 	if [ -b "$SCRATCH_DEV" ]; then
 		local devsize=`blockdev --getsize64 $SCRATCH_DEV`
 		[ "$fssize" -gt "$devsize" ] && _notrun "Scratch device too small"
-- 
2.31.1

