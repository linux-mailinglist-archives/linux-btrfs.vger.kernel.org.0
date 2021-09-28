Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2121741A7D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbhI1F7k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 01:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239261AbhI1F6n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 01:58:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EC0161288;
        Tue, 28 Sep 2021 05:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632808607;
        bh=H8gT73qWs9QvZDEwxm1QJLZLlOdawtOYwPH/pJwvbgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMpmrzUIr/zqVxrujj2ekmDk1E2yRdjQCsXLdovYvyvhfyWn4Fnf70xICpfvPlk7p
         h5vi1Em3C/exHsoHRVlC3bQhpjwOugkgpPn9gGdUsiJsekkd1hE+DNGl5vEBW5dqdA
         ukIpsTuf38Lj8bN1jYcQ8J0yRl5Xd9Wtsj3r5oiQxcPkYjPd8zGhN/n8cjfFfC9vJa
         E9it6BWRK2J4dVO/ASfvrk+/Wq+fPh5y805+qj1A/P71yCfTIxGDPo2XEh9X6uxBWy
         yx9uHWfJUjwCUSYDHoWZFaXWETrvybI3DlTCjtGJxa4k/OdLa7wXNMNSQ+ORbFaU6z
         ihfVBEPDY2vdA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/23] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with proper error handling
Date:   Tue, 28 Sep 2021 01:56:26 -0400
Message-Id: <20210928055645.172544-5-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928055645.172544-1-sashal@kernel.org>
References: <20210928055645.172544-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit bbc9a6eb5eec03dcafee266b19f56295e3b2aa8f ]

There is a BUG_ON() in btrfs_csum_one_bio() to catch code logic error.
It has indeed caught several bugs during subpage development.
But the BUG_ON() itself will bring down the whole system which is
an overkill.

Replace it with a WARN() and exit gracefully, so that it won't crash the
whole system while we can still catch the code logic error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file-item.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 48a2ea6d7092..2de1d8247494 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -568,7 +568,18 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 
 		if (!ordered) {
 			ordered = btrfs_lookup_ordered_extent(inode, offset);
-			BUG_ON(!ordered); /* Logic error */
+			/*
+			 * The bio range is not covered by any ordered extent,
+			 * must be a code logic error.
+			 */
+			if (unlikely(!ordered)) {
+				WARN(1, KERN_WARNING
+			"no ordered extent for root %llu ino %llu offset %llu\n",
+				     inode->root->root_key.objectid,
+				     btrfs_ino(inode), offset);
+				kvfree(sums);
+				return BLK_STS_IOERR;
+			}
 		}
 
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
-- 
2.33.0

