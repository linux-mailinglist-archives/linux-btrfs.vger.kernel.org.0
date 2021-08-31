Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D33FC515
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 11:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhHaJuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 05:50:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52124 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhHaJuC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 05:50:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00DAE221C7
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630403347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W892LH+49DnEaiUTc2wF4UpGB0FuS8x7MER/3GNxBX8=;
        b=ZJ4BsWPXkrWYuXP/zFLkpXdK4FptS1ZwpIcTaS8G/wS3JxSQSvg9A5NLRR3Y5yB25JY2XU
        dS1je+pTTgUsaHBLOy4MFX/s1TAgBoyQcXfEuRhAb55TcQWJB3c/ePSFrnatHQibw0UxDJ
        UpBpFUolYGroZDld7g5YaQz8BcrCbV8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 27FBE136DF
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id J60/NRH7LWGMcgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: qgroup: address the performance penalty for subvolume dropping
Date:   Tue, 31 Aug 2021 17:48:58 +0800
Message-Id: <20210831094903.111432-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
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

    This only affects subvolume dropping.

- Skip qgroup accounting when the numbers are already inconsistent

  But still keeps the qgroup relationship correct, thus users can keep
  its qgroup organization while do the rescan later.


This sysfs interface needs user space tools to monitor and set the
values for each btrfs.

Currently the target user space tool is snapper, which by default
utilizes qgroups for its space-aware snapshots reclaim mechanism.

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
 fs/btrfs/qgroup.c               |  87 +++++++++++++++++++-------
 fs/btrfs/qgroup.h               |   3 +
 fs/btrfs/sysfs.c                | 106 ++++++++++++++++++++++++++++++--
 include/uapi/linux/btrfs_tree.h |   4 ++
 6 files changed, 176 insertions(+), 26 deletions(-)

-- 
2.33.0

