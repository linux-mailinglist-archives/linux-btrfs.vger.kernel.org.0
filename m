Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A326A474
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfGPJAv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 05:00:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:59044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfGPJAv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 05:00:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EE0EB0BF;
        Tue, 16 Jul 2019 09:00:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jungyeon Yoon <jungyeon.yoon@gmail.com>
Subject: [PATCH 0/3] btrfs: Part 2 of enhanced defence against fuzzed images
Date:   Tue, 16 Jul 2019 17:00:31 +0800
Message-Id: <20190716090034.11641-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This wave has the following features:
- Hunt down BUG_ON() in btrfs_delete_delayed_dir_index()
  EEXIST can cause BUG_ON(). And all callers of this function has
  already handled error by aborting transacation.

- Only allocate extents from the same block group type
  This is a very tricky bug, needs MIXED_GROUP super flag with regular
  block groups (separate META and DATA) and corrupted extent tree.

- ROOT_ITEM check for tree checker
  This kills the unaligned bytenr, invalid level and incorrect reloc
  tree.

Reported-by: Jungyeon Yoon <jungyeon.yoon@gmail.com>

Qu Wenruo (3):
  btrfs: delayed-inode: Kill the BUG_ON() in
    btrfs_delete_delayed_dir_index()
  btrfs: extent-tree: Make sure we only allocate extents from block
    groups with the same type
  btrfs: tree-checker: Add ROOT_ITEM check

 fs/btrfs/delayed-inode.c | 14 +++++-
 fs/btrfs/extent-tree.c   |  9 ++++
 fs/btrfs/tree-checker.c  | 92 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.22.0

