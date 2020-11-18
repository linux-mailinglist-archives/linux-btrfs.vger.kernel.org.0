Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C852B8816
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgKRXGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:24 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57727 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbgKRXGY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:24 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 373DFC14;
        Wed, 18 Nov 2020 18:06:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=yZ49RngZQKv/gleY1OHWHCW9WO
        e02Zv36lYBMTsdPLE=; b=dF2rKidMvGkNyllyO9CY+/cWgt8GyvpGgQJ9E9cKKD
        SXM4BH/apqYzWln8wVyWKU5nyX+ElHnRrt71XLSnDWODSWVbFetdKld7U6/wYfB2
        bgMXIzqmggeoRnbilULZ595knEd3O2SZbP4PLsFv5J5uH4a2qBljUPSEYtoYKe96
        JQf7M03G4I7M6pvrfh4q69zZpGgbfpJdlaGgZ/KFn8IQ9ouHkIa0+7Ey7NQjWnAt
        Q7i0Mim8e/AHu4zStVfzu04o2KBXq49Vj9ItppVmqKHibstP1nM28N0dLcxxfAAu
        NlO+Vn+t4+0tTGffRbFYRb2Qcg9v3S1Zwtd8tz5+vyfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yZ49RngZQKv/gleY1
        OHWHCW9WOe02Zv36lYBMTsdPLE=; b=lajbfgvuKsyNmA1TawJqx8dApZnmcSsYd
        L0evbDdCReuuSoD0gj35lhS3W/cGsjTyLh2N4oQSN6LiYefITasUpbfCZr3yXf/D
        oImC/vJnj/CXzhkYrNYYdqgu7aBch3RheGcq5XnHSEtFf7yohFgKuwq0jLd/BXgV
        PgArCVdMYxD9BfJNFHOJaRwMQj7W11pr55snggqNq1Y+J5pYowRYZoa875Io9qKV
        aihJXmtU7X/0+0mK0pdkQsT2IThIWG8Vaah2lje5WVIcvZMG+/n9UHA/ALNN/QnE
        OInRpAUieaGTkxGkk0Sp4vE3pZZOZpuRv8ZPbEFExmyT4+xACXR+A==
X-ME-Sender: <xms:_6i1X925eA9PaMlhY7XAUF5Bs3xont5tl7hMWwOrcYAme8pXqePa6A>
    <xme:_6i1X0HNFVMJvgfvcWRP82WhTxLJoNyJM839ZavT5sv5Y6hefJXEulSAJVMb_Adas
    joiikBUyCvcdyoNtgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucfkphepudeifedruddugedrudefvddrfeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:_6i1X94i_YOCK6d2EmZy9bc-worsySJODpxwrMM5kYQRcSepNT9pNA>
    <xmx:_6i1X624po39ktuopgOEfrFDfFB4S54lL1sDwwpglv6kCfayFDCvmw>
    <xmx:_6i1XwHUp5vevyW_kTETh0Bi5c2ovc8S-QYBFw-UWXRQt9v1KbONlg>
    <xmx:_6i1XzwHdLlpLSF690hC_8mOpTVaqNHarMQlkEzYg1gCsZHJK1GGZg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id A81693280059;
        Wed, 18 Nov 2020 18:06:38 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 00/10] btrfs: free space tree mounting fixes
Date:   Wed, 18 Nov 2020 15:06:15 -0800
Message-Id: <cover.1605736355.git.boris@bur.io>
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

The third patch stops marking block groups with need_free_space when the
free space tree is not yet enabled.

The fourth patch adds enabling the free space tree to ro->rw remount.

The fifth patch adds a method for clearing oneshot mount options after mount.

The sixth patch adds support for clearing the free space tree on ro->rw remount.

The seventh patch sets up for more accurate /proc/mounts by ensuring that
cache_generation > 0 iff space_cache is enabled.

The eigth patch is the more accurate /proc/mounts logic.

The ninth patch is a convenience kernel message that complains when we skip
changing the free space tree on remount.

The tenth patch removes the space cache v1 free space item and free space
inodes when space cache v1 is disabled (nospace_cache or space_cache=v2).

The eleventh patch stops re-creating the free space objects when we are not
using space_cache=v1

The twelfth patch fixes a lockdep failure in creating the free space tree.

changes for v7:
Rebase onto newer misc-next
Patch 1/12: No change.
Patch 2/12: No change.
Patch 3/12: New.
Patch 4/12: No change.
Patch 5/12: Moved unused cache_opt variable to patch 7.
Patch 6/12: No change.
Patch 7/12: Declare cache_opt here rather than Patch 5. Actually clear
clear_cache as in the patch description.
Patch 8/12: No change.
Patch 9/12: No change.
Patch 10/12: No change.
Patch 11/12: No change.
Patch 12/12: New.

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

Boris Burkov (12):
  btrfs: lift rw mount setup from mount and remount
  btrfs: cleanup all orphan inodes on ro->rw remount
  btrfs: only mark bg->needs_free_space if free space tree is on
  btrfs: create free space tree on ro->rw remount
  btrfs: clear oneshot options on mount and remount
  btrfs: clear free space tree on ro->rw remount
  btrfs: keep sb cache_generation consistent with space_cache
  btrfs: use sb state to print space_cache mount option
  btrfs: warn when remount will not change the free space tree
  btrfs: remove free space items when disabling space cache v1
  btrfs: skip space_cache v1 setup when not using it
  btrfs: fix lockdep error creating free space tree

 fs/btrfs/block-group.c      |  45 ++------
 fs/btrfs/ctree.h            |   3 +
 fs/btrfs/disk-io.c          | 205 +++++++++++++++++++++---------------
 fs/btrfs/disk-io.h          |   2 +
 fs/btrfs/free-space-cache.c | 121 +++++++++++++++++++++
 fs/btrfs/free-space-cache.h |   6 ++
 fs/btrfs/super.c            |  70 ++++++------
 fs/btrfs/transaction.c      |   2 +
 8 files changed, 294 insertions(+), 160 deletions(-)

-- 
2.24.1

