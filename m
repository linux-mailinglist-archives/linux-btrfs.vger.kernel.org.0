Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAABF61855B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 17:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiKCQxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 12:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiKCQxg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 12:53:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE48E17
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 09:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0890BB8295F
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 16:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D34C433B5
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667494412;
        bh=aB9w2S5YnHVBiSUa/kg+ZcWhY1ioiAPkMZlPOOb6Dqs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DRu1jKmgUAqOva3oRD9sRlFJo+YNSqYLyB+BWO7SE9WrLEcRyye0XOMWVwAdC3Xog
         ruoVybhafTVWCqVWwujC5KKvhNH396Rt9f11iqruu0lR/BFXloVAA6Na5ldAh0u4St
         XSaFRvMIA/nmLEO1/mhMBNkUwY5pTvSLmkBd7R82T6fSo5ya+C+zoDDCXpUbFJOYNG
         XlXzpOv8Lt3wb4WNK8cPuN0c0ifKhZppp8SKOTB5j9guhRVBDIUxCGEXXVQyelUlqk
         tpLy96SSVOh0lAJi4YDYi4dxX/MfrmtF14fHuhnePV9mDPgRUW7D2wGfavFx9M+47k
         OGa3SE7WS8Tvw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: receive: work around failure of fileattr commands
Date:   Thu,  3 Nov 2022 16:53:27 +0000
Message-Id: <73d07400c0fbf7d52fbcee00f73390d0749e5e76.1667494221.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667494221.git.fdmanana@suse.com>
References: <cover.1667494221.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently fileattr commands, introduced in the send stream v2, always
fail, since we have commented the FS_IOC_SETFLAGS ioctl() call and set
'ret' to -EOPNOTSUPP, which is then overwritten to -errno, which may
have a random value since it was not initialized before. This results
in a failure like this:

   ERROR: fileattr: set file attributes on p0/f1 failed: Invalid argument

The error reason may be something else, since errno is undefined at
this point.

Unfortunatelly we don't have a way yet to apply attributes, since the
attributes value we get from the kernel is what we store in flags field
of the inode item. This means that for example we can not just call
FS_IOC_SETFLAGS with the values we got, since they need to be converted
from BTRFS_INODE_* flags to FS_* flags

Besides that we'll have to reorder how we apply certain attributes like
FS_NOCOW_FL for example, which must happen always on an empty file and
right now we run write commands before attempting to change attributes,
as that's the order the kernel sends the operations.

So for now comment all the code, so that anyone using the v2 stream will
not have a receive failure but will get a behaviour like the v1 stream:
file attributes are ignored. This will have to be fixed later, but right
now people can't use a send stream v2 for the purpose of getting better
performance by avoid decompressing extents at the source and compression
of the data at the destination.

Link: https://lore.kernel.org/linux-btrfs/6cb11fa5-c60d-e65b-0295-301a694e66ad@inbox.ru/
Fixes: 8356c423e619 ("btrfs-progs: receive: implement FILEATTR command")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 cmds/receive.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index af3138d5..6f475544 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1304,25 +1304,33 @@ static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
 
 static int process_fileattr(const char *path, u64 attr, void *user)
 {
-	int ret;
-	struct btrfs_receive *rctx = user;
-	char full_path[PATH_MAX];
+	/*
+	 * Not yet supported, ignored for now, just like in send stream v1.
+	 * The content of 'attr' matches the flags in the btrfs inode item,
+	 * we can't apply them directly with FS_IOC_SETFLAGS, as we need to
+	 * convert them from BTRFS_INODE_* flags to FS_* flags. Plus some
+	 * flags are special and must be applied in a special way.
+	 * The commented code below therefore does not work.
+	 */
 
-	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
-	if (ret < 0) {
-		error("fileattr: path invalid: %s", path);
-		return ret;
-	}
-	ret = open_inode_for_write(rctx, full_path);
-	if (ret < 0)
-		return ret;
-	ret = -EOPNOTSUPP;
-	/* ret = ioctl(rctx->write_fd, FS_IOC_SETFLAGS, &flags); */
-	if (ret < 0) {
-		ret = -errno;
-		error("fileattr: set file attributes on %s failed: %m", path);
-		return ret;
-	}
+	/* int ret; */
+	/* struct btrfs_receive *rctx = user; */
+	/* char full_path[PATH_MAX]; */
+
+	/* ret = path_cat_out(full_path, rctx->full_subvol_path, path); */
+	/* if (ret < 0) { */
+	/* 	error("fileattr: path invalid: %s", path); */
+	/* 	return ret; */
+	/* } */
+	/* ret = open_inode_for_write(rctx, full_path); */
+	/* if (ret < 0) */
+	/* 	return ret; */
+	/* ret = ioctl(rctx->write_fd, FS_IOC_SETFLAGS, &attr); */
+	/* if (ret < 0) { */
+	/* 	ret = -errno; */
+	/* 	error("fileattr: set file attributes on %s failed: %m", path); */
+	/* 	return ret; */
+	/* } */
 	return 0;
 }
 
-- 
2.35.1

