Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EAF29CAF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832072AbgJ0VIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:08:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37709 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1832061AbgJ0VIr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:08:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 15BDA5C00CC;
        Tue, 27 Oct 2020 17:08:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FQSNoiLjXzmZl
        GOJHXQfgG1LjDqCtSU4lrhfBf8GvL8=; b=WDdZpnZrEcuH11NThV3SCS7rhfd3t
        OLcdHCApZLgdO/tWv37bIXO4ggVop23voplxieDeA1blK9uR0MA5+ZUCi3+3wN7i
        E5u3W3Vsg+BOLouL0NIrbUtFXILlQNnR3pIqTSD6UsAy8mCsPuprFoQfpPPcTAzZ
        9X8A8nO1H4LfaJ8QTjNQnpBPjRH4lEuitiSne560VwtvcHn8mBgOHF/930hT6swS
        JRsOi2EjHiGZOtNncthT1WZq7OkrxQ47CWcI0fvCuOYAP/9jrmY5Sy5coTFMMo3Y
        InWHLw2Jwr128D3oWL2QWbdQnImIwIlJkcvfcs3olDFEp4QNV8YZRRBhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=FQSNoiLjXzmZlGOJHXQfgG1LjDqCtSU4lrhfBf8GvL8=; b=MqbQazA7
        64o/+TwG3cp4Hw+GEDHydK3oN0aeRIkjRSns9soc/1K4QnlifK1nWUAfRr0x+Zc6
        vcms3kgKDKXZyxADWakfJVsr+JxHhkdsXLisrtgysqM0XurjnsWHHNVyPlTMYX/Y
        VqsCnido5DSzJfc2Ej9DtZ4S1cTAjPq2uB9i/TLOlEIaKU/qf2Q9qBGEH8bk8G6v
        OEAKndQCTDL/aTD6L6NqFfRhjQHij7Di+7jdCG14s4iV+fhc2Jp6Kp/gM8uTRVir
        4lKcgEypBJPGDQhjGKfCx+YYZfAJsu64nTQMKwwQtA1ux6eq4LKB2UMjXlgfdsYh
        32jLj3JH/Hnz8Q==
X-ME-Sender: <xms:XYyYX3dpqvafb6OB2oxB45TpuVnjysHrAsvnb2FoWJftpIRnv4bw7g>
    <xme:XYyYX9Pt-dSPupbOxZ6LSGSP5lOnms_2xCY5G7c-PkGecPNUt-TCocdLjIdDHyZwF
    mDAboVu_8d7-79h_U4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:XYyYXwgt-mkr9K5ySEnUHmbWUX5ViUltB5crmfu3a9lJvun_MBQ4vA>
    <xmx:XYyYX4_IPZyvzMVZUcKiBwPX93ihqBTrAvGkR_jVIl28lJqC-nAwWQ>
    <xmx:XYyYXzujlioZhxrJEZr4iTAf2LpgCcU1TOqtHoOv1RnbCpd0wEIsaA>
    <xmx:XoyYXx3jrK2FrEOtvmepcpE50Y4VeR34nXG_J_io38UVqrDd5dpFrw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 653673280059;
        Tue, 27 Oct 2020 17:08:45 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v5 05/10] btrfs: clear free space tree on ro->rw remount
Date:   Tue, 27 Oct 2020 14:07:59 -0700
Message-Id: <273b5dee24b69ea34ef14f89343cc29eb0c9c885.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io>
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
index 987e40e12bb4..cf26ef5efb9f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2831,6 +2831,28 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 {
 	int ret;
+	bool cache_opt = btrfs_test_opt(fs_info, SPACE_CACHE);
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
@@ -2905,7 +2927,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	struct btrfs_root *chunk_root;
 	int ret;
 	int err = -EINVAL;
-	int clear_free_space_tree = 0;
 	int level;
 
 	ret = init_mount_fs_info(fs_info, sb);
@@ -3305,26 +3326,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
 	btrfs_discard_resume(fs_info);
 	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
-- 
2.24.1

