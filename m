Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5E1552CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgBGHU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 02:20:58 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26076 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGHU5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 02:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581060062; x=1612596062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ON5m3uvy11b+LGyJj9cUQ7M0G+evMrybtW7xaR9LOlM=;
  b=Z8v8HxLYStxNqAf3jJ4+GI9xrEAjoF+OBbv9e7tYBO0g/A4TGRMJ5p7A
   5LT7Gcb2JIbHf/8iChrtMa5FPDwZgoU1x8IxtfNu1dTO5Yg+5JYOoMKVo
   n7/J9zyh5Msc0hBTjw3roWhWKnNxBhGKVCPj895hoacBQQonQq65I7Q7b
   iL0k0mqSHUy/mCCb0CgflpYtMwdsyatjPztutY9UxgS/RQOJ28pfimJmJ
   pezWxkP/OHdJ4k1RJ6jYjFLpl5TGyIzgcNODetFad3YfvN5gIMZfzmWlS
   FAathgTdmDW4DhrYGK2v9yi4YZusazY27yve8phmRHAutuA4Nk6KGhnRh
   w==;
IronPort-SDR: JtOXpQGu9iNqUI22QXkJORpOaHK0hWouUwYemHEHjBBrDcKzgWy4Zr2i49NS6Bj2Fbsi5hxwqU
 DGRGOV9wdxPTTtrqlgilcCrFDVwPpUuKn3sM0JWOD/HzUdgyfhZutI8O4CYwmUjmCgvVJ9bs2S
 lyudGaCqMmZpi9wvD4CKeivj18X9Ik4DBuNRtWW7CxNlKrZHtBZDP5soZQHXkc11zIdHdTINi+
 fZfoJbwvSim4xgE9LtsikVq9UpYlREUh+YnY3w49NJTEGQaPL8+uQ/fxe+fnFyWlGYIaDsFWWD
 9xY=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="231092223"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 15:20:16 +0800
IronPort-SDR: NLKA7THcIbRpuLoUTYfE5Np0dnhzjPNKWXAUybFsUyeP/w34Y9FEo3OI8v1LoBeRbBlGSoDI4G
 xJyzW/3gGdndcR1y84smjkZHdWlduTvIgHoTMe/hCizR8iSCxh41wyDyMaCwmmh7dnaKTKVxAG
 re4tCnMoCF07WLBCN1Qq15FWRtoW9znQLLvpP2U6ztc3zGBg/ANqozwj9LbmeYmaTgQmRa1nn0
 dQ/ogeZxZ1y/tCH4Pq+YrBUoC4iIb8dL1lE00pnbCyb+GSFkTMZfSuDmjLxpoqckdcOztN9Fnw
 P6fbxjq0lBC+pHFc6ZBqLxug
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 23:13:09 -0800
IronPort-SDR: Yo9yFPWjW+nxgNqgYgSR4RciqwMqkSZJpqon2xSAz1XfL0RVWwwD4vO6zjl62QNGq7Kql46ktu
 564fpGIKyy9G3mO2GyfaTiRF0o4/XHvBTiPjdwTRFdswolb7nqmGryVw28lXndb1HPSTSdpFdC
 pRrN2b2b3aMrJBEfTmDWlve6+7h39ofh0Mt//w0EXtJZVUo+NM1a/6frCWDfTbmpALANvjiMB7
 Ugh+7/F6iBndEhMMNxs7dZF3dKCbIWVbTiXBBAjT7ZsGXYv/ABF3TJJ2cf6NfZk40tr08hSXpD
 4Sk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2020 23:20:11 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 0/7] btrfs: remove buffer heads form superblock handling
Date:   Fri,  7 Feb 2020 16:19:58 +0900
Message-Id: <20200207072005.22867-1-johannes.thumshirn@wdc.com>
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

The second patch removes buffer_heads from superblock reading. The forth
removes it from super_block writing and the subsequent patches remove the
buffer_heads from the integrity check code. Patches one and three are
preparatory patches. Patch number three could be merged into patch number two,
but I decided against it to not make the diff unreadable.

It's based on misc-next from Wednesday February 5, and doesn't show any
regressions in xfstests to the baseline.

Christoph also mentioned that block device mappings are never in highmem, so
we could get rid of the kmap()/kunmap() calls for these. But as this is
unrelated to the actual removal of the buffer heads, I'll address this in a
follow up series. 

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
  btrfs: use the page-cache for super block reading
  btrfs: let btrfs_read_dev_super() return a btrfs_super_block
  btrfs: use BIOs instead of buffer_heads from superblock writeout
  btrfs: remove btrfsic_submit_bh()
  btrfs: remove buffer_heads from btrfsic_process_written_block()
  btrfs: remove buffer_heads form superblock mirror integrity checking

Nikolay Borisov (1):
  btrfs: Export btrfs_release_disk_super

 fs/btrfs/check-integrity.c | 215 +++++++++++--------------------------
 fs/btrfs/check-integrity.h |   2 -
 fs/btrfs/disk-io.c         | 192 +++++++++++++++++----------------
 fs/btrfs/disk-io.h         |   6 +-
 fs/btrfs/volumes.c         |  59 +++++-----
 fs/btrfs/volumes.h         |   3 +-
 6 files changed, 194 insertions(+), 283 deletions(-)

-- 
2.24.1

