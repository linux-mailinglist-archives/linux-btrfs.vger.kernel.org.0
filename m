Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA16E12F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGSGvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 02:51:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfGSGvt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 02:51:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54F93AC8F
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2019 06:51:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] Fix for btrfs/156 failure and misc enhancements relocated to relocation
Date:   Fri, 19 Jul 2019 14:51:40 +0800
Message-Id: <20190719065144.15263-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs/156 fails after commit 302167c50b32 ("btrfs: don't end the
transaction for delayed refs in throttle"), however it's not that
commit's fault.

The root cause is btrfs_can_relocate() can report false ENOSPC when
there is any block group freed in current transaction.

However thanks to all the hard work due to btrfs balance, we don't
really need some early ENOSPC check, as the current ENOSPC report at
extent reservation time is good enough for balance.

So the main fix is just to remove btrfs_can_relocate(), in patch 4.

Patch 1~3 are miscellaneous patches. Patch 1 unexport
find_free_dev_extent_start(), Patch 2 and 3 adds comment for possible
confusing behaviors, like find_free_dev_extent_start() only searches
commit root, and inc_block_group_ro() only cares if we have 1M free
space left, not caring if other block groups can contain the used space.

Any of the miscellaneous patches can be dropped if needed.

Changelog:
v2:
- Add supporting miscellaneous patches
- Commit message change for the main fix
  * Directly explain how the ENOSPC is caused
  * Add comment for what will happen if we really run out of space

Qu Wenruo (4):
  btrfs: volumes: Unexport find_free_dev_extent_start()
  btrfs: volumes: Add comment for find_free_dev_extent_start()
  btrfs: extent-tree: Add comment for inc_block_group_ro()
  btrfs: volumes: Remove ENOSPC-prone btrfs_can_relocate()

 fs/btrfs/ctree.h       |   1 -
 fs/btrfs/extent-tree.c | 160 +++++------------------------------------
 fs/btrfs/volumes.c     |  15 ++--
 fs/btrfs/volumes.h     |   2 -
 4 files changed, 28 insertions(+), 150 deletions(-)

-- 
2.22.0

