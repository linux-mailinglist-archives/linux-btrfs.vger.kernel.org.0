Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC99D4AA000
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 20:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiBDT0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 14:26:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44896 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiBDT0J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 14:26:09 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B7B65210EF;
        Fri,  4 Feb 2022 19:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644002768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=K3Kzw0MnqE1dnpP4A1jw7HHxt97Lf7xlEuO78U2TV/g=;
        b=RBGeNJk0/PYMwN8Pkf47gqwlr6+i8iAj6zV6Xom5vULJc0WnKL68nil7ydzA68c0Vdn+bD
        CANFAJ+DNRDsugcr2trWR0/1+EFx7/dpjEMrjSehXN+zvR0Xd/WSbu5M89KRhCh6MRk2bB
        I0sbHsoaPrqyDrZQqZr66+23JJlgwZ8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AF3CAA3B87;
        Fri,  4 Feb 2022 19:26:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0B5BFDA781; Fri,  4 Feb 2022 20:25:22 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.17-rc3
Date:   Fri,  4 Feb 2022 20:25:22 +0100
Message-Id: <cover.1644001677.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few fixes and error handling improvements. Please pull, thanks.

* fix deadlock between quota disable and qgroup rescan worker

* fix use-after-free after failure to create a snapshot

* skip warning on unmount after log cleanup failure

* don't start transaction for scrub if the fs is mounted read-only

* tree checker verifies item sizes

----------------------------------------------------------------
The following changes since commit 27cdfde181bcacd226c230b2fd831f6f5b8c215f:

  btrfs: update writeback index when starting defrag (2022-01-24 18:16:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc2-tag

for you to fetch changes up to 40cdc509877bacb438213b83c7541c5e24a1d9ec:

  btrfs: skip reserved bytes warning on unmount after log cleanup failure (2022-01-31 16:06:50 +0100)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: fix use-after-free after failure to create a snapshot
      btrfs: skip reserved bytes warning on unmount after log cleanup failure

Qu Wenruo (1):
      btrfs: don't start transaction for scrub if the fs is mounted read-only

Shin'ichiro Kawasaki (1):
      btrfs: fix deadlock between quota disable and qgroup rescan worker

Su Yue (2):
      btrfs: tree-checker: check item_size for inode_item
      btrfs: tree-checker: check item_size for dev_item

Tom Rix (1):
      btrfs: fix use of uninitialized variable at rm device ioctl

 fs/btrfs/block-group.c  | 39 +++++++++++++++++++++++++++++++++++++--
 fs/btrfs/ctree.h        |  6 ++++++
 fs/btrfs/ioctl.c        |  7 ++-----
 fs/btrfs/qgroup.c       | 21 +++++++++++++++++++--
 fs/btrfs/transaction.c  | 24 ++++++++++++++++++++++++
 fs/btrfs/transaction.h  |  2 ++
 fs/btrfs/tree-checker.c | 15 +++++++++++++++
 fs/btrfs/tree-log.c     | 23 +++++++++++++++++++++++
 8 files changed, 128 insertions(+), 9 deletions(-)
