Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D987AAFBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjIVKjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjIVKj2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:39:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F36AF
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:39:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D49C433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379161;
        bh=L+/ApH5RSE4jvFBH5JV2BOMqX+OWB23yHdrzaKkxkOY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NyTrDng74vWZH9ZHhbbmK0ksWhniYVf3Cljw0EmBwbsfnu3cl1Uf8pY410RykN9mJ
         4WzohSXjLh7F9yF700gBsPBi1/qChmIgDbWFC+Cr08QTmxOKhtCHqVPrTCnLJ6f1EN
         aRSUnZsuGJ9P3lpNaIXBk2CK0m094fDLPuX0Xp4r0FHzhzy1EOQUg3hWSgHHk6FcKl
         yDWFshKnzqi29IIDxcKVuULuCFK878Ddts12O5BBP8O6GzK+/pIukh3Tvzj4VUXrud
         Bt8pkcQMWairYInM7X176uuhETgBLW5/HX8cAwMdMz5n/hdEtrJBU6HfrMoBoYifOW
         6x+b5xu0vCmvw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: make sure we cache next state in find_first_extent_bit()
Date:   Fri, 22 Sep 2023 11:39:09 +0100
Message-Id: <322c9453accd0e3329331339920099328d42077f.1695333278.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333278.git.fdmanana@suse.com>
References: <cover.1695333278.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently, at find_first_extent_bit(), when we are given a cached extent
state that happens to have its end offset match the desired range start,
we find the next extent state using that cached state, with next_state()
calls, and then return it.

We then try to cache that next state by calling cache_state_if_flags(),
but that will not cache the state because we haven't reset *cached_state
to NULL, so we end up with the cached_state unchanged, and if the caller
is iterating over extent states in the io tree, its next call to
find_first_extent_bit() will not use the current cached state as its end
offset does not match the minimum start range offset, therefore the cached
state is reset and we have to search the rbtree to find the next suitable
extent state record.

So fix this by resetting the cached state to NULL (and dropping our ref
on it) when we have a suitable cached state and we found a next state by
using next_state() starting from the cached state. This makes use cases
of calling find_first_extent_bit() to go over all ranges in the io tree
to do a single rbtree full search, only on the first call, and the next
calls will just do next_state() (rb_next() wrapper) calls, which is more
efficient.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index f2372d6cd304..6e3645afaa38 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -877,10 +877,19 @@ bool find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 		if (state->end == start - 1 && extent_state_in_tree(state)) {
 			while ((state = next_state(state)) != NULL) {
 				if (state->state & bits)
-					goto got_it;
+					break;
 			}
+			/*
+			 * If we found the next extent state, clear cached_state
+			 * so that we can cache the next extent state below and
+			 * avoid future calls going over the same extent state
+			 * again. If we haven't found any, clear as well since
+			 * it's now useless.
+			 */
 			free_extent_state(*cached_state);
 			*cached_state = NULL;
+			if (state)
+				goto got_it;
 			goto out;
 		}
 		free_extent_state(*cached_state);
-- 
2.40.1

