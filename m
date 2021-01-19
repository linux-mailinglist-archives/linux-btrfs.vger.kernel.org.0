Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6DE2FC397
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 23:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389640AbhASOiB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 09:38:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:37142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbhASM1i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 07:27:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611059212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zJJ8UJvPDTPv+4tlliuXqfzOWxrcbZtOHaEvkNxTpmA=;
        b=ImSNycUp5o88MO4AXdPCtaXtBxetXK6GnKDYQcaZx5gFJD4cDKIj7H4IfnEI7e2ou7OAx+
        PnN+U9Jl9SLdIzessj+1CGgdWE+QKFZSGUNvF2iPh9UIE85JH6bmHKIz127rW5V0qjUAvX
        CBFg2Gz/SsFdjyt2Qgmwq5dZNRwHHm4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24214AB9F;
        Tue, 19 Jan 2021 12:26:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 00/13] Make btrfs W=1 clean
Date:   Tue, 19 Jan 2021 14:26:36 +0200
Message-Id: <20210119122649.187778-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

This patch series aims to fix all current warnings produced by compiling btrfs
with W=1. My hopes are with these additions W=1 can become a default build
options for btrfs. With this series applied misc-next currently produces 1
genuine warning for an unused variable:

fs/btrfs/zoned.c: In function ‘btrfs_sb_log_location_bdev’:
fs/btrfs/zoned.c:491:6: warning: variable ‘zone_size’ set but not used [-Wunused-but-set-variable]
  491 |  u64 zone_size;


But I haven't fixed it since it's part of the WIP zoned support.

Nikolay Borisov (13):
  btrfs: Document modified paramater of add_extent_mapping
  btrfs: Fix parameter description of btrfs_add_extent_mapping
  btrfs: Fix function description format
  btrfs: Fix paramter description in delayed-ref.c functions
  btrfs: Improve parameter description for __btrfs_write_out_cache
  btrfs: Document now parameter of peek_discard_list
  btrfs: Document fs_info in btrfs_rmap_block
  btrfs: Fix description format of fs_info parameter of
    btrfs_wait_on_delayed_iputs
  btrfs: Document btrfs_check_shared parameters
  btrfs: Fix parameter description of
    btrfs_inode_rsv_release/btrfs_delalloc_release_space
  btrfs: Fix parameter description in space-info.c
  btrfs: Fix parameter description for functions in extent_io.c
  lib/zstd: Convert constants to defines

 fs/btrfs/backref.c          |  6 ++++++
 fs/btrfs/block-group.c      |  1 +
 fs/btrfs/delalloc-space.c   |  7 ++++---
 fs/btrfs/delayed-ref.c      | 16 +++++++++-------
 fs/btrfs/discard.c          |  1 +
 fs/btrfs/extent_io.c        | 34 +++++++++++++++++-----------------
 fs/btrfs/extent_map.c       | 12 +++++++-----
 fs/btrfs/file-item.c        | 22 ++++++++++++++--------
 fs/btrfs/free-space-cache.c | 10 ++++++----
 fs/btrfs/inode.c            |  2 +-
 fs/btrfs/space-info.c       | 35 +++++++++++++++++------------------
 include/linux/zstd.h        |  8 ++++----
 12 files changed, 87 insertions(+), 67 deletions(-)

--
2.25.1

