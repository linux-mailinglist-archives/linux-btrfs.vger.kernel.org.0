Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A9156B288
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 08:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiGHGHx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 02:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiGHGHw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 02:07:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F51277B
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 23:07:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 39C9B1FEDD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 06:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657260470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vAAiSc5Qtd17mBL0FCh6zlLTn9KYpdSGbj6AmibLu/s=;
        b=OMi3n+NZA7hK9pNVpUuVIS+piEdY1FegwfC1D3qNN60L0AFe0y8gq5gmSgsbgXwM/InyDX
        v0K31ZDEB/LcyDnjbSLU2YFDE7KISGEKDeoPx2ABgALP4DcPmMV4CezIHQh1DD2St1rrGY
        gGhCQrhx3iYx9epw4Q1p6Gezuas4uGo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8089413A80
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 06:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NteaErXJx2KUcgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 06:07:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/5]  btrfs: qgroup: address the performance penalty for subvolume dropping
Date:   Fri,  8 Jul 2022 14:07:25 +0800
Message-Id: <cover.1657260271.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Changelog:
v2:
- Split /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags into two
  entries

- Update the cover letter to explain the drop_subtree_threshold better

v3:
- Rebased to latest misc-next

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
2.36.1

