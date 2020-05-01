Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F257F1C0E5B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 08:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgEAGwY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 02:52:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:44300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgEAGwY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 02:52:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22D18AD11
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 06:52:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs-progs: Sync code for btrfs_block_group
Date:   Fri,  1 May 2020 14:52:15 +0800
Message-Id: <20200501065219.484868-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset mostly make btrfs_block_group structure to sync with
kernel, providing the basis for later modification. (Hint: skinny bg
tree)

Changelog:
v2:
- Add a patch to sync the block group item accessors

Qu Wenruo (4):
  btrfs-progs: Sync block group item accessors from kernel
  btrfs-progs: Kill block_group_cache::key
  btrfs-progs: Remove the unused btrfs_block_group_cache::cache
  btrfs-progs: Rename btrfs_block_group_cache to btrfs_block_group

 check/main.c                    |  51 +++----
 check/mode-common.c             |   4 +-
 check/mode-lowmem.c             |  22 +--
 cmds/rescue-chunk-recover.c     |  16 +--
 convert/common.c                |   6 +-
 convert/main.c                  |   8 +-
 convert/source-fs.c             |   4 +-
 ctree.h                         |  33 +++--
 extent-tree.c                   | 234 ++++++++++++++++----------------
 free-space-cache.c              |  32 ++---
 free-space-cache.h              |  12 +-
 image/main.c                    |   2 +-
 kernel-shared/free-space-tree.c | 117 ++++++++--------
 kernel-shared/free-space-tree.h |   6 +-
 mkfs/main.c                     |  19 ++-
 print-tree.c                    |   6 +-
 transaction.h                   |   2 +-
 volumes.h                       |   4 +-
 18 files changed, 290 insertions(+), 288 deletions(-)

-- 
2.26.2

