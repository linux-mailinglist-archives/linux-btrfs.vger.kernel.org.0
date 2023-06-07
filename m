Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677C47269AE
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjFGTZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjFGTYu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC91FD5
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C1B7639BC
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159C9C433EF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686165888;
        bh=gLvOi2Ppog4OeBikgV9x82wsSwVkvqPznbAcObJfA+M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VbytxNccxxuqcaa2DTPnCoMaRunWOP2eAEu4MzTZMm3bpPbz2jTeyj6bYm54AjlxR
         0SjE+BldGLSezVs+NC4RCkVVHIeh5T3A2xShfNkZV987kQ7VS/z1Uoo0WRRq8JaDMK
         4DFhjZMVxDM1QvOhHicyN5QBbcLWA1Yk26zeqww6HBXs6WaPvvohDt6QguZ42xdg7+
         N2WeF6JuyjgSU5GKx2peyaJgBN+PMI01NFoYID9XCwjLyayf3385WxnrnkX0GDz8bx
         UPuAT8wD0YHX9ERD77uTzwiv/WwGD2WCq+jFzgVRDhXheyoz2M/ZSCtfCp+Yem/aFH
         q5z/72wwWSWyg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/13] btrfs: abort transaction at balance_level() when left child is missing
Date:   Wed,  7 Jun 2023 20:24:32 +0100
Message-Id: <91e588216500d2aaa7e119e5ac4be927c71bf066.1686164817.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686164789.git.fdmanana@suse.com>
References: <cover.1686164789.git.fdmanana@suse.com>
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

At balance_level() we are calling btrfs_handle_fs_error() when the middle
child only has 1 item and the left child is missing, however we can simply
use btrfs_abort_transaction(), which achieves the same purposes: to turn
the fs to error state, abort the current transaction and turn the fs to
RO mode. Besides that, btrfs_abort_transaction() also prints a stack trace
which makes it more useful.

Also, as this is an highly unexpected case and it's about a b+tree
inconsistency, change the error code from -EROFS to -EUCLEAN and tag the
if branch as 'unlikely'.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4dcdcf25c3fe..e2943047b01d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1164,9 +1164,9 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		 * otherwise we would have pulled some pointers from the
 		 * right
 		 */
-		if (!left) {
-			ret = -EROFS;
-			btrfs_handle_fs_error(fs_info, ret, NULL);
+		if (unlikely(!left)) {
+			ret = -EUCLEAN;
+			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
 		wret = balance_node_right(trans, mid, left);
-- 
2.34.1

