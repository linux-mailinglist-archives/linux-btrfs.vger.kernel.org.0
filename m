Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7011C161
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 01:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLLAaw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 19:30:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:42170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727185AbfLLAaw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 19:30:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 446C0ACF2;
        Thu, 12 Dec 2019 00:30:50 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, dsterba@suse.cz,
        jthumshirn@suse.de, nborisov@suse.com
Subject: [PATCH 0/8 v5] btrfs direct-io using iomap
Date:   Wed, 11 Dec 2019 18:30:35 -0600
Message-Id: <20191212003043.31093-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an effort to use iomap for direct I/O in btrfs. This would
change the call from __blockdev_direct_io() to iomap_dio_rw().

The main objective is to lose the buffer head and use bio defined by
iomap code, and hopefully to use more of generic-FS codebase.

These patches are based and tested on v5.5-rc1. I have tested it against
xfstests/btrfs.

The tree is available at
https://github.com/goldwynr/linux/tree/btrfs-iomap-dio


Changes since v1
- Incorporated back the efficiency change for inode locking
- Review comments about coding style and git comments
- Merge related patches into one
- Direct read to go through btrfs_direct_IO()
- Removal of no longer used function dio_end_io()

Changes since v2
- aligning iomap offset/length to the position/length of I/O
- Removed btrfs_dio_data
- Removed BTRFS_INODE_READDIO_NEED_LOCK
- Re-incorporating write efficiency changes caused lockdep_assert() in
  iomap to be triggered, remove that code.

Changes since v3
- Fixed freeze on generic/095. Use iomap_end() to account for
  failed/incomplete dio instead of btrfs_dio_data

Changes since v4
- moved lockdep_assert_held() to functions calling iomap_dio_rw()
  This may be called immidiately after calling inode lock and
  may feel not required, but it seems important.
- Removed comments which are no longer required
- Changed commit comments to make them more appropriate

--
Goldwyn

 fs/btrfs/btrfs_inode.h |   18 ---
 fs/btrfs/ctree.h       |    1
 fs/btrfs/extent_io.c   |   37 ++----
 fs/btrfs/extent_io.h   |    2
 fs/btrfs/file.c        |   21 +++
 fs/btrfs/inode.c       |  288 ++++++++++++++++++-------------------------------
 fs/direct-io.c         |   19 ---
 fs/gfs2/file.c         |    4
 fs/iomap/direct-io.c   |   16 +-
 fs/xfs/xfs_file.c      |    9 +
 include/linux/fs.h     |    4
 include/linux/iomap.h  |    2
 mm/filemap.c           |   13 +-
 13 files changed, 176 insertions(+), 258 deletions(-)

