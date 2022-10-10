Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDC15F9CAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiJJKW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiJJKWm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445B35A816
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A66FA60ED3
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C3FC433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397356;
        bh=x62pqM/XRdoE8d/3+vyjhdSKtlk/VMUcD20O+luvXm0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hG9BJjrLARSX2ZtiyEmwIflLxKr5McPcjVI5464dGz1M5ZYVZeFHrtMJJSj7FpN+y
         zajPoHles4lIZarqgcVcQRxMzuniG9Sbv86AOBQPhgs4QzcOSJx55pJ0jA5LpBgc+q
         9B/JaWUD8lXOfpVIIP72OG91SzAx5968Y7hujeEokbg5per2b21R0JKodvwYVfUuLT
         MeOdD0tGCjuFSoENw2fgzMajtZraWWC3ZQn3pJTJHPvYrJmybYX8xJsiNoecsloUPJ
         glbwSzk+g5JNr7SzRj4aFOttMozKklmS23JLuAyYPr1dtfzjEPB7OEQvEAlCk8PDCo
         JvilbTaps3tFA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/18] btrfs: remove useless logic when finding parent nodes
Date:   Mon, 10 Oct 2022 11:22:16 +0100
Message-Id: <f6bee849ff9db587b568e23aa3e91ccdc8ee73a0.1665396437.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665396437.git.fdmanana@suse.com>
References: <cover.1665396437.git.fdmanana@suse.com>
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

At find_parent_nodes(), at its last step, when iterating over all direct
references, we are checking if we have a share context and if we have
a reference with a different root from the one in the share context.
However that logic is pointless because of two reasons:

1) After the previous patch in the series (subject "btrfs: remove roots
   ulist when checking data extent sharedness"), the roots argument is
   always NULL when using a share check context (struct share_check), so
   this code is never triggered;

2) Even before that previous patch, we could not hit this code because
   if we had a reference with a root different from the one in our share
   context, then we would have exited earlier when doing either of the
   following:

      - Adding a second direct ref to the direct refs red black tree
        resulted in extent_is_shared() returning true when called from
        add_direct_ref() -> add_prelim_ref(), after processing delayed
        references or while processing references in the extent tree;

      - When adding a second reference to the indirect refs red black
        tree (same as above, extent_is_shared() returns true);

      - If we only have one indirect reference and no direct references,
        then when resolving it at resolve_indirect_refs() we immediately
        return that the target extent is shared, therefore never reaching
        that loop that iterates over all direct references at
        find_parent_nodes();

      - If we have 1 indirect reference and 1 direct reference, then we
        also exit early because extent_is_shared() ends up returning true
        when called through add_prelim_ref() (by add_direct_ref() or
        add_indirect_ref()) or add_delayed_refs(). Same applies as when
        having a combination of direct, indirect and indirect with missing
        key references.

   This logic had been obsoleted since commit 3ec4d3238ab165 ("btrfs:
   allow backref search checks for shared extents"), which introduced the
   early exits in case an extent is shared.

So just remove that logic, and assert at find_parent_nodes() that when we
have a share context we don't have a roots ulist and that we haven't found
the extent to be directly shared after processing delayed references and
all references from the extent tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index c2ec132c2a9c..9332401affab 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1188,6 +1188,10 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		.indirect_missing_keys = PREFTREE_INIT
 	};
 
+	/* Roots ulist is not needed when using a sharedness check context. */
+	if (sc)
+		ASSERT(roots == NULL);
+
 	key.objectid = bytenr;
 	key.offset = (u64)-1;
 	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
@@ -1279,6 +1283,20 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		}
 	}
 
+	/*
+	 * If we have a share context and we reached here, it means the extent
+	 * is not directly shared (no multiple reference items for it),
+	 * otherwise we would have exited earlier with a return value of
+	 * BACKREF_FOUND_SHARED after processing delayed references or while
+	 * processing inline or keyed references from the extent tree.
+	 * The extent may however be indirectly shared through shared subtrees
+	 * as a result from creating snapshots, so we determine below what is
+	 * its parent node, in case we are dealing with a metadata extent, or
+	 * what's the leaf (or leaves), from a fs tree, that has a file extent
+	 * item pointing to it in case we are dealing with a data extent.
+	 */
+	ASSERT(extent_is_shared(sc) == 0);
+
 	btrfs_release_path(path);
 
 	ret = add_missing_keys(fs_info, &preftrees, path->skip_locking == 0);
@@ -1316,11 +1334,6 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		 * and would retain their original ref->count < 0.
 		 */
 		if (roots && ref->count && ref->root_id && ref->parent == 0) {
-			if (sc && ref->root_id != sc->root_objectid) {
-				ret = BACKREF_FOUND_SHARED;
-				goto out;
-			}
-
 			/* no parent == root of tree */
 			ret = ulist_add(roots, ref->root_id, 0, GFP_NOFS);
 			if (ret < 0)
-- 
2.35.1

