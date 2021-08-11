Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1804B3E938C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhHKOVb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31791 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhHKOVX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691659; x=1660227659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tmr0/LZH6L0mF134k+SLQgfcNiGUcTiEeyyHTL/B2p8=;
  b=p9grAhtJKoQPVNvyZ4g0DphIwJY9k4ZfvHFg/esjIMZ5q6As5xl5HkDD
   VmTJD+Q/NvHfOLCV25TO7fXRM8LL8WJ+9pxGrZ1VMhd+7zAekN/WJdhdA
   VdiaSM1di7Al9Su2Sw55t81Z2GDoPC5Ln2WhAm4p7IuoEdBRSBK9uPDCW
   ggY8xfR931WDVdPWpskZUDrfIEnV1PtT8esFhAFOdra9n/HnqpRsdgifO
   NC1DytJNANWwPyuwqjRjWxUCebdxJpvDjbPvYnX5aPIGKkKZRAbfrSpst
   +bmC0JBcVht/jvzMCcdIS7KesOUD9LgLWK7gCntH91p3Z/ULHUjyygK+C
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="280761380"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:58 +0800
IronPort-SDR: VUuJQDKykB/zeSwWpXcgjoqfVBdhXoN1dXHJ3Xcbxwp7Og65oy9VLYqio6HVgHgjFtBwF3fdNo
 iXwnGH2Atql0AqOMTfyY3QiNe98/YnKU86CAYrrnESoKAuu3tsscE4E4k1CLh83zcy41x8reQQ
 +FkrX80EmVbEbKHPkw8up8YHu6mExn3fcgoriZFret6d8hJZOHZovEMwBK7jBvHy+KKWXJO2C+
 ePIWTEcdcXWzgHpG5RGkb37dAY2lyLG9Tah0tjymbsh/M1NvxzshVrGrUwCqfbh/GSv6wT0E46
 eeBSptHQUtYhAi3338XrOC1i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:29 -0700
IronPort-SDR: iy2L/Ni+TTyDZNJtxs66JaeIN85xVinjEcKIjXQG9HUz5QAqPkykgOBvAiVTE4jpqLga0wJqw2
 EgxEaT1Dmjbu801VBVkjqh2Q03zJKtskuphRBrQJD9bAcNC5LOXaMc7lAI+1pKc5j7Ae924ZDX
 Nzv8vMAb7zTMjQo3SiueUSVgzNF8slXcyiZGCqwq36M2qEmjE4eDmnt1Hw1hDfn9MQ8PAONyNm
 FU88o2p2PVmQIew5y7vS3EXXd8sMB0e8gjT+iMjN5R1E5A/VQQjRxlCSQ7v8zvHXHDOPSfJCAG
 M5U=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:58 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 12/17] btrfs: zoned: activate block group on allocation
Date:   Wed, 11 Aug 2021 23:16:36 +0900
Message-Id: <f9d746d2e29bc5ba87a22587cde8f6d3f2a9874d.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Activate a block group when trying to allocate an extent from it. We check
read-only case and no space left case before trying to activate a block
group not to consume the number of active zones uselessly.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8dafb61c4946..ac367f1dc4e6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3773,6 +3773,18 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (skip)
 		return 1;
 
+	/* Check RO and no space case before trying to activate it */
+	spin_lock(&block_group->lock);
+	if (block_group->ro ||
+	    block_group->alloc_offset == block_group->zone_capacity) {
+		spin_unlock(&block_group->lock);
+		return 1;
+	}
+	spin_unlock(&block_group->lock);
+
+	if (!btrfs_zone_activate(block_group))
+		return 1;
+
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	spin_lock(&fs_info->treelog_bg_lock);
-- 
2.32.0

