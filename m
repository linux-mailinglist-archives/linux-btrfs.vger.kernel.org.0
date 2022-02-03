Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946934A87BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351892AbiBCPgx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 10:36:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35722 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351890AbiBCPgv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 10:36:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2A9160DE8
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 15:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB41C340ED
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643902610;
        bh=TMBp1hqIkubCUYyKnipUa/3z43SXMUDZuTBjSUEd35M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ocNGw1iM3oyD06cx7AgCsGzB7zbWwqFIw9tn9nTiOcGswYwQi26LhGWBYTWVrp60r
         zSwTKeChkKVMb3uMI1RItNZje6F1gXYkBhScD164HT7qvA02JjAQiZOcUEc20zK5vw
         LWNrc0LQTS/Onip4iKrNba4kSvfcm6gjhVKWOspZAIYE510wjmPNk50+9MIcfmeyBb
         txh4+X368CjSglCYlsTzymxw7sN4yIoP1BsOfEF93uag8XUsVxvexTMy4Htn78uho6
         nyzin7DnksH5dO06W74X14JoEoE8bcQyWlviS7zi6stg8pSmXalgCvJJJeZzAMbzG7
         kk8OSOg0pOI8A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: fix lost error return value when reading a data page
Date:   Thu,  3 Feb 2022 15:36:43 +0000
Message-Id: <6454d2f2bc3446c5b2310cf5b0aa2479bd8f267a.1643902108.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643902108.git.fdmanana@suse.com>
References: <cover.1643902108.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_do_readpage(), if we get an error when trying to lookup for an
extent map, we end up marking the page with the error bit, clearing
the uptodate bit on it, and doing everything else that should be done.
However we return success (0) to the caller, when we should return the
error encoded in the extent map pointer. So fix that by returning the
error encoded in the pointer.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 1 +
 fs/btrfs/inode.c     | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8c09038e3f0f..e713355c0e15 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3611,6 +3611,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		if (IS_ERR(em)) {
 			unlock_extent(tree, cur, end);
 			end_page_read(page, false, cur, end + 1 - cur);
+			ret = PTR_ERR(em);
 			break;
 		}
 		extent_offset = cur - em->start;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0e04624e557d..9f2c9e93eafe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8095,8 +8095,13 @@ int btrfs_readpage(struct file *file, struct page *page)
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
-	if (bio_ctrl.bio)
-		ret = submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
+	if (bio_ctrl.bio) {
+		int ret2;
+
+		ret2 = submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
+		if (ret == 0)
+			ret = ret2;
+	}
 	return ret;
 }
 
-- 
2.33.0

