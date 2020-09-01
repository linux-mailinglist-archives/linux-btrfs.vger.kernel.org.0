Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A165C2590E4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgIAOlO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 10:41:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:55594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbgIAOkD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Sep 2020 10:40:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51BB2AC7D;
        Tue,  1 Sep 2020 14:40:03 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/5] Improve setup_items_for_insert
Date:   Tue,  1 Sep 2020 17:39:56 +0300
Message-Id: <20200901144001.4265-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

here is a series to improve setup_items_for_insert. First patch is a simple
re-arranegement of statements to eliminate a duplication of calculation.
Patches 2 and 3 improve leaky interface of setup_items_for_insert as they
convey information about the function's implementation. Patch 4 adds a proper
kernel doc. Finally, patch 5 improves the error message in an exceptional
condition. As an added bonus after applying the whole series bloat-o-meter
output looks like:

add/remove: 0/0 grow/shrink: 1/7 up/down: 33/-99 (-66)
Function                                     old     new   delta
setup_items_for_insert                      1200    1233     +33
insert_extent                                448     445      -3
btrfs_duplicate_item                         260     254      -6
test_btrfs_split_item                       1784    1776      -8
insert_inode_item_key                        156     148      -8
__btrfs_drop_extents                        3637    3621     -16
btrfs_insert_delayed_items                  1153    1125     -28
btrfs_insert_empty_items                     177     147     -30
Total: Before=1113157, After=1113091, chg -0.01%

This has survived -g quick of xfstests

Nikolay Borisov (5):
  btrfs: Re-arrange statements in setup_items_for_insert
  btrfs: Eliminate total_size parameter from setup_items_for_insert
  btrfs: Sink total_data parameter in setup_items_for_insert
  btrfs: Add kerneldoc for setup_items_for_insert
  btrfs: improve error message in setup_items_for_insert

 fs/btrfs/ctree.c                     | 35 +++++++++++++++++-----------
 fs/btrfs/ctree.h                     |  2 +-
 fs/btrfs/delayed-inode.c             |  3 +--
 fs/btrfs/file.c                      |  6 +----
 fs/btrfs/tests/extent-buffer-tests.c |  3 +--
 fs/btrfs/tests/inode-tests.c         |  6 ++---
 6 files changed, 28 insertions(+), 27 deletions(-)

--
2.17.1

