Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51CF103469
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 07:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfKTGrK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 01:47:10 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49569 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKTGrJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 01:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574232429; x=1605768429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x3C0QWKGnbHiXf89Z95VPNtK6A6B5YQ6CboCRZJg454=;
  b=Z/GJNzPSUgO9D42wIQ+qowzmXGSjgA8gctVA6h9aAc77LbBwChDRHT+1
   1qaVzeMtqfbEYGmIDECaDcuhWRh3K7lERi41AmqDXSghlr1Y1HMXTJVI0
   GtqCfIfgfSxWwgfZUzdsycFNvJjUTQN+sqORd0q26JpCmh212UbtMy7TW
   lfj3K3m8MAsyWTTBdoPj8GHfWVQD7G23LXDDLzKLk2jz5qC6aRt+2ZmUm
   LfVQAxcW6SuxdVBUn9Q08ZTms6t3sybIe6epOFgMJl+6f8hzO+j5fzwoy
   oDuthES75yNrvX+Z4Ltp3ASGIgRROKVLTjmC8wu7TEm1QpWCXpCTzmFAR
   Q==;
IronPort-SDR: E/5pzDZMCngS7JwoQGSCnVljk9VeTSwrB/Bj6QtsYb3yZ8r0JPzn4tfmgO+QR3W/t8GWdTwoSv
 uvoSIIPFxjsZJ4i8lX8Mj0UUSKSEhBjfALrKH7H6vIyBoTcto3+sPFebUTz/5f8FvQ068MSmgn
 HAfDO5n2/XjFfVSsJfNumchyP/povTZdkOO3RRT5UCEhL2N+GKQvn0lzsnborkLQn7/9ZseVH7
 NdFhODNJpbYH/ZWk6KRQnuuYSnXK5doOggjzDEUfTnmtZDmul8AXn5NWlSOV2naIaN/LkDWp/c
 U9s=
X-IronPort-AV: E=Sophos;i="5.69,220,1571673600"; 
   d="scan'208";a="123506626"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2019 14:47:09 +0800
IronPort-SDR: XqyC7hvd8VD76gLqFrrq+yL12wkiym9QYNV5fTPYgUwTiq9q417JbfTQo50c6yNvtvY4iPoe4J
 huO/RqsvPFzGe5cYzV9JbxGKEyJE2GByb9QuYTwI70PuQRk+V8f9SL1yx9hbI8K+ij0SW5O6DE
 FPF0l/cvYlJSrcxSMZdMmLYtQkoRBstcyxRdCRqRo9oSgYGdCUKH7Zcfnzin8I9LEibUd+PBj9
 yhoKw/i1uwRMlTfYlfQ8mwYlu3bMY8w+Pr34Tq1A+d3ckIWEeS1NTm9JZEUN2C8G0Lkc0P8dIp
 Z/pBCUxwaJ2LvnprL0Vj83Xi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 22:42:20 -0800
IronPort-SDR: I4q08cXQk4g/llEotZS96WckPyC/OAcjAO2icxGiuReWHHnqhI5nEa02IpBJvbcaGiUGhMOk0s
 i3XcvZp/tsJTIrAJiWbBZIkC+7IGh+rRMYZNKtXYc/1YGSAmrJWpXH0qPcivyydAyUh/6AnBZj
 y5Tuk932y+Ls5HTtwHswZaupPEBfav3K/Gw6jAX9a0BCUhN8hvlQOyGzWlyJNfdbLM9zNvEAAJ
 aFBcj/MYc9aN8sEqxQGE1LnTEClAAmS4uAKGuLs0ZI9C/9g5AWz8NUjWFLBVHAGpvOjlRv8Ruw
 cxE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Nov 2019 22:47:09 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] fstests, btrfs: check flakey device instead of backend device
Date:   Wed, 20 Nov 2019 15:44:06 +0900
Message-Id: <20191120064406.3467779-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/085 mount and works on $FLAKEY_DEV, but it's inspecting the
underlying $SCRATCH_DEV. Since writing to dm-flakey does not invalidate
page cache of $SCRATCH_DEV, the btrfs command can read a stalled data
from page cache. We should check the flakey device to avoid such cache
inconsistency.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/085 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/085 b/tests/btrfs/085
index 4773ed8041fd..2a31eefd2013 100755
--- a/tests/btrfs/085
+++ b/tests/btrfs/085
@@ -46,7 +46,7 @@ rm -f $seqres.full
 has_orphan_item()
 {
 	INO=$1
-	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV | \
+	if $BTRFS_UTIL_PROG inspect-internal dump-tree $FLAKEY_DEV | \
 		grep -q "key (ORPHAN ORPHAN_ITEM $INO)"; then
 		return 0
 	fi
-- 
2.24.0

