Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6758756C4EA
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbiGHXTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiGHXTM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:12 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA9E41980;
        Fri,  8 Jul 2022 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322351; x=1688858351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s7rECdbtPS/xFD5a/QPIGcpKrU9rpkUQJ38wY6Yn8+0=;
  b=CaDqnLp7hpKdTPhL5rVhDMPml9spO3iAwYTDitkatYCGcsVHtwkVNpep
   I3HgEgOkQcpYHo3E+8dLvg7U4ByPNFku5muIUYIQbwtOdB63cQXMUNp+H
   UTwPRKt4PHqjwBUyhrk4pZ5uD7LiwZ8TyxLFv1SMxcwLHx43DZhkNNt/q
   B0qkYN6ylJn8g1u7s6QiwbQBnsQUxkYQ5mFv2o/QssRWHZWZpom2vDkcY
   ly4afnsBQohGkCalPptoI8aMG2GfVqfiItWNHOyvqV/AcD13bNWXv9s3h
   FbVZ0EbdvhfL9Khj/6ym/GX8ricc9I/IAHz9rXhMSb7TIJtyHXxou6OTs
   g==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871825"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:10 +0800
IronPort-SDR: igcWPKftA1EAk75FzxLtGq3kVYrzw0s2DtAOU8lqiKfH0sED0l8BTJsBpoGm0OuVBqeC1XxN3v
 ju6h1SU+BpO5khsA1WK4HQo9EDRFWCshLAqDDzQc2oyz/oS2zf7CXFYV3A8PddrbdtoXdYhLzZ
 kgwg/Bl9c6zYhHlRartvdTQj3UfdMkXbYksu1mS/oQQXVeFTwF5wRJOtO/ZYv9B2MmpqnqhpbQ
 rL7jK8ySrdcssmaFL0i+WhE0EOtF8G/Sm6R/A+v//cgRVEJHfFJA3K9OkiDvvltr/bcU9aQXW+
 RTCSpWxRdDDijTRFsWfw6ATG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:15 -0700
IronPort-SDR: l2LoFiW6bi8YiTjRqo/8wDg16TTVxQcKSy34EOyak8p/URdjvc4j2b7fr+/3VZC0WxNKRTsjgE
 lva5Z6l0QbKDDBcWncOftWdRVv9tiBRvsWm0NEkFeIKvA+Q/af0m5WFcAK3WlpnxvA0x4QIVYu
 dIMxkNNjro715TtzK3zuE//3GdtiBzisk9O7nJPbBG9Op7VF1/NH3MjoHi4gKw7iL0U7mugVeT
 mZGiQGB6pVBX+VUMUkQMrIJfF4qK7x+pCPrxv4jEFFo0YJOoGE0eIhmcPzr5yWxzdVKONeSWuf
 wzs=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/13] btrfs: use fs_info->max_extent_size in get_extent_max_capacity()
Date:   Sat,  9 Jul 2022 08:18:42 +0900
Message-Id: <fe4cbf4b2f44ae194e8dd371428529ee20d15fab.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
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

Use fs_info->max_extent_size also in get_extent_max_capacity() for the
completeness. This is only used for defrag and not really necessary to fix
the metadata reservation size. But, it still suppresses unnecessary defrag
operations.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ioctl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7e1b4b0fbd6c..37480d4e6443 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1230,16 +1230,18 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	return em;
 }
 
-static u32 get_extent_max_capacity(const struct extent_map *em)
+static u32 get_extent_max_capacity(struct btrfs_fs_info *fs_info,
+				   const struct extent_map *em)
 {
 	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
 		return BTRFS_MAX_COMPRESSED;
-	return BTRFS_MAX_EXTENT_SIZE;
+	return fs_info->max_extent_size;
 }
 
 static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 				     u32 extent_thresh, u64 newer_than, bool locked)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *next;
 	bool ret = false;
 
@@ -1263,7 +1265,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	 * If the next extent is at its max capacity, defragging current extent
 	 * makes no sense, as the total number of extents won't change.
 	 */
-	if (next->len >= get_extent_max_capacity(em))
+	if (next->len >= get_extent_max_capacity(fs_info, em))
 		goto out;
 	/* Skip older extent */
 	if (next->generation < newer_than)
@@ -1400,6 +1402,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 				  bool locked, struct list_head *target_list,
 				  u64 *last_scanned_ret)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	bool last_is_target = false;
 	u64 cur = start;
 	int ret = 0;
@@ -1484,7 +1487,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		 * Skip extents already at its max capacity, this is mostly for
 		 * compressed extents, which max cap is only 128K.
 		 */
-		if (em->len >= get_extent_max_capacity(em))
+		if (em->len >= get_extent_max_capacity(fs_info, em))
 			goto next;
 
 		/*
-- 
2.35.1

