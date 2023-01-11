Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9197A665A6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjAKLjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbjAKLjF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A5BE26
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15F2061C4B
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E6BC433F0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436992;
        bh=pMXbqdmklh4DA+hN5wPA1CB9cVGFnwZX4nlpjxQmsMs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=t3OVieC3uKmYMk6Doy9MCgyPUrRY4E4NmaDPlqlh2vR2wgafCTUZwF3jnLuVR5ALk
         L6bRr7S8Wi3/EwloeY2zZmcrKrd5/rAkaIhjZHNVgRcRFLqVzTGWKNuDp3xW09FxHl
         My8BkCrSs2C2DF4sBeSh1Dpb9dT5NRmHYTlnbViTKbUVih9biNfoul2MUlgV2hBaO/
         2rsWxnb8rKvna5sX9ISuowpvxqGV3jpCUfx/OTR90JVIAh4bfvE7oLV6IHMRtThvp4
         7vANwbK70MmkvcH+dHj5jdjFIbwyIQ6NKck6/295nh3E4oCAPfLU2YKARr+4a2ZMxN
         3oAppCacyRSvw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/19] btrfs: send: use MT_FLAGS_LOCK_EXTERN for the backref cache maple tree
Date:   Wed, 11 Jan 2023 11:36:11 +0000
Message-Id: <013ed0f5ae2bfb6a340ba7fa2642a81ec327b724.1673436276.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673436276.git.fdmanana@suse.com>
References: <cover.1673436276.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

As send is single threaded and there's no concurrency, we don't need to
protect the accesses to the backref cache's mapple tree, so initialize the
maple tree with the flag MT_FLAGS_LOCK_EXTERN.

This patch is part of a larger patchset and the changelog of the last
patch in the series contains a sample performance test and results.
The patches that comprise the patchset are the following:

  btrfs: send: directly return from did_overwrite_ref() and simplify it
  btrfs: send: avoid unnecessary generation search at did_overwrite_ref()
  btrfs: send: directly return from will_overwrite_ref() and simplify it
  btrfs: send: avoid extra b+tree searches when checking reference overrides
  btrfs: send: remove send_progress argument from can_rmdir()
  btrfs: send: avoid duplicated orphan dir allocation and initialization
  btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
  btrfs: send: reduce searches on parent root when checking if dir can be removed
  btrfs: send: iterate waiting dir move rbtree only once when processing refs
  btrfs: send: use MT_FLAGS_LOCK_EXTERN for the backref cache maple tree
  btrfs: send: initialize all the red black trees earlier
  btrfs: send: genericize the backref cache to allow it to be reused
  btrfs: adapt lru cache to allow for 64 bits keys on 32 bits systems
  btrfs: send: cache information about created directories
  btrfs: allow a generation number to be associated with lru cache entries
  btrfs: add an api to delete a specific entry from the lru cache
  btrfs: send: use the lru cache to implement the name cache
  btrfs: send: update size of roots array for backref cache entries
  btrfs: send: cache utimes operations for directories if possible

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 20fcf1c0832a..5ac3cff7bd68 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8140,7 +8140,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	INIT_LIST_HEAD(&sctx->name_cache_list);
 
 	INIT_LIST_HEAD(&sctx->backref_cache.lru_list);
-	mt_init(&sctx->backref_cache.entries);
+	mt_init_flags(&sctx->backref_cache.entries, MT_FLAGS_LOCK_EXTERN);
 
 	sctx->flags = arg->flags;
 
-- 
2.35.1

