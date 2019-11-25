Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E71109023
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 15:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfKYOhO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 09:37:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:37846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728035AbfKYOhN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 09:37:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5CB22AD18;
        Mon, 25 Nov 2019 14:37:12 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 0/2] remove BUG_ON()s in btrfs_close_one_device()
Date:   Mon, 25 Nov 2019 15:37:01 +0100
Message-Id: <20191125143703.4989-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series attempts to remove the BUG_ON()s in btrfs_close_one_device().
Therefore some reorganization of btrfs_close_one_device() was needed, to
avoid the memory allocation.

This series has passed fstests without any deviation from the baseline.

Changes to v2:
- Completly different approach to the origianl patchset, instead of handling
  eventual allocation failures.
- Dropped already merged patches for ' btrfs_fs_devices::rotating' and
  'btrfs_fs_devices::seeding'
- Kept the 1st patch of the old series, as it's a nice cleanup

Changes to v1:
- Fixed the decremt of btrfs_fs_devices::seeding.
- In addition to this, I've added two patches changing btrfs_fs_devices::seeding
  and btrfs_fs_devices::rotating to bool, as they are in fact used as booleans.

Johannes Thumshirn (2):
  btrfs: decrement number of open devices after closing the device not
    before
  btrfs: reset device back to allocation state when removing

 fs/btrfs/volumes.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

-- 
2.16.4

