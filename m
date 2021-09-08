Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9B8403D7B
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348794AbhIHQUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:20:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348619AbhIHQUx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 12:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631117985; x=1662653985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rLJDhZcRbDxZ4ZZ3Nhb5Je0U7xsXUI1Qhde/gjgbnI=;
  b=LyHBwQPSIsRs09pGq7NVOHpLqupR4hDOf293LN/lc4ad+ECb9551j4zi
   y77/w7GLJunM7X+bft0loRGtH+Wuoedp5tEgbGGNGzxU1YhY6HJp9jJ23
   S3a26865BIpwT4YYNftXpSInF9RGwckCMi61oiRE5KbrjDffotPtEXJVa
   tGOOb2eXGAIqQwfud7lru4xi1U4/ldesasABq6WQCIxJCfU8lpZeiMAMH
   jud+zipfjadkxDOMluN1TeyuHv7G7BGnNx8iMIxnQqobEdQrSMZsh/3ay
   HSySGOCgoEx4m/KjIniCrWsHFRk7y1N0LXsyUnXUlwH7dK2GSXPJyVMho
   g==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="179493940"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 00:19:45 +0800
IronPort-SDR: aEcSvgr6gN2g8lVDnseW+SriyASKJHu/hA//JMrGQp5enO1aQTk0b7oZ4GD4GBPWCLp4YxH98u
 HHsy+xZXeWGQuxFZo7Il0x63zx5UVyGgfb+wEaD0wCP7laKA15pwNkaNy/YQVXQn1Hk3R78SBF
 qfpy4/s9vmCcoBeZxipq9zTjCigXaYdPa49XDp2jAVZYt4ZkOxHkRstBm3fV4QWLKudLWCqFdZ
 3urumj6cb3ZRVj79wialxoeCCwv4JObRfic/8Xv28AXigl1phk9gIIfiACJ59wf02OaMxPgIdN
 DdlcqP9BR0T50ewQpI4EAvf8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 08:54:42 -0700
IronPort-SDR: +tBr+1TqKv3KbcTSUXVFVYV5zhfOTGBPQrVOtaXeW96dNpRB1krzncc18O+qcVC3SzvrbXuPsf
 G8qex+pY6dIW9t0EGwN33yGn2953fuXWwgp1qpkBdjVvy3k6AUUhYhoajspM3UqImf9rVu1UMv
 BAHL0RUKf0H7eBFtBKvxkBlONCtGK5LdayYZC7OeuuVIfV03joRJ4lhBfuYXJBhN3b9aBn6/sQ
 qpguwzi6kfHY9i+ezxeu0uSzoFAlCBAO2gPKcy7RvIILgek+y8tR0oewh68SRPQMZ21O3Vk1bV
 ZGc=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Sep 2021 09:19:46 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/8] btrfs: zoned: only allow one process to add pages to a relocation inode
Date:   Thu,  9 Sep 2021 01:19:27 +0900
Message-Id: <15fdddfffd14f3338f621ebd3210993ae7a55081.1631117101.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1631117101.git.johannes.thumshirn@wdc.com>
References: <cover.1631117101.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Don't allow more than one process to add pages to a relocation inode on a
zoned filesystem, otherwise we cannot guarantee the sequential write rule
once we're filling preallocated extents on a zoned filesystem.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8959ac580f46..96ade32cad9b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5132,6 +5132,9 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc)
 {
+	struct inode *inode = mapping->host;
+	const bool data_reloc = btrfs_is_data_reloc_root(BTRFS_I(inode)->root);
+	const bool zoned = btrfs_is_zoned(BTRFS_I(inode)->root->fs_info);
 	int ret = 0;
 	struct extent_page_data epd = {
 		.bio_ctrl = { 0 },
@@ -5139,7 +5142,11 @@ int extent_writepages(struct address_space *mapping,
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
 
+	if (data_reloc && zoned)
+		btrfs_inode_lock(inode, 0);
 	ret = extent_write_cache_pages(mapping, wbc, &epd);
+	if (data_reloc && zoned)
+		btrfs_inode_unlock(inode, 0);
 	ASSERT(ret <= 0);
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
-- 
2.32.0

