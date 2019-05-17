Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7233321664
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfEQJmO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:33216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727338AbfEQJmO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0726AEDB
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C0C0DA871; Fri, 17 May 2019 11:43:13 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 01/15] btrfs: fix minimum number of chunk errors for DUP
Date:   Fri, 17 May 2019 11:43:13 +0200
Message-Id: <f238d8b46f4645dd8d402007774a8748499e59f8.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The list of profiles in btrfs_chunk_max_errors lists DUP as a profile
DUP able to tolerate 1 device missing. Though this profile is special
with 2 copies, it still needs the device, unlike the others.

Looking at the history of changes, thre's no clear reason why DUP is
there, functions were refactored and blocks of code merged to one
helper.

d20983b40e828 Btrfs: fix writing data into the seed filesystem
  - factor code to a helper

de11cc12df173 Btrfs: don't pre-allocate btrfs bio
  - unrelated change, DUP still in the list with max errors 1

a236aed14ccb0 Btrfs: Deal with failed writes in mirrored configurations
  - introduced the max errors, leaves DUP and RAID1 in the same group

CC: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com
---
 fs/btrfs/volumes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1c2a6e4b39da..8508f6028c8d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5328,8 +5328,7 @@ static inline int btrfs_chunk_max_errors(struct map_lookup *map)
 
 	if (map->type & (BTRFS_BLOCK_GROUP_RAID1 |
 			 BTRFS_BLOCK_GROUP_RAID10 |
-			 BTRFS_BLOCK_GROUP_RAID5 |
-			 BTRFS_BLOCK_GROUP_DUP)) {
+			 BTRFS_BLOCK_GROUP_RAID5)) {
 		max_errors = 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID6) {
 		max_errors = 2;
-- 
2.21.0

