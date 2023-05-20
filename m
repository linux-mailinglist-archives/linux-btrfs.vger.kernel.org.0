Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8974B70AA04
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 May 2023 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjETSXX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 May 2023 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjETSXB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 May 2023 14:23:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E77619A2;
        Sat, 20 May 2023 11:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 049C860F93;
        Sat, 20 May 2023 18:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E42EC433D2;
        Sat, 20 May 2023 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606941;
        bh=y5Y1ZMu0vUNhf8febkEcDIU+Jf9TgpuNUDcfQOpSZC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBxZ2Nz2b0DRL15sBkejj6jo5hzNWN9psrFBSX31kUhUx+5P0nFhuXH6T6us473UH
         XDAm1yV0NTOC2esbuvoVpXjpi0MBrHs6lTZfPyloWR4PZsmJM8NiHOjDTS+rAmf8Zd
         4CdY+mhZaDkHRnl+yMCWORTdCZ3ZYF1ewUqH/3/p+7+1WpGXFWDr7o2VtaIBISx+we
         06WXcZ1a+kY8+TQ+npgMSlSV/Tmnw6EqTubgrMiGMfHmbrXF9+lZRmWanoAiLJr1Yh
         ZraTbGDegn7tdZB/PHjbTY47zYup7Rlp9KpR7lN5ajAwUDygZNnx3w6GcSSeSMpX1O
         9e1O48/N+nMpA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/11] btrfs: abort transaction when sibling keys check fails for leaves
Date:   Sat, 20 May 2023 14:22:05 -0400
Message-Id: <20230520182215.845131-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182215.845131-1-sashal@kernel.org>
References: <20230520182215.845131-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

[ Upstream commit 9ae5afd02a03d4e22a17a9609b19400b77c36273 ]

If the sibling keys check fails before we move keys from one sibling
leaf to another, we are not aborting the transaction - we leave that to
some higher level caller of btrfs_search_slot() (or anything else that
uses it to insert items into a b+tree).

This means that the transaction abort will provide a stack trace that
omits the b+tree modification call chain. So change this to immediately
abort the transaction and therefore get a more useful stack trace that
shows us the call chain in the bt+tree modification code.

It's also important to immediately abort the transaction just in case
some higher level caller is not doing it, as this indicates a very
serious corruption and we should stop the possibility of doing further
damage.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a31986ca9224e..1a19354382b2b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2907,6 +2907,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	if (check_sibling_keys(left, right)) {
 		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
 		btrfs_tree_unlock(right);
 		free_extent_buffer(right);
 		return ret;
@@ -3150,6 +3151,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	if (check_sibling_keys(left, right)) {
 		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 	return __push_leaf_left(path, min_data_size,
-- 
2.39.2

