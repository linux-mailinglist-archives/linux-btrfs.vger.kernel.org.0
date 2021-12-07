Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1346AF98
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 02:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbhLGBUr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 20:20:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60558 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhLGBUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 20:20:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E73041FD54
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 01:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638839833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Y3UpDdixDfxOtw7XB9CwH8T3o0vN0Q4Fr4Ua0zuoSRE=;
        b=ue2iC2Tu2GXtWcT3YqwP5ivnoq/T4H1ECiMcj4DKN6LYkOWBkS+flT+c4DVRV9jAIdSf6N
        ShxSBvf1tBGt5xYUeVO5YYSitGfBHb/WWzUyR8eBw6t9q8BP6h1hY69uK5D2r4LhL5xccY
        OikwHoU4pezpHbKyYd2wvoPGuuY6etU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FDB113A5C
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 01:17:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j3xtAhm2rmE8LQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Dec 2021 01:17:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs: qgroup: address the performance penalty for subvolume dropping
Date:   Tue,  7 Dec 2021 09:16:50 +0800
Message-Id: <20211207011655.21579-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs qgroup has a long history of bringing huge performance penalty,
from subvolume dropping to balance.

Although we solved the problem for balance, but the subvolume dropping
problem is still unresolved, as we really need to do all the costly
backref for all the involved subtrees, or qgroup numbers will be
inconsistent.

But the performance penalty is sometimes too big, so big that it's
better just to disable qgroup, do the drop, then do the rescan.

This patchset will address the problem by introducing a user
configurable sysfs interface, to allow certain high subtree dropping to
mark qgroup inconsistent, and skip the whole accounting.

The following things are needed for this objective:

- New qgroups attributes

  Instead of plain qgroup kobjects, we need extra attributes like
  drop_subtree_threshold.

  This patchset will introduce two new attributes to the existing
  qgroups kobject:
  * qgroups_flags
    To indicate the qgroup status flags like ON, RESCAN, INCONSISTENT.

  * drop_subtree_threshold
    To show the subtree dropping level threshold.
    The default value is BTRFS_MAX_LEVEL (8), which means all subtree
    dropping will go through the qgroup accounting, while costly it will
    try to keep qgroup numbers as consistent as possible.

    Users can specify values like 3, meaning any subtree which is at
    level 3 or higher will mark qgroup inconsistent and skip all the
    costly accounting.

    NOTE: if a snapshot is create with tree root level 3, dropping the
    snapshot with drop_subtree_threshold 3 will not mark the qgroup
    inconsistent.
    Since the level threshold is for shared subtree node, not the
    snapshot root node.

    In the case of newly created snapshot, only its (root level - 1)
    tree blocks are shared subtrees.

    This only affects subvolume dropping.

- Skip qgroup accounting when the numbers are already inconsistent

  But still keeps the qgroup relationship correct, thus users can keep
  its qgroup organization while do the rescan later.


This sysfs interface needs user space tools to monitor and set the
values for each btrfs.
And it's also user space daemon's responsibility to save the
drop_subtree_threshold values.

As introducing a new on-disk format just for qgroup is a little
overkilled to an optional feature to me.

Currently the target user space tool is snapper, which by default
utilizes qgroups for its space-aware snapshots reclaim mechanism.

Changelog:
v2:
- Split /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags into two
  entries

- Update the cover letter to explain the drop_subtree_threshold better

Qu Wenruo (5):
  btrfs: sysfs: introduce qgroup global attribute groups
  btrfs: introduce BTRFS_QGROUP_STATUS_FLAGS_MASK for later expansion
  btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN
  btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip
    qgroup accounting
  btrfs: skip subtree scan if it's too high to avoid low stall in
    btrfs_commit_transaction()

 fs/btrfs/ctree.h                |   1 +
 fs/btrfs/disk-io.c              |   1 +
 fs/btrfs/qgroup.c               |  87 ++++++++++++++++++-------
 fs/btrfs/qgroup.h               |   3 +
 fs/btrfs/sysfs.c                | 112 ++++++++++++++++++++++++++++++--
 include/uapi/linux/btrfs_tree.h |   4 ++
 6 files changed, 182 insertions(+), 26 deletions(-)

-- 
2.34.1

