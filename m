Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BC1A9718
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894817AbgDOIla (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 04:41:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894812AbgDOIlU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 04:41:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 81544AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 08:41:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/2] btrfs: Reformat and make btrfs_tree.h self-contained
Date:   Wed, 15 Apr 2020 16:41:11 +0800
Message-Id: <20200415084113.64378-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before this patch, although btrfs_tree.h contains most of needed
structures for one to read on-disk btrfs data, it still has some missing
parts:
- Missing some structures and flags
  Like btrfs_super_block, and BTRFS_INODE_* flags

- Not self-contained
  It still needs to include <linux/btrfs.h>

- Uses old/deprecated comment style

This patchset will first move on-disk structure definition to
btrfs_tree.h first, making it self-contained.

Then reformat btrfs_tree.h to make it follow current comment style.

This patchset is mostly designed for incoming projects like U-boot to
share the kernel definitions more easily.

Changelog:
v2:
- Add the reason why we move the code

v3:
- Move more flags/enum shared with ioctl to btrfs_btree.h
  This makes ioctl header to rely on btree_btree.h.
  But this makes btrfs_tree.h completely self-consistent.
  This problem is mostly exposed when syncing the header to btrfs-progs.

v4:
- Update btrfs_tree.h comment style
- Update btrfs_tree.h header define line
- Move enum btrfs_compression_type to btrfs_tree.h

Qu Wenruo (2):
  btrfs: Move on-disk structure definition to btrfs_tree.h
  btrfs: Reformat btrfs_tree.h comments

 fs/btrfs/compression.h          |   9 +-
 fs/btrfs/ctree.h                | 246 -----------
 include/uapi/linux/btrfs.h      |  74 +---
 include/uapi/linux/btrfs_tree.h | 721 +++++++++++++++++++++++---------
 4 files changed, 532 insertions(+), 518 deletions(-)

-- 
2.26.0

