Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62C66F6979
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjEDLE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEDLEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE54EDA
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 667BA6129B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEBCC433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683198278;
        bh=6LvE9M4jg1PtpyKkneV7Kv51VKE0GShkQFksh1Q94yU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=id+v0gdAOcC8OJ9EA5fkRkgTlGzkUxSjCPIl0mYdp0o73hqOtILTqAGAdMokLe3UU
         cw0tj3blWHjANRUA6Zo7rqQqocyvP04hbOiRSpAsZ4/yo66n4I/48p0PrXqbXscqeW
         81laG5bvWUtQQOertnL3/JsYqlgV9lglclTTzrUcULo0w4cTgwRMXMrbceGnfOi+4m
         rInzpJEpr6ucnq2WrCoKJRdF1NBrPPn2qG8CFfwEEJGnmNnNeuzQByUa68U0aPEXiE
         jleon9wjXOoYbICTyLc1CWU84KkjgCKDCbEhHQDQ7OJQmprmhu/SxORmN6O9e9L5FF
         832jZ10uOo27w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs: assert tree lock is held when linking free space
Date:   Thu,  4 May 2023 12:04:25 +0100
Message-Id: <018ffcab35457b341195411e85614029f3e25764.1683196407.git.fdmanana@suse.com>
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

When linking a free space entry, at link_free_space(), the caller should
be holding the spinlock 'tree_lock' of the given btrfs_free_space_ctl
argument, which is necessary for manipulating the red black tree of free
space entries (done by tree_insert_offset(), which already asserts the
lock is held) and for manipulating the 'free_space', 'free_extents',
'discardable_extents' and 'discardable_bytes' counters of the given
struct btrfs_free_space_ctl.

So assert that the spinlock 'tree_lock' of the given btrfs_free_space_ctl
is held by the current task. We have multiple code paths that end up
calling link_free_space(), and all currently take the lock before calling
it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 84e09ac50103..f5ddfb2e58a9 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1850,6 +1850,8 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 {
 	int ret = 0;
 
+	lockdep_assert_held(&ctl->tree_lock);
+
 	ASSERT(info->bytes || info->bitmap);
 	ret = tree_insert_offset(ctl, NULL, info);
 	if (ret)
-- 
2.35.1

