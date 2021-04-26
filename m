Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99E136AC22
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhDZG2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:28:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhDZG2x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418492; x=1650954492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6P2gg3pGzirHJwFMY6j+77k45SzmvWkOmRc14aa3gh0=;
  b=OTa0RFQOhsxU+sJiaIXNoW7eOc1l+9cWvZSRVruiDIJmgy2PEAg5wTZD
   WT1oYWpG3wmsuH8cYR/rUIoOUq3t3Me2GZa06WG9zJbxDeoEU11Ts+Tkz
   rmw0NqJkVQZ1R/jEDfB5l/w0GHABuUSL8xL533aYU2n/h6FuRDQw/4XOP
   9Xcc58+5zaEcQ6sXhkXLALqGXmqOj40/iTQ4SFkUPHLe5mL0NXnUjRmzr
   UVUmJMOL70WRAwYyHp/Y9hzKWnrZhib2Os74VPbwslsXBzdRyzozG1yC7
   7fCDMAkSbXKBtjHFiW94ifkCn0N8gQQEeONRK3j983amIIU8RBInFdSkq
   A==;
IronPort-SDR: T+/QzQGPVgjG3OVyT1Um8GmPrLCnxRrY88g8TTWbJN+drcp/at/HDIvuRVBbknsilaPZSLlYB/
 icp7pmWK+Wstj+5MslGtR7V42AEAXu1gTvjxiFaVGtfrB+JoJdkbqJ8HDkU0nUhFC1CxbFdfLm
 jkP+fDABFdwBeozmzUN+vQBFaAr+TyTDRufT6Uz8eRwzJu4KaiBcY/yBvrW9f5EwmGBT90maWA
 Qlq/lGlW2LjyUU1KAyBuIMzgQIc4t1L/4Vvt9HFLGoCZHq+BWMFFaz9KonZ4RTwYSNJXYtc6vd
 WII=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788108"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:12 +0800
IronPort-SDR: qJfGv/f/LYDHkPG6Myr6JJ64+tNueoKiQZkpqGuTLmP1veXseTOq3UFZ7RPrJcl1oVQKlyiR8Q
 +K5HRCz6bzvwwI5DuXsVNzsYtBPSTWv9MRA/SR9ARSm/VORXIGUfNu+08BRdXaWA+LslGT7/HA
 hz6IK3ReOjJ442eoBI8jZ2izlxVwUwQbDx0hCurWDvhBzqaa4lPAXUwO9bNlFcJm4vJoM3vzlh
 zrYvUP/aoIWE5Myar/brC8whkN5+7709ghpq4y46wbxtcp+BaVT0StS3Q4DB8aLwWr+fxcRKnU
 aF9Bxyqp6M2FEFF+x18VqIOs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:36 -0700
IronPort-SDR: ZUcfqRKwpcHIGC7hEBHHsKa6HBbx2jogi16WWUWePptiJywDAX/XKV6Qi3GiHOox7+J6EY68yd
 1uDVEIN9UseqJk6qsmWE3OTAoFhwsUxeWL6LwF5/6hoczeu/oVwhKPwBsI9YAToDNcgeanIzVg
 9uVwQ+dqBFSjPG4N2elth1C7QhYvUI2hyyEf+6N2ZCv57XJwFrg/HKANphhS30EA6Cmnp5VF7/
 guB0ZmX3v/U9j6yj2Bm64GuHTaTislzi6qXmue09jAeer1tw2uV32aG62/u1cUTPhcpCFULtyg
 lcQ=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:12 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 03/26] btrfs-progs: build: zoned: Check zoned block device support
Date:   Mon, 26 Apr 2021 15:27:19 +0900
Message-Id: <c906fcb0b1d90ac470d81cb12182f5d0e8426ad0.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If the kernel supports zoned block devices, the file
/usr/include/linux/blkzoned.h will be present. Check this and define
BTRFS_ZONED if the file is present.

If it present, enables ZONED feature, if not disable it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 configure.ac | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure.ac b/configure.ac
index 6ea29e0a5a06..5ad95d662b47 100644
--- a/configure.ac
+++ b/configure.ac
@@ -250,6 +250,18 @@ AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK],
 			   [Define to 1 if e2fsprogs defines EXT4_EPOCH_MASK])],
 		[AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found, probably old e2fsprogs, no 64bit time precision of converted images])])
 
+AC_CHECK_HEADER(linux/blkzoned.h, [blkzoned_found=yes], [blkzoned_found=no])
+AC_ARG_ENABLE([zoned],
+  AS_HELP_STRING([--disable-zoned], [disable zoned block device support]),
+  [], [enable_zoned=$blkzoned_found]
+)
+
+AS_IF([test "x$enable_zoned" = xyes], [
+	AC_CHECK_HEADER(linux/blkzoned.h, [],
+		[AC_MSG_ERROR([Couldn't find linux/blkzoned.h])])
+	AC_DEFINE([BTRFS_ZONED], [1], [enable zoned block device support])
+])
+
 dnl Define <NAME>_LIBS= and <NAME>_CFLAGS= by pkg-config
 dnl
 dnl The default PKG_CHECK_MODULES() action-if-not-found is end the
@@ -367,6 +379,7 @@ AC_MSG_RESULT([
 	Python bindings:    ${enable_python}
 	Python interpreter: ${PYTHON}
 	crypto provider:    ${cryptoprovider} ${cryptoproviderversion}
+	zoned device:       ${enable_zoned}
 
 	Type 'make' to compile.
 ])
-- 
2.31.1

