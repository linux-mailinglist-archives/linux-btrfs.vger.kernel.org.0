Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDEA3C63C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 21:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhGLTd2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 15:33:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44400 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhGLTd1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 15:33:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DD9741FFF7;
        Mon, 12 Jul 2021 19:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626118237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RW3R9SeQHG8573gc/MkdHYTv9cHBSypiXesl5DLdgYQ=;
        b=Zwu5Smxc/qWODS0Ga/WJGVeHEiO76SZwDdN05sq6vX1XZCBgpcCkyQRPMVVwMjpdLg0VrL
        n7KrV4Hl8plDkieVR/wYwmlF5hkJl9NMwpLYaQs/Cs0kNvEVUnT732RpAm9zhMo6ayvq0x
        OGL7wAOZ0tS2LdKgENsqsit3KvMjSGs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D59C2A3B85;
        Mon, 12 Jul 2021 19:30:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66A02DA790; Mon, 12 Jul 2021 21:28:01 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.14-rc2
Date:   Mon, 12 Jul 2021 21:28:00 +0200
Message-Id: <cover.1626115408.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following fixes, all are for the zoned mode support.
Thanks.

- fix deadlock when allocating system chunk

- fix wrong mutex unlock on an error path

- fix extent map splitting for append operation

- update and fix message reporting unusable chunk space

- don't block when background zone reclaim runs with balance in parallel

----------------------------------------------------------------
The following changes since commit 629e33a16809ae0274e1f5fc3d22b92b9bd0fdf1:

  btrfs: remove unused btrfs_fs_info::total_pinned (2021-06-22 19:58:26 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-rc1-tag

for you to fetch changes up to ea32af47f00a046a1f953370514d6d946efe0152:

  btrfs: zoned: fix wrong mutex unlock on failure to allocate log root tree (2021-07-07 18:27:44 +0200)

----------------------------------------------------------------
David Sterba (1):
      btrfs: zoned: fix types for u64 division in btrfs_reclaim_bgs_work

Filipe Manana (3):
      btrfs: fix deadlock with concurrent chunk allocations involving system chunks
      btrfs: rework chunk allocation to avoid exhaustion of the system chunk array
      btrfs: zoned: fix wrong mutex unlock on failure to allocate log root tree

Johannes Thumshirn (2):
      btrfs: zoned: print unusable percentage when reclaiming block groups
      btrfs: don't block if we can't acquire the reclaim lock

Naohiro Aota (1):
      btrfs: properly split extent_map for REQ_OP_ZONE_APPEND

 fs/btrfs/block-group.c | 367 ++++++++++++++++++++++++++++++++++++-------------
 fs/btrfs/block-group.h |   6 +-
 fs/btrfs/ctree.c       |  67 ++-------
 fs/btrfs/inode.c       | 147 ++++++++++++++++----
 fs/btrfs/transaction.c |  15 +-
 fs/btrfs/transaction.h |   9 +-
 fs/btrfs/tree-log.c    |   2 +-
 fs/btrfs/volumes.c     | 355 +++++++++++++++++++++++++++++++++++------------
 fs/btrfs/volumes.h     |   5 +-
 9 files changed, 687 insertions(+), 286 deletions(-)
