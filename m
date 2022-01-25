Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C78449B4FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 14:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386904AbiAYNZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 08:25:21 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30516 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576461AbiAYNWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 08:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643116935; x=1674652935;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n5M8KL+qOTUSyKeB0D0y9lW38wrp45o/Eqo4FBYABf8=;
  b=Z+z6r2h1vzixI57TxoTtvj+a5+pfnKOzYKoUB2BjLC0rJbKogAUH9pjs
   8JtDZFKVBi0Th9LUryUVElkJqYoT3ObiRE7oHkPXBgoWu8hksmLwNulRu
   K/Ca4DI2VlHUBDZSfX6+IsLzS3ws+J2BIfjvKFdlsXd66VA9PrC6j+wNv
   LLysgnFXsd1kvTNLpjJDoKfnnDQm4Zjuy+CU9MF/+FaSdSYy5x9zeFfEZ
   eU1KeTUgxgyaOfl5ck9DobmkLb0wlgK/gdWZ8iHvvaynfH5vfzT6JRJEr
   KxHaA5uMrS/mJBEyGW2J4Bz2B7idf8Veu/98jaAH/cFsGKFooDyR8VHTS
   w==;
X-IronPort-AV: E=Sophos;i="5.88,315,1635177600"; 
   d="scan'208";a="190280733"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2022 21:22:08 +0800
IronPort-SDR: eKy2Q3I7qlhCHhlNQ/QVqFbO2e+lw/xNZlpGLsurfy3TT1pQ5qbDMOlWVdTwdSXBevMFysmMf7
 y+9KJEcrWJXD9C95gh+MNRT9EnPrWKCr5lYlq1XBXszhleQrc9+zaq/rL+egT6DYqqbw2D09gW
 wI7hPdKAIb0qRI4LscbzMcDRAAsMf1wLuy4nFShYLuEwHyroXdlRWEQbz+U0DFJeTd5MbssGnC
 wtcZJB8E1Ogfj41AI7/cYzn1aJDsO8OSazkyG97D1WtLSguzX87KM1UV5HhsCNPrglLKZhZRQI
 m6UzOQE5h9SjKtvRr+LgwmrF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 04:55:29 -0800
IronPort-SDR: VZgLZlgaIwrRSJqFrTPks/GJbIaXmFMkdR/+m0KUMw9ZEt2/yEvqDdQKoCqTzjrGkJqaZ9PT3A
 Q10vgtmZCpoIpsKt+We3nD/xCziaTzfH7vvtymht3QsEsdXpL21w4c5qt3KxE79Kntn9oAD7Fl
 icA0RjvuBL1UEEAFXkxIX/wnJ4rSpFwDyzCKIvPa/v+YVE3kJQZ9ge2qi7Dm9C4jQQzzEB+k8u
 AoZuqZaaHDAYQ6VTDSmSxf+alZkIEKi+HOKAAJxJ2afOct/9j1LWnFyYnblplzyLAz4Im0oRt0
 xjA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2022 05:22:07 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohire.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs-progs: add udev rule to use mq-deadline on zoned btrfs
Date:   Tue, 25 Jan 2022 05:22:00 -0800
Message-Id: <20220125132200.56122-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As zoned btrfs uses regular writes for metadata, it needs zone write
locking in the IO scheduler. Add a udev rule that configures an IO
scheduler doing zone write locking.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 64-btrfs-zoned.rules | 9 +++++++++
 Makefile             | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 64-btrfs-zoned.rules

diff --git a/64-btrfs-zoned.rules b/64-btrfs-zoned.rules
new file mode 100644
index 000000000000..d70e22740557
--- /dev/null
+++ b/64-btrfs-zoned.rules
@@ -0,0 +1,9 @@
+SUBSYSTEM!="block", GOTO="btrfs_end"
+ACTION!="add|change", GOTO="btrfs_end"
+ENV{ID_FS_TYPE}!="btrfs", GOTO="btrfs_end"
+
+# Zoned btrfs needs an IO scheduler that supports zone write locking and
+# currently mq-deadline is the only scheduler capable of this.
+ATTR{queue/zoned}=="host-managed", ATTR{queue/scheduler}="mq-deadline"
+
+LABEL="btrfs_end"
diff --git a/Makefile b/Makefile
index a75d9ad8de1c..1223ba6d069f 100644
--- a/Makefile
+++ b/Makefile
@@ -231,7 +231,7 @@ image_objects = image/main.o image/sanitize.o
 all_objects = $(objects) $(cmds_objects) $(libbtrfs_objects) $(convert_objects) \
 	      $(mkfs_objects) $(image_objects) $(libbtrfsutil_objects)
 
-udev_rules = 64-btrfs-dm.rules
+udev_rules = 64-btrfs-dm.rules 64-btrfs-zoned.rules
 
 ifeq ("$(origin V)", "command line")
   BUILD_VERBOSE = $(V)
-- 
2.34.1

