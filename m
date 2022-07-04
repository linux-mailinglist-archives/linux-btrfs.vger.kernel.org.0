Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3100B564CE2
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiGDE67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiGDE6y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:54 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007335FAA
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910733; x=1688446733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EwDmWFc5fh5vTWPE6ypaTUYaucgB5pHnSi/gvodbfSs=;
  b=otLk3ZlTSsE1ifoTulv8utpqZzQUI5qXd93G22U6TwdvY7J4GKhI+Xuq
   CmlfZWRDAW0ix9m79LPq+Ediywrmyhy1OFfUySmyzrr0QZgLi4lX7L5eQ
   gX48Xfc4cNH8HnKSvNAVR+pYOSa1lEoN8ROImS32fsdOUrK785yaUNI2D
   +5l9ngiWdwBll1Eb5T22Yhq4u9G4EhMUvH0xq2GUeZMDZDNCHHmnlF+9j
   qyRUWYbZy0Bg9tg+KE/+mqa0KubcXURwLoj3QkuYTOA/KQC2eQOI2UtVI
   nWgcT4d5k2OgFPsMe6e5JKPEQ8ThWFlQQEX9tzdauBZLgITmbdeAp1/IX
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732412"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:53 +0800
IronPort-SDR: G6jXy+mdj8OhArLiJuMVRTyo5ukqdR3eMI/xkIphVuyRo07K5gJPU8LwZqV7HcMAKl8GaYISKW
 TasAoc8rRDi98ZQVQSCJBPQtaYsOMFub2wXkn0cIrJArBTt8IjcV1wxV11vM669aNLt+4h2pAD
 9fRRlNJdb9Uwco8yWNMwwu4moEztMNYjhb/QXIg79W3GrndkYdX2MqbY3hpDasSU03whioobpm
 dtPlVTI5mrLwtUXDemSbkQu/xdR+alObRClqnhP35XiMlbNOFhoV/D/PW+Ni6/yXv0ESEVr04u
 8nLvC8lc/mWjFqcuXjm2Tznv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:46 -0700
IronPort-SDR: eymQ4IV0M8SXNYztIs5SnsfarfddlmhJgHeidh7j6KpeI9FNDOSOdQHPpl9gVEr2yShn12CMsm
 aEZLK9GeEQSXEzqcM0y7Q0UY1K9WR0nwIc7iW04iBzn45LtQsKB9d2hK/RaUV694snCeVWHqa0
 nWbaDvslUuqEgKiWmeKEkQU84QzKu9xfDbuA+iHwoIh/3r+zynBB+2pkTBpicUFjhKJHrYb8L4
 9aQbKVMRENajpn4HsHYNGjEiWvXpXf7mZr/LgRd4eCRwicHdhqvCO3wXcMnWXrUxHyoPIBBiU5
 YM0=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:53 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 09/13] btrfs: zoned: disable metadata overcommit for zoned
Date:   Mon,  4 Jul 2022 13:58:13 +0900
Message-Id: <3d7e559990ec7abe5cc5433b1916f62b5c44e818.1656909695.git.naohiro.aota@wdc.com>
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

The metadata overcommit makes the space reservation flexible but it is also
harmful to active zone tracking. Since we cannot finish a block group from
the metadata allocation context, we might not activate a new block group
and might not be able to actually write out the overcommit reservations.

So, disable metadata overcommit for zoned btrfs. We will ensure the
reservations are under active_total_bytes in the following patches.

CC: stable@vger.kernel.org # 5.16+
Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c7a60341b2d2..4ce9dfbabd97 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -399,7 +399,10 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
-	avail = calc_available_free_space(fs_info, space_info, flush);
+	if (btrfs_is_zoned(fs_info) && (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
+		avail = 0;
+	else
+		avail = calc_available_free_space(fs_info, space_info, flush);
 
 	if (used + bytes < writable_total_bytes(fs_info, space_info) + avail)
 		return 1;
-- 
2.35.1

