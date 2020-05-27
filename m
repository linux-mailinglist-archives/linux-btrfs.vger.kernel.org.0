Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8981E3B5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbgE0IMl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 04:12:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15288 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbgE0IMd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 04:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590567153; x=1622103153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6MmVwvch6llO++wAjN1UzSvTgf+D9QAPaoHZXyV9F7U=;
  b=JodKIjdht1kGzjekaQa2iSppnQCgwkBgTKIwhfOHpIOtlbji5NVHjykD
   NYpeZpC4BKeezRqO2Y+t9xlrytfxmG2WOZxyszGIbJpKH1XH8sYc6LI/L
   jdB3w5AxTlyqdBXpAanhwTe3IjU09l4hgclf+deioYSlCB41PhPQZUL1l
   yRaJVO9AZSABr0p/nYZzacnHDw8LnWgMlVYEClBg1lUBMP2tpNxg8ABXq
   v2cVXgyjWBGwcTmyc8H3W6IMoaPYsVuR7XNNlvKFFbJ+UM2cqdeNE0hTD
   8x0G8pSNa1DYDDf7Mv5cau+iVmL5C1Uc5Hmw6+ZDEbResAWmYE/q8rioG
   g==;
IronPort-SDR: +z0bTf1f41xY9QdWBj39yOWARwC1O3iLopi69TE+G04st/TSJc6IUuEPCRzUy9HtAyIvaru5Pr
 7ugq+6mNyWbccNi3ojHgQVNwWP5vcJnb+z6M3mVzlNT9kwAhHDKarxj3V/NHbou+xxnqKrXlD3
 m7JeLuGAwwktnY44zXSXdXxSaETaXQjpUL+Wh3Q051VoTjpC9okFFA2Yo8bOu90/xLYyoO5PV3
 AI1L28jrE6mb4k42bwSbK2oUgYSMdALCrESxu1eMNuTS8tk6GxB/tcHGHA3/2z/DBE9YN+u9KP
 dBI=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; 
   d="scan'208";a="247648700"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 16:12:32 +0800
IronPort-SDR: gKbTJ19VziSJzeb8kDxhlXagLKTu2eObbnfxIq60VhA7TwzXw2FdK6hSjOXmRpIbkjcepo+1Nv
 BpQUim+s9jj17n8BhKNIbIKjtxYJUPmIs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 01:02:23 -0700
IronPort-SDR: doIUcgwtmXSOBCHiTuUxQ9eHH0W+hEHUmF0xtWHNKFZjVLnF+6oZ1aqLJIClBkPAN0DTORrZSA
 lK5RsjuNWgpQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 May 2020 01:12:32 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/3] btrfs: get mapping tree directly from fsinfo in find_first_block_group
Date:   Wed, 27 May 2020 17:12:26 +0900
Message-Id: <20200527081227.3408-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
References: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
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
index c5acd89c864c..c4462e4c8413 100644
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
2.24.1

