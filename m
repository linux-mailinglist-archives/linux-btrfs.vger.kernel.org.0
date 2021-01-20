Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281152FCFD8
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 13:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389389AbhATMPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:15:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:36118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbhATK0P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 05:26:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611138327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fNNX0OdKduF/lUQysNs2YyIVkKjxWmjAXo+PxBG6g9w=;
        b=C0UGziICsyCKisJ2zWC8I3KtRKlbyKBuHLc6R8GvWkbSMZgsdkD+Aza2s2Y8YobXUm7FGu
        Tfy73JBycBM85apzYJxUU+QzfkFrDc0kcyQMWHB+HvyRIJWVWmFHSP3g09RcSoYWeGPzrA
        5wypULp5BjrbNgxAqpsJCY2RrAxKDUE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA5D1AC63;
        Wed, 20 Jan 2021 10:25:27 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 00/14] Make btrfs W=1 clean
Date:   Wed, 20 Jan 2021 12:25:12 +0200
Message-Id: <20210120102526.310486-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's V2 of the patchset, I have incorporated all the feedback - namely spellin g
fixes as well as David's suggestions for documenting fs_info as well as aligning
description of members. In addition to that I added the last patch which copies
the W=1 checks plus the cmd_checkdoc definition to btrfs' Makefile. Effectively,
this series not only makes btrfs W=1 clean but also unconditionally enables the
checks for all subdirs of fs/btrfs/

Nikolay Borisov (14):
  btrfs: Document modified paramater of add_extent_mapping
  btrfs: Fix parameter description of btrfs_add_extent_mapping
  btrfs: Fix function description format
  btrfs: Fix parameter description in delayed-ref.c functions
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
  btrfs: Enable W=1 checks for btrfs

 fs/btrfs/Makefile           | 17 +++++++++++++++++
 fs/btrfs/backref.c          |  6 ++++++
 fs/btrfs/block-group.c      |  1 +
 fs/btrfs/delalloc-space.c   |  7 ++++---
 fs/btrfs/delayed-ref.c      | 16 +++++++++-------
 fs/btrfs/discard.c          |  3 ++-
 fs/btrfs/extent_io.c        | 34 +++++++++++++++++-----------------
 fs/btrfs/extent_map.c       | 12 +++++++-----
 fs/btrfs/file-item.c        | 22 ++++++++++++++--------
 fs/btrfs/free-space-cache.c | 10 ++++++----
 fs/btrfs/inode.c            |  2 +-
 fs/btrfs/space-info.c       | 37 ++++++++++++++++++-------------------
 include/linux/zstd.h        |  8 ++++----
 13 files changed, 106 insertions(+), 69 deletions(-)

--
2.25.1

