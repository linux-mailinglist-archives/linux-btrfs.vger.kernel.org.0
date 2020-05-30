Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FFE1E933A
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 May 2020 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgE3Sx1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 May 2020 14:53:27 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:37546 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729098AbgE3Sx0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 May 2020 14:53:26 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id f6bjjAOJZLNQWf6bkj3fyJ; Sat, 30 May 2020 20:53:24 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590864804; bh=Cs0wF4VmFB+yn19s/He+suPzR7UP54Xm9CIGupl2CzI=;
        h=From;
        b=VK0o+z4qJs1Pmhy8nXLub7hyZsjBfObPYY/XhzyanvwsAHb+9IqEGrOImM7YYhski
         gYRVPpJc27fuP+MqQFiUiQnktVhJX8Q5UXOlhFuSwKNRogqJ7Hzl6RvnAAuQY+zG0B
         0+QaECvly6wHGFeQFkiukAyEa8JYn0xslBCrhhwjWdiWNj6nAnCMgwW2qhVAUE0m9G
         +/DaqY4r/K43/ZcExbdyL8AQsMmqa0XjLmE0CFpF/ABBomQpBAZG6NqrwKAnmFDY73
         EwhtjN1qZOWd+3ui3q6e8ZCRwEIyIep5P32tTcjRTD92BugkwOV8yYFksgLX1vyQzU
         aOrYZlWJpgQHA==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=XHHvoBmdWm1DjIN-yBUA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH] btrfs: btrfs_reduce_alloc_profile(): add support for raid1c3/raid1c4
Date:   Sat, 30 May 2020 20:53:21 +0200
Message-Id: <20200530185321.8373-2-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <20200530185321.8373-1-kreijack@libero.it>
References: <20200530185321.8373-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHqK044pkb0oXXuWBi+WWeSkt18Iv+ABHmtxs5DE6KaL9iplsa8rjjfrPJN+HmjtlSiyRHBAtbcZFyJkV5YrTrxZiC5CRc+3+0vi0MraYZyKB9sA6E7E
 /eFSQ6BILRHKQuEIbe+0vbp1A3JIGk4q8AwkgYiXiUm6CB6KMi2nSG3DoPP4HU0MEOjuNCEn0ZSZpk9zWrimEEZV6X66j5sq3yKBN/odiVWwNMT00lvBXvUZ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

The function btrfs_reduce_alloc_profile() is in charge to choice
the profile for the 'next' block group allocation.

This patch add support RAID1C3 and RAID1C4.

Moreover are explicetely handled the case DUP and SINGLE.

Before if both DUP and RAID1C3/RAID1C3 were present
btrfs_reduce_alloc_profile() return both the bit set. This would cause
the check alloc_profile_is_valid() to fail leading to a ro filesystem.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/block-group.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5627f53ca115..f23a1e1dc359 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -81,8 +81,12 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	}
 	allowed &= flags;
 
-	if (allowed & BTRFS_BLOCK_GROUP_RAID6)
+	if (allowed & BTRFS_BLOCK_GROUP_RAID1C4)
+		allowed = BTRFS_BLOCK_GROUP_RAID1C4;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID6)
 		allowed = BTRFS_BLOCK_GROUP_RAID6;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID1C3)
+		allowed = BTRFS_BLOCK_GROUP_RAID1C3;
 	else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
 		allowed = BTRFS_BLOCK_GROUP_RAID5;
 	else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
@@ -91,6 +95,14 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 		allowed = BTRFS_BLOCK_GROUP_RAID1;
 	else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
 		allowed = BTRFS_BLOCK_GROUP_RAID0;
+	else if (allowed & BTRFS_BLOCK_GROUP_DUP)
+		allowed = BTRFS_BLOCK_GROUP_DUP;
+	else if (allowed & BTRFS_AVAIL_ALLOC_BIT_SINGLE)
+		allowed = BTRFS_AVAIL_ALLOC_BIT_SINGLE;
+	else {
+		btrfs_err(fs_info, "invalid profile type %llu", allowed);
+		BUG_ON(1);
+	}
 
 	flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
 
-- 
2.27.0.rc2

