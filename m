Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631E0123C58
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 02:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLRBTu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 20:19:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:49724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfLRBTu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 20:19:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68683ABCD
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 01:19:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs-progs: Fixes for github issues
Date:   Wed, 18 Dec 2019 09:19:36 +0800
Message-Id: <20191218011942.9830-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are a new batch of fuzzed images for btrfs-progs. They are all
reported by Ruud van Asseldonk from github.

Patch 1 will make QA life easier by remove the extra 300s wait time.
Patch 2~5 are all the meat for the fuzzed images.

Just a kind reminder, mkfs/020 test will fail due to tons of problems:
- Undefined $csum variable
- Undefined $dev1 variable
- Bad kernel probe for support csum
  E.g. if Blake2 not compiled, it still shows up in supported csum algo,
  but will fail to mount.

All other tests pass.

Qu Wenruo (6):
  btrfs-progs: tests: Add --force for repair command
  btrfs-progs: check/original: Do extra verification on file extent item
  btrfs-progs: disk-io: Verify the bytenr passed in is mapped for
    read_tree_block()
  btrfs-progs: Add extra chunk item size check
  btrfs-progs: extent-tree: Kill the BUG_ON() in btrfs_chunk_readonly()
  btrfs-progs: extent-tree: Fix a by-one error in
    exclude_super_stripes()

 check/main.c  | 34 ++++++++++++++++++++++++++++++++--
 extent-tree.c | 11 ++++++++---
 extent_io.c   | 26 ++++++++++++++++++++++++++
 extent_io.h   |  2 ++
 tests/common  |  2 +-
 volumes.c     | 41 ++++++++++++++++++++++++++++++++++++-----
 6 files changed, 105 insertions(+), 11 deletions(-)

-- 
2.24.1

