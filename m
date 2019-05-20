Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3C23DD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 18:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390229AbfETQvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 12:51:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:56658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388598AbfETQvw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 12:51:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86AA1AF99;
        Mon, 20 May 2019 16:51:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2D85DA86C; Mon, 20 May 2019 18:52:48 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.2-rc2
Date:   Mon, 20 May 2019 18:52:43 +0200
Message-Id: <cover.1558370339.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

the branch contains fixes, notable hilights:

* fixes for some long-standing bugs in fsync that were quite hard to
  catch but now finaly fixed

* some fixups to error handling paths that did not properly clean up
  (locking, memory)

* fix to space reservation for inheriting properties

No merge conflicts, please pull. Thanks.

----------------------------------------------------------------
The following changes since commit b1c16ac978fd40ae636e629bb69a652df7eebdc2:

  btrfs: Use kvmalloc for allocating compressed path context (2019-05-02 13:48:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc1-tag

for you to fetch changes up to 4e9845eff5a8027b5181d5bff56a02991fe46d48:

  Btrfs: tree-checker: detect file extent items with overlapping ranges (2019-05-16 14:33:51 +0200)

----------------------------------------------------------------
Filipe Manana (4):
      Btrfs: do not abort transaction at btrfs_update_root() after failure to COW path
      Btrfs: avoid fallback to transaction commit during fsync of files with holes
      Btrfs: fix race between ranged fsync and writeback of adjacent ranges
      Btrfs: tree-checker: detect file extent items with overlapping ranges

Johnny Chang (1):
      btrfs: Check the compression level before getting a workspace

Josef Bacik (2):
      btrfs: don't double unlock on error in btrfs_punch_hole
      btrfs: use the existing reserved items for our first prop for inheritance

Qu Wenruo (1):
      btrfs: extent-tree: Fix a bug that btrfs is unable to add pinned bytes

Tobin C. Harding (2):
      btrfs: sysfs: Fix error path kobject memory leak
      btrfs: sysfs: don't leak memory when failing add fsid

 fs/btrfs/compression.c  |  1 +
 fs/btrfs/extent-tree.c  | 15 ++++++++-------
 fs/btrfs/file.c         | 16 +++++++++++++---
 fs/btrfs/props.c        | 30 ++++++++++++++++++++++--------
 fs/btrfs/root-tree.c    |  4 +---
 fs/btrfs/sysfs.c        |  7 ++++++-
 fs/btrfs/tree-checker.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/tree-log.c     |  1 +
 8 files changed, 97 insertions(+), 26 deletions(-)
