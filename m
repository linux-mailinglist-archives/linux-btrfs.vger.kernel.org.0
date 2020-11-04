Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005DC2A62E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 12:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKDLHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 06:07:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgKDLHh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Nov 2020 06:07:37 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAAB821556
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 11:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604488057;
        bh=zTh0DS6Qo8YhgB2qBglJcgHeGhYucMyBjtNYt9HmMgg=;
        h=From:To:Subject:Date:From;
        b=u+6wqWfp9QgdjurFxo3lsyA/2ZXhmVDvLgBvKu6B1Cj78FnG2O7yVWAQHmWmcADnj
         oEp/rj87dLRLIqUE2SSjPKAE3IqrhnNLNVJ+g97RRc88D68YB/EXDk6bf/VW6m/GQ7
         Ti8tLUSDbWoWyQtXvhlF/XIeqLZM9U39gVyJtIb0=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: fix cases of stat(2) reporting incorrect number of used blocks
Date:   Wed,  4 Nov 2020 11:07:30 +0000
Message-Id: <cover.1604486892.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There are several cases where a stat(2) call can report an incorrect number
of used blocks. In some cases can even result in reporting 0 used blocks,
which is a specially bad value to report when a file is not empty, and we
had user bug reports in the past for such cases (the changelogs in the
patches point to one such report).

This patchset addresses all those cases. The third patch fixes a race in
defrag that while it does not result in a functional problem (data loss
or some corruption), it leads to unnecessary IO and space allocation,
and it's necessary for the 4th and final patch to work as it is.

A couple test cases for fstests will follow.

Filipe Manana (4):
  btrfs: fix missing delalloc new bit for new delalloc ranges
  btrfs: refactor btrfs_drop_extents() to make it easier to extend
  btrfs: fix race when defragging that leads to unnecessary IO
  btrfs: update the number of bytes used by an inode atomically

 fs/btrfs/btrfs_inode.h       |   3 +-
 fs/btrfs/ctree.h             |  71 ++++++++--
 fs/btrfs/extent-io-tree.h    |  16 ++-
 fs/btrfs/extent_io.c         |  10 +-
 fs/btrfs/file.c              | 246 +++++++++++++++--------------------
 fs/btrfs/inode.c             | 233 +++++++++++++++++++++++++++------
 fs/btrfs/ioctl.c             |  39 ++++++
 fs/btrfs/reflink.c           |   9 +-
 fs/btrfs/tests/inode-tests.c |  12 +-
 fs/btrfs/tree-log.c          |  32 +++--
 10 files changed, 458 insertions(+), 213 deletions(-)

-- 
2.28.0

