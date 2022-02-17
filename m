Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C4F4B9FD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbiBQMMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 07:12:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbiBQMMe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 07:12:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1EBDED2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 04:12:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72AA6B82178
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A075BC340EF
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645099938;
        bh=fD1jMEx21uXRTyLn54djMnu5b+wxAoT6QR39OWqkNxY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=W5ZOxYb6OugtHweJPFbsNMRj9HasyHWT7HNEuF9KsQ583o0B5xXuZrrIaFJX3uMIj
         kDwn1FKGzmPJss+YTFEBMemmAI4H4eU5YaJCKJJKIh2i7UsN7dehiY53W0pxbNdYbP
         1ba/9ANqdWXSyDastGx7NrxsyBYGH/ZZTPCxufyxAQO8tRS6/ylv2MUI5bJIZzxqwM
         pVnAZQ8xIn5Wj0a7sA+64GcRvvtFmtYbqgGbodiPiVHi7WP+zElPI1o+QLrFE2Ievj
         OYlx7X9EEab6bGJaUgQZ2l68JCcdiPNLn+yWojImjEx3txjWn8UAXp3q2KBlMJBKIA
         UydUO63xXIwmg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: deal with unexpected extent type during reflinking
Date:   Thu, 17 Feb 2022 12:12:08 +0000
Message-Id: <c449b8e21d90c495d9b6411b09744c7c3738725e.1645098951.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645098951.git.fdmanana@suse.com>
References: <cover.1645098951.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Smatch complains about a possible dereference of a pointer that was not
initialized:

    CC [M]  fs/btrfs/reflink.o
    CHECK   fs/btrfs/reflink.c
  fs/btrfs/reflink.c:533 btrfs_clone() error: potentially dereferencing uninitialized 'trans'.

This is because we are not dealing with the case where the type of a file
extent has an unexpected value (not regular, not prealloc and not inline),
in which case the transaction handle pointer is not initialized.

Such unexpected type should be impossible, except in case of some memory
corruption caused either by bad hardware or some software bug causing
something like a buffer overrun.

So ASSERT that if the extent type is neither regular nor prealloc, then
it must be inline. Bail out with -EUCLEAN and a warning in case it is
not. This silences smatch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 07e19e069c84..03d60db0c5a3 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -494,7 +494,8 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 					&clone_info, &trans);
 			if (ret)
 				goto out;
-		} else if (type == BTRFS_FILE_EXTENT_INLINE) {
+		} else {
+			ASSERT(type == BTRFS_FILE_EXTENT_INLINE);
 			/*
 			 * Inline extents always have to start at file offset 0
 			 * and can never be bigger then the sector size. We can
@@ -505,7 +506,8 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			 */
 			ASSERT(key.offset == 0);
 			ASSERT(datal <= fs_info->sectorsize);
-			if (WARN_ON(key.offset != 0) ||
+			if (WARN_ON(type != BTRFS_FILE_EXTENT_INLINE) ||
+			    WARN_ON(key.offset != 0) ||
 			    WARN_ON(datal > fs_info->sectorsize)) {
 				ret = -EUCLEAN;
 				goto out;
-- 
2.33.0

