Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E47528711
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244358AbiEPOb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244499AbiEPObw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:31:52 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A712AF8
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652711510; x=1684247510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ml4kXQTQWKd1I/2t4c1y5qyeT8AIR/c/+43rAipGW3A=;
  b=DrTsRr3yOSyYRD5VHT8YwdgWNNm3tNu45bVgRiuOpa/S8eX7R7ZnEPi/
   YxpcdFLsYtA1/w45yDFWzA5r4yjKBDIlhuRCcNqGucBsFvXdPaQZAyjTL
   BhEJWwqiPGy3TbI2LhzUN9X9HF7zQfQ8XEkUYoaa3gzd7mqhT6CKRfOAP
   YTWKZEpjzn+uDi5+4lllXWurtgsUIM9anyLVNb07aFjlBPGqSndAmhhJg
   zlLijX5DS4oqVYDfBuHK4yOkbmywEvwCFFLeyIn0JCT7BamvW6ckqWr/A
   uVEkdWRJO2NqueDzi5sCax9DJpVt66dBvanDkyrMnBEfwE0lP7sQKuX3X
   g==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205309212"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:31:48 +0800
IronPort-SDR: jzSfuTLw/TNWGN0n7YP2qqUUXk7alaxjgPDqkN9XBQfNqwp3MOMDYs4ygOAc64dSa2jYh9Q2xy
 I7WwQGW73XuzEiIf/ZsTTG92Nwt/ZfvtDpDxEEde2ZgBfSsdD4kWbKJg8rO1NkMOFuMATi0Fnf
 1u/IXJXpo/TZ2P0Ku/KCx4FdH/Ia5pezxBEKR8DuECMb7kO7EgCZTyC/28cu6wesf47l16lJrD
 XvOEljrVOJAOetngPdhskgrqVlkrYDSM1jSlZKxM3blu9/ymLOM8BwIhdvNg1zR4oEvaZ/UyFR
 xyO7CegeALOGgoP/qotZPXi6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:57:30 -0700
IronPort-SDR: gfDM21BsmFqueSCLY8vmNnSq41HmsviZLfYh5MGzpo947kbg7fkl2HV7+el3eXsa9i/BZdG6CF
 rIRHWPrf7m9OwUnm2LOBwHWASOhuNCxeiO9w9fzTpktvuemdTgu/zShWzLUZi286rEx+guFZQf
 gA1Y0ysly3Lv+Q7jUaJXs5PacnEkSpo9XZ8i4jxEEvtJr3R+ssYVsZOmn88a/9oYNBnP6wkoNr
 dhyDp8DUirAt7ASa3PkpO7Rf2lyoDF6ix/tCrWf7REmTLFQeUYjU8se01u0jHk7yEh5fl8sFQ9
 9M0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 May 2022 07:31:48 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Date:   Mon, 16 May 2022 07:31:38 -0700
Message-Id: <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652711187.git.johannes.thumshirn@wdc.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
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

If we're discovering a raid-stripe-tree on mount, read it from disk.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h           |  1 +
 fs/btrfs/disk-io.c         | 12 ++++++++++++
 include/uapi/linux/btrfs.h |  1 +
 3 files changed, 14 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 20aa2ebac7cd..1db669662f61 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -667,6 +667,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *data_reloc_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d456f426924c..c0f08917465a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1706,6 +1706,9 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 
 		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);
 	}
+	if (objectid == BTRFS_RAID_STRIPE_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->stripe_root) ?
+			fs_info->stripe_root : ERR_PTR(-ENOENT);
 	return NULL;
 }
 
@@ -1784,6 +1787,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_put_root(fs_info->block_group_root);
+	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -2337,6 +2341,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->fs_root);
 	free_root_extent_buffers(info->data_reloc_root);
 	free_root_extent_buffers(info->block_group_root);
+	free_root_extent_buffers(info->stripe_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2773,6 +2778,13 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
index d956b2993970..4e0429fc4e87 100644
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
2.35.1

