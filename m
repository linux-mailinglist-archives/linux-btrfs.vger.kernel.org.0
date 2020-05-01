Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CFB1C0E36
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 08:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEAGbv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 02:31:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:40044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgEAGbu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 02:31:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1436AAD71
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 06:31:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: Sync code for btrfs_block_group
Date:   Fri,  1 May 2020 14:31:35 +0800
Message-Id: <20200501063138.474044-1-wqu@suse.com>
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

Qu Wenruo (3):
  btrfs-progs: Kill block_group_cache::key
  btrfs-progs: Remove the unused btrfs_block_group_cache::cache
  btrfs-progs: Rename btrfs_block_group_cache to btrfs_block_group

 check/main.c                    |  43 ++++---
 check/mode-common.c             |   4 +-
 check/mode-lowmem.c             |  10 +-
 cmds/rescue-chunk-recover.c     |   6 +-
 convert/main.c                  |   8 +-
 convert/source-fs.c             |   4 +-
 ctree.h                         |  21 ++--
 extent-tree.c                   | 209 ++++++++++++++++----------------
 free-space-cache.c              |  32 ++---
 free-space-cache.h              |  12 +-
 image/main.c                    |   2 +-
 kernel-shared/free-space-tree.c | 117 +++++++++---------
 kernel-shared/free-space-tree.h |   6 +-
 mkfs/main.c                     |  12 +-
 transaction.h                   |   2 +-
 volumes.h                       |   4 +-
 16 files changed, 247 insertions(+), 245 deletions(-)

-- 
2.26.2

