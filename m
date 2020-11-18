Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7612B881D
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgKRXGn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:43 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56973 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbgKRXGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:43 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 0DC60CB5;
        Wed, 18 Nov 2020 18:06:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=22bWksDngmEiwuMGGZH21wlh00
        t8TNXXR/BVrt/ldJc=; b=UzhqsQGx7JioGgFag2/rsaLPwKCZ1V/yas1pUOWb6H
        u4bF1x+n/Wt4vaHTF1Z4ExhfuxSQoiE+1skRuedwLRbwPMvygUwCA0EdTpZ3p28X
        k3wFlbHXy2M40WZJdpYEgI2wim/xx9Olp4X9mdttALW7Aw04V+R6Uw3R9XIJHwIm
        Vxf48Zzw5b0UeLCjHoVGphjL1OTokx1S01KFQw8rfiGSICAWLvGl8mIw5vHCPeQg
        k9VIsJBjqAeLQ05ulTvfW6mF+G7E9zquO4e/O9x0hb9JfUqiJe6O4l2KpkII/8/O
        9J6n4+gnGEpH1Qf2C2y8dJV9pSWi7ca5xdlGqju0/Zpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=22bWksDngmEiwuMGGZH21wlh00t8TNXXR/BVrt/ldJc=; b=gLxCX4XE
        1k518+azOHmqJdhdhhd7UC2bOomLtqZ8VIPlz7CU20uC4tLk8u+w5lGlHznhsXDc
        ktSS5qmmYSXtMZ+lybxcyzlBkrFHLClZAmZQIzEYltkAx+UzfqBtzbO0EvHdOE11
        Fy0l0hLstPWnwtso3ScOZFh+t84+enuqJ3tKE92rnFFm8YCMYWsWCLfMPUQ5yiDC
        pUtp6IhsjVRBbcKDFVUUSc2SppjhNWLT1o4cGQ6QF9cgbIUIwphe1/SrdE4NnoIE
        eToa5I0BZkQoRKiENKwy5cfYbWs8I4M72y2VHd39F4q7geecqTZ+VD+1KPGKwoDs
        Tfn6cqHHyNrb0A==
X-ME-Sender: <xms:E6m1XwcSwiYyBur6utP0gDRfZcwVHYn4NeDwTGT_P7bdlEXsoY2T2A>
    <xme:E6m1XyMTPtUDOk816ffdyR3GUShPsDDxFThgLO-dfOO8Y8DD_HQzcjw_i9_9Pfap_
    mPRf_7lulTck26IZMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:E6m1XxjwQ4b7_rWJLSAM_njZKZeb_K9wQGZn4Gif-LYXzlzy89jWMw>
    <xmx:E6m1X182pp831pSs0XItu43stKgv9PwWUq7yzRdY2L8o6j5u862mxg>
    <xmx:E6m1X8tEdgxAlhBshfIrIyeJCUEIjjZBo2D1xRrv1pNccNkDmDNv2g>
    <xmx:E6m1X15ntvsaFGbAjnsqtbihUXdVQ1N_kHnvzyfQ5IFxmbv0LG-Owg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 370D03280060;
        Wed, 18 Nov 2020 18:06:59 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 06/12] btrfs: clear free space tree on ro->rw remount
Date:   Wed, 18 Nov 2020 15:06:21 -0800
Message-Id: <f91ff85f985eeaf8993022453ca21fa4772e28a8.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A user might want to revert to v1 or nospace_cache on a root filesystem,
and much like turning on the free space tree, that can only be done
remounting from ro->rw. Support clearing the free space tree on such
mounts by moving it into the shared remount logic.

Since the CLEAR_CACHE option sticks around across remounts, this change
would result in clearing the tree for ever on every remount, which is
not desirable. To fix that, add CLEAR_CACHE to the oneshot options we
clear at mount end, which has the other bonus of not cluttering the
/proc/mounts output with clear_cache.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0bc7d9766f8c..64e5707f008b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2892,6 +2892,7 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
 void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 {
 	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
+	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
 }
 
 /*
@@ -2901,6 +2902,27 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 {
 	int ret;
+	bool clear_free_space_tree = false;
+
+	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
+	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+		clear_free_space_tree = true;
+	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
+		btrfs_warn(fs_info, "free space tree is invalid");
+		clear_free_space_tree = true;
+	}
+
+	if (clear_free_space_tree) {
+		btrfs_info(fs_info, "clearing free space tree");
+		ret = btrfs_clear_free_space_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "failed to clear free space tree: %d", ret);
+			close_ctree(fs_info);
+			return ret;
+		}
+	}
 
 	ret = btrfs_cleanup_fs_roots(fs_info);
 	if (ret)
@@ -2975,7 +2997,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	struct btrfs_root *chunk_root;
 	int ret;
 	int err = -EINVAL;
-	int clear_free_space_tree = 0;
 	int level;
 
 	ret = init_mount_fs_info(fs_info, sb);
@@ -3377,26 +3398,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (sb_rdonly(sb))
 		goto clear_oneshot;
 
-	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
-	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		clear_free_space_tree = 1;
-	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
-		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
-		btrfs_warn(fs_info, "free space tree is invalid");
-		clear_free_space_tree = 1;
-	}
-
-	if (clear_free_space_tree) {
-		btrfs_info(fs_info, "clearing free space tree");
-		ret = btrfs_clear_free_space_tree(fs_info);
-		if (ret) {
-			btrfs_warn(fs_info,
-				   "failed to clear free space tree: %d", ret);
-			close_ctree(fs_info);
-			return ret;
-		}
-	}
-
 	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
 		close_ctree(fs_info);
-- 
2.24.1

