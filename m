Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F53E560362
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiF2Ol1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiF2OlZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 10:41:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA43AA54
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656513683; x=1688049683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ia25dKYcIFBFcqSMdu6uFLjvDsqOwLPJ9BKxl66x2rE=;
  b=DIAUaVslKpZJ9OwbRoMpyUMsfIfKAoy3zizvChYubDLiffVhSZkCJl9h
   916x5bJqH7690Obhio8S6qG1pnRNXgG4roxUyETchRWCQV5uOx1SAvgRx
   VZq7hTZWspSR89/c9c+0Rfyda8MWY1CQLmKL0Ym2Ljx6T0EMfTlY4lOmS
   Y7XHe9e7kf7uRWu3Xd+jkyFR7pPFOOTsQgV901qcqZBUiPc5Xva5zBfp1
   hjLMX8s1Izk2yvE5jGyhbJx0ei9UcdQqQq3mm/131Gq2p003dohWLug4l
   6Zak325oUN93+mfYLkaoMkTsNPBk3I5imTQw+zBQDIj2K4qu2diWrpHJC
   w==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="203064885"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 22:41:23 +0800
IronPort-SDR: NYAdobrUp+Hg2DC5d07DU69TvHGS7nwtTvBACMnxw2ihCNXJjyhAOSGhDD8EQDQfccPTdnd9vf
 j9INC38KyRWDUF6sc1jyRmfw9PVW2SvVi0E5taPJ5bRmfSSKlRSb3tLrSSGiK+m/SM1Kj0SOdo
 R5X1neqMnKg0QjiWQz1EoOC8ZqoUbASWLXZ+fCajuk1upoG89HilOu9wW5LUTwYZFmfVAe6h1h
 fvSaPB6rg699h9XCDRKzBSgI8DRfFaCsgPZ3HJfNLpB66iqiHqCqoMG4EviR5eKtuTOR/BJFfi
 Ybq+J4I7yxqmh49pFnzBzKaG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 06:59:02 -0700
IronPort-SDR: gtDHrYIN20j4rt2r6v2P9AIUm5lgytUWHhXk365FgBjKFfXMQnK+I0fICH6SsY72/8sRT1SSqc
 0NNhy6Dfsx6XUwIuC0R5bYntVJXqHhbK0kRw0YcUWsSQhwZBMTSwJK1sFXF+V+ork6L5k0JslI
 a04zWoo+qhxZVsHQG6cVXiQ/ZgXgxHKwqoHrEbYc8kM4opk5BY0B9nR9eOPzf0orzDB87568sn
 H6kMOsK2riAzarxBH5ZJw+EpvsuP6phC4Q5boAX0w/8Okb8uULzeC3qUIwBgKDUes4dArAZCjb
 5oQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2022 07:41:22 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 2/8] btrfs: read raid-stripe-tree from disk
Date:   Wed, 29 Jun 2022 07:41:08 -0700
Message-Id: <cace476a83e3f9eecb63c3e9f95c496840dc0d3e.1656513330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656513330.git.johannes.thumshirn@wdc.com>
References: <cover.1656513330.git.johannes.thumshirn@wdc.com>
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

If we find a raid-stripe-tree on mount, read it from disk.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-rsv.c       |  1 +
 fs/btrfs/ctree.h           |  1 +
 fs/btrfs/disk-io.c         | 12 ++++++++++++
 include/uapi/linux/btrfs.h |  1 +
 4 files changed, 15 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index b3ee49b0b1e8..62c20c9d8c25 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -427,6 +427,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	case BTRFS_CSUM_TREE_OBJECTID:
 	case BTRFS_EXTENT_TREE_OBJECTID:
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
+	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
 		root->block_rsv = &fs_info->delayed_refs_rsv;
 		break;
 	case BTRFS_ROOT_TREE_OBJECTID:
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 18e2f186cb5e..376b9b112429 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -690,6 +690,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *data_reloc_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 70b388de4d66..45d1ea23a230 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1607,6 +1607,9 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 
 		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);
 	}
+	if (objectid == BTRFS_RAID_STRIPE_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->stripe_root) ?
+			fs_info->stripe_root : ERR_PTR(-ENOENT);
 	return NULL;
 }
 
@@ -1679,6 +1682,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_put_root(fs_info->block_group_root);
+	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -2220,6 +2224,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->fs_root);
 	free_root_extent_buffers(info->data_reloc_root);
 	free_root_extent_buffers(info->block_group_root);
+	free_root_extent_buffers(info->stripe_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2646,6 +2651,13 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		fs_info->uuid_root = root;
 	}
 
+	location.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
+	root = btrfs_read_tree_root(tree_root, &location);
+	if (!IS_ERR(root)) {
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->stripe_root = root;
+	}
+
 	return 0;
 out:
 	btrfs_warn(fs_info, "failed to read root (objectid=%llu): %d",
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index f54dc91e4025..5ca789af5beb 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -310,6 +310,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_STRIPE_TREE	(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.35.3

