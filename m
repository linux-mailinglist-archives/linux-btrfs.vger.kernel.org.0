Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18124E3B80
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 10:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiCVJNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 05:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiCVJNJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 05:13:09 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964A37E58E
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647940302; x=1679476302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+jZp1mel7Nc/JPEAlj08v7gIYU1Um1djZWu1JJgWLI8=;
  b=frq0sEWstHMMS5vKRWZ10WktAfhzHfXMq2vnah1Hu6RYCSQOficEDVJt
   rEDuVGVihGQzmvTeDhVAMiHL4ERRnyGjp6wOtOlOLmiyN2zrOC7CNA1q9
   oxuhste62kfETvf1CE3Oin6vG85uyqvNOkQoCAyiNfT0bA+DxkDJ2gWQB
   /DZsBoHyun4EOwUYcRdBnGPv9TfTjNjsyVrkCnaz0wHYDVKxPcyxkb+Uy
   la6lQ0PQ2m0djZ2+4pku6jJwgC8ipjUvMmHzGh0uPpRIBcM7vyfjZp6D5
   lwOCQN/1qjL9gm59jMC0jiNMJXwcnpz2o/fOPEhl0Iizn8FnHkYguI5gg
   w==;
X-IronPort-AV: E=Sophos;i="5.90,201,1643644800"; 
   d="scan'208";a="300094311"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 17:11:41 +0800
IronPort-SDR: TmlFWyNIbFSwTNTrPHKMj89nWbyPSUqJsguv/YmeM3gaA+uOygw75XTQng7RUPcy4io21qey0K
 dm84KZflnuiIhgaxe5zPzrzY/HMkhCi/ISfrnebTOeQygJjkCvB+lQd+ybfF0XHYy3Dh8LyN11
 q7dfl2xLTMHrIdeEfQKq4+4YNjIStGcp8YelD7OVlwBK59r7cSI8fVC7umgm861lIcxuaAqhfN
 0JZbar9uCBVWZjGN4sd1F2ks7FyYL8Gy/v8k8ELA2DCz5iGtJxh9sv9cupl4stcmP/aMall5QH
 ONcssonj+thElplJRc+KPBvw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:43:36 -0700
IronPort-SDR: j7UfB4cxroxMMolijvQAvf/Nrnp/Aa9hQQ0VCipUiiQz7/i50XDsXUuTIEPBamhlQB24XG3osj
 J2ZiHQWUuFQpw9/ubraRfFrKT6E1pp856Vsuwl2cK5iZdwN3hHb379CmSkVCEfvtTJqRDnwcLo
 B4mMq4iac0dhonjDsbA7Ru6URzI719Ky3PieYbEU1xUacVwFfEK4hkL+Xz31SHXqYwTSSIrc8x
 7noKGXuEixGHo44RSPLOwk7o7PJy8j+nSPupuFKXjB1hVWRdYoG8HSHW9sq2O1iNr05gr0EH97
 9fw=
WDCIronportException: Internal
Received: from cqpt8y2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.186])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Mar 2022 02:11:40 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/2] btrfs: return allocated block group from do_chunk_alloc()
Date:   Tue, 22 Mar 2022 18:11:33 +0900
Message-Id: <d25a0ad7ec38469473e5f522096aa96d04a17008.1647936783.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647936783.git.naohiro.aota@wdc.com>
References: <cover.1647936783.git.naohiro.aota@wdc.com>
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

Return the allocated block group from do_chunk_alloc(). This is a
preparation patch for the next patch.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 59f18a10fd5f..d4ac1c76f539 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3433,7 +3433,7 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
-static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
+static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
 {
 	struct btrfs_block_group *bg;
 	int ret;
@@ -3520,7 +3520,11 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
 out:
 	btrfs_trans_release_chunk_metadata(trans);
 
-	return ret;
+	if (ret)
+		return ERR_PTR(ret);
+
+	btrfs_get_block_group(bg);
+	return bg;
 }
 
 /*
@@ -3635,6 +3639,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_space_info *space_info;
+	struct btrfs_block_group *ret_bg;
 	bool wait_for_alloc = false;
 	bool should_alloc = false;
 	int ret = 0;
@@ -3728,9 +3733,14 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 			force_metadata_allocation(fs_info);
 	}
 
-	ret = do_chunk_alloc(trans, flags);
+	ret_bg = do_chunk_alloc(trans, flags);
 	trans->allocating_chunk = false;
 
+	if (IS_ERR(ret_bg))
+		ret = PTR_ERR(ret_bg);
+	else
+		btrfs_put_block_group(ret_bg);
+
 	spin_lock(&space_info->lock);
 	if (ret < 0) {
 		if (ret == -ENOSPC)
-- 
2.35.1

