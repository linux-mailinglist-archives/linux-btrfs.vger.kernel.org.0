Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21436C2FF8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCULOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjCULOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416F21207B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA86DB815BB
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344E5C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397254;
        bh=aIF99skuJxHcx32kCBOeUKAzYYiPQuB+hjqiifdsR8w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ovbjGtpunLTIsgHJr2lhLldJ/M79SQGv/PiM5oRh3HJkV133Ooi7/zMUztZSWj252
         WzAm7FvsKukYDSptq6aXGsVqFIKCUhX3j/ya9i3P6EFGLjOxypK8K4DWEOYepm/FzN
         gKVLe1YrM43ofKESubTdYqdHnnV2mNm3Er1Yg7h66OzaUbzXq+hy3U+b+U4TSjZok7
         p9NzTYvd/2H1oem9xvuVWcLAGPHMkkqoFiIWEXo18a7pS7RKF+sZLM4I7avp2hzt6Y
         /Z9r3ir0jswlJshTcqQfSW03VKyHXAzYoISmyieu+Bca9EMJODEd3LPYwT4b4SXfdz
         CdDFc0lYPqAkQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/24] btrfs: remove redundant counter check at btrfs_truncate_inode_items()
Date:   Tue, 21 Mar 2023 11:13:47 +0000
Message-Id: <0618e34a343facf5c7ee34d0021ed6476c655a55.1679326432.git.fdmanana@suse.com>
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

At btrfs_truncate_inode_items(), in the while loop when we decide that we
are going to delete an item, it's pointless to check that 'pending_del_nr'
is non-zero in an else clause because the corresponding if statement is
checking if 'pending_del_nr' has a value of zero. So just remove that
condition from the else clause.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode-item.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index b65c45b5d681..b27c2c560083 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -660,8 +660,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				/* No pending yet, add ourselves */
 				pending_del_slot = path->slots[0];
 				pending_del_nr = 1;
-			} else if (pending_del_nr &&
-				   path->slots[0] + 1 == pending_del_slot) {
+			} else if (path->slots[0] + 1 == pending_del_slot) {
 				/* Hop on the pending chunk */
 				pending_del_nr++;
 				pending_del_slot = path->slots[0];
-- 
2.34.1

