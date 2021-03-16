Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4504333D159
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 11:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhCPKEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 06:04:43 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60572 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbhCPKEM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 06:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615889052; x=1647425052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vdbsyGiXPqhjSxFdtpvZO761lKw+QkHDEp1ksv4sTwM=;
  b=Us0A6PSl3DrdH4yEQFqGMX2CMB4QGokkAYliUny5Y3Z0MWrn868nnRcW
   M4AbXT7h1sbO3otDJryX1zKyvJGIDcfJx59t/QOCM2Gq9EL7IcOGul4cq
   T5Jj5zNk5/8YHyHynKIbpD51iebmQi2chrVR8ifcQnLoGApsVyq58JQ8d
   ldLmtlW8JD7FRaVB9IYQdJ7A95S0kxnW++ZgaW5CZ8Ji5g1BxiEazycVt
   zp3Ik0VmhEYoF6Oi2kEyKdOEWL6dMm/G0tr3/JV2zFV5Cqxbfm2kVizcL
   G1USzlI6v8J81eH0miV6iLtNq6e/OVX4y1BepU1C+m95AJ1MEurEULCJK
   g==;
IronPort-SDR: oAK4naotvJm6uIAMnYbQtkZoY225GZABQvqO6P+RwLZCj3VHH1ub5Nk/CjIFYkjz/Y5qz63csI
 CBqLHOscpcfsw9pNPoVUc/2SMQ4smiUIXj9u231SF9IhTFMkdw3IjGlF8NXBGpX1v0axMrNBJw
 WbTd9zBmobVycRXN1RRuzhPVcfsH8PyropMZ1eyYVioLvOnH+6oOSqaiWbopHCYjseugWkYN6z
 u2dDuAPtc/QI7ahs/OTn2AKvb8apkaHMuhXKrkNtnjY/SxzzzoUY7xnPB437V+mSOZlX0Xuyyj
 C64=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="166737533"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 18:04:11 +0800
IronPort-SDR: vWyn9Cx2DNyDYX3s2hXnIEiQ5G8UP7tdxFyLBTaRXpeReVAWP3k6zi+3ICkFChlR+/XWZZXhX5
 Ewtgb8m9uuFJBMUsRM4CY/GDQxA2jbvbH1r+qD+osewYILKNWaZWSrWZOu8zE9ej4x/5UwY+wc
 xso/9N85CLbA7APOMXu2VJuosGPZTZdRILNWu//iAT+M//RJ4yg619aRdV56fZaoJMvuQ1NSGb
 ZQ9fC5ZjAZn2KvLKQeNvAkl/d9P4iKUJp2386QR3SrybUzj0NOXynvs8uKp550WNVQIawCSeYx
 /AVt4nOK0bLMjWpDmHC4OLVH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 02:44:47 -0700
IronPort-SDR: oa4QNJRexsrIOdNvt+FczEnkLPFdfIsHUpDPKhbHLF/mPInhRZaL243uHfc6VU9CiuRp/Ejzij
 jdL0/Vn/2dd3zAbL9ehmd/nJMDUxJB8NRPI+y1jYOv9YrVSSXuB+ccyXpPFySvlX+Lrqu5b6kz
 uP0n4x62Pd5f0hibS86hx6cXLMVXcBAw/h+nMX4vVhSZShtdlfuNaE+Vppt7bF5D6azOTEl2Kl
 /5CQzU+d/FSQESDypAc1Zm2XeLMxQgOldJCON7GUAitubAFEt0KZHbdLKQoGOoZH0KNresMWIn
 SpA=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Mar 2021 03:04:11 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove duplicated in_range() macro
Date:   Tue, 16 Mar 2021 19:04:01 +0900
Message-Id: <dd5dbd8b1a0bb0046c76b4b9ee3e21b33ebfe801.1615889023.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The in_range() macro is defined twice in btrfs' source, once in ctree.h
and once in misc.h.

Remove the definition in ctree.h and include misc.h in the files depending
on it.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h     | 2 --
 fs/btrfs/extent_io.c | 1 +
 fs/btrfs/file-item.c | 1 +
 fs/btrfs/raid56.c    | 1 +
 4 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 751ab9f80e4c..1c18b4360df9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3733,8 +3733,6 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
 	return signal_pending(current);
 }
 
-#define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
-
 /* Sanity test specific functions */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 void btrfs_test_destroy_inode(struct inode *inode);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c18c2be57678..4b2579ebf42a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -27,6 +27,7 @@
 #include "subpage.h"
 #include "zoned.h"
 #include "block-group.h"
+#include "misc.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 47cd3a6dc635..1b2e2291939e 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -15,6 +15,7 @@
 #include "volumes.h"
 #include "print-tree.h"
 #include "compression.h"
+#include "misc.h"
 
 #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
 				   sizeof(struct btrfs_item) * 2) / \
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 8c31357f08ed..f60215b5d154 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -18,6 +18,7 @@
 #include "volumes.h"
 #include "raid56.h"
 #include "async-thread.h"
+#include "misc.h"
 
 /* set when additional merges to this rbio are not allowed */
 #define RBIO_RMW_LOCKED_BIT	1
-- 
2.30.0

