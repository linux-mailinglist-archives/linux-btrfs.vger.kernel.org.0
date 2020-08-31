Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8062578C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgHaLyK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:54:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgHaLx4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:53:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 143B8B810;
        Mon, 31 Aug 2020 11:53:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 00/12] Another batch of inode vs btrfs_inode cleanups
Date:   Mon, 31 Aug 2020 14:42:37 +0300
Message-Id: <20200831114249.8360-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is the latest batch of inode vs btrfs_inode of interface cleanups for
internal btrfs functions.

Nikolay Borisov (12):
  btrfs: Make inode_tree_del take btrfs_inode
  btrfs: Make btrfs_lookup_first_ordered_extent take btrfs_inode
  btrfs: Make ordered extent tracepoint take btrfs_inode
  btrfs: Make btrfs_dec_test_ordered_pending take btrfs_inode
  btrfs: Convert btrfs_inode_sectorsize to take btrfs_inode
  btrfs: Make btrfs_invalidatepage work on btrfs_inode
  btrfs: Make btrfs_writepage_endio_finish_ordered btrfs_inode-centric
  btrfs: Make get_extent_skip_holes take btrfs_inode
  btrfs: Make btrfs_find_ordered_sum take btrfs_inode
  btrfs: Make copy_inline_to_page take btrfs_inode
  btrfs: Make btrfs_zero_range_check_range_boundary take btrfs_inode
  btrfs: Make extent_fiemap take btrfs_iode

 fs/btrfs/btrfs_inode.h       |  5 +++++
 fs/btrfs/ctree.h             |  4 ----
 fs/btrfs/extent_io.c         | 23 +++++++++++-----------
 fs/btrfs/extent_io.h         |  2 +-
 fs/btrfs/file-item.c         |  4 ++--
 fs/btrfs/file.c              | 23 ++++++++++++----------
 fs/btrfs/inode.c             | 37 +++++++++++++++++------------------
 fs/btrfs/ordered-data.c      | 38 +++++++++++++++++-------------------
 fs/btrfs/ordered-data.h      |  8 ++++----
 fs/btrfs/reflink.c           | 36 +++++++++++++++++-----------------
 include/trace/events/btrfs.h | 17 ++++++++--------
 11 files changed, 98 insertions(+), 99 deletions(-)

--
2.17.1

