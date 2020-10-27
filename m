Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13E329CAEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832052AbgJ0VIS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:08:18 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35039 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502171AbgJ0VIS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:08:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 25C365C00C2;
        Tue, 27 Oct 2020 17:08:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=ciQIw/n/IU7j+OwI1IsETDKUqF
        6O163dXqyY5SLQF5A=; b=CXiwWbEClSszMCRa2W0/baGj8S1UEd6c4pNfd4+eCo
        G2p+rx+xSxIoJ9KQpAiqkNDRKFpNGiaYvzUaf/vgLZl/VC9rn/niTxObZm5v0+h5
        GPL1gkCVnSoBtEqSficnrbXDjivRZEiWPs7zLF0LjbFKfN7gO8wXfAEb4XnUl0uO
        ohnOzFXf+1rFITvrVVdYdoLqDuukDKkquqTB8pF0SQr44nDGlCviAIz4u5Ze/XmU
        J0FH608exlzmy4MnDIloLw2DDPlW/i+xOAFLS9As4BYqq9veYfkoTeK1TdDKiKno
        9k4C4AW/MNCpr2LYmAJ5w8X4CFXW4cWuwipnFdYaORwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ciQIw/n/IU7j+OwI1
        IsETDKUqF6O163dXqyY5SLQF5A=; b=FodtZWBT0Q3Debm2afMwZng3GdQz4vpwX
        zTwgx4Hg3GjsDQzxPLduyzQ/J2xaRUNLwA1vCeymUgIwL5IP1rLpewQjt/0R8Xxn
        I/kZ1WFzmaQ0GCUnbHjzcIsjr42JVTAYEcw9s18PjlGz/Iemahw7KiNj1eixtJQR
        3NKsVYEg5heoBTvvfTa+Dh8hve9h2jmnuEh0vchwEnbC2yw7bu3TYSjHyjeCSKzq
        FDNTIrqgV6yAQV6KAlaPrTs0TyuyvAyR5miWmRYEFZ49VwGvff/vcT5z3JWyF3UN
        yLq/1icP8sdDsJIpdY/GbEEh7Biaz09e/MZ5GK/a7rJOaSxh9CNvg==
X-ME-Sender: <xms:QIyYX7zioGeb-5p8TbHz3ixoqxg0g0yD_w8KBJTD9c0Yp1n6_PP7ZQ>
    <xme:QIyYXzSOewBKm6RUsANYVC33x-eTvcAJtDJcKs4SJ-b_0GXdMXesRMUEHwyxj-drn
    PNYsqX9WNBHuSyCTZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucfgmhhpthihuchsuhgsjhgvtghtucdluddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehu
    rhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtle
    euieejfeelffevleeifefgjeejieegkeduudetfeekffeftefhvdejveenucfkphepudei
    fedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:QIyYX1Wcrl25VrupIetwsvOjHh_0kM42nsmWys6K67iOLVcN4g00aw>
    <xmx:QIyYX1haDN2IBdmIxdUzGvM5gqiHpJ18oH2gFHLjXNEzkzEO3RuZIw>
    <xmx:QIyYX9BL0QxCsGhdbnaOZ2Pz0B189D9fFSJFRHIYgRQLNdiVDOG1-A>
    <xmx:QYyYXwoPMRJ8UcKGR8VIUlhkOchgF6AxvNCL2fw4YRd0I_k4u6xpDA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id B478C3064682;
        Tue, 27 Oct 2020 17:08:15 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: 
Date:   Tue, 27 Oct 2020 14:07:54 -0700
Message-Id: <cover.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Subject: [PATCH v5 00/10] btrfs: free space tree mounting fixes

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
 fs/btrfs/disk-io.c          | 203 ++++++++++++++++++++----------------
 fs/btrfs/disk-io.h          |   2 +
 fs/btrfs/free-space-cache.c | 121 +++++++++++++++++++++
 fs/btrfs/free-space-cache.h |   6 ++
 fs/btrfs/super.c            |  70 ++++++-------
 fs/btrfs/transaction.c      |   2 +
 8 files changed, 287 insertions(+), 162 deletions(-)

-- 
2.24.1

