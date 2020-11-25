Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1F32C3FC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 13:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgKYMTe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Nov 2020 07:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgKYMTc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Nov 2020 07:19:32 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 749B5206E5
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606306771;
        bh=a/ZTMT8dMKrBiD25skfWYlwWyLF0CciBCKLGWyTNKy4=;
        h=From:To:Subject:Date:From;
        b=nT+ZOvQPBMEVxeG6iGHACZVO+htTsUISVWnvst7oaoVjLZR85c7N4z08vcAddQfZ+
         0+JC5b+Wz9ZDOVyb1vfW1yb25YVk+DXN2tv+laAA1JMXtKr7ZuZLqoHus+04tMD/uw
         xdtAJx4XPWAXpDz0qQx9deVWQjkvoVK+pflcM3aE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: some performance improvements for dbench alike workloads
Date:   Wed, 25 Nov 2020 12:19:22 +0000
Message-Id: <cover.1606305501.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset mostly fixes some races that result in an fsync falling back
to a transaction commit unncessarily or logging more metadata than it needs
to. It also addresses link and rename operations logging inodes that were
fsynced in the previous transaction but they don't need to be logged in
the current transaction. All these cases can be triggered often by dbench.

Finally it avoids blocking an fsync for a significant time window when the
previous transaction is still committing. All these together resulted in
about +12% throughput with dbench and -8% maximum latency, as mentioned in
the changelog of the last patch.

There will be more changes to improve performance with dbench or similar
workloads, but these have been cooking and testing for about one week and
are independent from what's coming next.

Filipe Manana (6):
  btrfs: fix race causing unnecessary inode logging during link and rename
  btrfs: fix race that results in logging old extents during a fast fsync
  btrfs: fix race that causes unnecessary logging of ancestor inodes
  btrfs: fix race that makes inode logging fallback to transaction commit
  btrfs: fix race leading to unnecessary transaction commit when logging inode
  btrfs: do not block inode logging for so long during transaction commit

 fs/btrfs/ctree.h    |   2 +-
 fs/btrfs/tree-log.c | 101 +++++++++++++++++++++++---------------------
 2 files changed, 53 insertions(+), 50 deletions(-)

-- 
2.28.0

