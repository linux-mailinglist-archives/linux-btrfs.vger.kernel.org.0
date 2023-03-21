Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856066C3004
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCULPB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCULOv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D2E23128
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2232A61B14
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1720FC4339B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397255;
        bh=qXB5IpSDf3tUHVO9s49XT/STj6eVrbpZe6RRNw1bR/o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TkIAINW2nkCwCHKZAsf/vR0Bv5+WMgz/f+fuocMhkHAZBNFCOuR437bkHP/ytzAC0
         rMWOUziE5wW/x0Mh8a760x5FrRh3S6hIJlMRc1vKane9VOpXr4HAQbbDj8utsG9bct
         ZqB6ZmGT/1qQ8fvkOsf3zJgZo9bsVa/LrbhWBxW9UIR/ZZ8YzeAEtjdcJaEd1yDCXb
         D2+UUo+3u/3KsP5VL0HNFiN+dpB5KXo5ejZ31FYFJ5bpv+u63lKSl79Al+cA1QAAfS
         iwUAXlkB5cewzkhytR3pkWArDc8kbozxhCguhmrBSF8ANLOcQUG6rij5A26lhLmN+7
         hP91ajkFmA3Aw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/24] btrfs: simplify btrfs_block_rsv_refill()
Date:   Tue, 21 Mar 2023 11:13:48 +0000
Message-Id: <2ce9a65bf72584f5bb9da5e248f94ee4e104f24a.1679326433.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_block_rsv_refill(), there's no point in initializing the
'num_bytes' variable to 0 and then, after taking the block reserve's
spinlock, initializing it to the value of the 'min_reserved' parameter.

So just get rid of the 'num_bytes' local variable and rename the
'min_reserved' parameter to 'num_bytes'.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.c | 4 +---
 fs/btrfs/block-rsv.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 364a3d11bf88..90b8088e8fac 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -242,17 +242,15 @@ int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_percent)
 }
 
 int btrfs_block_rsv_refill(struct btrfs_fs_info *fs_info,
-			   struct btrfs_block_rsv *block_rsv, u64 min_reserved,
+			   struct btrfs_block_rsv *block_rsv, u64 num_bytes,
 			   enum btrfs_reserve_flush_enum flush)
 {
-	u64 num_bytes = 0;
 	int ret = -ENOSPC;
 
 	if (!block_rsv)
 		return 0;
 
 	spin_lock(&block_rsv->lock);
-	num_bytes = min_reserved;
 	if (block_rsv->reserved >= num_bytes)
 		ret = 0;
 	else
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 4cc41c9aaa82..6dc781709aca 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -65,7 +65,7 @@ int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
 			enum btrfs_reserve_flush_enum flush);
 int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_percent);
 int btrfs_block_rsv_refill(struct btrfs_fs_info *fs_info,
-			   struct btrfs_block_rsv *block_rsv, u64 min_reserved,
+			   struct btrfs_block_rsv *block_rsv, u64 num_bytes,
 			   enum btrfs_reserve_flush_enum flush);
 int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src_rsv,
 			    struct btrfs_block_rsv *dst_rsv, u64 num_bytes,
-- 
2.34.1

