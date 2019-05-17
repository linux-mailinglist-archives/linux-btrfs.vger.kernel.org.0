Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A496D2166E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfEQJmd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:33338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728397AbfEQJmd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3CD1AEDB
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 078A4DA871; Fri, 17 May 2019 11:43:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 09/15] btrfs: use raid_attr table for btrfs_bg_type_to_factor
Date:   Fri, 17 May 2019 11:43:31 +0200
Message-Id: <c67464f4b65eafdfbd31f5013b8954d20ccd9b73.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The factor is the number of copies.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9bcda2d76a33..3d65fdf7884c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7581,10 +7581,9 @@ void btrfs_reset_fs_info_ptr(struct btrfs_fs_info *fs_info)
  */
 int btrfs_bg_type_to_factor(u64 flags)
 {
-	if (flags & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1 |
-		     BTRFS_BLOCK_GROUP_RAID10))
-		return 2;
-	return 1;
+	const int index = btrfs_bg_flags_to_raid_index(flags);
+
+	return btrfs_raid_array[index].ncopies;
 }
 
 
-- 
2.21.0

