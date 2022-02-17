Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92C24B9FDB
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 13:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbiBQMMe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 07:12:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240298AbiBQMMc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 07:12:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8F411C31
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 04:12:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91D00B82179
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD625C340E9
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645099935;
        bh=gi7+qgpS1A1BYigm7j0e+3Lu+oOEa0IuEuKpzM2sveA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DManWdw8zv8hwQMOUIEc2hC4/LQlOgNPXh7mcEP0gC3R1rSAxUP+rKAyGn9FjI+E+
         Cke5OuubkAIYWRlvP9eoHGui8QQzJgf+S+9OA0/ERvqNv/QkN/d0Z341Bj5+FPEdLF
         oRup64KLZIQw1fejx6P/9G7iasyhdWKYsFEgP7eQdDbcP6kS5DCtrW7Klc+5Vm8RNP
         0a787MoELUck/QYfXq2lOsPJS39CjSITvZPVqw9y5lsjP1tx675O+f6rDxeRC4M5j4
         z2Pn9QgV8H5/cc4dFcsN1Y+OsbBQat5DhCZOVd5q/K58xOyb6EBBa67EhsJIyoqUCA
         D5nEa0n2+R+wg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: voluntarily relinquish cpu when doing a full fsync
Date:   Thu, 17 Feb 2022 12:12:05 +0000
Message-Id: <d54cd0f06d2d6bf48024763acede8b523ff5fa77.1645098951.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645098951.git.fdmanana@suse.com>
References: <cover.1645098951.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Doing a full fsync may require processing many leaves of metadata, which
can take some time and result in a task monopolizing a cpu for too long.
So add a cond_resched() after processing a leaf when doing a full fsync,
while not holding any locks on any tree (a subvolume or a log tree).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 513baf073510..e5b681854117 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5694,6 +5694,13 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 		} else {
 			break;
 		}
+
+		/*
+		 * We may process many leaves full of items for our inode, so
+		 * avoid monopolizing a cpu for too long by rescheduling while
+		 * not holding locks on any tree.
+		 */
+		cond_resched();
 	}
 	if (ins_nr) {
 		ret = copy_items(trans, inode, dst_path, path, ins_start_slot,
-- 
2.33.0

