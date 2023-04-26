Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB16EF2CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 12:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbjDZKxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 06:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbjDZKxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 06:53:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6511C46B0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 03:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F15D963546
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E827BC433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682506301;
        bh=lLgawJq5pSVwiRUxKKxG1RE8DLXRqsKfW0RdOYdbeLc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=W1pUX1MVTciZ1f2YZjDpRalM7sPgxFJexsmPBIMrueJ0wJQvEDXqb0EC3eGsUI4rk
         dlBki07jwuGpiATnbKLMGaYBuyjQJZ7e1WJjZZfbnpkZ4uvnXSUAzG1VJeX+FqvPUe
         hjkA6q1T7eS2aEWuRIF2kIrn+a8N02Jyk4pWXim9aiQEjqc05U6IoALiY0cMMNiibD
         3Lx3YgVKzpsCMeEnpxVOmJy8/jAQWcLKX4wnbrcjgad8+jkbitFbfz7F67U7cW+Tnl
         R5thfGK5Ik0cA8FQzfkKdCpU/bDaqYaKGSbSv2HPAe8eRFEOXKz3UHPV+Iup93RpY0
         xHyN3BWYdFtvg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: abort transaction when sibling keys check fails for leaves
Date:   Wed, 26 Apr 2023 11:51:35 +0100
Message-Id: <df0094379bdfae431142657c27dd00a854a4b402.1682505780.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1682505780.git.fdmanana@suse.com>
References: <cover.1682505780.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

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

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d94429e0f16a..a0b97a6d075a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3296,6 +3296,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	if (check_sibling_keys(left, right)) {
 		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
 		btrfs_tree_unlock(right);
 		free_extent_buffer(right);
 		return ret;
@@ -3514,6 +3515,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	if (check_sibling_keys(left, right)) {
 		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 	return __push_leaf_left(trans, path, min_data_size, empty, left,
-- 
2.34.1

