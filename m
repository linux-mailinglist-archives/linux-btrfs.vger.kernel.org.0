Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7C318626
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 09:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhBKIO4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 03:14:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:41004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhBKIOz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 03:14:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613031249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2DKA6L2pd6twnLJbaKFtef1Eqw4uyo73wD+GdtOOmJg=;
        b=RD224232epDjd3mCejUHpWiq6Pv3a1KoiWGjCat/j6f/2VZRk9JY96uIByXHidksaNZb8m
        XOxjFbQ4kUQEo5Cs8YVKku1gNXLwiB7K9go9s/c42+1FSzZAplpGL8f7qRqQofXzsmBjmB
        C/xzeIaJZd+YirjNDzp03pD1h5wtvPQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 357CEAE05
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Feb 2021 08:14:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: ordered-extent: fix comment for btrfs ordered extent flag bits
Date:   Thu, 11 Feb 2021 16:14:05 +0800
Message-Id: <20210211081405.392006-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is small error in comment about BTRFS_ORDERED_* flags.

The 4 types are for ordered extent itself, not for direct io.
Only 3 types support direct io, REGULAR/NOCOW/PREALLOC.

Fix the comment to reflect that.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ordered-data.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 99e0853e4d3b..e60c07f36427 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -39,8 +39,8 @@ struct btrfs_ordered_sum {
  */
 enum {
 	/*
-	 * Different types for direct io, one and only one of the 4 type can
-	 * be set when creating ordered extent.
+	 * Different types for ordered extents, one and only one of the 4 types
+	 * need to be set when creating ordered extent.
 	 *
 	 * REGULAR:	For regular non-compressed COW write
 	 * NOCOW:	For NOCOW write into existing non-hole extent
-- 
2.30.0

