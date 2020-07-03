Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4223E213405
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 08:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgGCGTJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 02:19:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:49826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCGTJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 02:19:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D02CAFF0
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jul 2020 06:19:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: qgroup: Fix the long existing regression of btrfs/153
Date:   Fri,  3 Jul 2020 14:18:59 +0800
Message-Id: <20200703061902.33350-1-wqu@suse.com>
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

Qu Wenruo (3):
  btrfs: qgroup: Allow btrfs_qgroup_reserve_data() to revert
    EXTENT_QGROUP_RESERVED bits when it fails
  btrfs: qgroup: Try to flush qgroup space when we get -EDQUOT
  btrfs: qgroup: remove the ASYNC_COMMIT mechanism in favor of qgroup 
    reserve retry-after-EDQUOT

 fs/btrfs/ctree.h       |   6 +-
 fs/btrfs/disk-io.c     |   2 +-
 fs/btrfs/qgroup.c      | 242 ++++++++++++++++++++++++++++++-----------
 fs/btrfs/transaction.c |   1 -
 fs/btrfs/transaction.h |  14 ---
 5 files changed, 180 insertions(+), 85 deletions(-)

-- 
2.27.0

