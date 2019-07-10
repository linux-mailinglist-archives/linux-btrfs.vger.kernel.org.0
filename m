Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD36433E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 10:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfGJICw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 04:02:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbfGJICv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 04:02:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2F40AEF8;
        Wed, 10 Jul 2019 08:02:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jungyeon Yoon <jungyeon.yoon@gmail.com>
Subject: [PATCH 0/5] btrfs: Enhanced runtime defence against fuzzed images
Date:   Wed, 10 Jul 2019 16:02:38 +0800
Message-Id: <20190710080243.15988-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Another wave of defence enhancment, including:

- Enhanced eb accessors
  Not really needed for the fuzzed images, as 448de471cd4c
  ("btrfs: Check the first key and level for cached extent buffer")
  already fixed half of the reported images.
  Just add a final layer of safe net.

- BUG_ON() hunt in __btrfs_free_extent()
  Kill BUG_ON()s in __btrfs_free_extent(), replace with error reporting
  and why it shouldn't happen.

  Also add comment on what __btrfs_free_extent() is designed to do, with
  two dump-tree examples for newcomers.

- BUG_ON() hunt in __btrfs_inc_extent_ref()
  Just like __btrfs_free_extent(), but less comment as
  comment for __btrfs_free_extent() should also work for
  __btrfs_inc_extent_ref(), and __btrfs_inc_extent_ref() has a better
  structure than __btrfs_free_extent().

- Defence against unbalanced empty leaf

- Defence against bad key order across two tree blocks

The last two cases can't be rejected by tree-checker and they are all
cross-eb cases.
Thankfully we can reuse existing first_key check against unbalanced
empty leaf, but needs extra check deep into ctree.c for tree block
merging time check.

Reported-by: Jungyeon Yoon <jungyeon.yoon@gmail.com>
[ Not to mail bombarding the report, thus only RB tag in cover letter ]

Qu Wenruo (5):
  btrfs: extent_io: Do extra check for extent buffer read write
    functions
  btrfs: extent-tree: Kill BUG_ON() in __btrfs_free_extent() and do
    better comment
  btrfs: Detect unbalanced tree with empty leaf before crashing btree
    operations
  btrfs: extent-tree: Kill the BUG_ON() in
    insert_inline_extent_backref()
  btrfs: ctree: Checking key orders before merged tree blocks

 fs/btrfs/ctree.c        |  63 +++++++++++++++
 fs/btrfs/disk-io.c      |   9 +++
 fs/btrfs/extent-tree.c  | 168 ++++++++++++++++++++++++++++++++++++----
 fs/btrfs/extent_io.c    |  79 ++++++++++---------
 fs/btrfs/tree-checker.c |   6 ++
 5 files changed, 273 insertions(+), 52 deletions(-)

-- 
2.22.0

