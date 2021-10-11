Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ADB428C93
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 14:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhJKMI5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 08:08:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52146 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbhJKMI5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 08:08:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8529521C95
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633954016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ygVRHdJB43HHOnOIyjbjpV9yDTzo+si+3yU2VdzxbXY=;
        b=R7jELgYBf5WAbtOBEbgeQsXuwqaODnGL8OqLpQRtZ5EENQkgHv3tRAPxGdFa6Fg1VR9sLi
        hGmY+8PtjHb1l7/Da8a+Vy1F+9VxmRvfxjPMtUXi9S6wrnaBhwtDCRTe4D7GdQTgHp7x5X
        V3u7maVFwmowzyZjspczyhHz54HeEc0=
Received: from adam-pc.lan (wqu.tcp.ovpn2.nue.suse.de [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id 9288CA3B83
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 12:06:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs-progs: mkfs: make sure we can clean up all temporary chunks
Date:   Mon, 11 Oct 2021 20:06:47 +0800
Message-Id: <20211011120650.179017-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug report that with certain mkfs options, mkfs.btrfs may
fail to cleanup some temporary chunks, leading to "btrfs filesystem df"
warning about multiple profiles:

  WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
  WARNING:   Metadata: single, raid1 

The easiest way to reproduce is "mkfs.btrfs -f -R free-space-tree -m dup
-d dup".

It turns out that, the old _recow_root() can not handle tree levels > 0,
while with newer free space tree creation timing, the free space tree
can reach level 1 or higher.

To fix the problem, Patch 2 will do the proper full tree re-CoW, with
extra transaction commitment to make sure all free space tree get
re-CoWed.

The 3rd patch will do the extra verification during mkfs-tests.

The first patch is just to fix a confusing parameter which also caused
u64 -> int width reduction and can be problematic in the future.

Changelog:
v2:
- Remove a duplicated recow_roots() call in create_raid_groups()
  This call makes no difference as we will later commit transaction
  and manually call recow_roots() again.
  Remove such duplicated call to save some time.

- Replace the btrfs_next_sibling_tree_block() with btrfs_next_leaf()
  Since we're always handling leaves, there is no need for
  btrfs_next_sibling_tree_block()

- Work around a kernel bug which may cause false alerts
  For single device RAID0, btrfs kernel is not respecting it, and will
  allocate new chunks using SINGLE instead.
  This can be very noisy and cause false alerts, and not always
  reproducible, depending on how fast kernel creates new chunks.

  Work around it by mounting the RO before calling "btrfs fi df".

  The kernel bug needs to be investigated and fixed.


Qu Wenruo (3):
  btrfs-progs: rename @data parameter to @profile in extent allocation
    path
  btrfs-progs: mkfs: recow all tree blocks properly
  btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans up temporary
    chunks

 kernel-shared/extent-tree.c                 | 26 +++---
 mkfs/main.c                                 | 90 ++++++++++++++++++---
 tests/mkfs-tests/001-basic-profiles/test.sh | 16 +++-
 3 files changed, 104 insertions(+), 28 deletions(-)

-- 
2.33.0

