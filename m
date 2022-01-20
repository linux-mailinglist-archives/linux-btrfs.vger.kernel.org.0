Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE54952EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 18:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347589AbiATRL7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 12:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346412AbiATRL7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 12:11:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F540C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 09:11:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16820B81D9A
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 17:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A779C340E0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642698716;
        bh=pOxC22RrtDkOZcx3wkioN8HAEaO7cXKoNRqohFMSQKI=;
        h=From:To:Subject:Date:From;
        b=aKAxmevBM1xpXWegjh1ycfFA8/Hebrf1zkOYXnGCI6mzstP1xZBsvqRYMfrcWa9ft
         c41ofC9TvSPXen7lTeZcxB0O2DwBp28ThfprdOKaV1YAu3h0n9cyOLpKoMCmuIHYQm
         9/2vLpXkDw5VE6yWSXId65GX7S+BTSfKm1lNG5Trjtlu5fsXoqalD1r4gV/lv3MEQt
         61ofUlUAYIlhY4WXqUT3N5I8nytxetYjWCW0SpeeTuj94plT44iErmbIp3aNbNad4n
         UjLKZ9/BjKYi6Y0waR/0mwH/I3zhDmXyxH2kdRJLg4THz4SNOzpuPb010n65BCpK7o
         SpinXNGXDAosg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add back missing dirty page rate limiting to defrag
Date:   Thu, 20 Jan 2022 17:11:52 +0000
Message-Id: <3fe2f747e0a9319064d59d051dc3f993fc41b172.1642698605.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A defrag operation can dirty a lot of pages, specially if operating on
the entire file or a large file range. Any task dirtying pages should
periodically call balance_dirty_pages_ratelimited(), as stated in that
function's comments, otherwise they can leave too many dirty pages in
the system. This is what we did before the refactoring in 5.16, and
it should have remained, just like in the buffered write path and
relocation. So restore that behaviour.

Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0082e9a60bfc..bfe5ed65e92b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1577,6 +1577,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	}
 
 	while (cur < last_byte) {
+		const unsigned long prev_sectors_defragged = sectors_defragged;
 		u64 cluster_end;
 
 		/* The cluster size 256K should always be page aligned */
@@ -1608,6 +1609,10 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 				cluster_end + 1 - cur, extent_thresh,
 				newer_than, do_compress,
 				&sectors_defragged, max_to_defrag);
+
+		if (sectors_defragged > prev_sectors_defragged)
+			balance_dirty_pages_ratelimited(inode->i_mapping);
+
 		btrfs_inode_unlock(inode, 0);
 		if (ret < 0)
 			break;
-- 
2.33.0

