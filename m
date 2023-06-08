Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35800727CC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjFHK2D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjFHK16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27C2736
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C0C564BF0
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70763C43442
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220077;
        bh=tdyQ2KVkAefBDdHrsTEVSbhlF8DU1UDNow65DdRFUr4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jJ2jWfJFvyWRQa0Ut2rXTTQIyDA9K0pdLd4pCBCIKK81B5FMcPRKjL20PDOXfK4bx
         Tk0vxi0Ozj52efrBY02ddG2GS+kmLI3/oB08TTdp4AucCkcUsB6zwncvk9nAOU8uou
         mH7HiNmhXjCUdb8BX8Tt33iKzr/fC4yJ3T5S8da9WDokwVqQM+s5l5LOxfQWXZP/M3
         QOwGkIxyy/evVyyVB2VMwfnvxcCn3f6Lx1kDuIU6BwkpSlN/6747/TMNhyL1xjy6nQ
         zr0gC3HPx5OqX7SQkT3gCdALcJYvAs4okzC0F5g2/vEJ5fT3OcU5p2vWizvJTk130D
         /X10W/07RqLkA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/13] btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()
Date:   Thu,  8 Jun 2023 11:27:40 +0100
Message-Id: <812ffcb37b94176fa247dd33ab7e7c0cbd4ad4e5.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
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

At __btrfs_cow_block(), instead of doing a BUG_ON() in case we fail to
record a tree mod log root insertion operation, do a transaction abort
instead. There's really no need for the BUG_ON(), we can properly
release all resources in this context and turn the filesystem to RO mode
and in an error state instead.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8496535828de..d6c29564ce49 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -584,9 +584,14 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
 			parent_start = buf->start;
 
-		atomic_inc(&cow->refs);
 		ret = btrfs_tree_mod_log_insert_root(root->node, cow, true);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		atomic_inc(&cow->refs);
 		rcu_assign_pointer(root->node, cow);
 
 		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
-- 
2.34.1

