Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057AAE36EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409740AbfJXPpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 11:45:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406101AbfJXPo7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 11:44:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54A94B36A;
        Thu, 24 Oct 2019 15:44:58 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 0/2] Provide an estimation of (free/total) inodes in statfs
Date:   Thu, 24 Oct 2019 17:44:53 +0200
Message-Id: <20191024154455.19370-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a user report on the BeeGFS mailing list, that it's impossible to run
BeeGFS on top of BTRFS.

This is because BeeGFS is storing it's meta-data either in the underlying
file-systems extended attributes or directly in an inode if it can make use of
inline inodes.

A more detailed description is in patch 2/2.

Without the patch applied:
rapido1:/# df -hTi /mnt/test
Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
/mnt/test      btrfs         0     0     0     - /mnt/test

With the patch applied on an empty fs:
rapido1:/# df -hTi /mnt/test
Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
/dev/zram0     btrfs      1.6K     0  1.6K    0% /mnt/test

With the patch applied on a dirty fs:
rapido1:/# df -hTi /mnt/test
Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
/dev/zram0     btrfs      1.6K  1.5K   197   88% /mnt/test

Johannes Thumshirn (2):
  btrfs: remove cached space_info in btrfs_statfs()
  btrfs: provide an estimated number of inodes for statfs

 fs/btrfs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.16.4

