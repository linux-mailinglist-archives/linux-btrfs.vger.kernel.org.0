Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1159229F94C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgJ2X6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48939 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:02 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 65ED35C00DD;
        Thu, 29 Oct 2020 19:58:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=yh6veElIUoQL5dMqY16CKuI2sO
        d8qa7KgVTulaF/p9A=; b=AdjzcOh790r5BBiwyww6IZyCEpo/ETL6WU30FK6F6b
        8ulL+hULbKQ4I4LViyoJCveHs4qXw7KibNObCFk7gU/HL8cGxLdif2hiLJCs+Ps2
        HcMBZeqPcXbGJxzCJogdMNa4+dhyjf2Y9uL2a7Zd/UR61l0efQ/25bR6T+QTCtbH
        LKrVx9a5eTs5hS86UITZe+4HIy0B4KVEs92phxm134rBBXrWVrrWozct1AVFQd8i
        i/rOJ9iOJLkTtLSX8ue68//F3XjmviesjYQOZQBNgrwzPnhu3ZOYxdZ19TyTNDS5
        6LxQsV7Up67p7Y2WqMm9wROcys3oz+95RiW8+8EgJv6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yh6veElIUoQL5dMqY
        16CKuI2sOd8qa7KgVTulaF/p9A=; b=IfcQKAMrcydjlSBnYOfbwih5oWG54sUa2
        oIUUhS97165jAYOfaijYUkZkqNN3mBuiHT1Z6LPMa036z+vHq4pyZokGAB5LYwXy
        GJmBQ9B/arGlKw4pipgeNtyIWL7LywAm1H3xm8LhDmsCLGqQ2ho2aODADsKR1kmz
        Zo5aZ/h+WDkFssoX7tAx01Ky9aJvu193nOHMhZL1hsG9i13rXyOBW8e8k6yaNTtq
        /NtRPAUiTg4MS2FvBLI2McL71VeJX8whqDpEk/n1MipPH1nyS99H5SIArUVbyTvl
        HWlHj/lcG5LFtPn01kvSY/qxvbIiBA/20YhdcDTClfIw5j+WkCMbg==
X-ME-Sender: <xms:CVebX7yKMt4Pu2ZUZyKuG6LPROjsM-YC4AGBE47qeZ8KGu3uOi68iA>
    <xme:CVebXzQWcDm_BxySJv9AYakyYltG-RG-zI1e-XMLnwTWLjA16fboWk5Ei-DQ2QAdh
    LihFZWoOWllU5F-kXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrih
    ho
X-ME-Proxy: <xmx:CVebX1WE_K_TjAACBxTNr8BJBsPT6HFht2lc9dOj4aopfKzLH2dK8Q>
    <xmx:CVebX1giqMZUEsjFFrMSiw1o7bcNHyvhiRjlKPYwQg1PIlfSnEaMXw>
    <xmx:CVebX9Bz1dmmr7bAm36KlZ5EA6SC40thLNQy1mHh3Ra4M3yQa69CEA>
    <xmx:CVebX49bhfafJaOxWkND-hge7x6huCitiNF3pBNMTTbtsialXUyI0A>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8C94E328005E;
        Thu, 29 Oct 2020 19:58:00 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 00/10] btrfs: free space tree mounting fixes
Date:   Thu, 29 Oct 2020 16:57:47 -0700
Message-Id: <cover.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch set cleans up issues surrounding enabling and disabling various
free space cache features and their reporting in /proc/mounts.  Because the
improvements became somewhat complex, the series starts by lifting rw mount
logic into a single place.

The first patch is a setup patch that unifies very similar logic between a
normal rw mount and a ro->rw remount. This is a useful setup step for adding
more functionality to ro->rw remounts.

The second patch fixes the omission of orphan inode cleanup on a few trees
during ro->rw remount.

The third patch adds enabling the free space tree to ro->rw remount.

The fourth patch adds a method for clearing oneshot mount options after mount.

The fifth patch adds support for clearing the free space tree on ro->rw remount.

The sixth patch sets up for more accurate /proc/mounts by ensuring that
cache_generation > 0 iff space_cache is enabled.

The seventh patch is the more accurate /proc/mounts logic.

The eighth patch is a convenience kernel message that complains when we skip
changing the free space tree on remount.

The ninth patch removes the space cache v1 free space item and free space
inodes when space cache v1 is disabled (nospace_cache or space_cache=v2).

The tenth patch stops re-creating the free space objects when we are not
using space_cache=v1

changes for v6:
Rebase all patches on newer misc-next
Patch 1/10: Fix unnecessary re-ordering of discard resume and most of mount_rw.
Patch 2/10: No change.
Patch 3/10: No change.
Patch 4/10: Handle unclean rebase.
Patch 5/10: No change.
Patch 6/10: No change.
Patch 7/10: No change.
Patch 8/10: No change.
Patch 9/10: No change.
Patch 10/10: No change.

changes for v5:
Patch 1/10: No change.
Patch 2/10: No change.
Patch 3/10: No change.
Patch 4/10: New.
Patch 5/10: New.
Patch 6/10: Handles remounts for no<->v1. Was Patch 4.
Patch 7/10: No change. Was Patch 5
Patch 8/10: Warns/undoes flags on skipped clear as well as skipped create.
            Was Patch 6.
Patch 9/10: No change. Was Patch 7.
Patch 10/10: No change. Was Patch 8.

changes for v4:
Patch 1/8: New
Patch 2/8: New
Patch 3/8: (was Patch 1) Made much simpler by lifting of Patch 1. Simply add
           free space tree creation to lifted rw mount logic.
Patch 4/8: Split out from old Patch 2. Add an fs_info flag to avoid surprises
           when a different transaction updates the cache_generation.
Patch 5/8: Split out from old Patch 2, but no change logically.
Patch 6/8: Split out from old Patch 1. Formatting fixes.
Patch 7/8: (was Patch 3) Rely on delayed_iput running after orphan cleanup
           (setup in patch 2) to pull iputs out of mount path, per review.
Patch 8/8: No change.

changes for v3:
Patch 1/4: Change failure to warning logging.
Patch 2/4: New; fixes mount option printing.
Patch 3/4: Fix orphan inode vs. delayed iput bug, change remove function
           to take inode as a sink.
Patch 4/4: No changes.

changes for v2:
Patch 1/3: made remount _only_ work in ro->rw case, added comment.
Patch 2/3: added btrfs_ prefix to non-static function, removed bad
           whitespace.


Boris Burkov (10):
  btrfs: lift rw mount setup from mount and remount
  btrfs: cleanup all orphan inodes on ro->rw remount
  btrfs: create free space tree on ro->rw remount
  btrfs: clear oneshot options on mount and remount
  btrfs: clear free space tree on ro->rw remount
  btrfs: keep sb cache_generation consistent with space_cache
  btrfs: use sb state to print space_cache mount option
  btrfs: warn when remount will not change the free space tree
  btrfs: remove free space items when disabling space cache v1
  btrfs: skip space_cache v1 setup when not using it

 fs/btrfs/block-group.c      |  42 +-------
 fs/btrfs/ctree.h            |   3 +
 fs/btrfs/disk-io.c          | 195 +++++++++++++++++++++---------------
 fs/btrfs/disk-io.h          |   2 +
 fs/btrfs/free-space-cache.c | 121 ++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |   6 ++
 fs/btrfs/super.c            |  70 +++++++------
 fs/btrfs/transaction.c      |   2 +
 8 files changed, 286 insertions(+), 155 deletions(-)

-- 
2.24.1

