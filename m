Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A119D15C66E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgBMQAe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 11:00:34 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43895 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgBMPYp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581607485; x=1613143485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qdaUHDz78Va59/mVTsP6Q8kl4bUPU2oD+RDwn42wdx8=;
  b=Lt9CGOHN642XPlfK4t4U59/ICF8bf0A1KhyDl5OlrxFBlQLacoInYF+A
   k5D4JNPlRVD4/H1at57Ao5PLtO9iEQ6qUJH3n+Oi9C09m25jMie9out0f
   oB/vl3xa7VJZ8gdSiCvS8NJax1jRUvp2OhzlLU5JnGMDiKHwt2P4Phxun
   xEhodlFdCFZCCwHFZZGs+HEuMxhaRsyAmpEQShfpviPIvzPLN4A17WVI9
   aPOv7BlYf6vn2y+ipI+2gNiz4Vt8S5l0jo2MGV4toAqiaMPuyP0Zf8wB3
   qufBHA9nKryzSSBH1oNs1PL8Ro0QGD0ivoCgxPAjC1awDK3rhNMzBkfnt
   w==;
IronPort-SDR: sKKgogdmUfmhtTFFPmegflxDm/IAE31xuCTvcNq5W6znTacPJ5Ms75rU6XqXzWtR5yg1swoPyw
 +DhxVEuUa/NZ5eRuHZjx3kuiBh0TG2oU41Ig3xcvT11dNt7vFKRBbyfAHPrRwfG6zq8lLn8oot
 TyhCCXh+nM+SSa3GOtsonYad4ukLJ1KzqJWwaFvRYl1mWUgZIU1rDY2kkqB/cgn2fhtXHrvPhg
 sDU3RT2iUcH/N1n1uSfZWGw4cmqOU3ZtRzdgKLICDrcVueDlqJawtwM5a5FlTUin791ltGLPJL
 Uxk=
X-IronPort-AV: E=Sophos;i="5.70,437,1574092800"; 
   d="scan'208";a="131227877"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 23:24:45 +0800
IronPort-SDR: 50Y3Jg8SZoCTaNxqOCqFMFLm/CIOCbngIcET6220zXjG/moXcif9RLix6Jm6sXvk5td1cx1WaX
 mLBL1Q9AmGo55Onbc0A5GFuT+0LYmpY3hU9DNqKKUMsqlwr94AqvW1tn/zfzDyWoNGCban2xho
 VSSal0AvVvOkGmYNUkUVixYVs8OGOYNSyzPG/KoKxT5/ik9YXzSd8d5ENPBGNXIyoqoeFKw6TA
 TDXEH2b0/lun6R/FcEGvs6Yfk2/p8s3LohAj8weaskfXzG7ruKY/F5DbeElWlHqKmF1a9xvNAQ
 /0dpguqApUAfImIBpZ2P997p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:17:31 -0800
IronPort-SDR: qeomJd0ohD5IHz4/JAiaiFTcHeDjZx+Ti7DiCu+tYXK/111F2iAFfnlpBPFYFWwDabkZEMw1Al
 jkS7b8aK3Hsr1re329xT4VI5lCdN3SPzC3JtPLCiWt34GdwLd2cMlcfMvvamofE4LQXLhY0YzZ
 bWIZVpRYbpjD3iBEvhAnggw/3OrfY5p1NbmzPgDZGy4AGeO1IBgbduLdxlPzIcuC+auAvdXGsv
 Xn/2crXrbrYfEwzw33CVnP3Bq/tw1uZWl3lPI3pi7dEzWSK7H9V534nc7d+73OZqDTL1n/e8lX
 bpU=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2020 07:24:42 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 0/8] btrfs: remove buffer heads form superblock handling
Date:   Fri, 14 Feb 2020 00:24:28 +0900
Message-Id: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
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

Changes to v7:
- Remove forward declaration for btrfs_scratch_superblocks() (Nikolay)
- Fix kmap()/kunmap() in check-integrity.c (David)
- Fix subject of patch 2 (hch)

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
  btrfs: reduce scope of btrfs_scratch_superblocks()
  btrfs: use the page-cache for super block reading
  btrfs: use BIOs instead of buffer_heads from superblock writeout
  btrfs: remove btrfsic_submit_bh()
  btrfs: remove buffer_heads from btrfsic_process_written_block()
  btrfs: remove buffer_heads form superblock mirror integrity checking

Nikolay Borisov (1):
  btrfs: Export btrfs_release_disk_super

 fs/btrfs/check-integrity.c | 202 +++++++++----------------------------
 fs/btrfs/check-integrity.h |   2 -
 fs/btrfs/disk-io.c         | 191 ++++++++++++++++++-----------------
 fs/btrfs/disk-io.h         |   6 +-
 fs/btrfs/volumes.c         | 125 ++++++++++++-----------
 fs/btrfs/volumes.h         |   4 +-
 6 files changed, 217 insertions(+), 313 deletions(-)

-- 
2.24.1

