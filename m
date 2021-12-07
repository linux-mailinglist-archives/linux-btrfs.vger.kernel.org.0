Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED3946BDAD
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 15:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbhLGOc3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 09:32:29 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19470 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbhLGOcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 09:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638887323; x=1670423323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D+bMwKCJaNa2/pvhhM7lVA5NOrd48LEYMuxc8IfMePE=;
  b=SJ6UzI8jYVtyXFmBGlyrZDTTbzsM+LxtO1ORpxC9vJvyzVF15VuoR2z8
   cjMwmamRYxhY32agMOBGAtLK18C4+omG9/w4Fz8SumsLnoYKcGF6OXxjC
   mk2lfJee2rQcbQxnqlZBxhATr9sDqZmzWFHM7/SPhs2fpN8ACK/S4IJhM
   hL8sQebE9WnfE2ppOdBJWWXDGluAmPBMiu/ZT7v14EqVz5V9dVX5oLokm
   FF215c6h0piHg17UXalJrZ9UNu5nh7GQyMfYeGIQZFdW7OkFTes+yWLeW
   GPH6tV4UtZHFsXxH8gpq2C0xKmMbSRLnIuR1FoA7lJooCNnBe+uBZoqS7
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="299501474"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 22:28:42 +0800
IronPort-SDR: JgBJRkijsRXDQfT7iIFTdUahxTHe2ARMiWgM4Dk3tYQnqZAZ7LmCrYmF/Biug8qyr8kfksddyk
 aJjj3W7tz8uZLGJlBHqb2xXTzwUpqRxuOCSYb2MUEPyTrMOYkuJeMDB9kgwl2Z7cGVIPqhbibe
 RM89QVuxCLOlR0j3QTqC4lNxpgLhUosRu3fkl6zuv47o3p6GOymH13oCF+Y2g3SBM6SYlT7q65
 fGIcbowfbhdZLOI7yN1+PZpvoXVULPJxzgU+V3ddccre0sYnRTjeG3Q+uVmNH0zm5PE7dvOY0C
 r6t9dZccNxbDkRBcPxJLkG0G
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:01:47 -0800
IronPort-SDR: JiCPKDdHMYyuedADoCsOAvljLaWD7ECCUMF2/gKsRibpLziuc7Ne5jAckr+olzJndMWqqVy8SG
 RBpD7JRmtzJOPYpIso5MrjgVMm7zw9fkrZlQxLfEqtXMqz+hu5YVpnYwEPrWUewj4ejW01PWen
 CkeLe/PwV/pH59DrEsjWVjVxmUxNjxFP1yPMQ6ODhGOpB4Q2ZLVQmYCZ/pAgFyvTuVCAVaqqwI
 ry9KzZUbos0h2yBvdnG8Ya6QQRFU4DXIY/hTGYaT11Gl2b44/abOzM9wfn8nTdODnSrB6ozdKb
 JYk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2021 06:28:42 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: first batch of zoned cleanups
Date:   Tue,  7 Dec 2021 06:28:33 -0800
Message-Id: <cover.1638886948.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's the first btach of cleanups for the zoned code. In contrast to the 1st
submission [1] it is a minimalized set of patches with no dependencies on
other subsystems in btrfs. All of these patches are independant and can be
applied on their own.

The remaining patches from v1 will be sent out separately, once properly
reworked.

[1] https://lore.kernel.org/linux-btrfs/cover.1637745470.git.johannes.thumshirn@wdc.com/

Johannes Thumshirn (4):
  btrfs: zoned: encapsulate inode locking for zoned relocation
  btrfs: zoned: simplify btrfs_check_meta_write_pointer
  btrfs: zoned: sink zone check into btrfs_repair_one_zone
  btrfs: zoned: it's pointless to check for REQ_OP_ZONE_APPEND and
    btrfs_is_zoned

 fs/btrfs/extent_io.c | 17 ++++++-----------
 fs/btrfs/scrub.c     |  4 ++--
 fs/btrfs/volumes.c   | 13 ++++++++-----
 fs/btrfs/volumes.h   |  2 +-
 fs/btrfs/zoned.c     | 26 ++++++++------------------
 fs/btrfs/zoned.h     | 17 +++++++++++++++++
 6 files changed, 42 insertions(+), 37 deletions(-)

-- 
2.31.1

