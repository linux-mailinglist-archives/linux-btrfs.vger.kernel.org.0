Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58006EF90C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjDZRNI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 13:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjDZRNH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 13:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066363A8E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9327061B36
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 17:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8773CC4339B
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682529186;
        bh=8nKX/PpOQ/QCMxB2J5FxrOINvphypg6PtXQYv7EQuuw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H6JwRFE/hOfqigWosrt0Jh/JUBBTVODYFTHwcO0/OXBSshrIkMVGXOc+YOglp/6mW
         snIhZtiUHYPxNIUt3amertQimJZd3wBIXqUfJ2hcD48wlK7Lpn39wj70G7Ong2NgXz
         cg1CKJ5T1kZtgugi+ztDqJU6UsD3Ye9Gy58Y8S42ZANnIrR4DtAvRK9Z635tL1xhRk
         Wl3JjUkTs+I9fk3Mqqh4Sf+zG01/u1H413SCxp8p1UpkqSncIkM8YN6++eZE+G/rcH
         McF7YOL9wnMCmUoUtQmaIRXEorXnq4Os6yBDgN4ybEuLdHa5VOFCwJwqniyS9iQXGp
         wSA0ukPo5BTug==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: make btrfs_free_device() static
Date:   Wed, 26 Apr 2023 18:13:01 +0100
Message-Id: <9182a6f15c0d7ea2395e9c9588eb8fa31d4525f9.1682528751.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1682528751.git.fdmanana@suse.com>
References: <cover.1682528751.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The function btrfs_free_device() is never used outside of volumes.c, so
make it static and remove its prototype declaration at volumes.h.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/volumes.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 841e799dece5..1a7620680f50 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -391,7 +391,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 	return fs_devs;
 }
 
-void btrfs_free_device(struct btrfs_device *device)
+static void btrfs_free_device(struct btrfs_device *device)
 {
 	WARN_ON(!list_empty(&device->post_commit_list));
 	rcu_string_free(device->name);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bf47a1a70813..5cbbee32748c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -617,7 +617,6 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 					const u64 *devid, const u8 *uuid,
 					const char *path);
 void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
-void btrfs_free_device(struct btrfs_device *device);
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct btrfs_dev_lookup_args *args,
 		    struct block_device **bdev, fmode_t *mode);
-- 
2.35.1

