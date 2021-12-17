Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B347961F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 22:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhLQVTt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 16:19:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57680 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLQVTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 16:19:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0CA761F394;
        Fri, 17 Dec 2021 21:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639775988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AKWJYbPYNpbWTxZMffWahj22ArP1wNrhDJN3ZuIxhhE=;
        b=poboJ8hawWCy8WFXDLhVxVC3LfXCfNVGYz1FpY9+8cIeZWlZbs5/thFPxNd2H2Pl/zzoQe
        s+DtdiIOVRTUBnKeZSbCkxh2g/3KIhDrtMQJgxMaZFWELG00Us8R6V4HGtAvaThbzdALFs
        qc1qjH2kWh84KRrjBLhVLItKflIwKuo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0523EA3B81;
        Fri, 17 Dec 2021 21:19:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1C848DA781; Fri, 17 Dec 2021 22:19:27 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.16-rc6
Date:   Fri, 17 Dec 2021 22:19:27 +0100
Message-Id: <cover.1639775076.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

still there are a few more fixes, almost all error handling one-liners
and for stable.  Please pull, thanks.

* regression fix in directory logging items

* regression fix of extent buffer status bits handling after an error

* fix memory leak in error handling path in tree-log

* fix freeing invalid anon device number when handling errors during
  subvolume creation

* fix warning when freeing leaf after subvolume creation failure

* fix missing blkdev put in device scan error handling

* fix invalid delayed ref after subvolume creation failure

----------------------------------------------------------------
The following changes since commit 8289ed9f93bef2762f9184e136d994734b16d997:

  btrfs: replace the BUG_ON in btrfs_del_root_ref with proper error handling (2021-12-08 15:45:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc5-tag

for you to fetch changes up to 4989d4a0aed3fb30f5b48787a689d7090de6f86d:

  btrfs: fix missing blkdev_put() call in btrfs_scan_one_device() (2021-12-15 17:07:34 +0100)

----------------------------------------------------------------
Filipe Manana (4):
      btrfs: fix double free of anon_dev after failure to create subvolume
      btrfs: fix missing last dir item offset update when logging directory
      btrfs: fix invalid delayed ref after subvolume creation failure
      btrfs: fix warning when freeing leaf after subvolume creation failure

Jianglei Nie (1):
      btrfs: fix memory leak in __add_inode_ref()

Josef Bacik (1):
      btrfs: check WRITE_ERR when trying to read an extent buffer

Shin'ichiro Kawasaki (1):
      btrfs: fix missing blkdev_put() call in btrfs_scan_one_device()

 fs/btrfs/ctree.c           | 17 +++++++++--------
 fs/btrfs/ctree.h           |  7 ++++++-
 fs/btrfs/disk-io.c         |  8 ++++++++
 fs/btrfs/extent-tree.c     | 13 +++++++------
 fs/btrfs/extent_io.c       |  8 ++++++++
 fs/btrfs/free-space-tree.c |  4 ++--
 fs/btrfs/ioctl.c           | 10 ++++++----
 fs/btrfs/qgroup.c          |  3 ++-
 fs/btrfs/tree-log.c        |  2 ++
 fs/btrfs/volumes.c         |  6 ++++--
 10 files changed, 54 insertions(+), 24 deletions(-)
