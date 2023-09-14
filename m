Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AA97A0A55
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbjINQHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241832AbjINQHH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:07 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA981FF6;
        Thu, 14 Sep 2023 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707623; x=1726243623;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=tfAj+1QeyQQxe36jSfS+R39/VwmnSFZHudvCn+33SQc=;
  b=JQK1ZyOgEIyE+MaJU9UCeMXovlqXHhS9GoHGtkek/sRkKNYF3JCPK21V
   z16HNcLDTp7Tq9BKMuN3xfacX/KwprJga5KYynOaaMmCMuE14vH84tcdN
   FLv57bRe+aWgU0tbPrW4WVV9QQtSu5IRb5fWtEbnhJL4cXVcfkO5tKtJh
   D+gY1N0qKvF8j/Ttrj4Xs9vydAcUizrQbUsJO5/MRlWObHskQhqcfzOzH
   mL++2gde1wwiildT7f6At7Kta7zYwPNqtszHoH096xiWYpM93YcSAnuRo
   mur4wZzuuUYSW42Lme3azKjc8ognsMiI9sKFIoauxkSzNCi14/I8OGFS4
   Q==;
X-CSE-ConnectionGUID: PY1F1lkzS2ah20PaTUaPcg==
X-CSE-MsgGUID: +97RoaoyT5SSwZ9OaS5Hlg==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490522"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:03 +0800
IronPort-SDR: LtbK6soRSdvjtyBoox8knGqdZnaO4vFOVk0IT0YZsPt6FqjbIoUqSt3iDHPQ5H8knPrX1AZGCq
 l/JqIYbFWdmjRsYNwYRB6sGXQnbdhl8BflXbIPYnyP0rBurB9dtevFrVN2973wvtb6SJjCYQ8r
 QcOD96vZuBCevzdMrBEBxv4lXIySX9EXvO7gkHVaw0yOcKWRUMk93U8O/yMOt/LQ6h9o+n+6RY
 ySWNCVKTsMXV1nOgbW64Y/Y/E1mipT/ZjKzcEUd1GayHS+WU4I0ggTEwzbkQPxiGW3fkZ+WSQt
 Jtk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:04 -0700
IronPort-SDR: H9ySB66UnfkJkbyk4SoO6c6fYGIZyVGQVtxjpitTd/U+QeGzu6mRVSyU2x2JHSgDJk8r2fXR4G
 +xr3P3jTe2fDGiI7O/7A8OHcV6oWEtUiuOPVAYr17W4C0PvdGZolQHLen3BBpnyDd9SlAR+kUG
 QAQ2m5rHTU6i5C9pLDGwne0qAyKG1vKWNYU0+v9yhLbFjP2kseYsWbYYp1APdYcUbJ5VDr8Ew6
 7WJAtf6KT/lUhisanC7DQvWQ9pq2Waf3rFSpai4JYKY18lG9vwiH4SZJnA5de2KfjmvWQXat0Z
 i8U=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:03 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v9 00/11] btrfs: introduce RAID stripe tree
Date:   Thu, 14 Sep 2023 09:06:55 -0700
Message-Id: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKAvA2UC/2WOwQ6CMBBEf4X07JpCoYAn/8NwKMsiexDItkEM4
 d8tePT4JjN5sylPwuTVLdmU0MKepzFCfUkUDm58EnAXWWU6M9qmBsRxBz4IzwRBiICM0Vi7vEA
 0Ks5a5wlacSMOx7AN0nt4sUcYaQ1HYxbqeT2ljybywD5M8jk/LNWR/nR1mv7rlgo02Ly0pe1dV
 WR4f3d4xemlmn3fvxXpQK3QAAAA
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=6809;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=tfAj+1QeyQQxe36jSfS+R39/VwmnSFZHudvCn+33SQc=;
 b=2SpkGuL90HD4Dw7Yctb5r2/pBPsKYL8/OKwmpxA7p4E7bkjaubdPJrHJ0kkojGCeiHkePA8Un
 HA/N+TzI9yJA9zwwJAtM/sBk3GHApjHgxKIB0WWspwBTVpmkQ/RiYin
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Updates of the raid-stripe-tree are done at ordered extent write time to safe
on bandwidth while for reading we do the stripe-tree lookup on bio mapping
time, i.e. when the logical to physical translation happens for regular btrfs
RAID as well.

The stripe tree is keyed by an extent's disk_bytenr and disk_num_bytes and
it's contents are the respective physical device id and position.

For an example 1M write (split into 126K segments due to zone-append)
rapido2:/home/johannes/src/fstests# xfs_io -fdc "pwrite -b 1M 0 1M" -c fsync /mnt/test/test
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0065 sec (151.538 MiB/sec and 151.5381 ops/sec)

The tree will look as follows (both 128k buffered writes to a ZNS drive):

RAID0 case:
bash-5.2# btrfs inspect-internal dump-tree -t raid_stripe /dev/nvme0n1
btrfs-progs v6.3
raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
leaf 805535744 items 1 free space 16218 generation 8 owner RAID_STRIPE_TREE
leaf 805535744 flags 0x1(WRITTEN) backref revision 1
checksum stored 2d2d2262
checksum calced 2d2d2262
fs uuid ab05cfc6-9859-404e-970d-3999b1cb5438
chunk uuid c9470ba2-49ac-4d46-8856-438a18e6bd23
        item 0 key (1073741824 RAID_STRIPE_KEY 131072) itemoff 16243 itemsize 56
                        encoding: RAID0
                        stripe 0 devid 1 offset 805306368 length 131072
                        stripe 1 devid 2 offset 536870912 length 131072
total bytes 42949672960
bytes used 294912
uuid ab05cfc6-9859-404e-970d-3999b1cb5438

