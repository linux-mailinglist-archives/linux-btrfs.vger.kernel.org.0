Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F54D1E23FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgEZOVh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 10:21:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15674 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEZOVg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 10:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590502896; x=1622038896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kgnjXng8/JrK5MZmUJI2s7IuSHBEfvk8UizKsNXmmiY=;
  b=mBZYlAentxSdwAhECJh07kqnHGB7nkb0TiFj10+ABE8ysT9dETRYaph/
   Vb4NcjdZA8hlgOXV5lgXHR/Ruc9DdbLhpSYzqnwQ6RdkE9O+3n5GRIAxU
   eeHzOjC7p7+tmtudvwvL2ibOs5C3NkjiflBp1eohAl20/qyA4XjMOlsCL
   VVqoKjPGLIIgEPhAWiTb4ueyJAAp2ditlC25WFAaC5fnG381Wo3sMK5pY
   F/OVn6nhZr4etGbLyUpypeOHqvDJ7O1tpVQgaEr584OMwPYPUsDt/XOhm
   kYSX+Bm8IgLYZNjiHkRmM2Hc1JlOTpDmzWSCfThBnajeRgGiqx7OGmbN1
   Q==;
IronPort-SDR: SSS39h+kvigY8RuGt3/wjtYzI8dVGSD8NezBielrUpc9V8viAUMwt5WPKEYEmkYvb1Is4TVKg9
 scxOWRJjgcIc01Up8hJmJnkx/x3ZKiII0l6K8vfmM3QX0VfaRqcFbBIvvJzqPlGZMqrJusuGzF
 1y+d/vXVr91tfzGuJk9MkW9x09vUbWOXeZtUBgO5fFs0qxA5ys6KpU3bTa0Fd9Z0cSkPGmk7GH
 o4LbkjTFSjPQdDki/7ogn9n5uzjnQ72l1pfs7Km79vphCgDgHa+x5LYrwqcbvLEj2T2tdF3dah
 6P4=
X-IronPort-AV: E=Sophos;i="5.73,437,1583164800"; 
   d="scan'208";a="247571874"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2020 22:21:35 +0800
IronPort-SDR: 63iXCvcRsMTEgGil4ZtIzp1sbVvcWGcL1Znkq6n3sXKktk9K4zvaMw/4vqNjEIXr52RteDZTbO
 gIQwjpBG1b4qLOMezE8jf9xBjL6qNyBzI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 07:10:55 -0700
IronPort-SDR: lwEuOx2+3jQGL4lYI24tlnaXwA+8zbaHMaADQLi/JrZp0jFCr5dM0Wrr8kVcz+ZFFCIsEkBtS9
 w9+fvx3nb1rw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 May 2020 07:21:35 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/3] btrfs: remove pointless out label in find_first_block_group
Date:   Tue, 26 May 2020 23:21:22 +0900
Message-Id: <20200526142124.36202-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200526142124.36202-1-johannes.thumshirn@wdc.com>
References: <20200526142124.36202-1-johannes.thumshirn@wdc.com>
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

