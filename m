Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9172B881B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKRXGh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:37 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55521 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbgKRXGg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:36 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 75799CB5;
        Wed, 18 Nov 2020 18:06:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=u/1qGS3weBrAzq6EszV7UslQgz
        6RAD2sf0UlFOd1vgE=; b=RNYjwNM56XE7YXsUsx2lH35th8EKiK5jT4S+nQuhvW
        8j7u22rfs8hHQv9ihdQLV5O00rEktlf07HZhH/ifYsifD3jrgcC6PqP6OQWCeT9X
        eFJVRmzdNgD2yClPVGgM9UfoMh1Rl8mwuA8pr1f25S7iD6Kp20EwgztH8dKy7p8X
        4cXgZf8SiQtKdzFIJC1aFg4Qnrp7bP5sQWQVlAFzxTnpEA7H+DOwtjqW8VzUlFAW
        hmsPzZcO0P6EYNXznXUjTD6O7Eql659H9p9zwBM40xokF46C335vIdhYhObMyJL0
        4szup6rNidgIF1k2Tq9Ks7IwRkdTTbUAPZcF92qbQGBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=u/1qGS3weBrAzq6EszV7UslQgz6RAD2sf0UlFOd1vgE=; b=m6kSFwWP
        wNP+KNCfBe0ySAXh4hxAdt4PEUlgWlZK2c6cRpyctYa3euIHz8vxtJQ2LQvHmG9d
        ldOwEWeHYpz+6EU2yW9QlwYOX5sAjGEYytmfV5yM3i79c075ngY+EMIAMTYiWi5a
        AS2TcFH7FKuJCGWOmKM9yLtbzgGXeE8pTtxFyABoDeO19tt+t3D4X5j/2r1cVr1h
        UdGoCCume+scUtFiIMgAB8mSvPl8rD0UqFEsrMXGeivfD/yhA46MQ9glz2nFUxXL
        e1HJiXmqdiEOsey56S2TtKpwHtsZLgcsxCgqbOuwq3fAqw0FNCRG0Drw+W+4dzV/
        ugEqY7dejp6GmQ==
X-ME-Sender: <xms:Dam1X16eU_IWx9C9ZtfN-BHRJxJls28cdALazsWUQ6inRoInmkVF8g>
    <xme:Dam1Xy7-gBgEz2qhD3Mueh8NyIEjM5HXvwhY1Rx9RtBoHaIIWz0HpQTThzTAihfNO
    ZymV8PPvWqwG9b-e0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:Dam1X8flEYERRO2SShQTeyMn2vYWwFn_CEF0hLN43Pnmr_hy3172mQ>
    <xmx:Dam1X-ILZ7P6Ueld2rZWcSCYtdj_5SIbiaCPbpGR2kCbQPMx4yN2gg>
    <xmx:Dam1X5LfKCSw-JQTNVCqWyY_bYhWxFu0zSQ178C_FWtwDUjozcMLwg>
    <xmx:Dam1X8mI6QTx7ZKIZmzNyF0rAtxHO_6f898dK8baeSZcx8vDjUFEmg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F73B3280064;
        Wed, 18 Nov 2020 18:06:52 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 04/12] btrfs: create free space tree on ro->rw remount
Date:   Wed, 18 Nov 2020 15:06:19 -0800
Message-Id: <464597922f2cb83486301a2ba6767cfbb9959c7e.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
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
as we go.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2cf81a4e9393..d934eb80ff49 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2912,6 +2912,17 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+		btrfs_info(fs_info, "creating free space tree");
+		ret = btrfs_create_free_space_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				"failed to create free space tree: %d", ret);
+			goto out;
+		}
+	}
+
 	ret = btrfs_resume_balance_async(fs_info);
 	if (ret)
 		goto out;
@@ -3376,18 +3387,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
-	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		btrfs_info(fs_info, "creating free space tree");
-		ret = btrfs_create_free_space_tree(fs_info);
-		if (ret) {
-			btrfs_warn(fs_info,
-				"failed to create free space tree: %d", ret);
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