RAID1 case:
bash-5.2# btrfs inspect-internal dump-tree -t raid_stripe /dev/nvme0n1
btrfs-progs v6.3
raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
leaf 805535744 items 1 free space 16218 generation 8 owner RAID_STRIPE_TREE
leaf 805535744 flags 0x1(WRITTEN) backref revision 1
checksum stored 56199539
checksum calced 56199539
fs uuid 9e693a37-fbd1-4891-aed2-e7fe64605045
chunk uuid 691874fc-1b9c-469b-bd7f-05e0e6ba88c4
        item 0 key (939524096 RAID_STRIPE_KEY 131072) itemoff 16243 itemsize 56
                        encoding: RAID1
                        stripe 0 devid 1 offset 939524096 length 65536
                        stripe 1 devid 2 offset 536870912 length 65536
total bytes 42949672960
bytes used 294912
uuid 9e693a37-fbd1-4891-aed2-e7fe64605045

A design document can be found here:
https://docs.google.com/document/d/1Iui_jMidCd4MVBNSSLXRfO7p5KmvnoQL/edit?usp=sharing&ouid=103609947580185458266&rtpof=true&sd=true

The user-space part of this series can be found here:
https://lore.kernel.org/linux-btrfs/20230215143109.2721722-1-johannes.thumshirn@wdc.com

Changes to v8:
- Changed tracepoints according to David's comments
- Mark on-disk structures as packed
- Got rid of __DECLARE_FLEX_ARRAY
- Rebase onto misc-next
- Split out helpers for new btrfs_load_block_group_zone_info RAID cases
- Constify declarations where possible
- Initialise variables before use
- Lower scope of variables
- Remove btrfs_stripe_root() helper
- Pick different BTRFS_RAID_STRIPE_KEY constant
- Reorder on-disk encoding types to match the raid_index
- And possibly more, please git range-diff the versions
- Link to v8: https://lore.kernel.org/r/20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com

Changes to v7:
- Huge rewrite

v7 of the patchset can be found here:
https://lore.kernel.org/linux-btrfs/cover.1677750131.git.johannes.thumshirn@wdc.com/

Changes to v6:
- Fix degraded RAID1 mounts
- Fix RAID0/10 mounts

v6 of the patchset can be found here:
https://lore/kernel.org/linux-btrfs/cover.1676470614.git.johannes.thumshirn@wdc.com

Changes to v5:
- Incroporated review comments from Josef and Christoph
- Rebased onto misc-next

v5 of the patchset can be found here:
https://lore/kernel.org/linux-btrfs/cover.1675853489.git.johannes.thumshirn@wdc.com

Changes to v4:
- Added patch to check for RST feature in sysfs
- Added RST lookups for scrubbing 
- Fixed the error handling bug Josef pointed out
- Only check if we need to write out a RST once per delayed_ref head
- Added support for zoned data DUP with RST

Changes to v3:
- Rebased onto 20221120124734.18634-1-hch@lst.de
- Incorporated Josef's review
- Merged related patches

v3 of the patchset can be found here:
https://lore/kernel.org/linux-btrfs/cover.1666007330.git.johannes.thumshirn@wdc.com

Changes to v2:
- Bug fixes
- Rebased onto 20220901074216.1849941-1-hch@lst.de
- Added tracepoints
- Added leak checker
- Added RAID0 and RAID10

v2 of the patchset can be found here:
https://lore.kernel.org/linux-btrfs/cover.1656513330.git.johannes.thumshirn@wdc.com

Changes to v1:
- Write the stripe-tree at delayed-ref time (Qu)
- Add a different write path for preallocation

v1 of the patchset can be found here:
https://lore.kernel.org/linux-btrfs/cover.1652711187.git.johannes.thumshirn@wdc.com/

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Johannes Thumshirn (11):
      btrfs: add raid stripe tree definitions
      btrfs: read raid-stripe-tree from disk
      btrfs: add support for inserting raid stripe extents
      btrfs: delete stripe extent on extent deletion
      btrfs: lookup physical address from stripe extent
      btrfs: implement RST version of scrub
      btrfs: zoned: allow zoned RAID
      btrfs: add raid stripe tree pretty printer
      btrfs: announce presence of raid-stripe-tree in sysfs
      btrfs: add trace events for RST
      btrfs: add raid-stripe-tree to features enabled with debug

 fs/btrfs/Makefile               |   2 +-
 fs/btrfs/accessors.h            |  10 +
 fs/btrfs/bio.c                  |  25 +++
 fs/btrfs/block-rsv.c            |   6 +
 fs/btrfs/disk-io.c              |  18 ++
 fs/btrfs/extent-tree.c          |   7 +
 fs/btrfs/fs.h                   |   4 +-
 fs/btrfs/inode.c                |   8 +-
 fs/btrfs/locking.c              |   1 +
 fs/btrfs/ordered-data.c         |   1 +
 fs/btrfs/ordered-data.h         |   2 +
 fs/btrfs/print-tree.c           |  26 +++
 fs/btrfs/raid-stripe-tree.c     | 449 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h     |  52 +++++
 fs/btrfs/scrub.c                |  53 +++++
 fs/btrfs/sysfs.c                |   3 +
 fs/btrfs/volumes.c              |  43 +++-
 fs/btrfs/volumes.h              |  16 +-
 fs/btrfs/zoned.c                | 144 ++++++++++++-
 include/trace/events/btrfs.h    |  75 +++++++
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  31 +++
 22 files changed, 954 insertions(+), 23 deletions(-)
---
base-commit: 1d73023d96965a5c8fb76a39aec88d840ebe5b21
change-id: 20230613-raid-stripe-tree-e330c9a45cc3

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>

