Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C232B21D3F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgGMKuz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 06:50:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbgGMKuz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 06:50:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 835C6AE53
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 10:50:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/3] btrfs: qgroup: Fix the long existing regression of btrfs/153
Date:   Mon, 13 Jul 2020 18:50:46 +0800
Message-Id: <20200713105049.90663-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have to"),
btrfs/153 always fails with early EDQUOT.

This is caused by the fact that:
- We always reserved data space for even NODATACOW buffered write
  This is mostly to improve performance, and not pratical to revert.

- Btrfs qgroup data and meta reserved space share the same limit
  So it's not ensured to return EDQUOT just for that data reservation,
  metadata reservation can also get EDQUOT, means we can't go the same
  solution as that commit.

This patchset will solve it by doing extra qgroup space flushing when
EDQUOT is hit.

This is a little like what we do in ticketing space reservation system,
but since there are very limited ways for qgroup to reclaim space,
currently it's still handled in qgroup realm, not reusing the ticketing
system yet.

By this, this patch could solve the btrfs/153 problem, while still keep
btrfs qgroup space usage under the limit.

The only cost is, when we're near qgroup limit, we will cause more dirty
inodes flush and transaction commit, much like what we do when the
metadata space is near exhausted.
So the cost should be still acceptable.

Changelog:
v2:
- Use existing ulist infrastructure
  Thanks to the advice from Josef, we can just iterate the ulist nodes
  inside the failure range to remove the offending nodes.
  And since already dirtied range won't show up in the current extent
  changeset, we won't clear existing range.
  This saves around 100 new lines

- Remove the use of "Revert" in the 3rd cleanup patch
  We're not reverting to fix some regression, but just remove some
  deprecated mechanism which was designed to partially solve the
  problem.

v3:
- Fix a variable shadowing bug 
  In the 2nd patch, there was a variable shadowing bug, which overrides
  the @start and @len parameter.

- Update the commit message for the first patch
  To make the cause more obvious

- Use cleaner if condition before try_flush_qgroup()

v4:
- Use rbtree_iterate_from_safe() wrapper to replace the while() loop
- Use proper variable names to replace single letter variable names
- Use proper btrfs_root bit with wait_queue_head to replace mutex

Qu Wenruo (3):
  btrfs: qgroup: allow btrfs_qgroup_reserve_data() to revert the range
    it just set without releasing other existing ranges
  btrfs: qgroup: try to flush qgroup space when we get -EDQUOT
  btrfs: qgroup: remove the ASYNC_COMMIT mechanism in favor of qgroup
    reserve retry-after-EDQUOT

 fs/btrfs/ctree.h       |   9 +-
 fs/btrfs/disk-io.c     |   2 +-
 fs/btrfs/qgroup.c      | 234 ++++++++++++++++++++++++++++++-----------
 fs/btrfs/transaction.c |   1 -
 fs/btrfs/transaction.h |  14 ---
 5 files changed, 175 insertions(+), 85 deletions(-)

-- 
2.27.0

