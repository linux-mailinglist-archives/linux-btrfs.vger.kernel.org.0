Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E1D23B572
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 09:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgHDHPt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 03:15:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:33626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgHDHPt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Aug 2020 03:15:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 552C3AC85
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Aug 2020 07:16:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: remove the inode_need_compress() call in
Date:   Tue,  4 Aug 2020 15:15:41 +0800
Message-Id: <20200804071543.33411-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an attempt to remove the inode_need_compress() call in
compress_file_extent().

As that compress_file_extent() can race with inode ioctl or bad
compression ratio, to cause NULL pointer dereferecen for @pages, it's
nature to try to remove that inode_need_compress() to remove the race
completely.

However that's not that easy, we have the following problems:

- We still need to check @pages anyway
  That @pages check is for kcalloc() failure, so what we really get is
  just removing one indent from the if (inode_need_compress()).
  Everything else is still the same (in fact, even worse, see below
  problems)

- Behavior change
  Before that change, every async_chunk does their check on
  INODE_NO_COMPRESS flags.
  If we hit any bad compression ratio, all incoming async_chunk will
  fall back to plain text write.

  But if we remove that inode_need_compress() check, then we still try
  to compress, and lead to potentially wasted CPU times.

- Still race between compression disable and NULL pointer dereferecen
  There is a hidden race, mostly exposed by btrfs/071 test case, that we
  have "compress_type = fs_info->compress_type", so we can still hit case
  where that compress_type is NONE (caused by remount -o nocompress), and
  then btrfs_compress_pages() will return -E2BIG, without modifying
  @nr_pages

  Then later when we cleanup @pages, we try to access pages[i]->mapping,
  triggering NULL pointer dereference.

  This will be address in the first patch though.

Qu Wenruo (2):
  btrfs: sysfs: fix NULL pointer dereference at
    btrfs_sysfs_del_qgroups()
  btrfs: inode: don't re-evaluate inode_need_compress() in
    compress_file_extent()

 fs/btrfs/compression.c |  10 ++--
 fs/btrfs/inode.c       | 106 ++++++++++++++++++++---------------------
 2 files changed, 59 insertions(+), 57 deletions(-)

-- 
2.28.0

