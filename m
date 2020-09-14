Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB5E268893
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 11:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgINJhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 05:37:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:41172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgINJhQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 05:37:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5891ABB2;
        Mon, 14 Sep 2020 09:37:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 0/9] Cleanup metadata page reading path
Date:   Mon, 14 Sep 2020 12:37:02 +0300
Message-Id: <20200914093711.13523-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is v2 of the metadata readout cleanups [0]. This series incorporates the
feedback I received, namely:

* Added justification why removing btree_readpage is safe in Patch 1
* Dropped Patch 2 (pg_offset remove from btrfs_get_extent) as Qu intends on using
it in his subpage blocksize work.
* Add a comment about caller's responsibility for cleanup in Patch 3
* Added RB for patches which haven't changed since v1 and got RB by Josef.

[0] https://lore.kernel.org/linux-btrfs/20200909094914.29721-1-nborisov@suse.com/T/#t

Nikolay Borisov (9):
  btrfs: Remove btree_readpage
  btrfs: Simplify metadata pages reading
  btrfs: Remove btree_get_extent
  btrfs: Remove btrfs_get_extent indirection from __do_readpage
  btrfs: Remove mirror_num argument from extent_read_full_page
  btrfs: Promote extent_read_full_page to btrfs_readpage
  btrfs: Sink mirror_num argument in extent_read_full_page
  btrfs: Sink read_flags argument into extent_read_full_page
  btrfs: Sink mirror_num argument in __do_readpage

 fs/btrfs/disk-io.c   | 53 ---------------------------------
 fs/btrfs/disk-io.h   |  3 --
 fs/btrfs/extent_io.c | 71 +++++++++++++++-----------------------------
 fs/btrfs/extent_io.h |  6 ++--
 fs/btrfs/inode.c     |  9 +++++-
 5 files changed, 36 insertions(+), 106 deletions(-)

--
2.17.1

