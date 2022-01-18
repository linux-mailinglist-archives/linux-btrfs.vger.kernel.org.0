Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5224918F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 03:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbiARCtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 21:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345577AbiARCbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 21:31:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53900C061771;
        Mon, 17 Jan 2022 18:29:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9040B8124F;
        Tue, 18 Jan 2022 02:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44D8C36AEB;
        Tue, 18 Jan 2022 02:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642472989;
        bh=h1gG3QeHnOPLatdWZB69RHtn1t68ZwkJIf+iuILpzcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMTKvjnrWk4HKdxX9paYqIbVNQ1atbgpoGLeGykyCA90cxcTB/8FG2qVPIZGBC0/0
         02FF0llWXY4j4x/9zvq11TZJ2FifebY32IL2fahKQPt69A/E8dB0IW33veo/4vYgta
         Rtpb1iqImieTKSSot6mZUtAF6KtumACnTJ+Z6QLKRVdJ4UufanSeVQ0rQIyd5tt//5
         o2TmEOv6R+/U1iBRCA1aRpjQHWOoQRQcLNaY83lFK20z9928mH/EiCSegEgdNAW4ax
         3l2w7SVbIqPMY5UX6fESoS3/16Ah1rIqTRZrSoDFN32+hz+TsOwiSG+TYHnUBDSqal
         VdxBBNC4ngdDA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 193/217] btrfs: remove BUG_ON(!eie) in find_parent_nodes
Date:   Mon, 17 Jan 2022 21:19:16 -0500
Message-Id: <20220118021940.1942199-193-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118021940.1942199-1-sashal@kernel.org>
References: <20220118021940.1942199-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 9f05c09d6baef789726346397438cca4ec43c3ee ]

If we're looking for leafs that point to a data extent we want to record
the extent items that point at our bytenr.  At this point we have the
reference and we know for a fact that this leaf should have a reference
to our bytenr.  However if there's some sort of corruption we may not
find any references to our leaf, and thus could end up with eie == NULL.
Replace this BUG_ON() with an ASSERT() and then return -EUCLEAN for the
mortals.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/backref.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 6b4b0f105a572..8b090c40daf77 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1365,10 +1365,18 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				goto out;
 			if (!ret && extent_item_pos) {
 				/*
-				 * we've recorded that parent, so we must extend
-				 * its inode list here
+				 * We've recorded that parent, so we must extend
+				 * its inode list here.
+				 *
+				 * However if there was corruption we may not
+				 * have found an eie, return an error in this
+				 * case.
 				 */
-				BUG_ON(!eie);
+				ASSERT(eie);
+				if (!eie) {
+					ret = -EUCLEAN;
+					goto out;
+				}
 				while (eie->next)
 					eie = eie->next;
 				eie->next = ref->inode_list;
-- 
2.34.1

