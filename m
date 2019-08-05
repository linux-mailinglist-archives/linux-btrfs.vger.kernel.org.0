Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C81A81F61
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 16:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfHEOrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 10:47:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728764AbfHEOrL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 10:47:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF0D1ABE7
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2019 14:47:10 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/6] Refactor nocow path
Date:   Mon,  5 Aug 2019 17:47:02 +0300
Message-Id: <20190805144708.5432-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series aims at making the nocow path code more understanble. This done by 
doing the following things: 

1. Re-arranging and renaming some variables so that they have more expressive
names, as well as reducing their scope. Patch 1 does this. 

2. Since run_delalloc_nocow open-codes traversal of the btree it contains a lot
of checks which do not pertain to the nocow logic per-se, but are there to 
ensure the code has found the correct EXTENT_ITEM. The nocow logic itself 
contains some subtle checks which are non-obvious at first. Patch 2 rectifies 
this by adding appropriate comments.

3. Patch 3 duplicates the call to btrfs_add_ordered_extent into each branch for 
REGULAR or PREALLOC extents. Despite this duplication I think the code flow 
becomes more streamlined and easier to understand. It also does away with one 
of the local variables. 

4. Patch 4 moves extent checking code into the branch it pertains to. 

5. Patch 5 simplifies the conditions of the main 'if' in that function 

6. Finally, patch 6 removes the BUG_ON that will be triggered in case 
btrfs_add_ordered_extent returned ENOMEM. Now it's replaced with proper graceful
error handling. 

This patchset has been tested with a full xfstest run with -onodatacow option
mount options set. 

Nikolay Borisov (6):
  btrfs: Refactor run_delalloc_nocow
  btrfs: Improve comments around nocow path
  btrfs: Simplify run_delalloc_nocow
  btrfs: Streamline code in run_delalloc_nocow in case of inline extents
  btrfs: Simplify extent type check
  btrfs: Remove BUG_ON from run_delalloc_nocow

 fs/btrfs/extent-tree.c |   3 +
 fs/btrfs/inode.c       | 156 ++++++++++++++++++++++++++---------------
 2 files changed, 102 insertions(+), 57 deletions(-)

-- 
2.17.1

