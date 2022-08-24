Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5F59F0AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 03:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiHXBOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 21:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiHXBOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 21:14:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D696CD30
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 18:14:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5262722622
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 01:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661303668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Opm0mf4JdBU2PEuwxtv6DpjOsuCrX5FjihVc2NJqKjQ=;
        b=M5DRHEUAS5fqW5YjJCoJapEnTOHbYRGfw/5fHWnKuvoP3jijdBWzoqT27wId0YuDit/J77
        XSqNHtK5ZxlaFDod2SAQq+AvU2xjPbGJqcGOvc8o45HQkE1iQIeCBcicRfVeaFR4ZcDtHv
        +jrLegkkfnSwU/IOFg0hBwttdZMQo4c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A3CD13A89
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 01:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8DnME3N7BWNnWAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 01:14:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/5] btrfs: qgroup: address the performance penalty for subvolume dropping
Date:   Wed, 24 Aug 2022 09:14:04 +0800
Message-Id: <cover.1661302005.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
v4:
- Fix a kmalloc() usage, which can lead to kobject warnings
  Since kobject_init_and_add() relies on certain values of a member,
  kmalloc() can leave kobj->state_initialized to be true, and cause
  crash at qgroups_kobj initialization time.

- Add a script in the cover letter to verify the behavior
  Will later be submitted as a test case.

v3:
- Rebased to latest misc-next

v2:
- Split /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags into two
  entries

- Update the cover letter to explain the drop_subtree_threshold better


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

All the behavior can be verified using the following simple script:

        btrfs dev scan -u
        mkfs.btrfs -U $fsid -f -n 4k $dev
        mount $dev $mnt
        btrfs subv create $mnt/subv

	# Bump the tree level to 2
        for (( i = 0; i < 8192; i++)); do
                xfs_io -f -c "pwrite 0 2k" $mnt/subv/inline1_$i > /dev/null
                xfs_io -f -c "pwrite 0 2k" $mnt/subv/inline2_$i > /dev/null
                xfs_io -f -c "pwrite 0 4k" $mnt/subv/regular_$i > /dev/null
        done
        sync
        btrfs subv snapshot $mnt/subv $mnt/snap
        btrfs quota enable $mnt
        btrfs quota rescan -w $mnt
        echo 2 > /sys/fs/btrfs/<fsid>/qgroups/drop_subtree_threshold
        btrfs subv delete $mnt/snap
        btrfs subv sync $mnt

After above workload, btrfs qgroup show should give the following
warning:

  WARNING: qgroup data inconsistent, rescan recommended

This sysfs interface needs user space tools to monitor and set the
values for each btrfs.
And it's also user space daemon's responsibility to save the
drop_subtree_threshold values.

As introducing a new on-disk format just for qgroup is a little
overkilled to an optional feature to me.

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
 fs/btrfs/qgroup.c               |  84 ++++++++++++++++++------
 fs/btrfs/qgroup.h               |   3 +
 fs/btrfs/sysfs.c                | 112 ++++++++++++++++++++++++++++++--
 include/uapi/linux/btrfs_tree.h |   4 ++
 6 files changed, 180 insertions(+), 25 deletions(-)

-- 
2.37.2

