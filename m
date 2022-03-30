Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA66E4EC697
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiC3OdS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346904AbiC3Oc6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 10:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3DA40A0B
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 07:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71B9B61450
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 14:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592F4C34110
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648650672;
        bh=qdWNaAAEamNUcA/bzAtH895TqBzYMpsTMUfzeuKZVrc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OOpr5I7B7AHpBriBcS/vEv2fhZyG7SRWNH99xNY2jgV+nb+Bfytoar2Fj4gFBt6/D
         ovsmOjpo0YKggUuhy0txurtp+AMiLUs6jHwNFwXdq4lhmkypHZ6JcjPX+0jpiCH1oC
         wcktvINRvxbrAR+iJnxoIXfLG6qtpiE2Vds6Kvm5W+7gHUvL0O5B5h/hDmXptJv5v6
         gMiUreXBWRnSYS6ou3aA8oTNYmvIMtJ0AKxx3z9bH5/RqSOwgzFz21sTPGmITPcYI6
         Q+m4Cvjhh5r+6Dviwh9mAJ9q1kpxLY1mEETlSn6fyyvGPLD+EEaFfAAo3zVI80s5PS
         yrzuVgF9sjRdQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: do not test for free space inode during NOCOW check against file extent
Date:   Wed, 30 Mar 2022 15:31:07 +0100
Message-Id: <ff32ed77e4404159cb33fea1065ee3ad8e1f4711.1648650280.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648650280.git.fdmanana@suse.com>
References: <cover.1648650280.git.fdmanana@suse.com>
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

When checking if we can do a NOCOW write against a range covered by a file
extent item, we do a quick a check to determine if the inode's root was
snapshotted in a generation older than the generation of the file extent
item or not. This is to quickly determine if the extent is likely shared
and avoid the expensive check for cross references (this was added in
commit 78d4295b1eeed4 ("btrfs: lift some btrfs_cross_ref_exist checks in
nocow path").

We restrict that check to the case where the inode is not a free space
inode (since commit 27a7ff554e8d34 ("btrfs: skip file_extent generation
check for free_space_inode in run_delalloc_nocow")). That is because when
we had the inode cache feature, inode caches were backed by a free space
inode that belonged to the inode's root.

However we don't have support for the inode cache feature since kernel
5.11, so we don't need this check anymore since free space inodes are
now always related to free space caches, which are always associated to
the root tree (which can't be snapshotted, and its last_snapshot field
is always 0).

So remove that condition.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ae63e6a85cac..9ec4842391a1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1696,7 +1696,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	 * for its subvolume was created, then this implies the extent is shared,
 	 * hence we must COW.
 	 */
-	if (!args->strict && !is_freespace_inode &&
+	if (!args->strict &&
 	    btrfs_file_extent_generation(leaf, fi) <=
 	    btrfs_root_last_snapshot(&root->root_item))
 		goto out;
-- 
2.33.0

