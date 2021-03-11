Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B03F3375C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 15:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhCKOb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 09:31:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233908AbhCKObX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 09:31:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D77FF64FD6;
        Thu, 11 Mar 2021 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615473082;
        bh=Pa+ckBg4vTPbYSYgH9cwBoSbRDY6L7gF0km5xxrIYuo=;
        h=From:To:Cc:Subject:Date:From;
        b=oS1vS5XIn1jeqHDfHV212oHgYxN2DeimytQrSHNkqcLJa3NCc2+dditu+c9oSma6Q
         EjooSNzFPLzduc832f+w/baLRnfe2/AEDBt19vbDD8LRIpjkU/T8trxeBhZXjyfFiT
         ESe1Z6UvcVaMJWjxNPLbgoUa1db4wzx36wLgk+9py5iURfp1DdxS778ONNX/nE644w
         CPJ+8Z5bV6y+BAozj1vu4kFqlNvBYICnB7tWXK4Bt8QHhzTUZbYMZp90UHQlaWrm72
         P+pAc+TTQsC4Vsr2DxOtynnyjK8o70q6Yilv6pWlVUB+KTh3/v8PcelfKZpC39sYbu
         5PJ+r6r/B5ZzQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/9] btrfs: bug fixes for the tree mod log and small refactorings
Date:   Thu, 11 Mar 2021 14:31:04 +0000
Message-Id: <cover.1615472583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset fixes a couple bugs, in the two first patches, with the tree
mod log code. The remaining patches just move all that code into a separate
file, since it's quite large and ctree.c is huge as well, and do some small
refactorings and cleanups.

One of the bugs in particular, has been hit frequently by Zygo, hitting a
BUG_ON().

Filipe Manana (9):
  btrfs: fix race when cloning extent buffer during rewind of an old
    root
  btrfs: always pin deleted leaves when there are active tree mod log
    users
  btrfs: move the tree mod log code into its own file
  btrfs: use booleans where appropriate for the tree mod log functions
  btrfs: use a bit to track the existence of tree mod log users
  btrfs: use the new bit BTRFS_FS_TREE_MOD_LOG_USERS at
    btrfs_free_tree_block()
  btrfs: remove unnecessary leaf check at btrfs_tree_mod_log_free_eb()
  btrfs: add and use helper to get lowest sequence number for the tree
    mod log
  btrfs: update debug message when checking seq number of a delayed ref

 fs/btrfs/Makefile       |   2 +-
 fs/btrfs/backref.c      |  33 +-
 fs/btrfs/ctree.c        | 954 ++--------------------------------------
 fs/btrfs/ctree.h        |  20 +-
 fs/btrfs/delayed-ref.c  |  31 +-
 fs/btrfs/extent-tree.c  |  21 +-
 fs/btrfs/qgroup.c       |   9 +-
 fs/btrfs/tree-mod-log.c | 912 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-mod-log.h |  53 +++
 9 files changed, 1056 insertions(+), 979 deletions(-)
 create mode 100644 fs/btrfs/tree-mod-log.c
 create mode 100644 fs/btrfs/tree-mod-log.h

-- 
2.28.0

