Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EB652B5EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiERJRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 05:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiERJRW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 05:17:22 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3208F1A060
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652865441; x=1684401441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b3kGikADO8HuoOwaiLohILbi67iOF1BbMB4LojY3yqk=;
  b=M/NMxYnuH2b0b5IbyTvhVIXd6SdTwBRoQ6xFAw5GPC4rZRR9R2Mdq/7x
   USnanAD7DBwqqDPY8OEOUKfr4/sIeOX9k6qC650xGg60lZQfdHVHTWfg5
   n09gWDeQsnbC02a9XDbuMaYNb5dBNMUqYaCI1GO11J600aIeBJTns8SBr
   saSjrX893s2ARrICKFN5bqelfyazYl0ARgzC1TiD7aBti0oZNPEdSjod1
   N5ljvl+5GICtOBmUkASzgEeoJG2R5xXJVoIovrYs5lm8DrJFr+FH9ZC9p
   cJWWOTim6jtpUpR8S3ZJ4IqE2ITcbQ/3yqQt4qcakqf14fiEpugTX+seI
   g==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647273600"; 
   d="scan'208";a="201514744"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2022 17:17:20 +0800
IronPort-SDR: oJGNuz8wYreIvJEGvwSk17kcud9N0R9zj43/qrxcvQQgIFUHqoohWzWgz0C1MeEPsSvM9wHq1y
 f+YlrgeeZj/sIFqszqOAGaYX5TksJkFEjJHgIXNCQd2ag+TVjcbdMZTyKY/i/zX+xPo2S45q35
 TvNpQC8/qpOLIm5huybqCSky0dtkxJzp6IHbO18N1b7y0hnbI8ZxAaeIk73kK9cneV5BYyEUM4
 HOAViXXTqZf39KSmPEdHZT1wvwINAeAVdH3PkrasBta+kjFrcYNkBTuDOZqllBxIYHuN/tvoEQ
 HkMLZy3kudLv/bNAweGGbWhk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 01:40:23 -0700
IronPort-SDR: B7cYCIi9WZ0DcD3SEwGsAbuSQASARnhQtLO8lQbgsmJn6S2joIXc/OwYJsQSgDmePX2usHQzDM
 UHrRhLPapiYAYH/7SLJvrz2yjfX0bKq/Xx5jVDb4o19DlFm7kwzo3oJOBJcTA3odT8Lo/OGZNP
 3XSysLNWxbUR7xEuC9CPpS65UsKf42bOBRDHBBbaS+fYaiU/ubEyPzMHKIN5CdYBVim8LKpu4V
 0PckNYHcgA6gTpC3zmh6qRC0GP37AFnNXEgYT6Fdap4rVxS97Lpjhj5/3GbloeUd5nZouenm9x
 xpE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2022 02:17:19 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 2/6] btrfs-progs: read fs with stripe tree from disk
Date:   Wed, 18 May 2022 02:17:12 -0700
Message-Id: <20220518091716.786452-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
References: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/disk-io.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index d70130ac121e..7109d434a2f4 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -881,6 +881,10 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 		return fs_info->block_group_root ? fs_info->block_group_root :
 						ERR_PTR(-ENOENT);
 
+	if (location->objectid == BTRFS_RAID_STRIPE_TREE_OBJECTID)
+		return fs_info->stripe_root ? fs_info->stripe_root :
+			ERR_PTR(-ENOENT);
+
 	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID);
 
 	node = rb_search(&fs_info->fs_root_tree, (void *)&objectid,
@@ -913,6 +917,9 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	if (fs_info->quota_root)
 		free(fs_info->quota_root);
 
+	if (fs_info->stripe_root)
+		free(fs_info->stripe_root);
+
 	free_global_roots_tree(&fs_info->global_roots_tree);
 	free(fs_info->tree_root);
 	free(fs_info->chunk_root);
@@ -937,12 +944,14 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->dev_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->stripe_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->block_group_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
 
 	if (!fs_info->tree_root || !fs_info->chunk_root || !fs_info->dev_root ||
 	    !fs_info->quota_root || !fs_info->uuid_root ||
-	    !fs_info->block_group_root || !fs_info->super_copy)
+	    !fs_info->block_group_root || !fs_info->super_copy ||
+	    !fs_info->stripe_root)
 		goto free_all;
 
 	extent_io_tree_init(&fs_info->extent_cache);
@@ -1364,6 +1373,15 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 			return -EIO;
 	}
 
+	ret = find_and_setup_root(root, fs_info, BTRFS_RAID_STRIPE_TREE_OBJECTID,
+				  fs_info->stripe_root);
+	if (ret) {
+		free(fs_info->stripe_root);
+		fs_info->stripe_root = NULL;
+	} else {
+		fs_info->stripe_root->track_dirty = 1;
+	}
+
 	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2) &&
 	    maybe_load_block_groups(fs_info, flags)) {
 		ret = btrfs_read_block_groups(fs_info);
@@ -1422,6 +1440,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 		free_extent_buffer(fs_info->chunk_root->node);
 	if (fs_info->uuid_root)
 		free_extent_buffer(fs_info->uuid_root->node);
+	if (fs_info->stripe_root)
+		free_extent_buffer(fs_info->stripe_root->node);
 }
 
 static void free_map_lookup(struct cache_extent *ce)
-- 
2.35.3

