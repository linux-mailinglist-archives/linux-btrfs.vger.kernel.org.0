Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65A3F191E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbhHSM1r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:27:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46871 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhHSM1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376030; x=1660912030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=La+dvmN1ehrQvyoiJaDHLq9VrKqIQQ51COnMnaS7eWA=;
  b=qty4BEl1p7v115qoR1UYC3lLfjDz2eZoT6WgTEsjaONkPybeeXVewXKb
   65IYJiJNx9oRk4Fe+lARfX98/PDowX1Zy6QEiTlgK9tpOjjYN9z5aK849
   3u1AXcUGOX5noQ/Lyr2IQFJi2mBmUfsfXTsNmTfeJIB6u89AGL4AAxEKX
   w2/QG6gPi2HvsZ9uHwySMxbwWfPyeau57GwGqYkNyyEg6pNMOHkzOlD4m
   W8r+TcqFCBVX7VoSBriiIqgEExcSfaRASKWwfKi3M6hZRyA8OS/Bs7g/0
   rLQQBLBlxYxvMY0ZvbppCARpPD1wbytxdNQIeGV86/BuAHS985JArK80d
   w==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773528"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:09 +0800
IronPort-SDR: oB9Od+J705u7Ip31V9ja3Qd2BIZ1hUJVjj4pb0RELzvJfWv9tvJaUwH3zXCTq9F0e42C0ASSrs
 Tlgr13zvLdRiyTR+VLEdDl0iMKgFEZQ1jXgA/Py4QazaEb+2/koyVIWuH0hNgchpoPEeoPhMAx
 ZIq0gd0A9boMYokmV+syugw9/CzeEzTokQ1JiHEP6YaI6jRNU1MsSgqRnFdVUy7GAVbaMwzzkL
 YDkGDuVyvItM1jAapdpAbx2dTsBe+zc6gkMSYVMwsDPPRzSgKA2m8ZecHVf/eoDSc3kZsGeV8W
 aZtlH8ZsacQsqpnXrJ9dXyXE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:17 -0700
IronPort-SDR: YPA+yBjz5C7O8Nbyd03R6sD4O5eNyL93s7xO1PJVoiMy68BPskZZ0ZAe0esDD7F9KZ13DoOMM/
 3e4MYAjuZ7HqMUBmqozNzPf0xZhs7dPYrotuI8He61/8ciY8AEA52fQI0IMK1tg75XL8xCcAsx
 /HdOyJKvqAYG5VLCpjvBMzZ3ItEHi4umYDc7+d32GgvTIyu7Z3Dex9/bewF/og5KGLUmdQ7IrP
 /4XT1qU1GUr708MUtZLvZrI5tZinrlvREWouw9m573i6cC9CozFsMII8eFRnHf/Y28sfru5NTb
 QRw=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 02/17] btrfs: zoned: move btrfs_free_excluded_extents out from btrfs_calc_zone_unusable
Date:   Thu, 19 Aug 2021 21:19:09 +0900
Message-Id: <d75c1d36b98cd9ea877cff90492a632d1eec8ca8.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_free_excluded_extents() is not nccessary for
btrfs_calc_zone_unusable() and it makes btrfs_calc_zone_unusable()
difficult to reuse. Move it out and call btrfs_free_excluded_extents() in
the proper context.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 5 +++++
 fs/btrfs/zoned.c       | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9e833d74e8dc..db368518d42c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2037,6 +2037,11 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	 */
 	if (btrfs_is_zoned(info)) {
 		btrfs_calc_zone_unusable(cache);
+		/*
+		 * Should not have any excluded extents. Just in case,
+		 * though
+		 */
+		btrfs_free_excluded_extents(cache);
 	} else if (cache->length == cache->used) {
 		cache->last_byte_to_unpin = (u64)-1;
 		cache->cached = BTRFS_CACHE_FINISHED;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 32f444c7ec76..579fb03ba937 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1273,9 +1273,6 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 	cache->cached = BTRFS_CACHE_FINISHED;
 	cache->free_space_ctl->free_space = free;
 	cache->zone_unusable = unusable;
-
-	/* Should not have any excluded extents. Just in case, though */
-	btrfs_free_excluded_extents(cache);
 }
 
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
-- 
2.33.0

