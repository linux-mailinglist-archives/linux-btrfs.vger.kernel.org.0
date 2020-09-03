Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2242D25CAA4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 22:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgICUeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 16:34:18 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:41931 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729635AbgICUdk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 16:33:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B1A6CEC8;
        Thu,  3 Sep 2020 16:33:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 16:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=S2G2/7Y3fo8C9
        hRoLdmekC8WxN+PHomVgA/W2q4Xc6w=; b=UyMbMfbtchOdC9L5DZgk0ZnYbTGaL
        PNS8ck5T4WMaL9CFWrJWmfJXDRRjs+C5R6fEQmjtTj3YvBdzlEZTG8/GETe/y9ln
        nx3Lf+KbUDDuHV7H9DtOnhAN3nHNTRkl4brSdWfiK8/PJf+atmyS0KFj9dQRDyvB
        4visAjinZ3it/Bd5TFKUX4KSQwNe+Vc+SVJRWUbvjUjL2VUbm7niPaaQn67IgRGT
        4gywWc2eBW4QKGOUYC/9IkAnJTazw7Tm4PaQYMR5RRVrMNmPo68E4zYQ4ybkKWYE
        qjRUc4qV7JCYCja8oZQN90iF9ZGPVyxpTUDxG1wu02SEeoUD7VVRAJ15A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=S2G2/7Y3fo8C9hRoLdmekC8WxN+PHomVgA/W2q4Xc6w=; b=f82QTiX8
        Uq2N3FXIdMEB0aeE3oTyN5TmVaCIZqTCDGsDs1dMY/MtJAmW6MyiQ/5WJmb3Wx9f
        C1zG+GSFj+TtZMFOSwYkaeWJ2R73JqrspHJO86EuzD+GnyL2lfYx3jfbvWmXBl2D
        G2MTkB5vc7GNxg+IIBwbyYnsf5p0S2Vj3xYH6jPhhx6hzSBogwt+vuWEiHnMVFlX
        350rAkoZ4uwwtEyJBOt50M8G5HnyDs/jwV5HuevjF5aCZaEalhIuXBibWw6Umv9N
        wkifAsI2sPP/KL44ew68XDPgEYrE41akdOeFJI9PdXeEKhwC3bW9QLTPV1B+7tCT
        MVOw3m5JR589kg==
X-ME-Sender: <xms:HlNRX5SgPuv3bI9VPc6xzBdIfVm7NDBCegzLyVHmuygqpZ2lX7Sslg>
    <xme:HlNRXyxzVRaz7zXWiH8Kpx-HKvl1pBuofdjVwwBPMD1buGMsCzxFN0jmuc8RJJ-UR
    ZmcF2ouN84nCEBRI70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudeguddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    etheehudfgleelhfehffettedtfeelvdfghfelkeefgefgvdevgefffedvtdefgeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduieefrdduudegrddufedvrdefne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhi
    shessghurhdrihho
X-ME-Proxy: <xmx:HlNRX-3py5NGKU5dBkXVeJePnYYEWg0DDGZ0R7ZcLYfSkkjSKCpfOQ>
    <xmx:HlNRXxD0XJPn9ApD27o7FIDSDhtpZMobO12pWHdezFSaAUgDdzZH1Q>
    <xmx:HlNRXygP3lzvYO-tm-tZ0H3yC2G6c5VFOFAiK3FTb2-v9n9R4iS6qg>
    <xmx:HlNRXztX83uzo6xH0qnQbS5oopNXvQgm2aj2cttT8WcrAd0AmsO2IQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id C5CF73060057;
        Thu,  3 Sep 2020 16:33:33 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Dave Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: support remount of ro fs with free space tree
Date:   Thu,  3 Sep 2020 13:33:08 -0700
Message-Id: <dea5fb2c9131b0b1c274f011596e5798fdc1971d.1599164377.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1599164377.git.boris@bur.io>
References: <cover.1599164377.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a user attempts to remount a btrfs filesystem with
'mount -o remount,space_cache=v2', that operation succeeds.
Unfortunately, this is misleading, because the remount does not create
the free space tree. /proc/mounts will incorrectly show space_cache=v2,
but on the next mount, the file system will revert to the old
space_cache.

For now, we handle only the easier case, where the existing mount is
read only. In that case, we can create the free space tree without
contending with the block groups changing as we go. If it is not read
only, we fail more explicitly so the user knows that the remount was not
successful, and we don't end up in a state where /proc/mounts is giving
misleading information.

References: https://github.com/btrfs/btrfs-todo/issues/5
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/super.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3ebe7240c63d..cbb2cdb0b488 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -47,6 +47,7 @@
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 #include "discard.h"
+#include "free-space-tree.h"
 
 #include "qgroup.h"
 #define CREATE_TRACE_POINTS
@@ -1862,6 +1863,22 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
 
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+		if (!sb_rdonly(sb)) {
+			btrfs_warn(fs_info, "cannot create free space tree on writeable mount");
+			ret = -EINVAL;
+			goto restore;
+		}
+		btrfs_info(fs_info, "creating free space tree");
+		ret = btrfs_create_free_space_tree(fs_info);
+		if (ret) {
+			btrfs_warn(fs_info,
+				   "failed to create free space tree: %d", ret);
+			goto restore;
+		}
+	}
+
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out;
 
-- 
2.24.1

