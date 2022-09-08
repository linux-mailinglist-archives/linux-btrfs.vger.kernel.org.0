Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F915B1B7A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiIHLcE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 07:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiIHLcA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 07:32:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C06CCD58
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 04:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C475961C5D
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 11:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B780EC433C1
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662636718;
        bh=cThmZ7o/2UdsM4uLo0w9/nHOldzfjSwMNP8ZUw37Z+c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EQ0O5I8OyvTXLZQf2VOklC1ZCoyT7RO9eKnFg4O72LCda6Sk8U/kWbB2usKLAPOQn
         o3D7vXtqzAUVRZm6reRSW34/pCVO/1thXKS6pbbvDsx5QDjSB6SWgaE2t0PxMZOG13
         v2lFdeUZR3jGOw5hk19GzTy9nQr575YOFCVM3n4Sr8dFIHz1+XGrKXcNLuklW14cXX
         9ht3qSYF4tzfl3gEbSJoficXFYOEVBmc0o8A+q8V6TzpdzCw/VFpsRG8ZFtH3rNNA3
         Q2NsbsDqw0R6x+oBIxHqXSKG1PfRdNRt1WCeY5VlQV30+hF56EjChG36UsEZ/DqKZl
         H4K8d19nuw7AQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: remove useless used space increment during space reservation
Date:   Thu,  8 Sep 2022 12:31:52 +0100
Message-Id: <221b489c8d0f2204a77517f3fb440b635914457a.1662636489.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662636489.git.fdmanana@suse.com>
References: <cover.1662636489.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At space-info.c:__reserve_bytes(), we increment the 'used' variable, but
then we don't use the variable anymore, making the increment pointless.
The increment became useless with commit 2e294c60497f29 ("btrfs: simplify
the logic in need_preemptive_flushing"), so just remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 477e57ace48d..30a256c8c2ea 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1666,7 +1666,6 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 				      &space_info->priority_tickets);
 		}
 	} else if (!ret && space_info->flags & BTRFS_BLOCK_GROUP_METADATA) {
-		used += orig_bytes;
 		/*
 		 * We will do the space reservation dance during log replay,
 		 * which means we won't have fs_info->fs_root set, so don't do
-- 
2.35.1

