Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F28262C73
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgIIJt2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 05:49:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgIIJtT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 05:49:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65CA1B15D;
        Wed,  9 Sep 2020 09:49:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 00/10] Cleanup metadata page reading path
Date:   Wed,  9 Sep 2020 12:49:04 +0300
Message-Id: <20200909094914.29721-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series streamlines the page read path for metadata pages. Currently
__do_readpage is shared between ordinary data inodes as well as the btree_inode.
This is unnecenssary and brings clutter to the interface of __do_readpage et al
in the form of needlessly passed parameters and unnecessary actions performed
in btree_get_extent just to appease the interface/logic of __do_readpage.

To simplify the code metadata read is switched from calling __do_readpage to
directly calling submit_extent_page in read_extent_buffer_pages which is sufficient
to grab metadata pages. This in turn paves the way for further cleanups by
removing a lot of arguments from top level functions and sinking them in
lowe-level worker functions.

Patch 1 and 2 remove unused function and a parameter from btrfs_get_extent.
Patch 3 switches read_extent_buffer_pages (sole metadata read path) to using
submit_extent_page which enables further simplifications. Following patches
now-unused functions and removes certain indirection now that __do_readpage
is used only for data read.

Every patch has survived a -g quick and the overall series survived a full
xfstest run.

Nikolay Borisov (10):
  btrfs: Remove btree_readpage
  btrfs: Remove pg_offset from btrfs_get_extent
  btrfs: Simplify metadata pages reading
  btrfs: Remove btree_get_extent
  btrfs: Remove btrfs_get_extent indirection from __do_readpage
  btrfs: Remove mirror_num argument from extent_read_full_page
  btrfs: Promote extent_read_full_page to btrfs_readpage
  btrfs: Sink mirror_num argument in extent_read_full_page
  btrfs: Sink read_flags argument into extent_read_full_page
  btrfs: Sink mirror_num argument in __do_readpage

 fs/btrfs/ctree.h             |  3 +-
 fs/btrfs/disk-io.c           | 53 --------------------------
 fs/btrfs/disk-io.h           |  3 --
 fs/btrfs/extent_io.c         | 74 ++++++++++++------------------------
 fs/btrfs/extent_io.h         | 10 +++--
 fs/btrfs/file.c              | 12 +++---
 fs/btrfs/inode.c             | 37 +++++++++---------
 fs/btrfs/ioctl.c             |  2 +-
 fs/btrfs/tests/inode-tests.c | 42 ++++++++++----------
 9 files changed, 79 insertions(+), 157 deletions(-)

--
2.17.1

