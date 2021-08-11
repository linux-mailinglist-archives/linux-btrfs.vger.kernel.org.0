Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8363E944F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhHKPNW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 11:13:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39984 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhHKPNV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 11:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628694776; x=1660230776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jp04U75vX5scCP7VtbLDhOyHbGzvl6TPnQ5nIrQ4LRs=;
  b=lWLveeOw4bII3HXMCNqV3i/0GGIzu5eUIjyPmMY+GKTkVPn2l0W9GG3W
   ovmHZSWZRLFqf5HuEVd3z+0NUdKX8fF4vfDK3YXLEuRUl5Pp9LlUMP0UF
   6RUHuMyesmwjj3rbAoNLbTJq8NuEE1ga9a3KbURylE7nA9gUxEu62BtOA
   GnpzvUOt7fTRwSrYKQRpa8yLsBmF+8Y9sxVUs47GiILnvfbfl2wTadEsJ
   ailzJM86ULvHOjS94R3bxWhIlG3QAy8WGT//lMpgSYPkNEV0HXEVfRtHp
   xGD+06Bbo82RIpMtazeO9MZ3XLT9PUPOInubX7OSd3DahI3VuxcoqmTnC
   A==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176942555"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 23:12:55 +0800
IronPort-SDR: VRcyhJFYE7Ivu7G4n269fU1q/837lGy9EQTxb0KNxVAF1tLbOsBSzI8Ex+xyQ1oZl17fv1S4p6
 W78Of475Nmk90/25eYHGLg6j/TkpwCFbnS7QFqfFWErn2JuZb9XiFeSwbFfYR/rks0bBAUXwkA
 eQwCXDj8tVPMgVvoaWQc5kxsZzl6/5C/wHvD+PnUYpATEgmC/xcX6gRebu08FXgmMFKUYCcSnH
 Zw5P84Sxwncb4GOdo2+rvoEqn4A5s602z4uO5WuaytDYvVElxYlcyCWrS8nh2APrfmNxy0g4no
 dy9eu5VpeIwxtit9Zy6AqODc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:48:26 -0700
IronPort-SDR: rPLCKwagFuzPiNIymfwV+v+NCTSpLYImbacOyPSVsn0scK6OemitK6r+jsHiMGfcoYDjrHOgHO
 qeOMZIj4U4wb7k1mzzuIHbqoD62jIVZXJTwNN71eF6MPz6JoC4mpe3Iobx/Fr6bNyOzxHRrAtH
 oCgbaSHH1a2Vag3EgyUJ/HgwzEEnVoUyaWJgF3fNl183SaC1n1FwyOTqrO24UC0GT/3WteobWC
 /yotAYZZmc0gWQxe+g89hdAPlOyja/Da+lvGklvwPrt4zedZ1LuUbmmCc1WnyrUwW+iSyGgrY1
 GJg=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 08:12:56 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/8] common/rc: introduce minimal fs size check
Date:   Thu, 12 Aug 2021 00:12:25 +0900
Message-Id: <20210811151232.3713733-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151232.3713733-1-naohiro.aota@wdc.com>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
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
index 18f7a6bc3ff0..b9877b7d8b1b 100644
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
index e04d9365d902..4cb062e2fd3f 100644
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
2.32.0

