Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323A620C63A
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jun 2020 07:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgF1FSr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jun 2020 01:18:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:52014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgF1FSr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jun 2020 01:18:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D7C0AEFB
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jun 2020 05:18:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 0/3] btrfs: allow btrfs_truncate_block() to fallback to nocow for data space reservation
Date:   Sun, 28 Jun 2020 13:18:36 +0800
Message-Id: <20200628051839.63142-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before this patch, btrfs_truncate_block() never checks the NODATACOW
bit, thus when we run out of data space, we can return ENOSPC for
truncate for NODATACOW inode.

This patchset will address this problem by doing the same behavior as
buffered write to address it.

Changelog:
v2:
- Rebased to misc-next
  Only one minor conflict in ctree.h

v3:
- Added two new patches
- Refactor check_can_nocow()
  Since the introduction of nowait, check_can_nocow() are in fact split
  into two usage patterns: check_can_nocow(nowait = false) with
  btrfs_drew_write_unlock(), and single check_can_nocow(nowait = true).
  Refactor them into two functions: start_nocow_check() paired with
  end_nocow_check(), and single try_nocow_check(). With comment added.

- Rebased to latest misc-next

- Added btrfs_assert_drew_write_locked() for btrfs_end_nocow_check()
  This is a little concerning one, as it's in the hot path of buffered
  write.
  It has percpu_counter_sum() called in that hot path, causing
  obvious performance drop for CONFIG_BTRFS_DEBUG build.
  Not sure if the assert is worthy since there aren't any other users.

v4:
- Rebased to latest misc-next

- Comment update to follow the relaxed kernel-doc format

- Re-order the patches
  So the fix comes first, then refactors.

- Naming updates for the refactor patch
  Now the exported pair is btrfs_check_nocow_lock() and
  btrfs_check_nocow_unlock().

- Remove the btrfs_assert_drew_write_lock()
  It's extremely slow for btrfs/187, and we only have two call sites so
  far, thus it's not really worthy.

v5:
- Fix a stupid bug that check_nocow_nolock() passes wrong bool

- Update the comment for btrfs_check_nocow_lock() as there is no
  "nowait" parameter anymore

v6:
- Replace one btrfs_drew_write_unlock() with the wrapper

Qu Wenruo (3):
  btrfs: allow btrfs_truncate_block() to fallback to nocow for data
    space reservation
  btrfs: add comments for btrfs_check_can_nocow() and can_nocow_extent()
  btrfs: refactor btrfs_check_can_nocow() into two variants

 fs/btrfs/ctree.h |  3 +++
 fs/btrfs/file.c  | 61 +++++++++++++++++++++++++++++++++++-----------
 fs/btrfs/inode.c | 63 +++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 104 insertions(+), 23 deletions(-)

-- 
2.27.0

