Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB7B17C4E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 18:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgCFRuE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 12:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgCFRuE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Mar 2020 12:50:04 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DF2B20656;
        Fri,  6 Mar 2020 17:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583517004;
        bh=v6j0WUDNIptlnOxtQuTOYCbQXGZBMLy6HNoIQXH4pdU=;
        h=From:To:Cc:Subject:Date:From;
        b=RexinD8eQBxdcUv2f6bP1A2Q4R9xzQXFmX8c8PDRd0Y2R+cH+BZFGvGVqqf7aKB0c
         oG+sKDa7N4ZDtf+A85gX6i6wiZnUUyeJJ+oi+GYkmBT0xt0ttGiujsaM6txsjYMxl+
         /CdBZ33wkDzEVnNxfXhOqSy1Kn5sX2JCTzWpkt4E=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH v2 0/4] Btrfs: make ranged fsyncs always respect the given range
Date:   Fri,  6 Mar 2020 17:50:01 +0000
Message-Id: <20200306175001.27778-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset fixes a bug when not using NO_HOLES and makes ranged fsyncs
respect the given file range when using the NO_HOLES feature.

The bug is about missing file extents items representing a hole after doing
a ranged fsync on a file and replaying the log.

Btrfs doesn't respect the given range for a fsync when the inode's has the
"need full sync" bit set - it treats the fsync as a full ranged one, operating
on the whole file, doing more IO and cpu work then needed.

That behaviour was needed to fix a corruption bug. Commit 0c713cbab6200b
("Btrfs: fix race between ranged fsync and writeback of adjacent ranges")
fixed that bug by turning the ranged fsync into a full one.

Later the hole detection code of fsync was simplified a lot in order to
fix another bug when using the NO_HOLES feature - done by commit
0e56315ca147b3 ("Btrfs: fix missing hole after hole punching and fsync when
using NO_HOLES").

That commit now makes it easy to avoid turning the ranged fsyncs into
non-ranged fsyncs. This patchset does that. The first patch fixes the bug
mentioned before, patches 2 and 3 are preparation cleanups for patch 4,
which is the one that makes fsync respect the given file range.

V2: Added one more patch to the series, which is the first patch, that
    fixes the bug regarding missing holes after doing a ranged fsync.

    The remaining patches remain the same, only patch 4 had a trivial
    conflict when rebasing against patch 1 and got its changelog
    updated. Now all fstests pass with version 2 of this patchset.

Filipe Manana (4):
  Btrfs: fix missing file extent item for hole after ranged fsync
  Btrfs: add helper to get the end offset of a file extent item
  Btrfs: factor out inode items copy loop from btrfs_log_inode()
  Btrfs: make ranged full fsyncs more efficient

 fs/btrfs/ctree.h     |   1 +
 fs/btrfs/file-item.c |  40 ++++--
 fs/btrfs/file.c      |  11 +-
 fs/btrfs/inode.c     |  10 +-
 fs/btrfs/send.c      |  44 +-----
 fs/btrfs/tree-log.c  | 379 +++++++++++++++++++++++++++++----------------------
 6 files changed, 255 insertions(+), 230 deletions(-)

-- 
2.11.0

