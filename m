Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 747207FB33
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389860AbfHBNj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:59928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfHBNj2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D7DDB62C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D0EFDADC0; Fri,  2 Aug 2019 15:40:01 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 00/13] Sysfs cleanups
Date:   Fri,  2 Aug 2019 15:40:00 +0200
Message-Id: <cover.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Handful of almost trivial changes that clean up the sysfs structures and
helpers so the sysfs-related api is used only inside sysfs.c and that
the API facing btrfs is minimized.

David Sterba (13):
  btrfs: move sysfs declarations out of ctree.h
  btrfs: move btrfs_add_raid_kobjects to sysfs.c
  btrfs: factor sysfs code out of link_block_group
  btrfs: sysfs: unexport btrfs_raid_ktype
  btrfs: factor out sysfs code for creating space infos
  btrfs: sysfs: unexport space_info_ktype
  btrfs: sysfs: replace direct access to feature set names with a helper
  btrfs: factor out sysfs code for sending device uevent
  btrfs: factor out sysfs code for deleting block group and space infos
  btrfs: factor out sysfs code for updating sprout fsid
  btrfs: cleanup kobject.h includes
  btrfs: sysfs: move helper macros to sysfs.c
  btrfs: sysfs: move type conversion helpers to sysfs.c

 fs/btrfs/ctree.h       |  15 ---
 fs/btrfs/extent-tree.c |  59 +----------
 fs/btrfs/ioctl.c       |   2 +-
 fs/btrfs/space-info.c  |  25 +----
 fs/btrfs/super.c       |   1 +
 fs/btrfs/sysfs.c       | 217 ++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/sysfs.h       |  80 +++------------
 fs/btrfs/volumes.c     |  25 +----
 8 files changed, 238 insertions(+), 186 deletions(-)

-- 
2.22.0

