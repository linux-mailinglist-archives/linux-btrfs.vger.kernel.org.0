Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE29153745
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 19:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBESJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 13:09:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:57534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgBESJi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 13:09:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 236E1ACE0;
        Wed,  5 Feb 2020 18:09:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 22898DA735; Wed,  5 Feb 2020 19:09:23 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/8] Cleanup io_tree arguments in extent read/write path
Date:   Wed,  5 Feb 2020 19:09:23 +0100
Message-Id: <cover.1580925977.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The io_tree is passed to several functions that do extent page
read/write, but there's a lot of redundancy and things can be
simplified.

David Sterba (8):
  btrfs: remove extent_page_data::tree
  btrfs: drop argument tree from submit_extent_page
  btrfs: add assertions for tree == inode->io_tree to extent IO helpers
  btrfs: drop argument tree from btrfs_lock_and_flush_ordered_range
  btrfs: sink argument tree to extent_read_full_page
  btrfs: sink argument tree to __extent_read_full_page
  btrfs: sink arugment tree to contiguous_readpages
  btrfs: sink argument tree to __do_readpage

 fs/btrfs/disk-io.c      |  4 +---
 fs/btrfs/extent_io.c    | 50 ++++++++++++++++-------------------------
 fs/btrfs/extent_io.h    |  4 ++--
 fs/btrfs/file.c         |  2 +-
 fs/btrfs/inode.c        |  6 ++---
 fs/btrfs/ordered-data.c |  8 +++----
 fs/btrfs/ordered-data.h |  3 +--
 7 files changed, 29 insertions(+), 48 deletions(-)

-- 
2.25.0

