Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8491589A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 06:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgBKFhh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 00:37:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:49898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgBKFhh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 00:37:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F1EEAB92
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 05:37:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: Make balance cancelling response faster
Date:   Tue, 11 Feb 2020 13:37:25 +0800
Message-Id: <20200211053729.20807-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
There are quite some users reporting that 'btrfs balance cancel' slow to
cancel current running balance, or even doesn't work for certain dead
balance loop.

With the following script showing how long it takes to fully stop a
balance:
  #!/bin/bash
  dev=/dev/test/test
  mnt=/mnt/btrfs

  umount $mnt &> /dev/null
  umount $dev &> /dev/null

  mkfs.btrfs -f $dev
  mount $dev -o nospace_cache $mnt

  dd if=/dev/zero bs=1M of=$mnt/large &
  dd_pid=$!

  sleep 3
  kill -KILL $dd_pid
  sync

  btrfs balance start --bg --full $mnt &
  sleep 1

  echo "cancel request" >> /dev/kmsg
  time btrfs balance cancel $mnt
  umount $mnt

It takes around 7~10s to cancel the running balance in my test
environment.

[CAUSE]
Btrfs uses btrfs_fs_info::balance_cancel_req to record how many cancel
request are queued.
However that cancelling request is only checked after relocating a block
group.

That behavior is far from optimal to provide a faster cancelling.

[FIX]
This patchset will add more cancelling check points, to make cancelling
faster.

And also, introduce a new error injection points to cover these newly
introduced and future check points.


For the canceled balance during relocate_block_group(), we are re-using
the existing error handling path.
It will mark all existing reloc_roots as orphan in prepare_to_merge(),
then queue all of them for cleanup in merge_reloc_roots().
Thus it shouldn't cause any problem.

Changelog:
v2:
- Rebased to v5.6-rc1
  There is a small conflicts caused by extra finished stage output.
  Other than that, everything is pretty straightforward

- Add explanation for the error handling path in cover letter.

Qu Wenruo (4):
  btrfs: relocation: Introduce error injection points for cancelling
    balance
  btrfs: relocation: Check cancel request after each data page read
  btrfs: relocation: Check cancel request after each extent found
  btrfs: relocation: Work around dead relocation stage loop

 fs/btrfs/ctree.h      |  1 +
 fs/btrfs/relocation.c | 24 ++++++++++++++++++++++++
 fs/btrfs/volumes.c    |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.25.0

