Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0FC26E36B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 20:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIQSWo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 14:22:44 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51367 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726544AbgIQSV2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 14:21:28 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 14:21:20 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1AA7994A;
        Thu, 17 Sep 2020 14:14:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 17 Sep 2020 14:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=IpEfRybLa8wi7
        /AMXW1zdFQPhFNVcCq7L3X+9DWs09s=; b=MprqB2RQVkXt53c6GjjNP6wXPg5w6
        KBfBej9DP6Dwl/+zqGKYWRNI3vrbkK/lF+DYbeehhT89HvKphjCXuVFUb5nhnYRy
        86TxjC8BTRDWIY/QnPOGTfqoBraSDYOi7d6Q523q0sQuuHDdyyRNa6SMsrro0LlY
        IgRCSVBsnxx4uXDnAAxO+h/iihd5CGp+ArsysgKUu0JSQDnd5xtwUU3cqC+AeZKT
        cmEhNpuwNwNgNW4eu9OLgNCN/AdtjbU/Kg8mkh+A8Zre0lWivB1Dc7D0EDKourcY
        9/ZiTEsgFuOsfwg46ach0XrBWYZfcagazmmK7hNHsJGbdnIUGrrMkQ+Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=IpEfRybLa8wi7/AMXW1zdFQPhFNVcCq7L3X+9DWs09s=; b=bXZYJYsm
        1ZBveSUSEUuN/uIdFAI86IyrFGaHqhZ4n/8Ie+yZzzzmYDWZF9yXJJl0i4DskpVt
        L9gTw7S1gyFq7BjFU2K2XQaHw2kp7YnsR+9Zy5O7w8qcdHY2dFsbFvXfqtRBTmNK
        0DBVuAVQUXg1Q2czAbq6AC8v2D6q6TZQJnwTeXIJbj9/R/Bvl4fC9GC2nFX0yPBT
        pT1uGIlsLfygI/8hz5Zr3QS09ZAbab+BWw66bcHHvcHqv5eTzQyCnqfXvBleDBWi
        Aw8RCxVk6pxcQQ5sHpfaqML07O9bc3V248wqtd7fvFWwEmzzfYBQ3av6pKNfJ7Lb
        Yyb/nv5Qx+jRYQ==
X-ME-Sender: <xms:aqdjX3WGqFDeNF8LDO8xycJrVkmBC0pZLBuKti8NN_AO_do7jV0B_g>
    <xme:aqdjX_l5YHJSCEt4j6YFC-LHmQKeZsDOeXTbHOi79R84q1BoBcLRJmQLTxiahcHvb
    HWWSV1I7H8t0mpEuq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeetheehudfgleelhfehffettedtfeelvdfghfelke
    efgefgvdevgefffedvtdefgeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:aqdjXzb9lbeTXR4UZC471LLw1i4LPdI25a8JRz-phGJkon4UKYg53A>
    <xmx:aqdjXyXABnOlFfMGsCJE5nQamraPM7vuwbg--P-3SQ49usBh7pmxFA>
    <xmx:aqdjXxnS4H5v6jySbXHNt9yfHuQRynJlzA8ggpXrltVE28exuHFugQ>
    <xmx:aqdjXwtLtR2R4Ta3_llKd-4yGuHCsGSTVmXM6uF_985wki_BUxzWDg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 00A123280064;
        Thu, 17 Sep 2020 14:14:02 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v3 1/4] btrfs: support remount of ro fs with free space tree
Date:   Thu, 17 Sep 2020 11:13:38 -0700
Message-Id: <1d0cca6ce1f67484c6b7ef591e264c04ca740c96.1600282812.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1600282812.git.boris@bur.io>
References: <cover.1600282812.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a user attempts to remount a btrfs filesystem with
'mount -o remount,space_cache=v2', that operation silently succeeds.
Unfortunately, this is misleading, because the remount does not create
the free space tree. /proc/mounts will incorrectly show space_cache=v2,
but on the next mount, the file system will revert to the old
space_cache.

For now, we handle only the easier case, where the existing mount is
read-only and the new mount is read-write. In that case, we can create
the free space tree without contending with the block groups changing
as we go. If the remount is ro->ro, rw->ro, or rw->rw, we will not
create the free space tree, and print a warning to dmesg so that this
failure is more visible.

References: https://github.com/btrfs/btrfs-todo/issues/5
Signed-off-by: Boris Burkov <boris@bur.io>
---
v3:
- change failure to warning in dmesg for consistency
v2:
- move creation down to ro->rw case
- error on all other remount cases
- add a comment to help future remount modifiers

 fs/btrfs/super.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3ebe7240c63d..8dfd6089e31d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -47,6 +47,7 @@
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 #include "discard.h"
+#include "free-space-tree.h"
 
 #include "qgroup.h"
 #define CREATE_TRACE_POINTS
@@ -1838,6 +1839,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	u64 old_max_inline = fs_info->max_inline;
 	u32 old_thread_pool_size = fs_info->thread_pool_size;
 	u32 old_metadata_ratio = fs_info->metadata_ratio;
+	bool create_fst = false;
 	int ret;
 
 	sync_filesystem(sb);
@@ -1862,6 +1864,16 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
 
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+		create_fst = true;
+		if (!sb_rdonly(sb) || *flags & SB_RDONLY) {
+			btrfs_warn(fs_info,
+				   "Remounting with free space tree only supported from read-only to read-write");
+			create_fst = false;
+		}
+	}
+
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out;
 
@@ -1924,6 +1936,21 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			goto restore;
 		}
 
+		/*
+		 * NOTE: when remounting with a change that does writes, don't
+		 * put it anywhere above this point, as we are not sure to be
+		 * safe to write until we pass the above checks.
+		 */
+		if (create_fst) {
+			ret = btrfs_create_free_space_tree(fs_info);
+			if (ret) {
+				btrfs_warn(fs_info,
+					   "failed to create free space tree: %d", ret);
+				goto restore;
+			}
+		}
+
+
 		ret = btrfs_cleanup_fs_roots(fs_info);
 		if (ret)
 			goto restore;
-- 
2.24.1

