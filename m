Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8698F15A199
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBLHRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:17:09 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46465 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLHRJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581491840; x=1613027840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zg0o49RIAl9eY/S9AHa+AZUrnlOB5g9oeSIGJ7/jidY=;
  b=EamZuiFms5fQXh/gJegPxAPGfJ4iVMy5JJmGDOFuXoBVidh8DXVhzr4s
   Bjp0Dj1luCbAAN0DfDd/Zk9C9nux5YLiph8HKxZ/nRr8cEyVxWWuF2vo1
   1gak3jy/Ai04eYs9fclBzxry//VXfpi14A/7hS6qUaN88PoHBbTPnR9il
   qj8VfkL60rIoL649UWCHcqhM//BP728yNAkdDmOxhIDvmDWawJLk5FGg0
   ozXYpZJu6YvEjFmGABcbJC6xQbtvEDpE3onrBk6KYL4YdRd/U9mzstb1l
   PlKtSTF0ayzOxUWNPSRO9N/+vHFpwRr3Zp/CFKNBFcCHmbfPCz0NbCbDE
   g==;
IronPort-SDR: aiSeEF/l9Tx6ORzYWdwKCRUl9zWRql7KePgrHgU6rbqnbCEnyfdA3ipbOlZLwaicrKwSobf9aT
 /cSckcqtonYNyMCjLAa7mtBNgV+GX3nnz0uimyvsjj8UhPGo44leHma3nCZ5g4FTKIwNYpCEFu
 HSHgncd0s0UOAr1tHzsG/3F++zqs0KYJnBoXyL4tRbWoc4pQbPbpQAhLQZMFfksr7+LSrpBsN7
 vlbjrTHzJmZFpQX5Yv2G48XafLg4HwOg4pH/Fo3fwCv1iiMBIbgg3r9y1eBcmwUvYnMZ9Td51Y
 7K0=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448454"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:17:20 +0800
IronPort-SDR: 5ud4lA84RvYurt9zxCAVb+I3zyqP7GzXG4lIIacmf3QAoLoGEuVQuWGl0avdGgGlix0S+I5DoQ
 cmXbhNXXfP5kNU3tPmvXeIQ7gliilQzDOUE14rfbyiwFcccZJypcbHg/EfwThbd4KeqYicSnDy
 XtFwztIarZ2978ybnr7yIgoMh8YljEDcyieBMeC+18uZvJZwMS4uFPQYyI0sUG2EMwywYjvPTV
 DeI3S7eEACrO+yI1PWaj3M6Vn3IqyjlYOLJ+Y45eYzXH0uMrDcAfH86K2Qh8cXl04SxgmMGhoN
 cPTOogppXtqE+kX210dD/RAt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:09:57 -0800
IronPort-SDR: unYqkGdwjTHje3H1I4FmJRNC41VEa4nO16iDLK4aWSzEffmqgkpWCShs/V1Mvi5PjC6VOgFvg3
 2DbccsvIuo2AZsBxSDVhfW742fztikCktmg0YZyPub3oRUEDctBhX842JCCth3nSdzmaK9c33M
 Zsa21L8fkkDvX9YiTDgcP6sXfmDHGy1hDmvPL9lgr+TZarHWPcm9nkCJcflP+Mcao/uxzrkeMm
 U/E+5UzBJv6stuc9s11o7VPSXIqN7Wq1faqtu/jYj4BXxvbUy8nUV9yuLAFGEq2f+KTuzl1gIf
 W4M=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 23:17:08 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 0/8] btrfs: remove buffer heads form superblock handling
Date:   Wed, 12 Feb 2020 16:16:56 +0900
Message-Id: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch series removes the use of buffer_heads from btrfs' super block read
and write paths. It also converts the integrity-checking code to only work
with pages and BIOs.

Compared to buffer heads, this gives us a leaner call path, as the
buffer_head code wraps around getting pages from the page-cache and adding
them to BIOs to submit.

Patches one to three are preparatory patches, the first one exports
btrfs_release_disk_super() as a commomn helper to release pages containig a
super block, the second removes the kmap() calls from block device mappings as
suggested by Christoph. The third one unexports btrfs_scratch_superblocks()

The fourth patch removes buffer_heads from superblock reading. The fifth
removes it from super_block writing and the subsequent patches remove the
buffer_heads from the integrity check code.

Due to a rebase error patch #3 of v5 got merged into the patch removing the
BHs form super-block reading, but in the end it isn't too bad this way either.

It's based on misc-next from Monday February 11
(23ba1a90f0571d91b55bdfef7f06f380a74e8475), and doesn't show any regressions
in xfstests to the baseline.

Changes to v6:
- Fixed build warning about unused result of write_one_page() (David)
- Unexport btrfs_scratch_superblocks()

Changes to v5:
- Rebase to newer misc-next
- Merge old patches 2 and 3
- Remove kmap()s of pages from block devices (both in new code as well as
  existing code)

Changes to v4:
- Ressurected Nikolay's patch exporting btrfs_release_disk_super()
- Incroporated feedback from Christoph

Changes to v3:
- Incroporated feedback from Christoph

Changes to v2:
- Removed patch #1 again
- Added Reviews from Josef
- Re-visited page locking, but not changes, it retains the same locking scheme
  the buffer_heads had
- Incroptorated comments from David regarding open-coding functions
- For more details see the idividual patches.

Changes to v1:
- Added patch #1
- Converted sb reading and integrity checking to use the page cache
- Added rationale behind the conversion to the commit messages.
- For more details see the idividual patches.


Johannes Thumshirn (7):
  btrfs: don't kmap() pages from block devices
  btrfs: unexport btrfs_scratch_superblocks
  btrfs: use the page-cache for super block reading
  btrfs: use BIOs instead of buffer_heads from superblock writeout
  btrfs: remove btrfsic_submit_bh()
  btrfs: remove buffer_heads from btrfsic_process_written_block()
  btrfs: remove buffer_heads form superblock mirror integrity checking

Nikolay Borisov (1):
  btrfs: Export btrfs_release_disk_super

 fs/btrfs/check-integrity.c | 215 +++++++++++--------------------------
 fs/btrfs/check-integrity.h |   2 -
 fs/btrfs/disk-io.c         | 191 ++++++++++++++++----------------
 fs/btrfs/disk-io.h         |   6 +-
 fs/btrfs/volumes.c         |  85 ++++++++-------
 fs/btrfs/volumes.h         |   4 +-
 6 files changed, 212 insertions(+), 291 deletions(-)

-- 
2.24.1

