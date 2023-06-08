Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D643727CC8
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjFHK2L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjFHK2D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7967B2733
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5738E61245
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42527C433D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220080;
        bh=TjB7pb3cLsK0qrBkhcY0YWbqmlKWjNJBHCDXjDZD/cU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Qm3MMGMsZeSc5mdtmiNFMJN9AU0qjB4aCsCx/68lXhp8GeNlFwCNjM13JS9LPSozO
         Y62JeSNxg2c5EWg6mrDuAJJGFRyGrcuFftzHi9jv3dc2kPji89DU5Umjr1Vz9XnhCr
         WEELvqN188FF3Ls3W60iHEu/ZYvKK/Zq19y6Nv1jSSkds/v+RMWCp1tvBbhY5SZJKl
         h5ZeqRkN3d05WOOifT8Rug25nrEVwoAR5EVQvwJa+zeACmj5zmIF24pNMPeprhDCYl
         sG6Taq0oy/veD1Xk3puh0w2/xuqT9aV8wwSffFrAiRtsG0p9axM11wkFiFllHFNwBB
         hwsVFT4aoGu9w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/13] btrfs: abort transaction at balance_level() when left child is missing
Date:   Thu,  8 Jun 2023 11:27:44 +0100
Message-Id: <77e4be6162916c2d23987cec9542acbc60ec2bde.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
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

Also, as this is a highly unexpected case and it's about a b+tree
inconsistency, change the error code from -EROFS to -EUCLEAN, tag the if
branch as 'unlikely' and log an explicit error message.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4dcdcf25c3fe..00eea2925d1d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1164,9 +1164,13 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		 * otherwise we would have pulled some pointers from the
 		 * right
 		 */
-		if (!left) {
-			ret = -EROFS;
-			btrfs_handle_fs_error(fs_info, ret, NULL);
+		if (unlikely(!left)) {
+			btrfs_crit(fs_info,
+"missing left child when middle child only has 1 item, parent bytenr %llu level %d mid bytenr %llu root %llu",
+				   parent->start, btrfs_header_level(parent),
+				   mid->start, btrfs_root_id(root));
+			ret = -EUCLEAN;
+			btrfs_abort_transaction(trans, ret);
 			goto out;
 		}
 		wret = balance_node_right(trans, mid, left);
-- 
2.34.1

