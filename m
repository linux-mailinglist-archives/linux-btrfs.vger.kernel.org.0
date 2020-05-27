Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA06F1E3EF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbgE0K2R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:28:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgE0K2Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:28:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA85AAC51
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 10:28:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs-progs: btrfs-image related fixes
Date:   Wed, 27 May 2020 18:28:04 +0800
Message-Id: <20200527102810.147999-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This branch can be fetched from github:
https://github.com/adam900710/btrfs-progs/tree/image_fixes

Since there are two binary files updates, and one big code move, it's
recommended to fetch github repo, in case some patches didn't reach mail
list.

This is inspried by one log tree replay dead loop bug, where the kind
reporter, Pierre Abbat <phma@bezitopo.org>, gave the btrfs-image to
reproduce it.

Then the image fails to pass check due to the existing log tree
conflicting with device/chunk fixup.
As log tree blocks are not recorded in extent tree, later COW can use
log tree blocks and cause transid mismatch.

To address the problem, this patchset will:
- Don't do any fixup if the source dump is single device
  Since the dump has the full super block contents, we can easily check
  if the source fs is single deivce.

  The chunk/device fixup is mostly for older btrfs-image behavior, which
  always restores the fs into SINGLE profile.
  However since commit 9088ab6a1067 ("btrfs-progs: make btrfs-image
  restore to support dup"), btrfs-image can restore into DUP profile,
  allowing us to do exact replay for single device fs.
  This is patch 5.

- Pin down all log tree blocks for fixup
  For cases we still need to fixup chunk/device items, at least pin down
  all log tree blocks to avoid transid mimsatch.
  This is patch 6.

After above fixes, fsck/012 and fsck/035 fails, due to bad original
images.
The old btrfs-image can fixup those bad device total_bytes and
bytes_used, but that just hides the problem.
We still need to update those images to make them correct, so here comes
patch 3 and 4.

During the debugging of btrfs-image restore, I found dump_superblock()
would help a lot to expose bad values in images, so is
btrfs_print_leaf().

Enahance them to be more handy for usage inside gdb, and here comes
patch 1 and 2.


Qu Wenruo (6):
  btrfs-progs: Allow btrfs_print_leaf() to be called on dummy eb whose
    fs_info is NULL
  btrfs-progs: print-tree: Export dump_superblock()
  btrfs-progs: fsck-tests: Update the image in 012
  btrfs-progs: fsck-tests: Update the image of test case 035
  btrfs-progs: image: Don't modify the chunk and device tree if  the
    source dump is single device
  btrfs-progs: image: Pin down log tree blocks before fixup

 cmds/inspect-dump-super.c                     | 454 +-----------------
 image/main.c                                  |  86 +++-
 print-tree.c                                  | 449 ++++++++++++++++-
 print-tree.h                                  |   1 +
 .../012-leaf-corruption/good.img.xz           | Bin 0 -> 186392 bytes
 .../012-leaf-corruption/no_data_extent.tar.xz | Bin 130260 -> 0 bytes
 tests/fsck-tests/012-leaf-corruption/test.sh  |  17 +-
 .../offset_by_one.img                         | Bin 3072 -> 3072 bytes
 8 files changed, 540 insertions(+), 467 deletions(-)
 create mode 100644 tests/fsck-tests/012-leaf-corruption/good.img.xz
 delete mode 100644 tests/fsck-tests/012-leaf-corruption/no_data_extent.tar.xz

-- 
2.26.2

