Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DA691D37
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 11:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjBJKuR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 05:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjBJKuQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 05:50:16 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342E0125A0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 02:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676026216; x=1707562216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nakzJtx5iDUdEBJeanouh2zn57xiUgZla53hOR76Hhw=;
  b=OhAJEWUTM/y4IXICoLO6Fp0kpapQezyPVxfyYhQGTp8eFS7544ZsXOBi
   AsgBnOI5Db9W7Qr1EonnLmA7W70q2pDBVNxOUdA/kFyAFsKcOucBE9CWi
   kI8IHPd2tCuh6NK/uCKCjlqR336BcP0CV/2kFOmmdPOLTwvp0XKOWE3fo
   vL3bJvvF3EYf6n7UJNrMQ1LZtYuVVSSYyTQu73f3lY93wSpK/5jDAiBl2
   KtdWrOz5POtpjfXZ81Sg2SdzN5iZLbdl6RybPusEiG3xDd9Wp7EWz0c4c
   YWqNZKxrgIsD9IAGlZ7x/4QnnWdgHxsVv+JjLZsJjbzRIq6ovdc0zmaek
   w==;
X-IronPort-AV: E=Sophos;i="5.97,286,1669046400"; 
   d="scan'208";a="222793475"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2023 18:50:15 +0800
IronPort-SDR: yENQoXdncuZy6nNHtC2hK7CVZALmR9xT02rHo3DJyXaY5PdayyZzYIgyFt4QjIuD6WBzyl5L1W
 EEVt6hDrMeNyH6H/cSTM2h4e5y24mWl9tGlhtHOX+CLoOkV3Yqobx/16y+yFBYnA7mB8WToeO2
 SUqSOto0JQ+4uAbBj8zn/TlJY5QPjZSKn955VWiqZm6VKhGOdaksmIbsbJQa+L2TYfbYPSpTDr
 fCpDYJUae3MxDxpG/5XOVfC2AlwJqTD3l/+SVKTiWO5pzRwghKuMrUpRbBim2cfjEJQMHfRVGX
 3l4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2023 02:01:43 -0800
IronPort-SDR: b2gvt4T2Y3uo0QoFz2JNtFYHD+Q5deVy3H9HDHgHdp/wczLLz/iLgRcFEsobdaKcLfKklUJzpm
 wRVodxjVd+zzGAggPJd6q5/ab+J+nJS8hvTNr6fzLxH8+Y2q46wX4u8EAzTzDbU6yVx2cRcE1f
 S+7K2ixywdnVx24oQ+qrTMOf8YiWdkQNj1OXdAp3jZyhhpWqeUInuGGyd3twqB3ilzaY81Innv
 5GuASP7WU8OLLGUijcUaBFcUOUR6f+JO/tBZSJd4fzeAd5HV6j1xygV1gwhx5tBOho+LtC45l/
 LAA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Feb 2023 02:50:15 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] btrfs: remove btrfs_csum_ptr
Date:   Fri, 10 Feb 2023 02:50:08 -0800
Message-Id: <5a3df9c70dc6e6ec3f6ee6222090c4217e2ed368.1676026165.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
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

Remove btrfs_csum_ptr() and fold it into it's only caller.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 44e9acc77a74..d3e1f2712aa5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3367,13 +3367,6 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 	return 0;
 }
 
-static u8 *btrfs_csum_ptr(const struct btrfs_fs_info *fs_info, u8 *csums, u64 offset)
-{
-	u64 offset_in_sectors = offset >> fs_info->sectorsize_bits;
-
-	return csums + offset_in_sectors * fs_info->csum_size;
-}
-
 /*
  * Verify the checksum of a single data sector.
  *
@@ -3411,7 +3404,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 		return true;
 	}
 
-	csum_expected = btrfs_csum_ptr(fs_info, bbio->csum, bio_offset);
+	csum_expected = bbio->csum + (bio_offset >> fs_info->sectorsize_bits) *
+				fs_info->csum_size;
 	if (btrfs_check_sector_csum(fs_info, bv->bv_page, bv->bv_offset, csum,
 				    csum_expected))
 		goto zeroit;
-- 
2.39.0

