Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DF8348EDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 12:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYLY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 07:24:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44123 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCYLX7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 07:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616671440; x=1648207440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KPQJaHzBlbP9xiIfDqBWXWGsGK0lqSpcHkN2QmqkQbo=;
  b=PD9EduBi7mOcCqpPSTznZPZXE3W7xipx40SFAM94ANPXc/gkXHBaOGWt
   OyvjYdbiJr7COANzTX1iWAqYVPwgKeVH6A5eSdvaacQ4oBNFE6DyzbWB9
   1JV2WUIRMJYStQeRKV8prqwE0UFzmF0eI8exsVXDbxcdVP9LclkqxBUYV
   NUhK/AGeFDV+xJ1eebLThf/rBohf+AVdsfrLxTyIuErJmptidWLKNu6Nh
   PCNN4Qi9U9YKUMJdgdhITMIubcNLFBjr/MKpRvrIQlsOMtJpM70Z1EvBE
   JamrXIoZBg2yNqkENeJ1+25lebX+KNj3mKF7ViJ+yPnYMsOJlnRto4pG1
   w==;
IronPort-SDR: h0cfbzEwcTUN/nyDLhsrY3FBpZ5CS2VGx2kiaf3kau3I0gsoaqBvBnKEkq0BdbiIHmeAb7Q4V+
 yWXpnihxTwOkq2KRNG+Ybfx5/IIMbQeyuYuNiYwKzWoq33b/8bbEgZqS9EkbFHrglShD0CvEoz
 Zpq/7UjzRkH9+c3v04bEvcJDCNcYy5kLJ6p81FgXAgQbXzuKiwcGNZYKAoheJy1/WIJLKCpbg6
 033ZiAyCN654hInZ/ea3MvhOk1qW+jFYbBz6RLIkx7+gpbhZIteRvE9Spo7ra6KDHrc4mBoPGX
 9U8=
X-IronPort-AV: E=Sophos;i="5.81,277,1610380800"; 
   d="scan'208";a="164096787"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2021 19:23:54 +0800
IronPort-SDR: 4OhH3hZwcSyCjtD+eO/meKrCEobKgJhPgqDkL/5ZKYn9k7eUrmzVG/7ca+JpUFjs89SbPKnyvZ
 4FnGx+7fXzMMNkJuovwjFDgqs4GeZDoy4mEZhrrc7tVFRnnuToHwT+gdIu7J7a8BgttwWGqDtE
 Vi8O7l4NnkS0ogqJW+XXAAK/4ZwlL/Ud6ekkLYmVlF36BFmGz3pqrETqtNkHedk40smfkt/V0j
 ugOd6BN2KvSvnuRKdXWISOrjrY5TtemPZeqCa3sLPT7EkrTgH1H0OYkNPUEydT3LVMiel/aUhf
 viF+MyAavDDQ9tCiGX+fL3Hb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 04:05:53 -0700
IronPort-SDR: KQHe4Pqc/qZSVZPZomxvoz+36Wb6CItdxPfSC5WRmV12nehepQrZ6r1qi635wU2QID5yY0v82u
 p7QI7LuRF7qIN4WX8CT42uRF4DfXiXFPD9tdCdymnnRPDi197tiV1k+dnsPV//4RdUw5Uvmvvr
 sMrhqLq7PgOi7SfdqEagsFLEosGXbuOExDCu9gPq9IQxPek7c6wiwa0S6gtLwmv+5DbT4oVUue
 Zjfc24m5L/h6SbbxAyA7kaSYd9BF5Aweh/yLKNru8OhU86z6pQDN1noMp8uQq3qe4reB9gpoTX
 T+4=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Mar 2021 04:23:49 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] fstests: don't relay on /proc/partitions for device size
Date:   Thu, 25 Mar 2021 20:23:37 +0900
Message-Id: <20210325112337.35102-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Non-partitionable devices, like zoned block devices, aren't showing up in in
/proc/partitions and therefore we cannot relay on it to get a device's
size.

Use sysfs' size attribute to get the block device size.

Cc: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 1c814b9aabf1..c99fff824087 100644
--- a/common/rc
+++ b/common/rc
@@ -3778,7 +3778,7 @@ _get_available_space()
 # return device size in kb
 _get_device_size()
 {
-	grep -w `_short_dev $1` /proc/partitions | awk '{print $3}'
+	echo $(($(cat /sys/block/`_short_dev $1`/size) >> 1))
 }
 
 # Make sure we actually have dmesg checking set up.
-- 
2.30.0

