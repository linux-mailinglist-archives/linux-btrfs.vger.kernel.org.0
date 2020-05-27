Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6686D1E3B5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgE0IMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 04:12:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15289 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387775AbgE0IMd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 04:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590567153; x=1622103153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RtXp2JkcAgZd33XjOKlvLt4nU9bdMxQXaBrp5ggLE9E=;
  b=lVzKKT2sqNU5jlykiMTq0k3BI/bK5F6pVhHNJ8u25XWCrfitYI7trAf6
   e1zxNGj7r3jLHm0SLBSOJRVJQ9K0i5EUsWB1iZiJENN8HDoEqn7o8HakR
   exUQQ67q27jx5OPB96ouR7b6bje4k2SkKkRBqyIaA0m9UNMnYMBMXEuTh
   8pEFPFlB0TtVKp9rTiR+8t3Q9auDRAs+XAy87OU16OUvHoZairh5Qubh+
   KRvTswhz0qrzgSm/LpBRxpn2XjV6zvHve3MkhErZMWM1WL9e2sIPdDv/n
   i5EGg1MwKdmCe+4Q8h7xF2im4Ye7Zx3MS4FcWWggm6zX4Ij8D7iEaDkuB
   w==;
IronPort-SDR: XQ7n+p5JUdxK+OkPqDTV0cN1gwfkwbyO1QRXZO03G5HYiAqnvEdwUrMkItfIQxOmpMKc5W0aj0
 wAGrR9T9HY9qXaNjjlsjSokgJvm9Pyw1vAPmX7O20IvJMkFeSevVG3GsQqwMQG0rWnHb54LF1a
 8EY7UfqBbv1Ogaf+vSOwi1ucqJZ1d2rN3R9iukvE6ryoITmg8K4zMS8H563F6KVQgDX0/xrVKe
 K2IGSDfVyNNlD3hENXEJuDvgfIzGl4JECuEP4+GaWMAw9JhAA/zPl/FDfREuy8kcU+tEMZB2v3
 h7E=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; 
   d="scan'208";a="247648699"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 16:12:31 +0800
IronPort-SDR: p6uge7cMGTrRix/ZZdXmdIKDdadL0CyaOTYc+gqUFhnEICPwTI9UF52vWI8nsQBZecUE/lMBsG
 RdRyc44O0sAjJP3I+H6bczpHIOfBjk6OA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 01:02:22 -0700
IronPort-SDR: 3pewpqWvWrc8AgA2uduCGgg+BnmPbltUgN74SOKWNNaLYAw3dwIbeYfPO2lE16SgA5J16kSf6U
 UfY/Z5X0WesQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 May 2020 01:12:31 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/3] btrfs: remove pointless out label in find_first_block_group
Date:   Wed, 27 May 2020 17:12:25 +0900
Message-Id: <20200527081227.3408-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
References: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The 'out' label in find_first_block_group() does not do anything in terms
of cleanup.

It is better to directly return 'ret' instead of jumping to out to not
confuse readers. Additionally there is no need to initialize ret with 0.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 176e8a292fd1..c5acd89c864c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1527,7 +1527,7 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 				  struct btrfs_key *key)
 {
 	struct btrfs_root *root = fs_info->extent_root;
-	int ret = 0;
+	int ret;
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
 	struct btrfs_block_group_item bg;
@@ -1536,7 +1536,7 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	while (1) {
 		slot = path->slots[0];
@@ -1546,7 +1546,7 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 			if (ret == 0)
 				continue;
 			if (ret < 0)
-				goto out;
+				return ret;
 			break;
 		}
 		btrfs_item_key_to_cpu(leaf, &found_key, slot);
@@ -1594,11 +1594,11 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 				}
 			}
 			free_extent_map(em);
-			goto out;
+			return ret;
 		}
 		path->slots[0]++;
 	}
-out:
+
 	return ret;
 }
 
-- 
2.24.1

