Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FFC745114
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jul 2023 21:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjGBToT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jul 2023 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjGBTnR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jul 2023 15:43:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9758E6F;
        Sun,  2 Jul 2023 12:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11AC260D42;
        Sun,  2 Jul 2023 19:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C0CC433C8;
        Sun,  2 Jul 2023 19:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326898;
        bh=cVkPx0m2nHb9Fk8cZOozHwWAYRpPzw/xd7wN6mzG1oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5TKWZlX1+DrkFqeO+ZHuoeEevLYb5/d1I0IpKwdUy9KmFnTnvCuCzQxNdt2W4mMc
         J8D3BG188mZhDOCd8cwjVxlIWbOddwohB96L86D1WI0rZXnLH0H7qw4p3rpB4Ntc7m
         voEjQL/jH9NCUuUW2j4H4I+GhFoWT9iUewC9CvYC92DGXsH73Rxp1JEPTMo8OURiME
         PGoYCXFXKf81Q33GU0xOXdh6OAZR83PF0TWMFf1S8E3xaO0R4peKPs5yVxumjPw5//
         dN82pTEPFdvCXeTu7kYFtLVX7ilOFXjruZqQADi5wjNrlot0bMAgOxno3z7h7sVcI8
         qOTXfGRoLn4gg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/12] btrfs: abort transaction at update_ref_for_cow() when ref count is zero
Date:   Sun,  2 Jul 2023 15:41:17 -0400
Message-Id: <20230702194118.1777794-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194118.1777794-1-sashal@kernel.org>
References: <20230702194118.1777794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.37
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

[ Upstream commit eced687e224eb3cc5a501cf53ad9291337c8dbc5 ]

At update_ref_for_cow() we are calling btrfs_handle_fs_error() if we find
that the extent buffer has an unexpected ref count of zero, however we can
simply use btrfs_abort_transaction(), which achieves the same purposes: to
turn the fs to error state, abort the current transaction and turn the fs
to RO mode as well. Besides that, btrfs_abort_transaction() also prints a
stack trace which makes it more useful.

Also, as this is a very unexpected situation, indicating a serious
corruption/inconsistency, tag the if branch as 'unlikely', set the error
code to -EUCLEAN instead of -EROFS, and log an explicit message.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ab9f8d6c4f1b9..5d462dd5fcf56 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -309,9 +309,13 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 					       &refs, &flags);
 		if (ret)
 			return ret;
-		if (refs == 0) {
-			ret = -EROFS;
-			btrfs_handle_fs_error(fs_info, ret, NULL);
+		if (unlikely(refs == 0)) {
+			btrfs_crit(fs_info,
+		"found 0 references for tree block at bytenr %llu level %d root %llu",
+				   buf->start, btrfs_header_level(buf),
+				   btrfs_root_id(root));
+			ret = -EUCLEAN;
+			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
 	} else {
-- 
2.39.2

