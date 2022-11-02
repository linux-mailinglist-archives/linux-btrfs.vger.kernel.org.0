Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959956162F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 13:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiKBMqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 08:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiKBMqq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 08:46:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451652A40A
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 05:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A2D5ACE214B
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 12:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83828C4347C
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667393202;
        bh=+iPqfyuV0YPCxcPwEGWPW1uV8LBmcDlLZ7FIEaQ/FiE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IeQqcSu4eMeARWNRbsa/40K+5lM9j/RVQY5fxbTF+rDqrKSkMuityOqnU2uB/+s7k
         wWT7Bq3FdDcDjPBl7wlz4e7gQYvG4EMadEJqNr0grfDwmhr2Lbc5WuNHZo+VUWrzUC
         9vX4Lb9j1b8jXYIym3cOVbjchLv1LiMZkkCJQLoYdAxQmBeNT70IE2stfPvceBV5FP
         EaqT2n6VlSP/uabEMRuwLI6f0/y/cLIlk4ObDlCZUbvI9jpOplWtg8IXvu5bTMAY0W
         PLco9qOzfU0fLDiu/JbobKUiRdB7VBZhK3PAcddZVPEcOLrPBYW3vL+Fhh5hvvOASL
         qKW2T73GDh9MQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix inode reserve space leak due to nowait buffered write
Date:   Wed,  2 Nov 2022 12:46:36 +0000
Message-Id: <4611e4d00d202f24c7c9d3581194b2d68a67c986.1667392727.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667392727.git.fdmanana@suse.com>
References: <cover.1667392727.git.fdmanana@suse.com>
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

During a nowait buffered write, if we fail to balance dirty pages we exit
btrfs_buffered_write() without releasing the delalloc space reserved for
an extent, resulting in leaking space from the inode's block reserve.

So fix that by releasing the delalloc space for the extent when balancing
dirty pages fails.

Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/all/202210111304.d369bc32-yujie.liu@intel.com
Fixes: 965f47aeb5de ("btrfs: make btrfs_buffered_write nowait compatible")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 75d4d0bc9d8f..f8be9d629e75 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1295,8 +1295,10 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		release_bytes = reserve_bytes;
 again:
 		ret = balance_dirty_pages_ratelimited_flags(inode->i_mapping, bdp_flags);
-		if (ret)
+		if (ret) {
+			btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 			break;
+		}
 
 		/*
 		 * This is going to setup the pages array with the number of
-- 
2.35.1

