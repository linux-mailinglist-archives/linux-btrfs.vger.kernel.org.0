Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBCA272708
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgIUOap (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:30:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27276 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgIUOap (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600698645; x=1632234645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hIPCgkv88milcjNzRRkd5ayi8pFW3zweK7LgZUTxAMg=;
  b=mn0u5MeBwzOGcpB9nst9qnQatSGrcOMEgRsOB6aJSzmDJi37JOzFZWAO
   U219hHRj2fQBHzXa+JfWP/UGBt9fEVJxBAiplpgKYil3TiEDbtYSXlbY3
   J1s3zsU2bEOll7TFB2nWm9LUR91N/en4UFuxkCX4h7LV5jhRDbcBLE6+/
   SWVRk65S2C7JMSteQRMQr1FgtkMl907AadD9RKWfbDB70b1Vft8JUKJgX
   VfRBMAQbNrJiKsFz12BnRIAc2NUpsQWpNqG6Y+LjYKwq/mM7lhbIJwMhS
   4JST3IRh9cbjUWT2k5+WLdcVOvqd9GkCtnhpkqwwBsSUe6xRQ2UwvJ8JZ
   w==;
IronPort-SDR: HrdlCHP/a3zB4kUB2yCP9kvQsKhOmP7+rgQOq5YdmGqSCXPv0G653ViIJ6p7vsbFpc5H4ILj0l
 yMOvzbQYgNhOvOjU1jM4uCMTiPchLqEbf8WW1/MaoYp/vOm2PItm/vfjlZz60400SbCvwO+JQw
 q7v6YSSo1wVqvjZVbp8GJMitOlkLMoQG6xW7NuioXHLWvR3eh+ZqF9A2yuMJPVkLM0TSWN6diw
 4MT01MSaFWRYZm4Co9z6mb2+3lAAXRDcGPCFAVzSNZL9/xcnQUsPEy5D9MfOWhT8zvrH4pV9c5
 cdg=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="147817423"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 22:30:44 +0800
IronPort-SDR: YvYMhTQUDQAHbfLCpKFjq4DvgF05FFVN2sxoMeAt7LhiZfM+kOR+aVryur/c+hcvD7+tUxiq0k
 g9RNgp5XSEdQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 07:16:53 -0700
IronPort-SDR: GY+GIzqLqM90CxrW4fcL5TNTmEV0P2OMP4B+HO30k/odRS8+c9+2h/GDdw2uJVlgioX94Ve7lz
 B36PcZDW8h/Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Sep 2020 07:30:44 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: remove stale test for alien devices from auto group
Date:   Mon, 21 Sep 2020 23:30:35 +0900
Message-Id: <20200921143035.26282-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/198 is supposed to be a test for the patch
"btrfs: remove identified alien device in open_fs_devices" but this patch
was never merged in btrfs.

Remove the test from fstests' auto group, as it is constantly failing.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index 1b5fa695a9f7..a1ec54c51631 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -199,7 +199,7 @@
 195 auto volume balance
 196 auto metadata log volume
 197 auto quick volume
-198 auto quick volume
+198 quick volume
 199 auto quick trim
 200 auto quick send clone
 201 auto quick punch log
-- 
2.26.2

