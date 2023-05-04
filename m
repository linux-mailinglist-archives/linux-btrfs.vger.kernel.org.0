Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C0F6F697E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjEDLEz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjEDLEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56CF5256
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 854596176A
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76168C4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683198277;
        bh=Lb8pmXoZIjPQpjaSC8eI7nEo1yoCF67sEhq8bsNHye8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tofoWcJhE35IKVbtZN7SqkqGSOFGWHepFmQ+H4+7TPNutDVsmzDl6c4gzQEkWameH
         aXf2BIHoZYW2VbBba2nIJZcp8mdcsw80WIMljpO3ZO+s18stHT1mp7S7/TLL0aUuv0
         R6suAK1M34mVZVvE425d8kX4iw75Uqd1mQHiYreBw4KGz8+/c7EYhYIYLkHs0TIWeK
         +lWwXQN4lPQ/DhtbS2nupwy/8rXxoqpQxyJBRMbp65uZ5xuLGAaVKM6ilBXcjKbVoi
         vPqRHMPg5VRLh81B713uogGe8tcbksJIFmpdp2c7G7vfWH3FNcbEseJGVs5AagrvGW
         KvwbEWZOyJYkA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs: assert tree lock is held when searching for free space entries
Date:   Thu,  4 May 2023 12:04:24 +0100
Message-Id: <524c29c4f899918f9597a6ea6af1e86d99117bc7.1683196407.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1683196407.git.fdmanana@suse.com>
References: <cover.1683196407.git.fdmanana@suse.com>
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

When searching for a free space entry by offset, at tree_search_offset(),
we are supposed to have the btrfs_free_space_ctl's 'tree_lock' held, so
assert that. We have multiple callers of tree_search_offset(), and all
currently hold the necessary lock before calling it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 31d9bb958dc7..84e09ac50103 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1721,6 +1721,8 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 	struct rb_node *n = ctl->free_space_offset.rb_node;
 	struct btrfs_free_space *entry = NULL, *prev = NULL;
 
+	lockdep_assert_held(&ctl->tree_lock);
+
 	/* find entry that is closest to the 'offset' */
 	while (n) {
 		entry = rb_entry(n, struct btrfs_free_space, offset_index);
-- 
2.35.1

