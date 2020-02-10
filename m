Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3374715825C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 19:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJScc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 13:32:32 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25711 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgBJScb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 13:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581359551; x=1612895551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xNXmdWQBmTVBdM10g7b+6CYZEf/GWzR92+ITUNMLcco=;
  b=NnIcIB98ywMVCiSKqmRnwYski4BHEZAZy7vzHAmZqJczV5BJoiRmGNt/
   IuxJgIeZvKzRTqw+xbDAfGP4CkMsphoB06MCazQPOUO2ksylIX4b0TBqI
   Qi6OOB09VagtZOJVGcOPF4FAz6e6gBfuteHTjwewU/omVwc/E+zzL3a3U
   r576NLdFlLyio9PHN6XjD8WYFWQ5u5vtRUmb17vlvxK3blCl23K3mppvX
   RbDSlyYmTScNbCI16gfua63rpQ8s1eWyGqS0fzqNKPnpl1T6eqyRIXbhR
   Qr1TnVkB9pBz3bEOliXcPvo+GOaPHdkqRwIBIsLEFhy3cSms2+dTIdSBP
   A==;
IronPort-SDR: B7xcAVC8A8wIStH/t/Ri+bB9t4+ju0LxCpMhgBUk21Z5Z6ciAaSP04CuMEL0TaYqTJVXjCr1wh
 pOacUFMUrEGpAsXh0g3BZvBKyNylt8bgcBM9zk3bB0r1qxg/B5aHhBsP2C0EcwQb2dx5HfvdPh
 An/4zo8Ql0HC1TCnapE2v72gIYpqTutdpVKVIgIE4arTqaplwz1DzOe31POGQ2RyPzfluFmJIH
 3nQ9u4EIbvravXZ54+/VBPL4lCOaxiI9TsO5jpQqFd5IfYfBHr9+EGCg1mLrpWB4IyhqmPqiBv
 6UQ=
X-IronPort-AV: E=Sophos;i="5.70,425,1574092800"; 
   d="scan'208";a="237529173"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 02:32:31 +0800
IronPort-SDR: nP2pyTO5uBuRK94zz0IysHXTXIZQAeyywUOo6hobN+2SjzypB4d21Z09bRNiLn6pjyD1ZP86C5
 DXd4Rth9rcMK0NxCOwYf+L1rb8Kn2Z3rKtTTqPOhsOvO1Knk1yp0V6B+VG7bvbLnohYH8CZc/1
 LNgak3UBcIftfegxjpwFuDDeRKrxSMVRi7O7C2yHM3b0L1RBUgdG6CkZgyiwBhW+03Q+O2YmH5
 v+bWnCSsJPGfbYLK7NnRT0XcHJKn5XopnH8ruMpsJmLHYt6lu3kHGzuwlQhQqtJpaBCiyOp6Ta
 EhDWkudxKKofA+KYUEuA+b2t
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 10:25:23 -0800
IronPort-SDR: yIpej9bqQDqeWD71TAx5gOdg2z6yFQTVSxdVwE0i2EVF4fvkw9eVewYUb8fsqNBdiRydBnAgbj
 l18KZABhDFDAkN9MZzzF3NxzHY/Xg9GpXjacl8Dpkf4AEBWxQ4JrE5UEhyYyUv3X6NRDl1D7Zc
 d51T1tH7wio8KBHaJDxle9ypg8Z0zlCiGq1Qq5Vpxr6Qeaa244sqZKgtKz1CEORxChDSLd49g5
 RnVMQygcxCVf8mrRSxEgbKXPIY0yaZ/VvH5LI2Cy+PSq0XSE4ObWzsIUpHFbES3DA51X2FlV4Q
 TK0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Feb 2020 10:32:29 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 0/7] btrfs: remove buffer heads form superblock handling
Date:   Tue, 11 Feb 2020 03:32:18 +0900
Message-Id: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
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

Patches one and two are preparatory patches, the first one exports
btrfs_release_disk_super() as a commomn helper to release pages containig a
super block, the second removes the kmap() calls from block device mappings as
suggested by Christoph.

The third patch removes buffer_heads from superblock reading. The forth
removes it from super_block writing and the subsequent patches remove the
buffer_heads from the integrity check code.

Due to a rebase error patch #3 of v5 got merged into the patch removing the
BHs form super-block reading, but in the end it isn't too bad this way either.

It's based on misc-next from Monday February 11
(23ba1a90f0571d91b55bdfef7f06f380a74e8475), and doesn't show any regressions
in xfstests to the baseline.

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


Johannes Thumshirn (6):
  btrfs: don't kmap() pages from block devices
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
 fs/btrfs/volumes.c         |  64 +++++------
 fs/btrfs/volumes.h         |   3 +-
 6 files changed, 195 insertions(+), 286 deletions(-)

-- 
2.24.1

