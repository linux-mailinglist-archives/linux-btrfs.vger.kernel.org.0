Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C54564CDB
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiGDE7A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiGDE64 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:56 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5035662E7
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910734; x=1688446734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a9skFt42ZiIPVwzVrx254d/+4T4+JdXMMXYVtNvFxB8=;
  b=k/9oEzEZIHu13C6HlFN/z4D3OY90uYADbL9eHflaMEH+USQ8zn8iNMbL
   010xanHTXBBG+WslhBvLswFRcRDiHLiY49WbKqJVEhwOQWCN5b+mVE6eS
   o5jqDtWCZCMn5Td9tWU3bAOAxTdo6Nh7wooa87obP985Ro1/MUzPKTNBj
   RWAWn+hy+QRPBmVYb47ICm+hKKVOHxPrZWO5QePdPAvCEov5WucFxODRf
   mSxElYCsA3pUszK/L0GuxCZeBRf49ZfgJc3JUAbwupxnQR3RrqKA13NAw
   kJSnxryNDF4rRlUXF7bm1TwWVYJrUxsD7TvVex5pjFyhRJJyV34vX1Fw6
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732414"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:54 +0800
IronPort-SDR: ZmAWaU1ROv4TV50bk0I5AI4l4h4lrJgMSThhUzo6vR+mEhcPeSxHxXi5jCJagmZWPNS6ArlRyS
 7hk9vAuQ7JizdXu2bxqJJDsAas6MNLE9fiU1B/1M8asmSWZHfkwAlxepY4kVOvvb+ZVx0uDxKZ
 4s3OM/ZQnPXHJLKG4bpwkjH+fBaBMOdoU58nZ5YWI+dB9tOSjxTokKeqT5Fhof1aK8+VTRF/5l
 LC41YmdfX/h7tk6VaWZ5aC3f1vrcBTw2D8MQ/yTcD1BbZcm25Lquky92JXopBc5EXX8Vg5k5G8
 du3wdgcFJSV+7reKZRGVaD6m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:47 -0700
IronPort-SDR: s81DjSIuHLRhRM0aPErxmH9+++xn1tnaV+1CGA7u8P/xzbSJvWlz/b0TPSpNtmy9nYm/13VwuI
 rz3OYGHEWzl+A/l/MZ1cjUwUKNTesN2epDTQRmnyEvi09/5n3h09umPKXbTWjlrsKZKLsu0OYM
 MwIgSIUXXBBy3e0Pkxm8Su637qR2Hgk3KGP4OJLQrxQlYp0LDuyxdq+ZWZti/sedjAOmsTTPhC
 86jRyU/8Zpy8MzmE3UbmChL4ZNkAd+58TUDJa+ZYnuU0skrKf3mY/YnegJVnq8g3RYPF+opRRQ
 UbM=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:55 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 11/13] btrfs: zoned: activate necessary block group
Date:   Mon,  4 Jul 2022 13:58:15 +0900
Message-Id: <bbdd836915d620e57416174ece589c6c33da4511.1656909695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
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

There are two places where allocating a chunk is not enough. These two
places are trying to ensure the space by allocating a chunk. To meet the
condition for active_total_bytes, we also need to activate a block group
there.

CC: stable@vger.kernel.org # 5.16+
Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 51e7c1f1d93f..1c22cfe91a65 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2664,6 +2664,11 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
+	/*
+	 * We have allocated a new chunk. We also need to activate that chunk to
+	 * grant metadata tickets for zoned btrfs.
+	 */
+	btrfs_zoned_activate_one_bg(fs_info, cache->space_info, true);
 	ret = inc_block_group_ro(cache, 0);
 	if (ret == -ETXTBSY)
 		goto unlock_out;
@@ -3889,6 +3894,12 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 		if (IS_ERR(bg)) {
 			ret = PTR_ERR(bg);
 		} else {
+			/*
+			 * We have a new chunk. We also need to activate it for
+			 * zoned btrfs.
+			 */
+			btrfs_zoned_activate_one_bg(fs_info, info, true);
+
 			/*
 			 * If we fail to add the chunk item here, we end up
 			 * trying again at phase 2 of chunk allocation, at
-- 
2.35.1

