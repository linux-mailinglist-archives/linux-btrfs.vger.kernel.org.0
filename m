Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34F479BC07
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355651AbjIKWBi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbjIKMwc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:32 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B122CEB;
        Mon, 11 Sep 2023 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436748; x=1725972748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bkhueVP2Qax3H8bEjdzjP/3E8mphYatEpGf7D9a4/uc=;
  b=bEZ9aFLzYwdPJ2xsLeDT0Lk845KyWJ4EpBmWUXQKrv9TzSElSeF/JvS/
   uklMHwYj990stUKCyVHB7BJ7/JK6BzLujpmH+uWlnXKT66eGLHkLelMZW
   bTdfn31sb3LBaCOtaIb6EDY+8pMVQuQmR88QBXT/eeXJhMdnb5siusc6m
   4+/j9zT5kwW+cZLDj1EP9Nq29i34U47UemOffj29TfIHrcdQdMF3whReL
   O533lTovxd5CdOAkofXOZg9+NrDtDbIGEI1bL3wvC4kVvbXRgmHp7qZa6
   hCWijGAC8FJW8Z8Bt5XvT8D0LnyEkDeFBjS0WJiwCuFvYqZrRwBdDVG4B
   A==;
X-CSE-ConnectionGUID: ucvXE4tiSTWol53WdYcnGw==
X-CSE-MsgGUID: 9NoX7HcrTLi1Z0G50Jzbig==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594382"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:28 +0800
IronPort-SDR: MYSeBuz2shmTAhjq6LNQahDDhuT65r+3j6mDlBvz6SzG8eW3fIHKA9oirItEBkKwRU+xn4Z+2u
 1Ok0Kg5jKzyuxrKGPtpB1Wu01wwgRcwZOeABWMzI1x5N1dfdmP4ZRc1t9i6cpGH4Vbtm18jZmy
 2oqhnfpGbfTSaJpUI+hnOedJQsGPUoGXFbHJKazuCOcHXJtGS9lL45mnNdQkL2DcZjPySnXcyG
 7KzQ+/rENFXnstLYMpmG7VNroeJk8vHHWX0ytIXXJQXXNx6YkNwkK+wjZ5FXpcPJs5zeE/IR9M
 cL4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 04:59:33 -0700
IronPort-SDR: dr4X3oAQHt8s1t3OmhKXv+ITJWlxRQVb5afF6PESNHGAXn/HBNgcTjdv7adyfJ13pYu6dXnSqk
 ESDRvxS2YfgtblvoDIvXnIt0vPdo+7mID55RTSzaoq/RubeSaMygtGLUwOciyqXzVdao/c2IC6
 FUx36UMZ2mGsv+7SIFl/34tmm7MhFlOE9A3AgEcaPoiyWWyVJroabUSlvAQoNwyR3NSE0SFaoG
 vcb/tQKq8d3fgF+2FLg9zyi9P3EYq1/2XmxAqyO5HTyh0S0BFp2j2kU7sMsOJnKlzUJzySHfgB
 TDA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:26 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v8 02/11] btrfs: read raid-stripe-tree from disk
Date:   Mon, 11 Sep 2023 05:52:03 -0700
Message-ID: <20230911-raid-stripe-tree-v8-2-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=4798; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=bkhueVP2Qax3H8bEjdzjP/3E8mphYatEpGf7D9a4/uc=; b=YbY7mFGA8DSC9Gu8QnDSxQHmb+4Xj2wDP+ZNRy46iGamnA4OL8/pjdaoQRv5LNny+VNJP3S/4 Z2bWaiPGY9xCwFncbfRyZwqDv/TL8AIAzBF0l3ddMQn368sZR6v5kDr
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we find a raid-stripe-tree on mount, read it from disk.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-rsv.c       |  6 ++++++
 fs/btrfs/disk-io.c         | 18 ++++++++++++++++++
 fs/btrfs/disk-io.h         |  5 +++++
 fs/btrfs/fs.h              |  1 +
 include/uapi/linux/btrfs.h |  1 +
 5 files changed, 31 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 77684c5e0c8b..4e55e5f30f7f 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -354,6 +354,11 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
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
@@ -405,6 +410,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	case BTRFS_EXTENT_TREE_OBJECTID:
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
 		root->block_rsv = &fs_info->delayed_refs_rsv;
 		break;
 	case BTRFS_ROOT_TREE_OBJECTID:
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4c5d71065ea8..1ecebcfc1c17 100644
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
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 02b645744a82..8b7f01a01c44 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -103,6 +103,11 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 	return NULL;
 }
 
+static inline struct btrfs_root *btrfs_stripe_tree_root(struct btrfs_fs_info *fs_info)
+{
+	return fs_info->stripe_root;
+}
+
 void btrfs_put_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
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

