Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46195FD7D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 12:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJMKgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 06:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJMKgf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 06:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C64BB4896
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 03:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A3FD61759
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 10:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D71C433D7
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665657394;
        bh=+vvhwOUGt9icQ/FTN3OTnNZPakffhxinxc10wDsZSEY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m2YETigFmKLL6zKhp9HW8EQV0Grebzf5Edj/0gq0L/8jhFKMnz1vI33DT9eUpjVMX
         shcyaZhyJCm/LK1wvHI8wjqJIBK7JbVtWW9sZ8NQN43y580CJW+Ds0jtVlKqq0UxlE
         DiS5PD/67Ehpk0f30XymQvGXTsXSUSSvz9mNBr3v67W3NOdL7BwjcYR0+GTRLHl6d6
         FctYYkHEAE6aIqdAjTNcunHlpb6ga0qijnQ3Dgl+H278dyLo+CwqA2AoUVdyc6el4x
         0/0vIaXbVVcB2LBfM97LDIU+CgTzwZ5dNMN91sB2VgRKob+4v9TrmmT410FvXSyGFV
         oMFwL6rbMbcdg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: switch GFP_ATOMIC to GFP_NOFS when fixing up low keys
Date:   Thu, 13 Oct 2022 11:36:25 +0100
Message-Id: <0b1364682b590a48763d5ef343cf1e6a6b930620.1665656353.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665656353.git.fdmanana@suse.com>
References: <cover.1665656353.git.fdmanana@suse.com>
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

