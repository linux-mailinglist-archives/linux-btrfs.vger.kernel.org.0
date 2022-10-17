Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FBF600E47
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiJQLzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJQLzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEAA580A4
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007741; x=1697543741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Du6tCc6fBTLlhGjBKl1Mr6W7UOAlDi7W0ad9SYMPw+4=;
  b=PUKpbEpJB3toF0VFOjQjM7JQ1RvSGXKwOF6f63+gl8YWgQbJXLgS1sfd
   L80YkKO5Ek6iHBBzrgree07W1DOGTABkT/TUjVJ4wr0k1NtDL1rAJpKNq
   A1Y/3JSn4tbuYCc5D9c4LpvpfbUtRUzLxD1mZQPOVyd5GrUX0bFpaVbli
   Jn9mGI4USZB2KECIm8bTrAVLwd6ipmGrFj+Xs5SSB4oza32JzjFBXRFd9
   Q0nIZ1j8q4GFhu5leUD7IE9Yobl0LQWintq+8plseNQp+4PusN0LdcLGY
   q0TJFqMbTwHDgZB2srcsJD2j1evAXRt3tY+kpOSeeLYWXbN+vPA+NnyZ9
   A==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337166"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:40 +0800
IronPort-SDR: O9SRt+saAqLgDHShaOas6x+pMikj3ItfX+censO9tUP8h8zgESeB2OjxIwsnMxzKTc2RUAaxlm
 ivQAJl9WoUIPJ4DzXlhRHAdPWe0gPe6l4P/ksnDUnSgUHRRK+DMMsKD1zSEjRv6AO0UOg4cLsS
 dJdgLviSYwwsl/iJblkgCVhMKFHLMSMvT67hHzG9pP9avI04rteb8mWNkUrMOwST5u+MpzHWCu
 VEXTNZejUfw8oSpYkltZesQk92JeiVuiBL4/9tI9q7mu0xbP+kZrWlVGIrAfbomeNeYnrAlLoV
 qLwiEhCoko3twnc0NLvrZPeO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:13 -0700
IronPort-SDR: asY75MFp5SRWiOJSL2Bm5MPfAXqwLntg82JigtqibesEhQJb90DnoWNM6FHF/7cyF33npn9CjW
 DzQs86slCGUHKSaU6IqlvLjJpLMr4AZrHrBEXhdjV5MrhgWZDxg3CYDUdZZe2tVjgl8EYqHVlH
 RiR+IXQUu3dTrpExlx1FUIkR/FoXiFmrOyroIrjX5Ur4Kw9PFC7XbIvQlkp5Mx22NRbMHOHOR0
 Xm7VbNxYlDcq7++vDAfVznsJax6Cki46g5LjaRodoqjEhdPjGvHOGMbQbAHom2Pebke464zFfD
 iKA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:40 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 08/11] btrfs: allow zoned RAID0 and 10
Date:   Mon, 17 Oct 2022 04:55:26 -0700
Message-Id: <0c8a339cfd8d364b0d5c817637ba85ee0302503a.1666007330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666007330.git.johannes.thumshirn@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.h | 7 ++++++-
 fs/btrfs/zoned.c            | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 083e754f5239..d1885b428cd4 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -41,13 +41,18 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 	if (!fs_info->stripe_root)
 		return false;
 
-	// for now
 	if (type != BTRFS_BLOCK_GROUP_DATA)
 		return false;
 
 	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
 		return true;
 
+	if (profile & BTRFS_BLOCK_GROUP_RAID0)
+		return true;
+
+	if (profile & BTRFS_BLOCK_GROUP_RAID10)
+		return true;
+
 	return false;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f4ce39169468..3325e7761ef7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1488,6 +1488,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID1C3:
 	case BTRFS_BLOCK_GROUP_RAID1C4:
+	case BTRFS_BLOCK_GROUP_RAID0:
+	case BTRFS_BLOCK_GROUP_RAID10:
 		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
 		    !fs_info->stripe_root) {
 			btrfs_err(fs_info,
@@ -1525,8 +1527,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		}
 		cache->alloc_offset = alloc_offsets[0];
 		break;
-	case BTRFS_BLOCK_GROUP_RAID0:
-	case BTRFS_BLOCK_GROUP_RAID10:
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
 		/* non-single profiles are not supported yet */
-- 
2.37.3

