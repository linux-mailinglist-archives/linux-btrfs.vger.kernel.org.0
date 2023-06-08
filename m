Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31302727CC7
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjFHK2N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbjFHK2E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A62D46
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47F4C64BEA
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C71C433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220081;
        bh=+3ZvIhVlNJtr5yJdRAukgAqDyfWb+8m181WJjtARqyc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eOdVXIALYVyCmQDqFGpplVGrt+CRwiTPRLnY9bb9SiYoXaQyU+f2dAZH//Tjobsdj
         zw5EFU+fOvnrvyLWJeYfYzR4wupApD7gHbdZ5FlhRLrao523CJWE1J4iHtN9jHLC+u
         rc7TiMfJtk/3XB0r01bXG9ZrqapBylkdQlu/XrRERcRXur2lUJ8YilPuJLy0SxZ43L
         tJ4BHEPlZda+4aU585SL/+oayYX7fUAgEBHygTcNzM6vk1BqOFFpW94qVUBPzNMxh4
         3AqJ7RuqOui3CQhBmW+QE2DFLXtY/Wj/pTZydDrBYlaPDnGiYBGNrdjwT8k+pDbQqy
         1jxDSaFmIsBMg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/13] btrfs: abort transaction at update_ref_for_cow() when ref count is zero
Date:   Thu,  8 Jun 2023 11:27:45 +0100
Message-Id: <9980464fc9f02392f0dab60c5564495c811ed256.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At update_ref_for_cow() we are calling btrfs_handle_fs_error() if we find
that the extent buffer has an unexpected ref count of zero, however we can
simply use btrfs_abort_transaction(), which achieves the same purposes: to
turn the fs to error state, abort the current transaction and turn the fs
to RO mode as well. Besides that, btrfs_abort_transaction() also prints a
stack trace which makes it more useful.

Also, as this is a very unexpected situation, indicating a serious
corruption/inconsistency, tag the if branch as 'unlikely', set the error
code to -EUCLEAN instead of -EROFS, and log an explicit message.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 00eea2925d1d..0449b3d819a9 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -421,9 +421,13 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 					       &refs, &flags);
 		if (ret)
 			return ret;
-		if (refs == 0) {
-			ret = -EROFS;
-			btrfs_handle_fs_error(fs_info, ret, NULL);
+		if (unlikely(refs == 0)) {
+			btrfs_crit(fs_info,
+				   "found 0 references for tree block at bytenr %llu level %d root %llu",
+				   buf->start, btrfs_header_level(buf),
+				   btrfs_root_id(root));
+			ret = -EUCLEAN;
+			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
 	} else {
-- 
2.34.1

