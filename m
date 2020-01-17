Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F8140A24
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 13:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgAQMvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 07:51:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51277 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgAQMvL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 07:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579265471; x=1610801471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fFl5G83st43qLcPVMZIZvs8atVtIo2xMBqW/fD3w9jI=;
  b=CFgnqiXHtOqlnDY5PSnQdckajQCjbaH+Ml09RAgWa1im2m0acw5tXiwR
   /X3hq0HsRbavzuc4Mr9XukXM6mI76vBlXiyC//7OrVEMj0MXGwPLWa5SG
   gjtFbrf4C3ko+cC8Z/SdQNf+z3lN2+PayDPoPaN4/BrnMNm4E6C6nAx+v
   S3hG16P4nSDBjoensSLgwCTnE1MlKfaoz106LaYMjLRdymvbwn56sD9Fl
   BxvR2ckJTJXAYHzKbPF5VL6UpXgcHdVag/6aenwCL+vpokKovnPpjkVvo
   kGKRGU7GOWrfpB14hy+cSR2fuw9OKqgwf2w4bdpnaqLBK4EL/bx0CRMLl
   w==;
IronPort-SDR: JOf31pg1eXvE9TIbCW0YHEUNUCrkepzXZIU/Z85o/5rdeTjvlffYiGvdlLXHvbjoFYy8SE7eUJ
 9lQkJt85EHMpXFndFVwLlHssnbz8IIyrQJ8VzikIuta4SpRCAWVyl2B6mIDm/Yc4LD+upchGFI
 zM2F8ZgYcbMsbKPBpRsmBwCyB+/WUUulZnQ708VuGuCeN+60RI6gEGkP6UhROqgfKFmYh4iA1t
 itCest+PTk9Y77mUUButJ3M49veUtj2pJZiZnGDl6fyKLUjznUdhRr/zdFqKuK8vxoN2bdVzlA
 EFs=
X-IronPort-AV: E=Sophos;i="5.70,330,1574092800"; 
   d="scan'208";a="235550978"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2020 20:51:11 +0800
IronPort-SDR: BRxVcqTNPI1AKRULq2FKg27cZyMisRVdL8DGA+TDEdgoNoKfpmuzyKoGlQ9QrVJzsRGUCO/sj0
 +B08ORNdUeEapvuBijDWqgwD2paAq7qlb0VOH372p2O7Q4Yn392p4K4My8VzJpipNLGtnk0a8G
 Q1809OJo8i4S6AodHPnhCJMlsDPJgpRAyBFv68yMbPAC/Wo3Q/tzCNlJEYsxBWxH/JCQj2Tn/6
 WTCy+eY8/dVbs5atfw5LnYmnhmkHsbBR2RXeDQY27DiWQ/7eeEGKsEmYswrtw7YEGFxNPpOVPR
 NKpHLCUe0Skn5nqpddpYmjj3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 04:44:44 -0800
IronPort-SDR: kq1NnDkK3S/MNl7ILQqm4G1N7CN8Lzw02/ljTigBD3id/1eEufzks9weiMQYRC/0e8ToIMDirm
 WYX6RQnBvsO7hHYNT1AN9YkIUh5lWyTWZFwAsPSFcXZHQJ4LH3/uEduE8TmfWHZ2GmAQO1/Vnl
 mNG+a149oF7FSxBFSeKE5cX/i+akTIh4VqodChd9Y86IE8xKPveeIE/5mXvN7WqMWDkG5IP1R1
 wADkKl1wuaPv+FxZ4Ou3z6cqyiTyvycfY1xYe7fgZ3wx2Vwfs88hD2sOkfLKeaypgwaeLgZJ0Q
 8KY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2020 04:51:10 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/5] btrfs: remove buffer heads form superblock handling
Date:   Fri, 17 Jan 2020 21:51:00 +0900
Message-Id: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch series removes the use of buffer_heads from btrfs' super block read
and write paths.

The first patch removes buffer_heads from superblock reading.
The second from super_block writing and the subsequent patches remove the
buffer_heads from the integrity check code.

It's based on misc-next from Friday January 17, and doesn't show any
regressions in xfstests to the baseline.

Johannes Thumshirn (5):
  btrfs: remove buffer heads from super block reading
  btrfs: remove use of buffer_heads from superblock writeout
  btrfs: remove btrfsic_submit_bh()
  btrfs: remove buffer_heads from btrfsic_process_written_block()
  btrfs: remove buffer_heads form superblock mirror integrity checking

 fs/btrfs/check-integrity.c | 198 ++++++++++---------------------------
 fs/btrfs/check-integrity.h |   2 -
 fs/btrfs/disk-io.c         | 187 ++++++++++++++++++++---------------
 fs/btrfs/disk-io.h         |   4 +-
 fs/btrfs/volumes.c         |  64 +++++++-----
 fs/btrfs/volumes.h         |   2 -
 6 files changed, 199 insertions(+), 258 deletions(-)

-- 
2.24.1

