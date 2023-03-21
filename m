Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800E66C2FF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCULOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCULOd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E01635ED2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C2A61B0F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6E7C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397250;
        bh=8Vw4mFbmx7jusR1EQ9Wt5RVqNnWrvsptg1gIM4H8pVE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SkVlPELOpHSmQJa3Q0NBS9qGLVCXhXxuDZc76OGKAa32aev+FhpY14ACqaPcCX83Z
         g9niwHZZNZdm5tOk74aFl6K/Kwc8D9Y49CzrZajQQmproc+eHtjQ08fF1fwawbnsIA
         oj92y4sXA9i2A4z5iFPVAcT1ea2YEZhm/au/2U3XobdY03R4seIMkkoAi9sTptJsBJ
         3YyvTkZpz4sdd2d1I5P8z8ygiyP69QlGtJhkG86H9XhWHik+V3F6vxePbbs7sOS04p
         rwT5xgsSDArh/vw8UaTyl8PkU9eObMP42n16P1hFA/NGFZHz5u4qBBj/dcxb0l/wYE
         GFvTb9bzKZjIA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/24] btrfs: initialize ret to -ENOSPC at __reserve_bytes()
Date:   Tue, 21 Mar 2023 11:13:42 +0000
Message-Id: <e20f821150a7f888758021613820c70a268a072e.1679326431.git.fdmanana@suse.com>
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

At space-info.c:__reserve_bytes(), instead of initializing 'ret' to 0 when
it's declared and then shortly after set it to -ENOSPC under the space
info's spinlock, initialize it to -ENOSPC when declaring it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 379a0e778dfb..5eb161d96e35 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1599,7 +1599,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	struct reserve_ticket ticket;
 	u64 start_ns = 0;
 	u64 used;
-	int ret = 0;
+	int ret = -ENOSPC;
 	bool pending_tickets;
 
 	ASSERT(orig_bytes);
@@ -1622,7 +1622,6 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		async_work = &fs_info->async_reclaim_work;
 
 	spin_lock(&space_info->lock);
-	ret = -ENOSPC;
 	used = btrfs_space_info_used(space_info, true);
 
 	/*
-- 
2.34.1

