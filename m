Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9601949AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 22:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZVDQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 17:03:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:40280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgCZVDQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 17:03:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E8751AE83
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 21:03:14 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/9 v7] btrfs direct-io using iomap
Date:   Thu, 26 Mar 2020 16:02:45 -0500
Message-Id: <20200326210254.17647-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an effort to use iomap for direct I/O in btrfs. This would
change the call from __blockdev_direct_io() to iomap_dio_rw().

The main objective is to lose the buffer head and use bio defined by
iomap code, and hopefully to use more of generic-FS codebase.

These patches are based and tested on v5.6-rc7. I have tested it against
xfstests.

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

Changes since v5
- restore inode_dio_wait() in truncate
- Removed lockdep_assert_held() near callers

Changes since v6
- Fixed hangs due to underlying device failures
- Removed the patch to wait while releasing pages

 fs/btrfs/btrfs_inode.h |   18 --
 fs/btrfs/ctree.h       |    4
 fs/btrfs/file.c        |  124 +++++++++++++-
 fs/btrfs/inode.c       |  418 +++++++++++++++----------------------------------
 fs/direct-io.c         |   19 --
 fs/iomap/direct-io.c   |   17 +
 include/linux/fs.h     |    4
 include/linux/iomap.h  |    2
 mm/filemap.c           |   13 -
 9 files changed, 274 insertions(+), 345 deletions(-)



