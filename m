Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D082226AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgGPPRW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jul 2020 11:17:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:37358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgGPPRW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jul 2020 11:17:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2735AC90;
        Thu, 16 Jul 2020 15:17:24 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove done label in writepage_delalloc
Date:   Thu, 16 Jul 2020 18:17:19 +0300
Message-Id: <20200716151719.3967-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since there is not common cleanup run after the label it makes it somewhat
redundant.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a76b7da91aa6..e6d1d46ae384 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3445,8 +3445,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			 * started, so we don't want to return > 0 unless
 			 * things are going well.
 			 */
-			ret = ret < 0 ? ret : -EIO;
-			goto done;
+			return ret < 0 ? ret : -EIO;
 		}
 		/*
 		 * delalloc_end is already one less than the total length, so
@@ -3478,10 +3477,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		return 1;
 	}

-	ret = 0;
-
-done:
-	return ret;
+	return 0;
 }

 /*
--
2.17.1

