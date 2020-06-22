Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B88203AB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 17:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgFVPZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 11:25:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:52154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbgFVPZO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 11:25:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB275C1A2;
        Mon, 22 Jun 2020 15:25:12 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        david@fromorbit.com, dsterba@suse.cz, jthumshirn@suse.de,
        fdmanana@gmail.com
Subject: [PATCH 0/6 v9] btrfs direct-io using iomap
Date:   Mon, 22 Jun 2020 10:24:51 -0500
Message-Id: <20200622152457.7118-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an effort to use iomap for direct I/O in btrfs. This would
change the call from __blockdev_direct_io() to iomap_dio_rw().
These are remanants of the series which was revoked due to page
invalidation errors and adds patches in iomap for proper buffered
fallback.

The main objective is to lose the buffer head and use bio defined by
iomap code, and hopefully to use more of generic-FS codebase.

These patches are based and tested on vanilla. I have tested it against
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

Changes since v7
- Moved reservation into btrfs iomap begin()/end() for correct
  reservation cleanup in case of device error.
- Merged patches switch to iomap, and adding btrfs_iomap_end()
  for easier bisection. The switch to iomap would fail in case
  of dio after buffered writes.

Changes since v8
- Added a flag to iomap_dio_rw() to return zero for buffered fallback

--
Goldwyn


