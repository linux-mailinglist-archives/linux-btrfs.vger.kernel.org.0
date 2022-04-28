Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0D45137A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 17:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348716AbiD1PFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 11:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348705AbiD1PFl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 11:05:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF803B3C6C
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651158146; x=1682694146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=McS6LOQ+qbCDqY9h9ImN2+sDf7qjg7/obzhcg89zg0o=;
  b=Vl9OAEtuvDVSH2H/pckWp5pdQ+U3RnTQEVyjchD49HG80Lfdnpfs/m/W
   8uQhiD0hK2q58FuwqPOy4Lg711+M+2oxTwP2mFKJ1dlvQ4GaY3bp6jp8m
   SajbDuCjevikSzrk7TtQ7oRAvdOabeGyiwjm6kKC9bV7PG+M4RweZWWvb
   aFagpWYDSR6q+DO2VJe9pEw+LMZqQWlKYqhiUWssYFrvSk4ZiIiiwT7X3
   6yg17+Bt0PI6sjpUuoo1n+XMnYBOtxjYk07V51YNnqRge1NJpc2PqF7Nt
   dejjAnXq3tjbD8t6oHFUthSzOw3I/b6VadtKAD6rEJ9n4Lk09sRl2FlN9
   A==;
X-IronPort-AV: E=Sophos;i="5.91,295,1647273600"; 
   d="scan'208";a="303279901"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 23:02:26 +0800
IronPort-SDR: D4dSp0uMDCOS8ZqlxgefMWURUIyJWCYEUnkNaBSMKK+6SjwipiQ43EXofZXuWt3sO0k1s/iI8+
 F4zzdjgsVVl+gF4SVFn+xNP4ipKQgRVMKvRIwIBXBhO4A7WCvPnmzfwWQ1lGTlENxAU8FKk6Hm
 V83ECPy79Y7fgsH/RzIqDwkDm82tdDe3shN33SVuNw3flK9nsBxAkq6eHsenmr5KBMvoyA9mV8
 5xLdeuRBIXx5tX5WCFy3V+xREZptrT8m8mq57navfZr8ObP0MsPUCAu2fPE4SeR9a5WE9lSXrm
 MVyup3ZBon6uiEzB5kR4wA3E
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 07:32:34 -0700
IronPort-SDR: Gqnl9Cm+C5fofjR8OJvZCjL6J/d+W6sVK1t0JIMoHIaPvG/vzNp8VwSLt7o/PxEkU/euwBipOI
 SzMK2erXY1OyR1sRhPCKDmj7G4EWlfniqTE0hQQBi46UqEcg1EjTHyyWkI1d4B+ukN3OUX65gs
 XQtnfATyI/L0mqHCvK+NinhC8q/+U5XNMtPxc4p2DjaHWoIMw8OjUoYVDW6dEwyR/YFwAnBTjv
 2Xns/xp3Aqf/CrcyHuTc0zv458x8cz8l1rfxmfrx1Pj/lCNAE72bgurTMm0i5POgq4n1DlOJOk
 77E=
WDCIronportException: Internal
Received: from fd6v5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Apr 2022 08:02:26 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/4] btrfs: zoned: zone finish unused block group
Date:   Fri, 29 Apr 2022 00:02:18 +0900
Message-Id: <1572dbb7eb23266429fe61dd3c764d70c116942c.1651157034.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651157034.git.naohiro.aota@wdc.com>
References: <cover.1651157034.git.naohiro.aota@wdc.com>
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

While the active zones within an active block group are reset, and their
active resource is released, the block group itself is kept in the active
block group list and marked as active. As a result, the list will contain
more than max_active_zones block groups. That itself is not fatal for the
device as the zones are properly reset.

However, that inflated list is, of course, strange. Also, a to-appear patch
series, which deactivates an active block group on demand, get confused
with the wrong list.

So, fix the issue by finishing the unused block group once it gets
read-only, so that we can release the active resource in an early stage.

Cc: stable@vger.kernel.org # 5.16+
Fixes: be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9739f3e8230a..ede389f2602d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1385,6 +1385,14 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			goto next;
 		}
 
+		ret = btrfs_zone_finish(block_group);
+		if (ret < 0) {
+			btrfs_dec_block_group_ro(block_group);
+			if (ret == -EAGAIN)
+				ret = 0;
+			goto next;
+		}
+
 		/*
 		 * Want to do this before we do anything else so we can recover
 		 * properly if we fail to join the transaction.
-- 
2.35.1

