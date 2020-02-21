Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B781F16836D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgBUQbT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:31:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:43652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgBUQbT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D730DAF5C;
        Fri, 21 Feb 2020 16:31:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87E82DA70E; Fri, 21 Feb 2020 17:30:59 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 00/11] Minor cleanups
Date:   Fri, 21 Feb 2020 17:30:58 +0100
Message-Id: <cover.1582302545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Minor and safe cleanups.

David Sterba (11):
  btrfs: use struct_size to calculate size of raid hash table
  btrfs: move mapping of block for discard to its caller
  btrfs: open code trivial helper btrfs_header_fsid
  btrfs: open code trivial helper btrfs_header_chunk_tree_uuid
  btrfs: simplify parameters of btrfs_set_disk_extent_flags
  btrfs: adjust message level for unrecognized mount option
  btrfs: raid56: simplify sort_parity_stripes
  btrfs: replace u_long type cast with unsigned long
  btrfs: adjust delayed refs message level
  btrfs: merge unlocking to common exit block in
    btrfs_commit_transaction
  btrfs: reduce pointer intdirections in btree_readpage_end_io_hook

 fs/btrfs/ctree.c       |  4 +--
 fs/btrfs/ctree.h       | 12 +--------
 fs/btrfs/disk-io.c     | 18 +++++++------
 fs/btrfs/extent-tree.c |  7 +++---
 fs/btrfs/raid56.c      |  4 +--
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/transaction.c | 57 +++++++++++++++---------------------------
 fs/btrfs/volumes.c     | 33 ++++++++----------------
 8 files changed, 49 insertions(+), 88 deletions(-)

-- 
2.25.0

