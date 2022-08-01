Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9169C586C66
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiHAN6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiHAN6A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 09:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ACD13CF1
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 06:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC5FC6126E
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 13:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77ACC433D7
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 13:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659362278;
        bh=C5k3MavFlKdVVjILbxt9C0MpxsbVbkWmL136fxrHzQ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fy5PwOV+jCbu+S2qKIVGtAtvBYF1BhJntJZZ6685e7dJLpH6VIg5vuwE4chzt7nRi
         UOE+UYyS7yhMp9sTm5N19mmgRUbwgZWaheZ995HNTV93v4LJPK/QujLgt69qolP1bk
         35QkA7dyAFNlauV0qjr2vsWqMCqVDY/PT+jFVAe5gyzVrNyymSRL7AFK6euRjkxk+7
         d8Um6Us5j8CKLgy9JxXN4yJQE9yF9eZr12Dtzlk0ibuvbpahjejjP6iL8+I8/HsBjN
         w1za7pnSpQP5gAgqIW4JqPF3XhVUgJgnTZF30XporQU7tBd+af2X9343JY2mSnXtCe
         PbuZQJSG9BNNg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix lost error handling when looking up extended ref on log replay
Date:   Mon,  1 Aug 2022 14:57:51 +0100
Message-Id: <49766a99f4f0fe3f0757fc8bfaeae6c7343314a6.1659361747.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1659361747.git.fdmanana@suse.com>
References: <cover.1659361747.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During log replay, when processing inode references, if we get an error
when looking up for an extended reference at __add_inode_ref(), we ignore
it and proceed, returning success (0) if no other error happens after the
lookup. This is obviously wrong because in case an extended reference
exists and it encodes some name not in the log, we need to unlink it,
otherwise the filesystem state will not match the state it had after the
last fsync.

So just make __add_inode_ref() return an error it gets from the extended
reference lookup.

Fixes: f186373fef005c ("btrfs: extended inode refs")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9acf68ef4a49..ccf93ac58e73 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1146,7 +1146,9 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	extref = btrfs_lookup_inode_extref(NULL, root, path, name, namelen,
 					   inode_objectid, parent_objectid, 0,
 					   0);
-	if (!IS_ERR_OR_NULL(extref)) {
+	if (IS_ERR(extref)) {
+		return PTR_ERR(extref);
+	} else if (extref) {
 		u32 item_size;
 		u32 cur_offset = 0;
 		unsigned long base;
-- 
2.35.1

