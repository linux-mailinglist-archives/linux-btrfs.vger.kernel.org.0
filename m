Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A851EB916
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgFBKGU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 06:06:20 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65297 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgFBKGT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 06:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591092378; x=1622628378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ek/aYutujYSTB63skhSjVpG2rGoDax5o6D4SSqxGcZg=;
  b=l6uj3ZS+WPUxF5ROynKAY0WLjPMLF+Ur7vOsuiH3pCmpfRpnAUKcfwQc
   vjgS19SMYGmBSqEaZDYNMRxj08hd6xSnzuF01RedX4qlmUoJQ+TNbE7v8
   tjwGbA84vJr3Vl0K+wDkxjNNZ1VN2n5vn4VUIbeqmt82WbhM1oAOhmpQv
   Bb6MHZKv/DKMz+dNkYJw1m6d0ntRWPfv/d5tweKk9z2NnDsk96sA0tZCJ
   UUgZ9xRFDr0le2tB3OoOBSZOH1ooGN4C8Yb7CjYPko1Ys7D7apwj0xolx
   41jO22WmZoK/9xNz8lGAk+bZwGrqjnErfJ6noZCRUErpeIQTJEZclJUCn
   Q==;
IronPort-SDR: a0MtIyh6ys8W25DbltVCfCIUzkTopLB6FVVbkB5AmynNKptK59g8IUNUfNQDDrVAmrQgTrxvmV
 VpMkK4CF7jSI644afb1dMISpXJS3UNKOxAysYOeqwfuj6rWZXS1f2asVi7mAifuoGU7KE3QYSN
 wVewOTeMDdy8/pkPlVfqoNgJLxYlF6401IZEv3YW1DmGSxe2GPwgEvCR9q8AXrzGMOLVvkQeFd
 ypM/DAK9GwJArGhPbzo91gKhWVKQHXw7Uk0DvEcPQ+Uz9etmm8JVb4YpyYt0UayDb9VgdfUtNw
 PhM=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="248104354"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 18:06:03 +0800
IronPort-SDR: rK6zvjaBaxxGuSZIxMh2V3JGC+VfK0nQQ1GSEaT8Rw2xe2a74gVrn9B2JHdLB/yegrwwA1hPom
 6KvjJ7qEfEwHvWDJ5BD9K/VFjBasHFIok=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:55:10 -0700
IronPort-SDR: qTPD+BTPKhF5mnEexZw8L6Q8jb0vyBG9f1sUzrUKA+wg3VpDaZIUUKyHQO1pix0su+nWMw0RnQ
 8mmiPN1aPWgw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Jun 2020 03:06:03 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/2] btrfs: get mapping tree directly from fsinfo in find_first_block_group
Date:   Tue,  2 Jun 2020 19:05:56 +0900
Message-Id: <20200602100557.6938-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602100557.6938-1-johannes.thumshirn@wdc.com>
References: <20200602100557.6938-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We already have an fs_info in our function parameters, there's no need to
do the maths again and get fs_info from the extent_root just to get the
mapping_tree.

Instead directly grab the mapping_tree from fs_info.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 176e8a292fd1..e5641b6a3097 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1556,7 +1556,7 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 			struct extent_map_tree *em_tree;
 			struct extent_map *em;
 
-			em_tree = &root->fs_info->mapping_tree;
+			em_tree = &fs_info->mapping_tree;
 			read_lock(&em_tree->lock);
 			em = lookup_extent_mapping(em_tree, found_key.objectid,
 						   found_key.offset);
-- 
2.26.2

