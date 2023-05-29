Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED23714CD7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjE2PRh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE2PRW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064FC4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80450615AF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D314C433EF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373440;
        bh=pz2MAxyOZ3d+9a0F8cJTuIQmhVZjESvuXajfhu55W6k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A01Xrcuiux1HKDTcWZgL6cPCG4+aguRxpF3ExtQIxNbB4PB9sJ38+ms6csYvlbZIX
         pK4I/P8MqbfMP3HfVVf4no9DJIfbzGPQGo8B79v/dgjV4lNAgmDvbPGr7HYxDgH9nk
         V2dBOMRE8nBXn0DrYWX1l7X6s6U0VjfhegXw8lfhn90utdtNgPY7B+I2QV90wyCLLw
         w4vOSzOirHl8k3zxE+gTBnoa2XrO96kc51KiK9bfHilXs1usFq95rzGoqQ0bNWcYEM
         gSdx9u4l+c0PlLVLjDBeT3V5i9Gb3q7DrAT4XWwj07FQaPr7lwVEPHAaiTFKSXXhTX
         3TVV1eZDLhfFQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/11] btrfs: get rid of label and goto at insert_delayed_ref()
Date:   Mon, 29 May 2023 16:17:02 +0100
Message-Id: <5ef479b0dfa2c93bf010fc9d613baed9cd9f1043.1685363099.git.fdmanana@suse.com>
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

At insert_delayed_ref() there's no point of having a label and goto in the
case we were able to insert the delayed ref head. We can just add the code
under label to the if statement's body and return immediately, and also
there is no need to track the return value in a variable, we can just
return a literal true or false value directly. So do those changes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index c3da7c3185de..e4579e66a57a 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -565,15 +565,18 @@ static bool insert_delayed_ref(struct btrfs_delayed_ref_root *root,
 {
 	struct btrfs_delayed_ref_node *exist;
 	int mod;
-	bool ret = false;
 
 	spin_lock(&href->lock);
 	exist = tree_insert(&href->ref_tree, ref);
-	if (!exist)
-		goto inserted;
+	if (!exist) {
+		if (ref->action == BTRFS_ADD_DELAYED_REF)
+			list_add_tail(&ref->add_list, &href->ref_add_list);
+		atomic_inc(&root->num_entries);
+		spin_unlock(&href->lock);
+		return false;
+	}
 
 	/* Now we are sure we can merge */
-	ret = true;
 	if (exist->action == ref->action) {
 		mod = ref->ref_mod;
 	} else {
@@ -600,13 +603,7 @@ static bool insert_delayed_ref(struct btrfs_delayed_ref_root *root,
 	if (exist->ref_mod == 0)
 		drop_delayed_ref(root, href, exist);
 	spin_unlock(&href->lock);
-	return ret;
-inserted:
-	if (ref->action == BTRFS_ADD_DELAYED_REF)
-		list_add_tail(&ref->add_list, &href->ref_add_list);
-	atomic_inc(&root->num_entries);
-	spin_unlock(&href->lock);
-	return ret;
+	return true;
 }
 
 /*
-- 
2.34.1

