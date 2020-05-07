Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8D1C9C15
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgEGUUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:56114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUUR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B64ACAE96;
        Thu,  7 May 2020 20:20:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 43F86DA732; Thu,  7 May 2020 22:19:27 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 00/19] Set/get helpers speedups and cleanups
Date:   Thu,  7 May 2020 22:19:27 +0200
Message-Id: <cover.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Set/get helpers are all the functions that read or write b-tree item
members, like btrfs_device_type, btrfs_set_device_type, or the variants
with token btrfs_token_device_type, defined in ctree.h with
BTRFS_SETGET_FUNCS. Most of them are implemented by btrfs_get_8/16/32/64
and btrfs_set_8/16/32/64 functions.

The helpers are used all over the place and can be seen in perf top
results quite often, though it's about 0.5-1.5%. This series simplifies
the helpers and removes function calls that do the translation from/to
the input buffers to/from the extent buffer pages.

I don't have exact number to show the speedup, watching perf top and the
same workload at least does not point to a drop, the functions are still
in the overall range 0.5-1.5%. The code cleanups result in a
straightforward code, also map_private_extent_buffer is gone!!!

David Sterba (19):
  btrfs: use the token::eb for all set/get helpers
  btrfs: drop eb parameter from set/get token helpers
  btrfs: don't use set/get token for single assignment in overwrite_item
  btrfs: don't use set/get token in leaf_space_used
  btrfs: preset set/get token with first page and drop condition
  btrfs: add separate bounds checker for set/get helpers
  btrfs: speed up btrfs_get_##bits helpers
  btrfs: speed up btrfs_get_token_##bits helpers
  btrfs: speed up btrfs_set_##bits helpers
  btrfs: speed up btrfs_set_token_##bits helpers
  btrfs: speed up and simplify generic_bin_search
  btrfs: remove unused map_private_extent_buffer
  btrfs: constify extent_buffer in the API functions
  btrfs: drop unnecessary offset_in_page in extent buffer helpers
  btrfs: optimize split page read in btrfs_get_##bits
  btrfs: optimize split page read in btrfs_get_token_##bits
  btrfs: optimize split page write in btrfs_set_##bits
  btrfs: optimize split page write in btrfs_set_token_##bits
  btrfs: update documentation of set/get helpers

 fs/btrfs/ctree.c        |  98 +++++++-----------
 fs/btrfs/ctree.h        |  58 +++++------
 fs/btrfs/extent_io.c    | 137 ++++++++-----------------
 fs/btrfs/extent_io.h    |  48 ++++-----
 fs/btrfs/inode.c        |  71 ++++++-------
 fs/btrfs/struct-funcs.c | 222 ++++++++++++++++++++--------------------
 fs/btrfs/tree-log.c     | 130 +++++++++++------------
 7 files changed, 337 insertions(+), 427 deletions(-)

-- 
2.25.0

