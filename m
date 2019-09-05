Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8623DA9C68
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbfIEH6K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 03:58:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:47956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731592AbfIEH6K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Sep 2019 03:58:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D7D5AD07
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2019 07:58:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/6] btrfs-progs: check: Repair invalid inode mode in
Date:   Thu,  5 Sep 2019 15:57:54 +0800
Message-Id: <20190905075800.1633-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before this patch, btrfs check can only repair bad free space cache
inode mode (as it was the first case detected by tree-checker and reported)

But Murphy is always right, what may happen will finally happen, we have
users reporting bad inode mode in subvolume trees.
According to the creation time, it looks like some older kernel around
2014 is causing the problem.

Although the reported get the fs fixed by removing the offending old
files, it's still a bad thing that "btrfs check" can't fix it.

This patch will bring the repair functionality to all inodes, along with
needed test image.

The core complexity is in how to determine the correct imode.
This patch will use the following methods to determine the correct
imode:
- INODE_REF
  Do a DIR_INDEX/ITEM search to find a valid filetype then convert it to
  imode. If it works, this should be the most reliable method.

- DIR_INDEX/DIR_ITEM belong to this inode
  Then this inode must be a directory.

- EXTENT_DATA
  This inode can be a regular file or soft link.
  We default to regular file so user can inspect the content to do
  further correction.

- rdev of INODE_ITEM
  If all above fails, and the INODE_ITEM has non-zero rdev, this inode
  must be either BLK or CHR. We default to BLK for this case.

- Error out if nothing matches
  This is to be 100% sure that we won't further corrupt the fs.

Changelog:
v2:
- Implement INODE_REF based imode lookup functionality
- Instead of defaulting to REG, error out if no imode can be found
  To avoid corrupting the fs.

Qu Wenruo (6):
  btrfs-progs: check: Export btrfs_type_to_imode
  btrfs-progs: check/common: Introduce a function to find imode using
    INODE_REF
  btrfs-progs: check/common: Make repair_imode_common() to handle inodes
    in subvolume trees
  btrfs-progs: check/lowmem: Repair bad imode early
  btrfs-progs: check/original: Fix inode mode in subvolume trees
  btrfs-progs: tests/fsck: Add new images for inode mode repair
    functionality

 check/main.c                                  |  50 ++--
 check/mode-common.c                           | 229 +++++++++++++++++-
 check/mode-common.h                           |  17 ++
 check/mode-lowmem.c                           |  39 +++
 .../039-bad-inode-mode/.lowmem_repairable     |   0
 .../bad_free_space_cache_imode.raw.xz}        | Bin
 .../bad_regular_file_imode.img.xz             | Bin 0 -> 2060 bytes
 7 files changed, 298 insertions(+), 37 deletions(-)
 create mode 100644 tests/fsck-tests/039-bad-inode-mode/.lowmem_repairable
 rename tests/fsck-tests/{039-bad-free-space-cache-inode-mode/test.raw.xz => 039-bad-inode-mode/bad_free_space_cache_imode.raw.xz} (100%)
 create mode 100644 tests/fsck-tests/039-bad-inode-mode/bad_regular_file_imode.img.xz

-- 
2.23.0

