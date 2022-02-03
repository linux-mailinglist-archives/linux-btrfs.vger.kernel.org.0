Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7044A87C2
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 16:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbiBCPgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 10:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351891AbiBCPgv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 10:36:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C35C061714
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 07:36:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E567560C38
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 15:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6FCC340E8
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643902609;
        bh=huGOHh+pfm/NHh6Q6Az6dPXPxhd/cEbfdP/Ww6VXjXA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y/lt0ScgMhNM2QHlvkFOxNJy4WIL/zqJWtMZ3ILf5vTpMeJBfGvk7H9ia5m6rsMcu
         DPgq3k/ZV+/zbwDhDzIt3AXIwK1TT38slrKji5Fazzv6S3OpMW8f3PNMKDd0ujWFLn
         k7ntj7rmyAqpiqS4HTzSYuf5XBYRjfguPAKfSZCB/jEB/sJEK2GSirZEzRI2hOO5im
         jV4b2jJYuEmyCU80kiPuh1E1bpwQ/zMqagxkSywA4Lk5zqv/tiJZ67B548pEY+3NJu
         TjPQnBtkPWS5C5TstDj1/QQLQ1vwFjeXztUZV1CUHZufQzgnrGjSYxLngcQSpzfZ1e
         uFt2jkDsvreUw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: stop checking for NULL return from btrfs_get_extent()
Date:   Thu,  3 Feb 2022 15:36:42 +0000
Message-Id: <4296f624e349be0b08984cb3a5276ab4e693c57b.1643902108.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643902108.git.fdmanana@suse.com>
References: <cover.1643902108.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At extent_io.c, in the read page and write page code paths, we are testing
if the return value from btrfs_get_extent() can be NULL. However that is
not possible, as btrfs_get_extent() always returns either an error pointer
or a (non-NULL) pointer to an extent map structure.

Eveywhere else outside extent_io.c we never check for NULL, we always
treat any returned value as a non-NULL pointer if it does not encode an
error.

So check only for the IS_ERR() case at extent_io.c.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 409bad3928db..8c09038e3f0f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3534,7 +3534,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
 	}
 
 	em = btrfs_get_extent(BTRFS_I(inode), page, pg_offset, start, len);
-	if (em_cached && !IS_ERR_OR_NULL(em)) {
+	if (em_cached && !IS_ERR(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
 		*em_cached = em;
@@ -3608,7 +3608,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 		em = __get_extent_map(inode, page, pg_offset, cur,
 				      end - cur + 1, em_cached);
-		if (IS_ERR_OR_NULL(em)) {
+		if (IS_ERR(em)) {
 			unlock_extent(tree, cur, end);
 			end_page_read(page, false, cur, end + 1 - cur);
 			break;
@@ -3951,7 +3951,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		}
 
 		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
-		if (IS_ERR_OR_NULL(em)) {
+		if (IS_ERR(em)) {
 			btrfs_page_set_error(fs_info, page, cur, end - cur + 1);
 			ret = PTR_ERR_OR_ZERO(em);
 			break;
-- 
2.33.0

