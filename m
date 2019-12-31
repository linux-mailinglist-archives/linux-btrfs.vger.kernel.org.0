Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B8212D6C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 08:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfLaHM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 02:12:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:46434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfLaHM0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 02:12:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F2331AD12
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Dec 2019 07:12:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs-progs: Bad extent item generation related bug fixes
Date:   Tue, 31 Dec 2019 15:12:15 +0800
Message-Id: <20191231071220.32935-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is an issue reported in github, where an fs get corrupted
extent tree initialy, then I recommended --init-extent-tree.

Although --init-extent-tree indeed fixed the original problem, it caused
new problems, quite a lot of EXTENT_ITEMs now get bad generation number,
which failed to mount with v5.4.

The problem turns out to be a bug in backref repair code, which doesn't
initialize extent_record::generation, causing garbage in EXTENT_ITEMs.

This patch will:
- Fix the problem
  Patch 1

- Enhance EXTENT_ITEM generation repair
  Patch 2

- Make `btrfs check` able to detect such bad generation
  Patch 3~4

- Add new test case for above ability
  Patch 5

Qu Wenruo (5):
  btrfs-progs: check: Initialize extent_record::generation member
  btrfs-progs: check: Populate extent generation correctly for data
    extents
  btrfs-progs: check/lowmem: Detect invalid EXTENT_ITEM and EXTENT_DATA
    generation
  btrfs-progs: check/original: Detect invalid extent generation
  btrfs-progs: fsck-tests: Make sure btrfs check can detect bad extent
    item generation

 check/main.c                                  |  36 ++++++++++++++----
 check/mode-lowmem.c                           |  19 +++++++++
 .../bad_extent_item_gen.img.xz                | Bin 0 -> 1916 bytes
 .../test.sh                                   |  19 +++++++++
 4 files changed, 67 insertions(+), 7 deletions(-)
 create mode 100644 tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen.img.xz
 create mode 100755 tests/fsck-tests/044-invalid-extent-item-generation/test.sh

-- 
2.24.1

