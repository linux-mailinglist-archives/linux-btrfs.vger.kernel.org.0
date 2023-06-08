Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B879E727CC0
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjFHK2A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbjFHK16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24106272A
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA1960A13
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86359C433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220075;
        bh=zp+8Ld/AxtDSSgFUo231T73Mkd5kPjlBD8Z+wJuC6Uk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VRr97oxdd95d3xE6aQmj1gqukqEe3J35OpG8b2kDuMv7lPsEb7ai2UVR0/10BPFkX
         kJBlOk/SXYOBOWIqkRKyue/5osp+s4mWzCzUO3i4rFo6LXlsW5fqEMCsNJ5wtXyEwt
         6kQkvvnO18jLLh8lLnRaTNmQwlYzKzEaPIelEXhp2m6s/S2qjkKnTk3iXHnJNmgxKU
         FoF8oaqagwHPTw3Tz1uhA49q6YTQEFyJeyrTiCzAi5uJH7OeAPeR0/eUCq3tZb8Xzi
         zRruMlWMlxg0SUPI2R9Unwezxx668gH2ssudTm8xWt5/qud9SvT7iWizyfk6s15HCe
         sojf+nRWgxddQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/13] btrfs: fix extent buffer leak after tree mod log failure at split_node()
Date:   Thu,  8 Jun 2023 11:27:38 +0100
Message-Id: <4b3a1538467250930330ff1b922f5c19434adb18.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At split_node(), if we fail to log the tree mod log copy operation, we
return without unlocking the split extent buffer we just allocated and
without decrementing the reference we own on it. Fix this by unlocking
it and decrementing the ref count before returning.

Fixes: 5de865eebb83 ("Btrfs: fix tree mod logging")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7f7f13965fe9..8496535828de 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3053,6 +3053,8 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid);
 	if (ret) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
-- 
2.34.1

