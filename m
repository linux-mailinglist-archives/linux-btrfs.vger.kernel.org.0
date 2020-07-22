Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410FD22931F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 10:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgGVIJ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 04:09:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgGVIJ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 04:09:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D335BAFE8;
        Wed, 22 Jul 2020 08:09:33 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/4] Misc cleanups around device addition
Date:   Wed, 22 Jul 2020 11:09:21 +0300
Message-Id: <20200722080925.6802-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are 4 minor cleanups around btrfs_init_new_device. First one converts
a readonly usage of device_lists to using RCU. Second patch slightly simplifies
the logic around locking when seed device is used. Third one removes a leftover
from rewrite of btrfs_free_stale_devices. And the final one replaces an
opencoded filemap_write_and_wait on the bdev inode with the more consistent
sync_blockdev.

All these have passed xfstest and don't constitute functional changes.

Nikolay Borisov (4):
  btrfs: Use rcu when iterating devices in btrfs_init_new_device
  btrfs: Refactor locked condition in btrfs_init_new_device
  btrfs: Remove redundant code from btrfs_free_stale_devices
  btrfs: Don't opencode sync_blockdev

 fs/btrfs/volumes.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

--
2.17.1

