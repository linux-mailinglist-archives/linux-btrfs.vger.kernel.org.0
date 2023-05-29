Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9222F714CDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjE2PRk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjE2PRZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3703D2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5998F60B28
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465E3C433EF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373443;
        bh=qyzhnvFZ8DUwRAaTslY61RTRf+/OXDb8e2S1zea0a1M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=trYq75sCoVl2zOLYuWwJ3kwA4c+JfzP7LXjGEFisKltacbuW4F05Li/1QjMHUW1EZ
         iKDMzKiBr3DIVQEOq5wQ7LsQAIFM5n4iOdlwQt+WlorGDCv3i8fAgkydiK1W67GaZf
         AewhrqAVz0R+DtLmIv2RakALHGJHTjkdVVbgGOD4RM6iVxaY1Rj8CvDzEe6MNhxYJv
         bXtvNGZyoOJpodLC5tIpl1Y22d3P/bmAHsMNBpaYx+iGKzdRp28dzVogXR/ZgVQgOf
         9iiTjodWatwkkVLWvhAq6a5qEZZ0bdwIxARGOAfNHlFq67IA6m0O8qRUcV2vFEaAoU
         dKMKT+9ga0/vw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/11] btrfs: use a single switch statement when initializing delayed ref head
Date:   Mon, 29 May 2023 16:17:05 +0100
Message-Id: <17984e68ade72b7b411688f32585a8038406bf33.1685363099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685363099.git.fdmanana@suse.com>
References: <cover.1685363099.git.fdmanana@suse.com>
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

At init_delayed_ref_head(), we are using two separate if statements to
check the delayed ref head action, and initializing 'must_insert_reserved'
to false twice, once when the variable is declared and once again in an
else branch.

Make this simpler and more straitghforward by having a single switch
statement, also moving the comment about a drop action to the
corresponding switch case to make it more clear and eliminating the
duplicated initialization of 'must_insert_reserved' to false.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 44 +++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index bf8c2ac6c95e..6a13cf00218b 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -702,29 +702,33 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	/* If reserved is provided, it must be a data extent. */
 	BUG_ON(!is_data && reserved);
 
-	/*
-	 * The head node stores the sum of all the mods, so dropping a ref
-	 * should drop the sum in the head node by one.
-	 */
-	if (action == BTRFS_UPDATE_DELAYED_HEAD)
+	switch (action) {
+	case BTRFS_UPDATE_DELAYED_HEAD:
 		count_mod = 0;
-	else if (action == BTRFS_DROP_DELAYED_REF)
+		break;
+	case BTRFS_DROP_DELAYED_REF:
+		/*
+		 * The head node stores the sum of all the mods, so dropping a ref
+		 * should drop the sum in the head node by one.
+		 */
 		count_mod = -1;
-
-	/*
-	 * BTRFS_ADD_DELAYED_EXTENT means that we need to update the reserved
-	 * accounting when the extent is finally added, or if a later
-	 * modification deletes the delayed ref without ever inserting the
-	 * extent into the extent allocation tree.  ref->must_insert_reserved
-	 * is the flag used to record that accounting mods are required.
-	 *
-	 * Once we record must_insert_reserved, switch the action to
-	 * BTRFS_ADD_DELAYED_REF because other special casing is not required.
-	 */
-	if (action == BTRFS_ADD_DELAYED_EXTENT)
+		break;
+	case BTRFS_ADD_DELAYED_EXTENT:
+		/*
+		 * BTRFS_ADD_DELAYED_EXTENT means that we need to update the
+		 * reserved accounting when the extent is finally added, or if a
+		 * later modification deletes the delayed ref without ever
+		 * inserting the extent into the extent allocation tree.
+		 * ref->must_insert_reserved is the flag used to record that
+		 * accounting mods are required.
+		 *
+		 * Once we record must_insert_reserved, switch the action to
+		 * BTRFS_ADD_DELAYED_REF because other special casing is not
+		 * required.
+		 */
 		must_insert_reserved = true;
-	else
-		must_insert_reserved = false;
+		break;
+	}
 
 	refcount_set(&head_ref->refs, 1);
 	head_ref->bytenr = bytenr;
-- 
2.34.1

