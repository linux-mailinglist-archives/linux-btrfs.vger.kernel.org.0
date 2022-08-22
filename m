Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C564459C1DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 16:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiHVOrS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 10:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHVOrQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 10:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94E2B250
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 07:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F54B60EC8
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 14:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BA1C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661179634;
        bh=sYMgyG5cnmto6HDXA8qk3LKkoWCdWyuh1tgaxI0AZLk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pgLuVxGx7+6feaBAV+FONuWlb2wuajRGshRu1Q3Qg1OBClZ+seu2MtSYmC0R8xklf
         ZI69hAiyVViVUNY0jMQBdZaxO35lkzi1BFfmxlJ2o5szbuhEttU0SacgYLqff8WiiG
         G+4GmwaUxdoa2lbkOK/dwkpXEazCE/zDk53ZsES5ZQRlQwSWEalm7g9+H0vLffxCdX
         1YEsMrjn4KFEnJRnqrkpZ/FFrmONODZJGAcxWykTBImyGR8W4zKKkFW+EqeJbc6+B8
         cYcZSKoxdtuxL7o1QZ22o+BuGhGdojKRFQqGNtV2Ck7kxy+/LVIs9/fpuKs5o3P6zY
         D62iSrIs1BKYQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: fix silent failure when deleting root reference
Date:   Mon, 22 Aug 2022 15:47:09 +0100
Message-Id: <f070919ec910b3682dd22742151a60f9e4c95cbf.1661179270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661179270.git.fdmanana@suse.com>
References: <cover.1661179270.git.fdmanana@suse.com>
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

At btrfs_del_root_ref(), if btrfs_search_slot() returns an error, we end
up returning from the function with a value of 0 (success). This happens
because the function returns the value stored in the variable 'err', which
is 0, while the error value we got from btrfs_search_slot() is stored in
the 'ret' variable.

So fix it by setting 'err' with the error value.

Fixes: 8289ed9f93bef2 ("btrfs: replace the BUG_ON in btrfs_del_root_ref with proper error handling")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/root-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index a64b26b16904..d647cb2938c0 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -349,9 +349,10 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	key.offset = ref_id;
 again:
 	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
-	if (ret < 0)
+	if (ret < 0) {
+		err = ret;
 		goto out;
-	if (ret == 0) {
+	} else if (ret == 0) {
 		leaf = path->nodes[0];
 		ref = btrfs_item_ptr(leaf, path->slots[0],
 				     struct btrfs_root_ref);
-- 
2.35.1

