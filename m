Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A0B1552D0
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 08:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBGHU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 02:20:59 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46765 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgBGHU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 02:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581060063; x=1612596063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oiDv9PAJ2QH5JABjSYa2OdujPSxbLqUMdcBADB4QEFo=;
  b=Sm00ZzvCJ03IUMQQrFlvAaHwfx2f+k9qlkO8BuwKYjaZyxUQch4MRaA9
   orW0mj2CmgITeww9kIA9rwOL5Cd02b2alGTvbqCEgLX4YnuVVmbxXpwJZ
   KKZqhZjOG8dGqQN2E6sKuxcbfRPCLjf06Bsm4n2b0xFjBzuRZF/85EpdV
   9OUivWhZGkxFbsZM0OfQIQqrrIibdu5PGhOSNSitAobkcDHLHjwk47NYE
   iC9CvzU07wlR32NzPxzkqaWYHWb/11PcmgkoqBkYSY591Crrixrr7UQ8q
   qvFoxbCfa5fxufXcQjxKR5ZSoPV4eXERxUb3y993H0lmtd5ea4PHQWVjU
   g==;
IronPort-SDR: K1dY5XhdxJ0zEg8Q0wEKTrH2sKM8ULfm80VTBlHvwnQjzqAOcKM7Yk+AR5T/tBCj5oXHvxgK38
 ylEQfUuDFfo6Uq5YYD/yluMKh4YjhqzMmnk071gpeE4xUSbiVTNzfp29z6hBP34a0zINB5ze7L
 6+N9/tSmZsMSUe4S9vcX/qfpqk4F5qmvVfY1pyyxrfiytIYsUxsmLuyIujESQiHxKOHdM841Ff
 3ZJwErIqHNZoEGiKGwF6dT7dEsnr/xWVX3pN+iybSUZGWhEHie0Gu1T3WsoHe+zf2rq/82oRcz
 Pjw=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="231092225"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 15:20:17 +0800
IronPort-SDR: ypEBdkOX1JWaQJoU+EsWOo2A7Y1jdLBAmZ3dFU7v4IcKzAHOwW9yD/5gEPy841p144Z9NQNEsl
 ME76rkrE2gi3YjY8Z/dSBe7yXinRqLUoyqkhaEDjw6qLb+5yYmvPyQJNqXIYSdNIlxFLdpKs/d
 +wJ7nANR+40mibfkdVnl+NJvSbS+N0BYgQ65fScE1Vvu1r7J3TYrrdAsaWtzoPqY1ARSczf9hH
 KsTFKMfqHgNKXTYawOWsq9Ds3+MmV/m2koHB9RQyc68S+9+9wGBCeYNvV/hAJwPyhQv+g5Gsu/
 XhhRvvYRssG0dnPNOgSFseqA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 23:13:10 -0800
IronPort-SDR: ok8WqDlnTz5jFZRJaIzbysNjy1iPJ2ux8xFrI+NIDgAbvMEE4PDF1FxigCHwaCVzrLB0r/nEHd
 fDh4atwbIfZ1VoYwwVU2JmNpDp1aR91fXUoewjY61ETyniGVU9HIGYof5+uSExkgDMZmYFYPT7
 rH7iBkMEIQC7DOm2E+Ubl+RLjNnbOZpY+BVZrUkY22VaQN8azQQEY6adyIBSAnJFFFwik1T84j
 DXnTXIp7+YvsV/Ex2Cvl/cAU7j0G/fl4J3QfMu41wGw1QT6nfE24dYztnWPguW2mKLscQqsOf5
 RsM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2020 23:20:12 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 1/7] btrfs: Export btrfs_release_disk_super
Date:   Fri,  7 Feb 2020 16:19:59 +0900
Message-Id: <20200207072005.22867-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207072005.22867-1-johannes.thumshirn@wdc.com>
References: <20200207072005.22867-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

Preparatory patch for removal of buffer_head usage in btrfs.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/volumes.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0b3167bd9f35..c312de1a55a6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1247,7 +1247,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	return ret;
 }
 
-static void btrfs_release_disk_super(struct page *page)
+void btrfs_release_disk_super(struct page *page)
 {
 	kunmap(page);
 	put_page(page);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 690d4f5a0653..b7f2edbc6581 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -483,6 +483,7 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
 struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 				       u64 logical, u64 length);
+void btrfs_release_disk_super(struct page *page);
 
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
 				      int index)
-- 
2.24.1

