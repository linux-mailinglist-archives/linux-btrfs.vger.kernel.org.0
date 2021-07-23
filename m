Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF63D4118
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhGWTHm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 15:07:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50422 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhGWTHl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 15:07:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9053F220C7;
        Fri, 23 Jul 2021 19:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627069693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JzNDHNw6jpOjTMcIGbGOMoNsDs1xXc5Ogv+24S1ygOs=;
        b=ANCDT7cEUOLQwyFZxOnIgXK8exC37K9XE5sdfxMooHt1yYljWkw4c6A6Yrfs1oOvDlDE3+
        QPJtGHXkoWFx5tDEIl4hBSjGVuq9Lk2Zoi4Exs4nktqbaVkmIDsw1DffCSvEicoSVQKGtn
        yoyD5Tpxp/5cm6226wk9GE9Vi/NHox8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 88DA3A3B88;
        Fri, 23 Jul 2021 19:48:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42A34DA8EB; Fri, 23 Jul 2021 21:45:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.14-rc3
Date:   Fri, 23 Jul 2021 21:45:29 +0200
Message-Id: <cover.1627068865.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few fixes and one patch to help some block layer API cleanups.
Please pull, thanks.

* skip missing device when running fstrim

* fix unpersisted i_size on fsync after expanding truncate

* fix lock inversion problem when doing qgroup extent tracing

* replace bdgrab/bdput usage, replace gendisk by block_device

----------------------------------------------------------------
The following changes since commit ea32af47f00a046a1f953370514d6d946efe0152:

  btrfs: zoned: fix wrong mutex unlock on failure to allocate log root tree (2021-07-07 18:27:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-rc2-tag

for you to fetch changes up to c7c3a6dcb1efd52949acc1e640be9aad1206a13a:

  btrfs: store a block_device in struct btrfs_ordered_extent (2021-07-22 15:50:15 +0200)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: check for missing device in btrfs_trim_fs

Christoph Hellwig (1):
      btrfs: store a block_device in struct btrfs_ordered_extent

Filipe Manana (2):
      btrfs: fix unpersisted i_size on fsync after expanding truncate
      btrfs: fix lock inversion problem when doing qgroup extent tracing

 fs/btrfs/backref.c            |  6 +++---
 fs/btrfs/backref.h            |  3 ++-
 fs/btrfs/delayed-ref.c        |  4 ++--
 fs/btrfs/extent-tree.c        |  3 +++
 fs/btrfs/inode.c              |  2 +-
 fs/btrfs/ordered-data.c       |  2 --
 fs/btrfs/ordered-data.h       |  3 +--
 fs/btrfs/qgroup.c             | 38 ++++++++++++++++++++++++++++++--------
 fs/btrfs/qgroup.h             |  2 +-
 fs/btrfs/tests/qgroup-tests.c | 20 ++++++++++----------
 fs/btrfs/tree-log.c           | 31 ++++++++++++++++++++++---------
 fs/btrfs/zoned.c              | 12 ++++--------
 12 files changed, 79 insertions(+), 47 deletions(-)
