Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCDAF279C
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 07:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfKGG1Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 01:27:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:37582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfKGG1Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Nov 2019 01:27:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D076AE4D
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Nov 2019 06:27:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: More intelligent degraded chunk allocator
Date:   Thu,  7 Nov 2019 14:27:07 +0800
Message-Id: <20191107062710.67964-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset will make btrfs degraded mount more intelligent and
provide more consistent profile keeping function.

One of the most problematic aspect of degraded mount is, btrfs may
create unwanted profiles.

 # mkfs.btrfs -f /dev/test/scratch[12] -m raid1 -d raid1
 # wipefs -fa /dev/test/scratch2
 # mount -o degraded /dev/test/scratch1 /mnt/btrfs
 # fallocate -l 1G /mnt/btrfs/foobar
 # btrfs ins dump-tree -t chunk /dev/test/scratch1
        item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 1674575872) itemoff 15511 itemsize 80
                length 536870912 owner 2 stripe_len 65536 type DATA
 New data chunk will fallback to SINGLE or DUP.


The cause is pretty simple, when mounted degraded, missing devices can't
be used for chunk allocation.
Thus btrfs has to fall back to SINGLE profile.

This patchset will make btrfs to consider missing devices as last resort if
current rw devices can't fulfil the profile request.

This should provide a good balance between considering all missing
device as RW and completely ruling out missing devices (current mainline
behavior).

Qu Wenruo (3):
  btrfs: volumes: Refactor device holes gathering into a separate
    function
  btrfs: volumes: Add btrfs_fs_devices::missing_list to collect missing
    devices
  btrfs: volumes: Allocate degraded chunks if rw devices can't fullfil a
    chunk

 fs/btrfs/block-group.c |  10 ++-
 fs/btrfs/volumes.c     | 170 ++++++++++++++++++++++++++---------------
 fs/btrfs/volumes.h     |   6 ++
 3 files changed, 121 insertions(+), 65 deletions(-)

-- 
2.24.0

