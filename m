Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A15FEEDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJNNpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 09:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJNNpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 09:45:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BD464FF
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 06:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE4D3B82344
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 13:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412CFC433C1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665755077;
        bh=+vvhwOUGt9icQ/FTN3OTnNZPakffhxinxc10wDsZSEY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZBP0iE/yo0hvoSExxHt5fPQzSQBJpld1Xg6L9ty6Ow8rcmU0k9yCowolq5G764AUs
         7133k+Ru8gDu8tKaQYOTFH+klVrt8zqYdyTCM+FGElWY1IRgDQhYo7svedkj5hsoiB
         GDXGVMwV4JzPI8cA30CV2Oevf5uzfBr5SdCXmsC64BIWJsR0NPfNxw4gSJtza2Rz8u
         0Hh5+ik+Law43MTCxtBpgtLo2ZYVjYfcEUZ0hV1g5OwuJOcb8bCCMNAQ165j8Aj5nS
         Uxl3FIhZKBBxbr4gVufB7jnLSlZDtP8IWsoFc/+eoMHhyMfKGLZfRDXUsYlJ/qec5l
         cZLL/VbTXZh7w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: switch GFP_ATOMIC to GFP_NOFS when fixing up low keys
Date:   Fri, 14 Oct 2022 14:44:32 +0100
Message-Id: <8a28f1e28d7a01038303b98d3ccd5c1ea8b625e3.1665754838.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665754838.git.fdmanana@suse.com>
References: <cover.1665754838.git.fdmanana@suse.com>
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

When fixing up the first key of each node above the current level, at
fixup_low_keys(), we are doing a GFP_ATOMIC allocation for inserting an
operation record for the tree mod log. However we can do just fine with
GFP_NOFS nowadays. The need for GFP_ATOMIC was for the old days when we
had custom locks with spinning behaviour for extent buffers and we were
in spinning mode while at fixup_low_keys(). Now we use rw semaphores for
extent buffer locks, so we can safely use GFP_NOFS.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index b39b339fbf96..5d4add61f0a0 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2400,7 +2400,7 @@ static void fixup_low_keys(struct btrfs_path *path,
 			break;
 		t = path->nodes[i];
 		ret = btrfs_tree_mod_log_insert_key(t, tslot,
-				BTRFS_MOD_LOG_KEY_REPLACE, GFP_ATOMIC);
+				BTRFS_MOD_LOG_KEY_REPLACE, GFP_NOFS);
 		BUG_ON(ret < 0);
 		btrfs_set_node_key(t, key, tslot);
 		btrfs_mark_buffer_dirty(path->nodes[i]);
-- 
2.35.1

