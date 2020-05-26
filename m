Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA541E23FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgEZOVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 10:21:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15674 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgEZOVi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 10:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590502897; x=1622038897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgfFMefm73C0QZ4iZxCnqz1lYnwe0blqEwAqg17Ncgs=;
  b=CKilb/udwJ0QnFsSZKgK8AtoLV2v8zTQS7Nz08uhr+7dRbKM3ZQIrjqW
   ice0ZHmJA2uqOjgY+dR+lWTf/tBJRq8GyuvnLgSW0U2wKR1h/ljcF9q9M
   PhGVu6jcGIfoRJxdOcrf9ZnkYKkV0ala7Pl1DsFNcnnrbCg0FlSCC1Mj+
   +U4ghx9xQMJHzDjs8ELT1EKzt7yIRKJ/metkuktnap0Fd86kQJwp12PbK
   L4xj3MB2sp5w0emxQuGgmEu3+0MoFfMO1UWH3e46l9XUJHh8shfkK21zz
   eC1aVvKSjCV322Z4Gy1ajHtrIPlhEK1KLIB50Rkt2hhlpFCNN2MJIJWGb
   g==;
IronPort-SDR: YRNkiMGFAf2CQ6SreB8vNp4XGhjRNd5ujufkhcIvhOc1j2bdLA4S6G99S5KJqo3It1McVzJnzJ
 l9nZoNY3PBaCdtA3UWi1/JDNwlNKEtPyDxx/T8/lHGQpsSobvclwKN9A228B3q6lABYjdsBlBY
 zepxQEVycg+Oqgp3NkzBkym4GaGKvara85n6wwyHlDiF+TQA4NBSTT6zn2wBmBmKZCcBE4i1DB
 osPvAmbLZ3jjMzUZg1SYIZHaSdjI2NPAwG3wGGlZJTIbeI5j5BpAfPo0sgsnJDSqJ+aAVyzwXv
 4gk=
X-IronPort-AV: E=Sophos;i="5.73,437,1583164800"; 
   d="scan'208";a="247571875"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2020 22:21:36 +0800
IronPort-SDR: UFf7u8tzEumBEyx4quJFrIpPJwyIEDJH4+TsWgQZSh0qKO06nOF454OIiCxYjVi3hgQ90gnhup
 5aO6nWBJqZl2H3DeS+W8W6GNWHoJWCHAM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 07:10:56 -0700
IronPort-SDR: 0qEVEg2lV85ehLL9FwydM43mYm1DNsVzgcsiN7oX4QuYnjvycMSodBb9HVkYtcHQZI9N3FC4AJ
 kRKpfRsmMeMg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 May 2020 07:21:36 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/3] btrfs: get mapping tree directly from fsinfo in find_first_block_group
Date:   Tue, 26 May 2020 23:21:23 +0900
Message-Id: <20200526142124.36202-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200526142124.36202-1-johannes.thumshirn@wdc.com>
References: <20200526142124.36202-1-johannes.thumshirn@wdc.com>
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

