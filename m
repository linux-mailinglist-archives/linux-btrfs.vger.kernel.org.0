Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466D951B3BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 01:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiEDXr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 19:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385945AbiEDXRd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 19:17:33 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BD0F5D
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651706034; x=1683242034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PxnPOVhSijQqEPJX13eGDAqvE01Xf5KXzn2pYPAoq8A=;
  b=nmqzjwMvVyoLCuTludmghvQkySU/UDk/JQ24Z8+k7cfoUAuuJPwwvzYs
   qEbKcKFnvwilm4GOmMlQbDKIUo3adjJReTMsjWXfJnKYuEI9FPRKLAk4q
   IdG8ODmmHYmdZnbCpJTXWFkoeC/qBeJqG0k2tCUTuLQuIB8+fODsbEJJE
   1FUWSpKPBKR5CXFR/vmwHVioDNKEcKghcGqFUsUNC+gDEMJHymFF7uStO
   WDWWi6ckGfvxxBzK3XoNxvnT2L7yz976X+sOjT7X2fWgLh7lF0BWu+Cyu
   +JksA8L46wF+unilKUFic1HuydGlGqHSyjXMqcCeI1I4C+fZJT+5oG91O
   g==;
X-IronPort-AV: E=Sophos;i="5.91,199,1647273600"; 
   d="scan'208";a="311517693"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2022 07:13:54 +0800
IronPort-SDR: q2ICAIOFS9yoHgj9Lbm8K2rrjgvnuXXhQrhxX54kS7B4eB+yVUqdNcQLKQATBEfdyWvgiI6AEX
 MKd6HZwUN02Vpazn/qZQGY4x3PRpQH7O6tqPJhzyH+FBSZ+JbuLas6z5ks2kkNGP6RdxN+1y5Z
 tBo9EApPZVex8RFju3L/eD+Ydu19Tv4q0+80+T2q2rg3UicGzsx2YPqyy2ozx9y9ghq6PPd+RZ
 JRWYE9ZoGlh58aE3nHbPq/+aT98ykRGGE1B/DTlYN9EQsPyBwoMq3vYJvnDgAWYAUaXZqmj3WN
 q44aTvVEz4HhXXMBvott2u4w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2022 15:43:55 -0700
IronPort-SDR: UCnsE82Brb4Mpu78s09c7sBYh0ckbtuyUZS6+KU0vtpZV89YUZhfwKb/r0lqqkxXPZiuhDHg9L
 x20JDaYdM74gkOevwl5WOWDx4MY6ADLMpkkKw+8mOhDDuc9hn3zs7gYZqQ2tVSDcoUes3o2xmi
 IBz8kMfX+yKX6D/rdOmaCSL933SaN5JIuD4ZGEMfxr1sxAKVLL0LHuYJpjZuhS+1/hqQ9fQdqu
 E+k2fVLJZ0elYy5ygfe/7MgafwJOMaPccug3gxMWrG+q8yZzNvlVxe/NILTia7gxu9yxZtltOU
 qIk=
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.48.235])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2022 16:13:53 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix comparison of alloc_offset vs meta_write_pointer
Date:   Wed,  4 May 2022 16:12:48 -0700
Message-Id: <72f5f60036d5f9a3b096365f5c72cc1ad8db588b.1651705923.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The block_group->alloc_offset is an offset from the start of the block
group. OTOH, the ->meta_write_pointer is an address in the logical
space. So, we should compare the alloc_offset shifted with the
block_group->start.

Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
CC: stable@vger.kernel.org # 5.16+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index db1848a24d44..253cba8c73ca 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1900,7 +1900,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	/* Check if we have unwritten allocated space */
 	if ((block_group->flags &
 	     (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)) &&
-	    block_group->alloc_offset > block_group->meta_write_pointer) {
+	    block_group->start + block_group->alloc_offset > block_group->meta_write_pointer) {
 		spin_unlock(&block_group->lock);
 		return -EAGAIN;
 	}
-- 
2.35.1

