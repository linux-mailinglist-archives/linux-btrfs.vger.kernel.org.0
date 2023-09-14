Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D57A0A57
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbjINQHQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbjINQHK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9D2103;
        Thu, 14 Sep 2023 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707626; x=1726243626;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=P0037+7VztgRtReqF7DKCInw0cIljZg5YluFFhKagsE=;
  b=UpkuOuQwHt7+Yp/67834g5I37mtkpBAXy8w1ZKvlrHUwsCqi8Wu4HP2C
   FrIJrJvvFeVJQjz8tUKyNcF/l1f3QzfJ6ICxz45YE+zDad2MvarflBYeV
   eO1Z+EvbMuTvF6wQH0BuqR6XxoQtlWL+hm1e1LJEdKUQf2u7L9zjzXLXs
   sc0DPYgS7cLNBkuN8m7AYT5EqL/CjDiT85LIE1fvrzMzvgO0bqH6laDSs
   t1fwLlUSsOriQNogo7HKUZvr0MdJ4pjgzAifFg8BSCr+lPonNrhGUBNA4
   przCx7VAlNULpke566Wvsh2nRPEHyBGAWrxab295UvRcJad648uvWt60G
   A==;
X-CSE-ConnectionGUID: DN8DTrugSyeAiHUycKttLA==
X-CSE-MsgGUID: On6SvCYvQlKQ3XG4hfkbdw==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490531"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:05 +0800
IronPort-SDR: BIHPiiDaHGgUA33UBJVNBEoERiH6ha8+ndwPX7LY906jcBcGieyUvEaqJRVFKawCMoSeMxith8
 UfqCiYnqEwIQpo6/syIymtSweP5MhlgNYb+6kqA5RdjNLBcM9E+yyG88/BAP8Zu3pUe7pOsbPK
 B6J1+ruEZRlMsNureIAtIJBq/n9rFpEZXaV5qc8UT+9iGXj/c1zNzHUmi76zYKE1sfqhmcet+K
 YJw/Fy4fGmWIE3jm635Izjc2MXQJCHi9usOmwJu4wK0rcNbELborXguYrTXhFKl7QlMCDCffmQ
 4xM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:07 -0700
IronPort-SDR: ZzxviuFIUU1rJcLWzc+De6L1N1jn09FSEstz7Zr5tx3N5/iKc6vBwGul9jrHNpUjt51L1b/nbr
 zKt7InzVyoExvqefpqeLfMsPkdRxpRvG3PEeREMdU/AFLdo7MCPDCdgBbLiiqpBDisNWs85XF4
 qVVzi8MYnAwwy3SuhC8xkQUq2pCEAJGH1+490RiAzuAHO5/pp3lNgKTdD1LGZO6isNB+WKdd5Z
 oG/zUp3vi3Y7TEN0LtpdCz6eAAUIKMSgiNZ2k1pzTM4GYfET6FIYJdWXJZOyQPBJEYt09gmYzc
 UPU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:05 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:06:57 -0700
Subject: [PATCH v9 02/11] btrfs: read raid-stripe-tree from disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v9-2-15d423829637@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=4080;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=P0037+7VztgRtReqF7DKCInw0cIljZg5YluFFhKagsE=;
 b=17pb+HbVzgmZYVQ3kaCrrsx6cvMdRdxbn0TPQ5TOwUvv94+n/Nxf5I3USW0x9C0vFnc5ciXye
 Qebxnp7RcHVBcLZ7l0QmO5cPqyGdj7yyS2e2LYsZqxIn+XIQBcJ/9wg
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we find a raid-stripe-tree on mount, read it from disk.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-rsv.c       |  6 ++++++
 fs/btrfs/disk-io.c         | 18 ++++++++++++++++++
 fs/btrfs/fs.h              |  1 +
 include/uapi/linux/btrfs.h |  1 +
 4 files changed, 26 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 6a8f9629bbbd..ceb5f586a2d5 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -356,6 +356,11 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 		min_items++;
 	}
 
+	if (btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE)) {
+		num_bytes += btrfs_root_used(&fs_info->stripe_root->root_item);
+		min_items++;
+	}
+
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
 	 * global reserve for an unlink, which is an additional
@@ -407,6 +412,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	case BTRFS_EXTENT_TREE_OBJECTID:
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
 		root->block_rsv = &fs_info->delayed_refs_rsv;
 		break;
 	case BTRFS_ROOT_TREE_OBJECTID:
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 163f37ad1b27..dc577b3c53f6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1179,6 +1179,8 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 		return btrfs_grab_root(fs_info->block_group_root);
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
+	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
+		return btrfs_grab_root(fs_info->stripe_root);
 	default:
 		return NULL;
 	}
@@ -1259,6 +1261,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_put_root(fs_info->block_group_root);
+	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -1804,6 +1807,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->fs_root);
 	free_root_extent_buffers(info->data_reloc_root);
 	free_root_extent_buffers(info->block_group_root);
+	free_root_extent_buffers(info->stripe_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2280,6 +2284,20 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		fs_info->uuid_root = root;
 	}
 
+	if (btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE)) {
+		location.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
+		root = btrfs_read_tree_root(tree_root, &location);
+		if (IS_ERR(root)) {
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
+				ret = PTR_ERR(root);
+				goto out;
+			}
+		} else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+			fs_info->stripe_root = root;
+		}
+	}
+
 	return 0;
 out:
 	btrfs_warn(fs_info, "failed to read root (objectid=%llu): %d",
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index d84a390336fc..5c7778e8b5ed 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -367,6 +367,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *data_reloc_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	/* The log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dbb8b96da50d..b9a1d9af8ae8 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -333,6 +333,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;

-- 
2.41.0

