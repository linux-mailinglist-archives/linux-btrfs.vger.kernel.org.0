Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9BC2FA71
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfE3KnO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 06:43:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:49108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfE3KnO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 06:43:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E8B3ACEE;
        Thu, 30 May 2019 10:43:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04DA8DA85E; Thu, 30 May 2019 12:44:06 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.2-rc3
Date:   Thu, 30 May 2019 12:44:01 +0200
Message-Id: <cover.1559167316.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes for bugs reported by users, fuzzing tools and
regressions:

* fix crashes in relocation
  * resuming interrupted balance operation does not properly clean up
    orphan trees
  * with enabled qgroups, resuming needs to be more careful about
    block groups due to limited context when updating qgroups

* fsync and logging fixes found by fuzzing

* incremental send fixes for no-holes and clone

* fix spin lock type used in timer function for zstd

No merge conflicts, please pull. Thanks.

----------------------------------------------------------------
The following changes since commit 4e9845eff5a8027b5181d5bff56a02991fe46d48:

  Btrfs: tree-checker: detect file extent items with overlapping ranges (2019-05-16 14:33:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc2-tag

for you to fetch changes up to 06989c799f04810f6876900d4760c0edda369cf7:

  Btrfs: fix race updating log root item during fsync (2019-05-28 19:26:46 +0200)

----------------------------------------------------------------
Dennis Zhou (1):
      btrfs: correct zstd workspace manager lock to use spin_lock_bh()

Filipe Manana (5):
      Btrfs: incremental send, fix file corruption when no-holes feature is enabled
      Btrfs: incremental send, fix emission of invalid clone operations
      Btrfs: fix fsync not persisting changed attributes of a directory
      Btrfs: fix wrong ctime and mtime of a directory after log replay
      Btrfs: fix race updating log root item during fsync

Nikolay Borisov (1):
      btrfs: Ensure replaced device doesn't have pending chunk allocation

Qu Wenruo (2):
      btrfs: reloc: Also queue orphan reloc tree for cleanup to avoid BUG_ON()
      btrfs: qgroup: Check bg while resuming relocation to avoid NULL pointer dereference

 fs/btrfs/dev-replace.c | 35 +++++++++++++++++++++++----------
 fs/btrfs/inode.c       | 14 ++++++++++++--
 fs/btrfs/qgroup.c      |  8 +++++++-
 fs/btrfs/relocation.c  | 27 ++++++++++++++++++--------
 fs/btrfs/send.c        | 52 +++++++++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/tree-log.c    | 20 ++++++-------------
 fs/btrfs/zstd.c        | 20 +++++++++----------
 7 files changed, 128 insertions(+), 48 deletions(-)
