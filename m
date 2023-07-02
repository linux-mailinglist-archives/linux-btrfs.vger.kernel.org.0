Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE44A7450E9
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jul 2023 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjGBTnV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jul 2023 15:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjGBTmx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jul 2023 15:42:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909271FC7;
        Sun,  2 Jul 2023 12:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CF9860CD4;
        Sun,  2 Jul 2023 19:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7317C433C9;
        Sun,  2 Jul 2023 19:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326849;
        bh=HU1DK0W3QoKEfKIShWh067RI29CD78lqkq05j/YJ3Ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q4cWosatRpqyvv7w2txdwfzYXJFGh0QUgEaqLZq0WirFT5aoX/GVbJshiFAx9QPuO
         z7oW0aYcYxiFHCSMfGjsR21p2gGXrecu2w0kNx72wbnbCh17CKcpzc+ujzwUap4dj6
         zj9u6OFkV2LtAmep65FwylTx6hpl3vA0HUGQc8wAnVtZGXCWUqInqn2dTQ2mLkdr5W
         W1N03hI9/t9RXYBkCtT3IqXITsE0gT+MitPb+mzrmQWq++sKQC9gEPLhFk7lIuUnwp
         tpgJ32lhC2sDup4o6rW0S8u78X1d0CuHPnr+u+LeSOj10mwpU1PEqLNdC1HJFckK3d
         dviInNh/SJpzQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 13/15] btrfs: don't check PageError in __extent_writepage
Date:   Sun,  2 Jul 2023 15:40:18 -0400
Message-Id: <20230702194020.1776895-13-sashal@kernel.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3e92499e3b004baffb479d61e191b41b604ece9a ]

__extent_writepage currenly sets PageError whenever any error happens,
and the also checks for PageError to decide if to call error handling.
This leads to very unclear responsibility for cleaning up on errors.
In the VM and generic writeback helpers the basic idea is that once
I/O is fired off all error handling responsibility is delegated to the
end I/O handler.  But if that end I/O handler sets the PageError bit,
and the submitter checks it, the bit could in some cases leak into the
submission context for fast enough I/O.

Fix this by simply not checking PageError and just using the local
ret variable to check for submission errors.  This also fundamentally
solves the long problem documented in a comment in __extent_writepage
by never leaking the error bit into the submission context.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1adadd5d25dd..014049c4fcc76 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1623,38 +1623,7 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 		set_page_writeback(page);
 		end_page_writeback(page);
 	}
-	/*
-	 * Here we used to have a check for PageError() and then set @ret and
-	 * call end_extent_writepage().
-	 *
-	 * But in fact setting @ret here will cause different error paths
-	 * between subpage and regular sectorsize.
-	 *
-	 * For regular page size, we never submit current page, but only add
-	 * current page to current bio.
-	 * The bio submission can only happen in next page.
-	 * Thus if we hit the PageError() branch, @ret is already set to
-	 * non-zero value and will not get updated for regular sectorsize.
-	 *
-	 * But for subpage case, it's possible we submit part of current page,
-	 * thus can get PageError() set by submitted bio of the same page,
-	 * while our @ret is still 0.
-	 *
-	 * So here we unify the behavior and don't set @ret.
-	 * Error can still be properly passed to higher layer as page will
-	 * be set error, here we just don't handle the IO failure.
-	 *
-	 * NOTE: This is just a hotfix for subpage.
-	 * The root fix will be properly ending ordered extent when we hit
-	 * an error during writeback.
-	 *
-	 * But that needs a bigger refactoring, as we not only need to grab the
-	 * submitted OE, but also need to know exactly at which bytenr we hit
-	 * the error.
-	 * Currently the full page based __extent_writepage_io() is not
-	 * capable of that.
-	 */
-	if (PageError(page))
+	if (ret)
 		end_extent_writepage(page, ret, page_start, page_end);
 	if (bio_ctrl->extent_locked) {
 		struct writeback_control *wbc = bio_ctrl->wbc;
-- 
2.39.2

