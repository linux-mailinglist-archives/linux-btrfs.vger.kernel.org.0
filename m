Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9442F11AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbhAKLnP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 06:43:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbhAKLnP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 06:43:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D834224BD
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 11:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610365354;
        bh=sNtcyuYa6RzRIp6gbyQnAv2xp67lz7Wzjtit4SPTHVs=;
        h=From:To:Subject:Date:From;
        b=O+I4ruB9Lu7UR0kzMVeSeNJgeGXks/EpKLE+yipKkp+dHsO++T31SGtdwC74ddD4p
         MBZNl54m4aL2XHR7AZNizJ1AiW0Ed5TxNeVA7mj5P2TkvpMoS2hkqhlX+usYeCG6jq
         ckhNEUCiJs84P+vc76MsUJ9/dMrbQUdW5zgN8/gR2u9+iIBMSxr6TzCsOinamWlVd9
         AKzuzkvBGGcNBd5dmqUn72AefD7RrbsvSnqXb5mHn/eTDO5oXxE0c3LNhTaWBoGlM1
         JjaTOMvJ0w7q44Uj30loiSXUroe7UeFxi4Wwoob8ZFdhyHQugUzwpgqYp5GLFyNq7t
         eMSmUdUYH2Bjg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send, remove stale code when checking for shared extents
Date:   Mon, 11 Jan 2021 11:42:32 +0000
Message-Id: <8e6bcde253b959537168b420ef643424238bcc5a.1610363887.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After commit 040ee6120cb670 ("Btrfs: send, improve clone range") we do not
use anymore the data_offset field of struct backref_ctx, as after that we
do all the necessary checks for the data offset of file extent items at
clone_range(). Since there are no more users of data_offset from that
structure, remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 1eaa004d97cd..9dd59611838c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1191,9 +1191,6 @@ struct backref_ctx {
 	/* may be truncated in case it's the last extent in a file */
 	u64 extent_len;
 
-	/* data offset in the file extent item */
-	u64 data_offset;
-
 	/* Just to check for bugs in backref resolving */
 	int found_itself;
 };
@@ -1401,19 +1398,6 @@ static int find_extent_clone(struct send_ctx *sctx,
 	backref_ctx->cur_offset = data_offset;
 	backref_ctx->found_itself = 0;
 	backref_ctx->extent_len = num_bytes;
-	/*
-	 * For non-compressed extents iterate_extent_inodes() gives us extent
-	 * offsets that already take into account the data offset, but not for
-	 * compressed extents, since the offset is logical and not relative to
-	 * the physical extent locations. We must take this into account to
-	 * avoid sending clone offsets that go beyond the source file's size,
-	 * which would result in the clone ioctl failing with -EINVAL on the
-	 * receiving end.
-	 */
-	if (compressed == BTRFS_COMPRESS_NONE)
-		backref_ctx->data_offset = 0;
-	else
-		backref_ctx->data_offset = btrfs_file_extent_offset(eb, fi);
 
 	/*
 	 * The last extent of a file may be too large due to page alignment.
-- 
2.28.0

