Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972D22B8818
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKRXGa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:30 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56617 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbgKRXGa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:30 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id E4DCCD37;
        Wed, 18 Nov 2020 18:06:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=eJZSpcjXxOpl9/AEy4OvQwVU6w
        DDaas8FavaIrwBnbc=; b=VfYiNDCULjFsZ7NU0tZcmQAcqI72BJycbWqfOWHUhD
        R3riA/dWC3EYIDm6QsqUU8c40UnXIdmKXEP+Gnsuc879w/LUCZhJEryFVBOJJLzm
        da/x5/nbDUR0B3TAP/kDwDBzfj1HOiUypTAFne8Ti35TLjrmYqQjRyhbNQPnE9Wb
        3R4aBVvjRKA4l6ZoEJlBYOOtXomxqopmx1qzxnoOY5vcwx0RoJ/hCTvT1E65jQg8
        dii35lzclXrbAH7TuBENolGTQcBTKXW8rLXf56wu13nkdZuvCHy9M74yg1E1h0U6
        7JJL1ECc14GAGormjVkQjVZHFRbowxdEKpNxJ8idMDJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eJZSpcjXxOpl9/AEy4OvQwVU6wDDaas8FavaIrwBnbc=; b=BYR28fFx
        QAYLzZ1h9QxGSKCOYRKMZhRrQn6H+RM7l/T4wvXjW01viUYDUy/7ggeDLG//ESS0
        ERTbpdTx+3xTPfHekSsIaKmk1mnXzD2ju2etFjxsYPOOKRc7uhoxuh0rzSKOs9OF
        ree4/H79YdQN4HsOnKFLiqG7HH6FuAQ1uLirSDkxKwskZ7r/hgScRNjZ0f1qTZ84
        2cdHhqp+KJ7r1LBYPXHMMOx5kgSufFW0XLcHKrYEAsi39SqAYMF5TDo5fMelp402
        D6JfKlc8ki4oMFJ0ag0Fegf5jTsMsDQDayee55kXEJFI4rY2b1Bi55xQypMsj5DD
        aztt1uBxV5oWBA==
X-ME-Sender: <xms:Bqm1X6I2XFlMIaZHfXv5rdtcNAIzDfaM0GpxG1IiqKwho4dASRCPtA>
    <xme:Bqm1XyLrpgZC0vuldYYPjDmpXXo6OOsSK5Mm8-fJqBFB1YF24XK0WUNuOCdEw__Sx
    EUtX8IHyc2HbocSnr4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:Bqm1X6sBCwOXaey32C2W6n2xGlhV_IwEwFYZoK3CrzkmWvAHfv0G1Q>
    <xmx:Bqm1X_bDtkcDpD2P8Z5xELd6sZ-OGypE3w34arFmLSJ3vjQ3ldEmBw>
    <xmx:Bqm1XxY47PMcOMILLN8h7A0hLQgwKwm-v6-Yu7gp2JqRCXXSb7Wvyw>
    <xmx:Bqm1Xz2gPBG20yv16InlhpjMQyp3Lp7W4yejGQSXJ149J_zkc4f_OA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A8ED3280060;
        Wed, 18 Nov 2020 18:06:46 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 02/12] btrfs: cleanup all orphan inodes on ro->rw remount
Date:   Wed, 18 Nov 2020 15:06:17 -0800
Message-Id: <623aef2cdca5e4444a1575f09555d24a827130d7.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we mount a rw file system, we clean the orphan inodes in the
filesystem trees, and also on the tree_root and fs_root. However, when
we remount a ro file system rw, we only clean the former. Move the calls
to btrfs_orphan_cleanup() on tree_root and fs_root to the shared rw
mount routine to effectively add them on ro->rw remount.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3e0de4986dbc..2cf81a4e9393 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2896,6 +2896,14 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 	if (ret)
 		goto out;
 
+	down_read(&fs_info->cleanup_work_sem);
+	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
+	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
+		up_read(&fs_info->cleanup_work_sem);
+		goto out;
+	}
+	up_read(&fs_info->cleanup_work_sem);
+
 	mutex_lock(&fs_info->cleaner_mutex);
 	ret = btrfs_recover_relocation(fs_info->tree_root);
 	mutex_unlock(&fs_info->cleaner_mutex);
@@ -3380,15 +3388,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	down_read(&fs_info->cleanup_work_sem);
-	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
-	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
-		up_read(&fs_info->cleanup_work_sem);
-		close_ctree(fs_info);
-		return ret;
-	}
-	up_read(&fs_info->cleanup_work_sem);
-
 	ret = btrfs_mount_rw(fs_info);
 	if (ret) {
 		close_ctree(fs_info);
-- 
2.24.1

