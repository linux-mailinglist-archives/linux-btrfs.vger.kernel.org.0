Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF258745159
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jul 2023 21:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjGBTqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jul 2023 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjGBTpH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jul 2023 15:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4791010FD;
        Sun,  2 Jul 2023 12:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F2A060CEC;
        Sun,  2 Jul 2023 19:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213F7C433C8;
        Sun,  2 Jul 2023 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326851;
        bh=tYUbgO5YeHYEPNFDqTRx0P8v2TaJ4wq6bKWVJqZ9l9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wpx+4p1cfKrFvVUXShEuCxd5RHOs8Sip2kh0GUaq0mxb+1+4/RNEZfvyOw9zCF1Ud
         BTfTm2GKh+XSLW1j1YM1Jsz7AbLTvmUzwDUxmtobn9W/kYuTuJjRAJUHSln8dbvvrQ
         bqamQgT5Rf6d2O4kI+JM9JdDQc9qlKtkH9XxAiwSqipZ0f2mBBTkWqC1mbHzLMtzzr
         7VspgnBZ03iYx/rqFfmE2PDxWJ1IcuE3N+cAo/AFd5zkfyRWsmcIvabgflt8QRncz+
         jkMCLjMXWtL3ooTVfEvKSWsvdm9UWa8uH70n6f+bKxi2P5DIUczPLJCbiOKunJknAR
         sGlsqNyngIjOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 14/15] btrfs: abort transaction at update_ref_for_cow() when ref count is zero
Date:   Sun,  2 Jul 2023 15:40:19 -0400
Message-Id: <20230702194020.1776895-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194020.1776895-1-sashal@kernel.org>
References: <20230702194020.1776895-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
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
index 2ff2961b11830..0ba4d1e6a94ec 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -417,9 +417,13 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
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

