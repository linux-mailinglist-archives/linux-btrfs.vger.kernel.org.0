Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB56715ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jan 2023 09:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjARIPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Jan 2023 03:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjARIOo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Jan 2023 03:14:44 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A5613CD
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 23:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674027914; x=1705563914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YrTatM5eucJi7UvlGSM81EVt6REo1JwZ+ahE2ONq6fY=;
  b=pV8WZvqqF9RjWJr5vzjwdglc7z6Zur7lzeeXYNwL2KdzNeuOAUeZAT41
   gx0qFBMrf+bhMVIYLI7wiglRbzC+hNnQN6KZMS62V4hve9lghY/7QndcP
   R65AWv/gPD+P6O2FRmclqmmOrsq9WI20Zlfhm3wm7BfL3zypA5ByIAi1g
   FOHje3w5QLbuj5hFff9R+lOrmMGp1R6svj0TEKhwG2gC+oo4uLyz/NFvP
   Qb2kZPdvPGructrYtnE+qwR74PYJYVzcJNGcM3qo8X83w1FYdM0u/Y57U
   zw6WNtHSAoTASKppQaoSfo6AQsOeyGQPqLFzUjwPNkDBPgGTTwG3g2pri
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,224,1669046400"; 
   d="scan'208";a="333108005"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2023 15:45:13 +0800
IronPort-SDR: /q81jTI/s3bimlhLD467V8YzzqV+a/CsOw/ZV81DCbjy5OpCw2kVjk1vUodRuSkHPzZxSjJRUq
 1n8EpFiZSR3bEV42opGlCIJ08tRPclVt/1ckTzTZKp84UKVzIg+H4zQJ51Gfgr2fR9HMCgSk3A
 hMG4kx10cvUdCy4mppQAJCZ9ZtrXi4UglDTedx9EkcAtiz+7Jsgex2SJqezGAMGtiQP18Nwaf3
 N4hdBuboPRrb0BNGMYSYjeg3liWGPmgNmLehzdHSA93RhWwnNAowE5ZuOtO6AokRhdx7eBW1pR
 F0c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2023 23:02:53 -0800
IronPort-SDR: ZIBjqOiWL9A1DNWZTwgk7mP2T9KWFOPgmW++ewewLbwV6FSHsTdHnfxC5Nx/nZeBpQJGyadgB3
 d4b9kdGyhXQg7/Ks5BaR/3OFTcUk2FupsUiy/QEagaLRLIFKVKX87sEUUIBYMTwU/UqJ3hg3IZ
 +uBwGXDSwO9OQtzBV2nkwY7kaVeT06Jdtz3KZxi2zyr618LrrhVMvAoxEvkyPgtOB05Fu/AaFO
 zSBJ4zKUapjn8bsVgbDdcV9T6XhXz0u+lX/RQzVuW31pn7SjHJAMmS+ZGxki6iXCZSYlpNcWlL
 rr0=
WDCIronportException: Internal
Received: from f9rd9y2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.16])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2023 23:45:13 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/3] btrfs-progs: docs: add per-space_info bg_reclaim_threshold entry
Date:   Wed, 18 Jan 2023 16:44:56 +0900
Message-Id: <20230118074458.2985005-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230118074458.2985005-1-naohiro.aota@wdc.com>
References: <20230118074458.2985005-1-naohiro.aota@wdc.com>
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

There are two "bg_reclaim_threshold" under the sysfs directory. One is at
/sys/fs/btrfs/<UUID>/ and sets the threshold to start the auto reclaim
thread. The other one is
at/sys/fs/btrfs/<UUID>/allocations/{data,metadata,system} and sets the
threshold to reclaim a block group.

These two options have the same name but they are calculated against
different metrics. The former is a percentage of allocated (for a device
extent) space on total device space, and the latter is a percentage of
reclaimable space on a block group's zone capacity.

Add description for per-space_info bg_reclaim_threshold to distinguish
these two same name configurations.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 Documentation/ch-sysfs.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/ch-sysfs.rst b/Documentation/ch-sysfs.rst
index 96fdaa34bff3..37fb49f945c7 100644
--- a/Documentation/ch-sysfs.rst
+++ b/Documentation/ch-sysfs.rst
@@ -29,7 +29,7 @@ Files in `/sys/fs/btrfs/<UUID>/` directory are:
 bg_reclaim_threshold
         (RW, since: 5.19)
 
-        Used space percentage to start auto block group claim.
+        Used space percentage of total device space to start auto block group claim.
         Mostly for zoned devices.
 
 checksum
@@ -117,6 +117,14 @@ global_rsv_size
         Space info accounting for the 3 chunk types.
         Mostly for debug purposes.
 
+Files in `/sys/fs/btrfs/<UUID>/allocations/{data,metadata,system}` directory are:
+
+bg_reclaim_threshold
+        (RW, since: 5.19)
+
+        Reclaimable space percentage of block group's size (excluding permanently unusable space) to reclaim the block group.
+        Used for zoned devices.
+
 Files in `/sys/fs/btrfs/<UUID>/devinfo/<DEVID>` directory are:
 
 error_stats:
-- 
2.39.1

