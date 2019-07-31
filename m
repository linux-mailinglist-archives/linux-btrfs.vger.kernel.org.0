Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACB87BE4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfGaKX6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 06:23:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:32892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728098AbfGaKX6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 06:23:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 690FBAE6D
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2019 10:23:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/3] btrfs: qgroup: Pause and resume qgroup for subvolume removal
Date:   Wed, 31 Jul 2019 18:23:49 +0800
Message-Id: <20190731102352.6028-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs qgroup has one big performance overhead for certain snapshot drop.

Current btrfs_drop_snapshot() will try its best to find the highest
shared node, and just drop one ref of that common node.
This behavior is good for minimize extent tree modification, but a
disaster for qgroup.

Example:
      Root 300  Root 301
        A         B
        | \     / |
        |    X    |
        | /     \ |
        C         D
      /   \     /   \
     E     F    G    H
    / \   / \  / \   / \
   I   J K  L  M  N O   P

In above case, if we're dropping root 301, btrfs_drop_snapshot() will
only drop one ref for tree block C and D.

But for qgroup, tree blocks E~P also have their owner changed, from
300, 301 to 300 only.

Currently we use btrfs_qgroup_trace_subtree() to manually re-dirty tree
block E~P. And since such ref change happens in one transaction for each
ref drop, we can't split the overhead to different transactions.

This could cause qgroup extent record flood, hugely damage performance
or even cause OOM for too many qgroup extent records.


Unfortunately unlike previous qgroup + balance optimization, we can't
really do much to help.
So to make the problem less obvious, let's just pause qgroup and resume
it for snapshot drop, and queue a rescan automatically.

For independent subvolume or small snapshot, we don't really need to do
such pause/rescan workaround, as regular per-tree-block dropping is
pretty qgroup friendly.

Qu Wenruo (3):
  btrfs: Refactor btrfs_clean_one_deleted_snapshot() to use fs_info
    other than root
  btrfs: qgroup: Introduce quota pause infrastrucutre
  btrfs: Pause and resume qgroup for snapshot drop

 fs/btrfs/ctree.h       |  3 +-
 fs/btrfs/disk-io.c     |  9 ++---
 fs/btrfs/extent-tree.c | 13 ++++++-
 fs/btrfs/qgroup.c      | 79 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/qgroup.h      |  3 ++
 fs/btrfs/relocation.c  |  4 +--
 fs/btrfs/transaction.c |  8 ++---
 fs/btrfs/transaction.h |  2 +-
 8 files changed, 106 insertions(+), 15 deletions(-)

-- 
2.22.0

