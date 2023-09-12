Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7079D0A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 14:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjILMEw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 08:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjILMEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 08:04:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4310D0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 05:04:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9714DC433CB
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 12:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694520278;
        bh=qpls9Im8qQr8gF64uTTMuIIvTSlrIHyTeHhiRk9OTo4=;
        h=From:To:Subject:Date:From;
        b=kIH5kuDiXVdS6y1q9Vr9MUpB6YAymk8YuYnB7g3Lb0vpk8aCHdsbbvxVE9Vd1qV6S
         KUIgwldBDZcTm0Yh5HQS1h5pqCZBsAR3m7ZP7jULudEg9nZq+uDJrD/2GHXs+imUh0
         NXy2RytGWtMOMZrqLXSnkTmkDcw4FpGUroCLREw4Lnhf+SAFT37VJRCEffdKJmUXLJ
         GNIHuv380h4vYjQLPsQS8QYnvZ8lkm97mIyg9ESfY81G3uVgMVVBSXj20TJHyWHXNg
         dECiJxnvKHsb0mjRX+Hw3eA9PFxsf2DNlgiqFwdcrRnNuBDrBoOhl4jv+g+58Q2xXi
         QfZUOL6i5tPyQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: some updates to btrfs_mark_buffer_dirty()
Date:   Tue, 12 Sep 2023 13:04:28 +0100
Message-Id: <cover.1694519543.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A few updates to btrfs_mark_buffer_dirty(), with the most important one
to not allow a transaction to commit when we know there's some corruption
due to marking an extent buffer as dirty when its generation does not
match the current transaction's generation. More details on the change
logs of each patch.

Filipe Manana (3):
  btrfs: abort transaction on generation mismatch when marking eb as dirty
  btrfs: use btrfs_crit at btrfs_mark_buffer_dirty()
  btrfs: mark transaction id check as unlikely at btrfs_mark_buffer_dirty()

 fs/btrfs/block-group.c               |   4 +-
 fs/btrfs/ctree.c                     | 109 +++++++++++++++------------
 fs/btrfs/ctree.h                     |  11 ++-
 fs/btrfs/delayed-inode.c             |   2 +-
 fs/btrfs/dev-replace.c               |   2 +-
 fs/btrfs/dir-item.c                  |   8 +-
 fs/btrfs/disk-io.c                   |  18 +++--
 fs/btrfs/disk-io.h                   |   3 +-
 fs/btrfs/extent-tree.c               |  36 +++++----
 fs/btrfs/file-item.c                 |  17 +++--
 fs/btrfs/file.c                      |  34 ++++-----
 fs/btrfs/free-space-cache.c          |   6 +-
 fs/btrfs/free-space-tree.c           |  17 +++--
 fs/btrfs/inode-item.c                |  16 ++--
 fs/btrfs/inode.c                     |  10 +--
 fs/btrfs/ioctl.c                     |   4 +-
 fs/btrfs/qgroup.c                    |  14 ++--
 fs/btrfs/relocation.c                |  10 +--
 fs/btrfs/root-tree.c                 |   4 +-
 fs/btrfs/tests/extent-buffer-tests.c |   6 +-
 fs/btrfs/tests/inode-tests.c         |  12 ++-
 fs/btrfs/tree-log.c                  |  12 +--
 fs/btrfs/uuid-tree.c                 |   6 +-
 fs/btrfs/volumes.c                   |  10 +--
 fs/btrfs/xattr.c                     |   8 +-
 25 files changed, 208 insertions(+), 171 deletions(-)

-- 
2.40.1

